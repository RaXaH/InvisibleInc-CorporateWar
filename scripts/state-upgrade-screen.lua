local mui = include("mui/mui")
local mui_defs = include("mui/mui_defs")
local scroll_text = include("hud/scroll_text")
local util = include("client_util")
local cdefs = include("client_defs")
local simdefs = include("sim/simdefs")
local agentdefs = include("sim/unitdefs/agentdefs")
local serverdefs = include( "modules/serverdefs" )
local simfactory = include( "sim/simfactory" )
local unitdefs = include("sim/unitdefs")

local upgradeScreen = include( "states/state-upgrade-screen" )
--TODO: Drag-Zone correction
--	edit lock for agents on mission

-----------------------------------------------------
----Vanilla rewrite to support the bigger storage----
-----------------------------------------------------
local function onClickInv(self, unit, unitDef, upgrade, index, itemIndex, stash )

	if stash then
		if self._agency.upgrades and #self._agency.upgrades >= 16 then
			MOAIFmodDesigner.playSound("SpySociety/HUD/gameplay/upgrade_cancel_unit")
			modalDialog.show( STRINGS.UI.REASON.FULL_STASH )
		else
			MOAIFmodDesigner.playSound("SpySociety/HUD/gameplay/HUD_ItemStorage_PutIn")
			if not self._agency.upgrades then
				self._agency.upgrades ={}
			end
			table.insert(self._agency.upgrades,upgrade)
			table.remove(unitDef.upgrades,itemIndex)
		end
	else
		if unit:getInventoryCount( ) >= 8 then
			MOAIFmodDesigner.playSound("SpySociety/HUD/gameplay/upgrade_cancel_unit")
			modalDialog.show( STRINGS.UI.REASON.INVENTORY_FULL )
		else
			MOAIFmodDesigner.playSound("SpySociety/HUD/gameplay/HUD_ItemStorage_TakeOut")
			table.insert(unitDef.upgrades,upgrade)
			table.remove(self._agency.upgrades,itemIndex)
		end
	end
	self:refreshInventory(unitDef,index)
end
--hook the new function to the buttons
baseRefreshInventory = upgradeScreen.refreshInventory
function upgradeScreen:refreshInventory( unitDef, index )
	baseRefreshInventory( self, unitDef, index )

	if self._CW_campaign_enabled then
		local inventory, augments = {}, {}
		local unit = simfactory.createUnit( unitdefs.createUnitData( unitDef ), nil )

		for i,item in ipairs(unitDef.upgrades) do
			local itemDef, upgradeParams
			if type(unitDef.upgrades[i]) == "string" then
				itemDef = unitdefs.lookupTemplate( unitDef.upgrades[i] )
			else
				upgradeParams = unitDef.upgrades[i].upgradeParams
				itemDef = unitdefs.lookupTemplate( unitDef.upgrades[i].upgradeName )
			end
			if itemDef then
				local itemUnit = simfactory.createUnit( util.extend( itemDef )( upgradeParams and util.tcopy( upgradeParams )), nil )
				if itemUnit:getTraits().augment and itemUnit:getTraits().installed then
					if itemUnit:getTraits().modSkillLock then
						for p,skill in ipairs(itemUnit:getTraits().modSkillLock) do
							self._lockedSkills[skill] = true
						end
					end
					table.insert(augments,itemUnit)
				else
					table.insert(inventory,{item=itemUnit,upgrade=unitDef.upgrades[i],index = i })
				end
			end
		end


		for i, widget in self.screen.binder:forEach( "inv_" ) do
			if inventory[i] then
				widget.binder.btn.onClick = util.makeDelegate( nil, onClickInv, self, unit, unitDef, inventory[i].upgrade, index, inventory[i].index, true )
			end
		end
		for i, widget in self.screen.binder:forEach( "agency_inv_" ) do
			local item = i+self._stashIndex
			if self._agency.upgrades and  self._agency.upgrades[item] then
				widget.binder.btn.onClick = util.makeDelegate( nil, onClickInv, self, unit, unitDef, self._agency.upgrades[item], index, item, false)
			end
		end
	end
end
---------------------------------
---------------------------------
---------------------------------
local INACTIVE_BG = { 78/255, 136/255, 136/255,1 }
local SELECTED_BG = { 140/255, 255/255, 255/255,1 }
local function refreshAgentButton( widget, isSelected )
    if isSelected then
        widget.binder.img:setColor( 1, 1, 1, 1 )
        widget.binder.btn:setColorInactive( unpack(SELECTED_BG) )
    else
        widget.binder.img:setColor( 1, 1, 1, 0.5 )
        widget.binder.btn:setColorInactive( unpack(INACTIVE_BG) )
    end
    widget.binder.btn:updateImageState()
end

local baseSelectIncognita = upgradeScreen.selectIncognita
function upgradeScreen:selectIncognita( unitDef )
	if self.screen:findWidget("programPnl"):isVisible() and self._CW_campaign_enabled then
		self.screen:findWidget("programPnl"):setVisible(false)
		self.screen:findWidget("agentPnl"):setVisible(true)
		refreshAgentButton( self.screen:findWidget( "incognita" ), false )
	else
		baseSelectIncognita(self, unitDef)
	end
end

---------------------------------

local LOGO_COLOR =
{
	SANKAKU = {89/255,138/255,221/255, 1},
	KO = {180/255,180/255,180/255, 1},
	PLASTECH = {200/255, 125/255, 13/255, 1},
	FTM = {187/255,82/255,200/255, 1},
	OMNI = {255/255,175/255,36/255, 1},
}

local baseSelectAgent = upgradeScreen.selectAgent
function upgradeScreen:selectListAgent(old_id, new_id, agent_data)
	if self._CW_campaign_enabled then
		local lb = self.screen.binder.agentsList
		if old_id then
			local old_selected = lb:getItem( old_id )
			old_selected.widget.binder.selectHint:setVisible(false)
			old_selected.widget.binder.agentIcon:setColor(1, 1, 1, 0.3)
			old_selected.widget.binder.agentName:setColor(0.30588236451149, 0.533333361148834, 0.533333361148834, 1)
		end
		local new_selected = lb:getItem( new_id )
		--new_selected.widget.binder.selectHint:setVisible(true)
		new_selected.widget.binder.agentIcon:setColor(1, 1, 1, 1)
		--new_selected.widget.binder.agentName:setColor(0.549019634723663, 1, 1, 1)
		new_selected.widget.binder.agentName:setColor(0.956862745, 1,  0.470588235, 1)
	end
	baseSelectAgent (self, agent_data.agent, agent_data.idx)
end

local basePopulateScreen = upgradeScreen.populateScreen
function upgradeScreen:populateScreen()
	basePopulateScreen(self)

	if self._CW_campaign_enabled then
		local lb = self.screen.binder.agentsList
		lb:clearItems()

		for i, agent in ipairs(self._agency.unitDefs) do
			log:write(agentdefs[agent.template].name)
			local user_data = {agent = agent, idx = i}
			local widget = lb:addItem(user_data , nil)
			widget.binder.agentIcon:setImage(agentdefs[agent.template].profile_icon_64x64)
			widget.binder.agentIcon:setColor(1, 1, 1, 0.3)
			--TODO: remove select hint
			widget.binder.selectHint:setImage("gui/menu pages/upgrade_screen/arrowLeft_14x74.png")
			widget.binder.selectHint:setVisible(false)
			------------
			widget.binder.agentName:setText(util.toupper(agentdefs[agent.template].name))
			widget.binder.agentName:setColor(0.30588236451149, 0.533333361148834, 0.533333361148834, 1)
			if agent.on_mission then
				local corpData = serverdefs.getCorpData( agent.mission )
				local situationData = serverdefs.SITUATIONS[agent.mission.name]
				--widget.binder.agentStatus:setText(STRINGS.CORP[corpData.shortname].SHORTNAME.." "..situationData.ui.locationName)
				widget.binder.corpLogo:setImage(corpData.imgs.logoLarge)
				widget.binder.corpLogo:setColor(unpack(LOGO_COLOR[corpData.shortname]))
				widget.binder.agentStatus:setText(situationData.ui.locationName)
				widget.binder.agentStatus:setColor(0.7, 0.7, 0.7, 1)
				widget.binder.agentIcon:getTexture():setShader( MOAIShaderMgr.DESATURATION_SHADER )
			else
				widget.binder.agentStatus:setVisible(false)
				widget.binder.agentName:setPosition(34, 0)
			end
		end

		lb.onItemSelected = util.makeDelegate(nil, upgradeScreen.selectListAgent, self)

		lb:selectIndex(1)
	end
end

baseOnLoad = upgradeScreen.onLoad
function upgradeScreen:onLoad( agency, endless, is_post_mission, suppress_map_intro )
	--//from Cyberboy2000, AgentReserve Mod
	for i = #agency.unitDefs, 1, -1 do
		local unitDef = agency.unitDefs[i]
		local unitData = agentdefs[ unitDef.template ]

		--Skills are missing before mission 1
		if not unitDef.skills then
			unitDef.skills = {}

			for i,skillData in ipairs(unitData.skills) do
				local level = 1
				if unitData.startingSkills then
					level = unitData.startingSkills[ skillData ] or 1
				end
				table.insert( unitDef.skills, { skillID = skillData, level = level } )
			end
		end
	end
	--//

	baseOnLoad( self, agency, endless, is_post_mission, suppress_map_intro )

	--no sim, no campaign here :/
	self._CW_campaign_enabled = self.screen:findWidget("agentSelectPnl")

	if self._CW_campaign_enabled then
		self.screen:findWidget("agentSelectTitle"):setText(STRINGS.C_WAR.UI.AGENTS)
	end
end
