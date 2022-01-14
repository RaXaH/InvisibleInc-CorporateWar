local mui = include("mui/mui")
local mui_defs = include( "mui/mui_defs" )
local util = include("client_util")
local simdefs = include("sim/simdefs")
local array = include("modules/array")
local serverdefs = include( "modules/serverdefs" )
local simdefs = include("sim/simdefs")
local rig_util = include( "gameplay/rig_util" )
local locationPopup = include('client/fe/locationpopup')
local stars = include('client/fe/stars')
local agentdefs = include("sim/unitdefs/agentdefs")
local simfactory = include( "sim/simfactory" )
local unitdefs = include("sim/unitdefs")
local cdefs = include("client/client_defs")
local version = include( "modules/version" )
local metrics = include( "metrics" )
local guard_daemons = include("sim/abilities/npc_abilities")

local mapScreen = include("states/state-map-screen")


local LOGO_COLOR = { 144/255,1,1,1 }

local CORP_COLOR =
{
	SANKAKU = {89/255,138/255,221/255, 1},
	KO = {180/255,180/255,180/255, 1},
	PLASTECH = {200/255, 125/255, 13/255, 1},
	FTM = {187/255,82/255,200/255, 1},
	OMNI = {255/255,175/255,36/255, 1},
}

local map_colours_normal =
{
	asia = {14/255, 54/255, 79/255, 1},
	europe = {22/255, 56/255, 56/255, 1},
	sa = {42/255, 61/255, 30/255, 1},
	na = {28/255, 36/255, 64/255, 1},
	omni = {255/255,175/255,36/255, 1},
}
local map_colours_highlight =
{
	--asia = {45/255,77/255,132/255, 1},
	asia = {89/255,138/255,221/255, 1},
	--europe = {71/255,81/255,81/255, 1},
	europe = {180/255,180/255,180/255, 1},
	sa = {200/255, 125/255, 13/255, 1},
	na = {187/255,82/255,200/255, 1},
	omni = {255/255,175/255,36/255, 1},
	--na = {93/255,39/255,100/255, 1},
}

local map_colours_unhighlight =
{
	asia = {34/255,57/255,56/255,.5},
	europe = {34/255,57/255,56/255,.5},
	sa = {34/255,57/255,56/255,.5},
	na = {34/255,57/255,56/255,.5},
	omni = {255/255,175/255,36/255, 1},
}

------------------------------------
----Mission Preview Screen Stuff----
------------------------------------
local agents_on_mission = {-1, -1, -1, -1}

function mapScreen:updateLoadout( screen )
	screen:findWidget("acceptBtn.btn"):setDisabled(true)
	for i, agent in ipairs(agents_on_mission) do
		if agents_on_mission[i] ~= -1 then
			screen:findWidget("acceptBtn.btn"):setDisabled(false)
			break
		end
	end
	for i, widget in screen:findWidget("pnl_loadout").binder:forEach("agentLoadout_") do
		local inventory, augments = {}, {}
		if agents_on_mission[i] ~= -1 then
			local agentDef = self._campaign.agency.unitDefs[agents_on_mission[i]]
			local data = agentdefs[agentDef.template]
			widget.binder.agentImg.binder.img:setImage(data.profile_icon_64x64)
			widget.binder.agentImg.binder.img:setColor(1,1,1,1)
			widget.binder.agent_cancel:setVisible(true)
			widget.binder.agent_edit:setVisible(false)

			for i, item in ipairs(agentDef.upgrades) do
				local itemDef, upgradeParams
		    if type(item) == "string" then
		        itemDef = unitdefs.lookupTemplate( item )
		    else
		        upgradeParams = item.upgradeParams
		        itemDef = unitdefs.lookupTemplate( item.upgradeName )
		    end
				if itemDef then
					local itemUnit = simfactory.createUnit( util.extend( itemDef )( upgradeParams and util.tcopy( upgradeParams )), nil )
					if itemUnit:getTraits().augment and itemUnit:getTraits().installed then
						table.insert(augments, itemUnit)
					else
						table.insert(inventory, itemUnit)
					end
				end
			end
		else
			widget.binder.agentImg.binder.img:setImage("gui/hud3/CW_button_add.png")
			widget.binder.agentImg.binder.img:setColor(0.549019634723663,1,1,1)
			widget.binder.agent_edit:setVisible(false)
			widget.binder.agent_cancel:setVisible(false)
		end
			for j, widget_aug in widget.binder:forEach( "aug_" ) do
				if augments[j] then
					local augData = augments[j]:getUnitData()
					widget_aug.binder.img:setImage(augData.profile_icon_100)
					widget_aug.binder.img:setTooltip(
            					function()
		        				local tooltip = util.tooltip( screen, nil )
		        				local section = tooltip:addSection()
		        				augData.onTooltip( section, augments[j], nil, nil)
                					return tooltip
            					end )
					widget_aug:setVisible(true)
				else
					widget_aug:setVisible(false)
				end
			end
			for j, widget_inv in widget.binder:forEach( "item_" ) do
				if inventory[j] then
					local itemData = inventory[j]:getUnitData()
					widget_inv.binder.img:setImage(itemData.profile_icon_100)
					widget_inv.binder.img:setTooltip(
            					function()
		        				local tooltip = util.tooltip( screen, nil )
		        				local section = tooltip:addSection()
		        				itemData.onTooltip( section, inventory[j], nil, nil)
                					return tooltip
            					end )
					widget_inv:setVisible(true)
				else
					widget_inv:setVisible(false)
				end
			end
	end
end

function mapScreen:OnSelectAgent( screen, loadoutID )
	for i, widget in screen.binder:forEach("agentSelect_") do
		local agentDef = self._campaign.agency.unitDefs[i]
		if agentDef then
			local is_agent_on_mission = false
			for j, agent in ipairs(agents_on_mission) do
				if self._campaign.agency.unitDefs[agent] == agentDef then
					is_agent_on_mission = true
					break
				end
			end
			if agentDef.on_mission then
				is_agent_on_mission = true
			end
			local data = agentdefs[agentDef.template]
			widget.binder.img:setImage(data.profile_icon_64x64)
			if is_agent_on_mission == false then
				widget.binder.img:setColor(1,1,1,1)
				widget.binder.btn.onClick = function () self:closeSelectAgent( screen, loadoutID, i ) end
				widget.binder.btn:setDisabled(false)
			else
				widget.binder.img:setColor(1,1,1,0.3)
				widget.binder.btn:setDisabled(true)
			end
		else
			widget:setVisible(false)
		end
	end
	screen:findWidget("fullBg"):setVisible(true)
	screen:findWidget("popup_agentSelect"):setVisible(true)
	screen:findWidget("popup_btn_cancel").onClick = function () self:closeSelectAgent( screen ) end
	screen:findWidget("popup_btn_cancel"):setHotkey ("pause")
	screen:findWidget("cancelBtn.btn"):setHotkey( )
end

function mapScreen:closeSelectAgent( screen, loadoutID, agentDefID )
	if agentDefID then
		agents_on_mission[loadoutID] = agentDefID
	end

	self.updateLoadout(self, screen)

	screen:findWidget("fullBg"):setVisible(false)
	screen:findWidget("popup_agentSelect"):setVisible(false)
	screen:findWidget("cancelBtn.btn"):setHotkey( "pause" )
end

--Set the loadout for this situation, mark agents for on_mission
function mapScreen:startInfiltration( screen, situation )
	situation.is_infiltrating = true
	situation.loadout = {}
	for i, agent in ipairs(agents_on_mission) do
		situation.loadout[i] = agent
		if agent ~= -1 then
			self._campaign.agency.unitDefs[agent].on_mission = true
			self._campaign.agency.unitDefs[agent].mission = situation
		end
	end
	self:updateLocations(	)
	self:closePreview(screen, situation, false)
end

--Start mission portion of the mapScreen:closePreview
--Adjusted to set active agents depending on loadout and freeing loadout agents from their on_mission flag
function mapScreen:startMission( preview_screen, situation )
	MOAIFmodDesigner.stopSound(	"mission_preview_speech" )
	mui.deactivateScreen( preview_screen )
	MOAIFmodDesigner.playSound( cdefs.SOUND_HUD_GAME_WOOSHOUT )

	local corpData = serverdefs.getCorpData( situation )
	self:UpdateMapColours( corpData.region )

	self._screen.binder.pnl:findWidget("cornerMenu"):setVisible(false)
	local user = savefiles.getCurrentGame()
	local campaign = self._campaign
	local travelTime = serverdefs.calculateTravelTime( self._campaign.location, situation.mapLocation ) + serverdefs.BASE_TRAVEL_TIME

	local destx,desty = self:getMapLocation( situation.mapLocation, self.locationOffsetX, self.locationOffsetY )
	local fly_time = math.max(2, travelTime / 4)

	local x, y = self.jet:getPosition()
	local dx, dy = destx - x, desty - y
	local PI = 3.14159

	local angle = math.atan2(dy, dx)
	if angle < 0 then
		angle = angle + 2*PI
	end
	local percent = angle / (2*PI)
	local frame = math.floor(percent * self.jet:getFrameCount())
	self.jet:setFrame(frame)
	self.jet:setPlayMode( KLEIAnim.STOP )
	self.jet:seekLoc( destx, desty, fly_time)

	MOAIFmodDesigner.playSound( "SpySociety/HUD/menu/map_jetmove" )
	inputmgr.setInputEnabled(false)

	local overlay = self._screen:findWidget("overlay")
	overlay:setVisible(true)

	local fade_time = .5


	rig_util.wait((fly_time - fade_time)* cdefs.SECONDS)
	local t = 0
	while t < fade_time do
		t = t + 1/cdefs.SECONDS
		local percent = math.min(t / fade_time, 1)
		overlay:setColor(0, 0, 0, percent)
		coroutine.yield()
	end

	overlay:setColor(0, 0, 0, 1)

	inputmgr.setInputEnabled(true)

	user.data.saveSlots[ user.data.currentSaveSlot ] = campaign

	user.data.num_games = (user.data.num_games or 0) + 1
	campaign.recent_build_number = util.formatGameInfo()
	campaign.missionVersion = version.VERSION

	local situationIndex = array.find( self._campaign.situations, situation )
	campaign.situation = table.remove( campaign.situations, situationIndex )
	campaign.preMissionNetWorth = serverdefs.CalculateNetWorth(campaign)

	campaign.agency.activeAgents = {}
	for i, agent in ipairs(situation.loadout) do
		if agent ~= -1 then
			campaign.agency.unitDefs[agent].on_mission = false
			table.insert(campaign.agency.activeAgents, agent)
		end
	end

	if not user.data.saveScumLevelSlots then
		user.data.saveScumLevelSlots = {}
	end
	user.data.saveScumLevelSlots[ user.data.currentSaveSlot ] = util.tcopy( user.data.saveSlots[ user.data.currentSaveSlot ] )

	user:save()

	metrics.app_metrics:incStat( "new_games" )


	local stateLoading = include( "states/state-loading" )
	statemgr.deactivate( self )
	stateLoading:loadCampaign( self._campaign )
end

--TODO: Add Response Level
local baseOnClickLocation = mapScreen.OnClickLocation
function mapScreen:OnClickLocation( situation )
	if self._campaign.difficultyOptions.CW_CAMPAIGN then
		local situationData = serverdefs.SITUATIONS[ situation.name ]
		MOAIFmodDesigner.playSound( "SpySociety/HUD/gameplay/popup" )
		local screen = mui.createScreen( "CW_mission_preview_dialog.lua" )
		local corpData = serverdefs.getCorpData( situation )

		mui.activateScreen( screen )

		local situationData = serverdefs.SITUATIONS[situation.name]


		--TODO: remove this
		--special case for the very first story mission
		if self._campaign.missionCount == 0 and self._campaign.difficultyOptions.maxHours ~= math.huge and situationData.ui.first_insetvoice then
			MOAIFmodDesigner.playSound(	situationData.ui.first_insetvoice, "mission_preview_speech" )
		else
			if not situation.random_idx or situation.random_idx > #situationData.ui.insetVoice then

				situation.random_idx = math.random(#situationData.ui.insetVoice)

			end
			MOAIFmodDesigner.playSound(	situationData.ui.insetVoice[situation.random_idx], "mission_preview_speech" )
		end
		--screen:findWidget("central.speechText"):setText(situationData.ui.insetTxt)

		local cityName = util.toupper(serverdefs.MAP_LOCATIONS[situation.mapLocation].name)
		local travelTime = serverdefs.calculateTravelTime( self._campaign.location, situation.mapLocation ) + serverdefs.BASE_TRAVEL_TIME

		screen:findWidget("locationTxt"):setText(STRINGS.UI.MAP_SCREEN_LOCATION..": "..cityName)
		screen:findWidget("travelTime"):setText(util.toupper(util.sformat(STRINGS.UI.MAP_SCREEN_TRAVEL_TIME, cityName, travelTime)))

		screen:findWidget("CorpDetails.corpName"):setText(STRINGS.CORP[corpData.shortname].NAME)
		screen:findWidget("CorpDetails.corporationDesc"):setText(STRINGS.CORP[corpData.shortname].SHORTDESC)
		screen:findWidget("CorpDetails.logo"):setImage(corpData.imgs.logoLarge)

		if corpData.region then
			local c = map_colours_highlight[corpData.region]
			if c then
				screen:findWidget("CorpDetails.logo"):setColor(unpack(LOGO_COLOR))
			end
		end


		screen:findWidget("MissionDetails.title"):setText(util.toupper(situationData.ui.locationName))
		screen:findWidget("MissionDetails.text"):setText(situationData.ui.playerdescription)
		screen:findWidget("MissionDetails.reward"):setText(situationData.ui.reward)
		screen:findWidget("MissionDetails.preview"):setImage(situationData.ui.insetImg)

		screen:findWidget("Difficulty.difficultyName"):setText(STRINGS.UI.DIFFICULTY[situation.difficulty])

		stars.setDifficultyStars(screen, situation.difficulty)
		if situation.corpName == "omni" then
			screen:findWidget("Difficulty.difficultyDesc"):setText(STRINGS.UI.DIFFICULTY_OMNI)
		else
			screen:findWidget("Difficulty.difficultyDesc"):setText(STRINGS.UI.DIFFICULTYDESC[math.min(situation.difficulty, #STRINGS.UI.DIFFICULTYDESC)])
		end


		screen:findWidget("cancelBtn.btn").onClick = function() self:closePreview(screen, situation, false) end
		screen:findWidget("cancelBtn.btn"):setHotkey( "pause" )
		screen:findWidget("cancelBtn.btn"):setText( STRINGS.UI.MAP_DONOTINFILTRATE )
		screen:findWidget("cancelInfiltration.btn"):setText( STRINGS.C_WAR.UI.CANCEL_INFILTRATION )

		screen:findWidget("moreInfoBtn.btn").onClick = function()
				local modalDialog = include( "states/state-modal-dialog" )
				modalDialog.show( situationData.ui.moreInfo, util.toupper(situationData.ui.locationName), true )
		end
		screen:findWidget("moreInfoBtn.btn"):setText( STRINGS.UI.MAP_MOREINFO )


		agents_on_mission = {-1, -1, -1, -1}

		screen:findWidget("loadout_title"):setText( STRINGS.C_WAR.UI.LOADOUT_TITLE )
		screen:findWidget("popup_title"):setText( STRINGS.C_WAR.UI.LOADOUT_POPUP_TITLE )

		if situation.is_infiltrating == true then
			screen:findWidget("acceptBtn.btn").onClick = function() self:startMission( screen, situation ) end
			screen:findWidget("acceptBtn.btn"):setHotkey( mui_defs.K_ENTER )
			screen:findWidget("acceptBtn.btn"):setText( STRINGS.C_WAR.UI.START_MISSION )

			agents_on_mission = util.tdupe(situation.loadout)
			self:updateLoadout( screen )
			for i, widget in screen:findWidget("pnl_loadout").binder:forEach("agentLoadout_") do
				widget.binder.agentImg.binder.btn:setDisabled(true)
				widget.binder.agent_cancel:setVisible(false)
				if agents_on_mission[i] == -1 then
					widget.binder.agentImg:setVisible(false)
				end
			end
		else
			screen:findWidget("acceptBtn.btn").onClick = function() self:startInfiltration( screen, situation) end
			screen:findWidget("acceptBtn.btn"):setHotkey( mui_defs.K_ENTER )
			screen:findWidget("acceptBtn.btn"):setText( STRINGS.C_WAR.UI.START_INFILTRATION )
			screen:findWidget("cancelInfiltration"):setVisible(false)

			for i, widget in screen:findWidget("pnl_loadout").binder:forEach("agentLoadout_") do

				widget.binder.agentImg.binder.btn.onClick = function () self:OnSelectAgent( screen, i ) end
				widget.binder.agent_cancel.binder.btn.onClick = function () self:closeSelectAgent( screen, i, -1 ) end
			end
			self.updateLoadout( self, screen )
		end
	else
		baseOnClickLocation(self, situation)
	end
end

--------------------------------
----Campaign Time Management----
--------------------------------

local clock = class()

local PAUSE_TIME = 0
local NORMAL_TIME = 1
local FAST_TIME = 2

--TODO: Add a second speedfactor for faster forward?
function clock:init(campaign)
	self._campaign = campaign

	self.mode = NORMAL_TIME
	self.speedfactor = 1000

	self.currentSec = 0
	self.currentMin = self._campaign.game_time % 60
	self.currentHour = math.floor(self._campaign.game_time/60) % 24
	self.currentDay = math.floor(self.currentHour / 24) + 1
end

function clock:updateClock(pnl)
	self.currentMin = self._campaign.game_time % 60
	self.currentHour = math.floor(self._campaign.game_time/60) % 24
	self.currentDay = math.floor(self.currentHour / 24) + 1
end

--TODO: I kinda want the hotkeys to be
--	Space: toggle between pause and last speed
--	Tab: cycle through speeds pause->normal->fast->pause
--	Need to figure out how to give a button two hotkeys. Maybe add a dummy button?
function mapScreen:onClickScan(mode)
	self._screen:findWidget("scanPauseBtn"):setColor(0.956862745, 1, 0.470588235, 0.588235318660736)
	self._screen:findWidget("scanForBtn"):setColor(0.956862745, 1, 0.470588235, 0.588235318660736)
	self._screen:findWidget("scanFastBtn"):setColor(0.956862745, 1, 0.470588235, 0.588235318660736)
	self._screen:findWidget("scanForBtn"):setHotkey()
	self._screen:findWidget("scanFastBtn"):setHotkey()

	if mode == PAUSE_TIME then
		self._screen:findWidget("scanForBtn"):setHotkey( mui_defs.K_TAB )
	else
		self._screen:findWidget("scanFastBtn"):setHotkey( mui_defs.K_TAB )
	end

	self._clock.mode = mode

	if mode == PAUSE_TIME then
		self._screen:findWidget("scanPauseBtn"):setColor(1, 1, 1, 1)
	elseif mode == NORMAL_TIME then
		self._screen:findWidget("scanForBtn"):setColor(1, 1, 1, 1)
	else
		self._screen:findWidget("scanFastBtn"):setColor(1, 1, 1, 1)
	end
end

--This needs to be overwritten. Vanilla doesnt really care about time, so...
local baseStartCountdownTimer = mapScreen.StartCountdownTimer
function mapScreen:StartCountdownTimer()
	if self._campaign.difficultyOptions.CW_CAMPAIGN then
		local pnl = self._screen.binder.pnl
		local currentSec = 0
		local currentMin = self._campaign.game_time % 60
		local currentHour = math.floor(self._campaign.game_time/60) % 24
		local currentDay = math.floor(currentHour / 24) + 1

		pnl:findWidget("timer"):spoolText(string.format(STRINGS.UI.MAP_SCREEN_DAYS_SPENT, currentDay, currentHour, currentMin, currentSec ))
		self._timeUpdateThread = MOAICoroutine.new()
		self._timeUpdateThread:run( function()

			local i = 0
			local speed = 1
			while true do
				if self._clock.mode == FAST_TIME then
					speed = self._clock.speedfactor
				elseif self._clock.mode == NORMAL_TIME then
					speed = 1
				else
					speed = 0
				end
				i = i + speed
				if i >= 60 then
					currentSec = currentSec + math.floor(i/60)
					i = i % 60
					if currentSec >= 60 then
						serverdefs.advanceTimeCustom (self._campaign, math.floor(currentSec/60))
						currentMin = currentMin + math.floor(currentSec/60)
						currentSec = currentSec % 60
						if currentMin >= 60 then
							currentHour = currentHour + math.floor(currentMin/60)
							currentMin = currentMin % 60
							if currentHour >= 24 then
								currentDay = currentDay + math.floor(currentHour/24)
								currentHour = currentHour % 24
							end
						end
					end

					pnl:findWidget("timer"):setText(string.format(STRINGS.UI.MAP_SCREEN_DAYS_SPENT, currentDay, currentHour, currentMin, currentSec ))
				end

				coroutine.yield()
			end
		end )


		pnl:findWidget("timeRemaining"):spoolText(util.sformat(STRINGS.UI.MAP_SCREEN_REMAINING, math.max(0, self._campaign.difficultyOptions.maxHours - self._campaign.hours) ))
		pnl:findWidget("timeRemaining"):setTooltip(STRINGS.UI.MAP_SCREEN_REMAINING_TOOLTIP)

		if self._campaign.difficultyOptions.maxHours == math.huge then
			pnl:findWidget("timeRemaining"):setVisible( false )
			pnl:findWidget("timerGroup"):setPosition( pnl:findWidget("timeRemainingGroup"):getPosition() )
		else
			pnl:findWidget("timeRemaining"):setVisible( true )
		end

		if serverdefs.isTimeAttackMode( self._campaign ) then
		    local totalTime = self._campaign.chessTimeTotal or 0
			local hr = math.floor( totalTime / (60*60*60) )
			local min = math.floor( totalTime / (60*60) ) - hr*60
			local sec = math.floor( totalTime / 60 ) % 60
			pnl:findWidget("totalPlayTime"):setText( string.format( STRINGS.UI.MAP_SCREEN_TOTAL_PLAY_TIME, hr, min, sec ) )
			pnl:findWidget("totalPlayTime"):setVisible(true)
		else
			pnl:findWidget("totalPlayTime"):setVisible(false)
		end
	else
		baseStartCountdownTimer(self)
	end
end

---------------------------
----Region Screen Stuff----
---------------------------

--TODO: neptune support
local region_switch = false
local corps_shortnames = {"ftm", "sankaku", "ko", "plastech"}

--Switch between guard daemons and personel management
local function OnRegionSwitch(screen)
	if region_switch then
		region_switch = false
		for _, corp in ipairs(corps_shortnames) do
			local lb_daemons = screen:findWidget(corp.."_daemonList")
			local lb_personel = screen:findWidget(corp.."_personelList")
			lb_daemons:setVisible(true)
			lb_personel:setVisible(false)
		end
	else
		region_switch = true
		for _, corp in ipairs(corps_shortnames) do
			local lb_daemons = screen:findWidget(corp.."_daemonList")
			local lb_personel = screen:findWidget(corp.."_personelList")
			lb_daemons:setVisible(false)
			lb_personel:setVisible(true)
		end
	end
end

function mapScreen:closeRegionsView(regionsScreen)
	if self._progressUpdateThread then
	    self._progressUpdateThread:stop()
	    self._progressUpdateThread = nil
    	end
	mui.deactivateScreen( regionsScreen )
end

function mapScreen:onClickRegions ()
	MOAIFmodDesigner.playSound( "SpySociety/HUD/gameplay/popup" )
	local screen = mui.createScreen( "CW_corp_preview.lua" )

	mui.activateScreen( screen )

	screen:findWidget("backBtn.btn"):setText(STRINGS.C_WAR.UI.BACK)
	screen:findWidget("backBtn.btn").onClick = function() self:closeRegionsView( screen ) end
	screen:findWidget("switchBtn.btn"):setText(STRINGS.C_WAR.UI.SWITCH)
	screen:findWidget("switchBtn.btn"):setAlignment( MOAITextBox.CENTER_JUSTIFY, MOAITextBox.CENTER_JUSTIFY )
	screen:findWidget("switchBtn.btn").onClick = function() OnRegionSwitch( screen ) end


	for _, corp in ipairs(corps_shortnames) do
		local widget = screen:findWidget("pnl_"..corp)
		local corpData = serverdefs.HEAD_CORP_TEMPLATES[corp]
		widget.binder.corpLogo:setImage(corpData.imgs.logoLarge)
		widget.binder.corpLogo:setColor(unpack(CORP_COLOR[corpData.shortname]))
		widget.binder.corpName:setText(util.toupper(corp))
		local progress = serverdefs.getGuardProgress(self._campaign, corp)
		widget.binder.guardProgress:setProgress(progress)
		local guard_level = self._campaign.corpProgress[corp].guard_level
		widget.binder.guardLevel:setImage(string.format("gui/menu pages/map_screen/shield%d.png", guard_level))

		--TODO: Show actual personel data
		--	add tooltips
		local lb_daemons = screen:findWidget(corp.."_daemonList")
		local lb_personel = screen:findWidget(corp.."_personelList")
		lb_daemons:clearItems()
		lb_personel:clearItems()
		lb_personel:setVisible(false)

		local daemonList = self._campaign.corpProgress[corp].guard_daemons

		for _, daemon in ipairs(daemonList) do
			local entry = lb_daemons:addItem(nil , nil)
			local d_icon = guard_daemons[daemon].icon
			local d_name = guard_daemons[daemon].name
			entry.binder.daemonLogo:setImage(d_icon)
			entry.binder.daemonDesc:setText(d_name)
		end

		for i=1, 20 do
			local entry = lb_personel:addItem(nil , nil)
			entry.binder.personelActivitySelect:setText(tostring(i))
			entry.binder.personelActivitySelect:setAlignment(MOAITextBox.LEFT_JUSTIFY, nil)
			for j=1, 5 do
				entry.binder.personelActivitySelect:addItem(tostring(j), nil)
			end
		end
	end

	--I really hate how this is implemented, but i guess it works...
	self._progressUpdateThread = MOAICoroutine.new()
	self._progressUpdateThread:run( function()
		local i = 0
		local speedconst = 5
		while true do
			i = i + 1
			for _, corp in ipairs(corps_shortnames) do
				local widget = screen:findWidget("pnl_"..corp)
				local corpData = serverdefs.HEAD_CORP_TEMPLATES[corp]
				local progressImg = "gui/hud3/CW_progressbar_progress_100x20_"..tostring(math.floor(i/speedconst)%6)..".png"

				widget.binder.guardProgress:setImages(nil, progressImg)
			end

			coroutine.yield()
		end
	end )
end

------------------------
----Map Screen Stuff----
------------------------
local situation_locations = {}

--TODO: Set infiltration progress
function mapScreen:updateLocations(	)
	for situation, widget in pairs(situation_locations) do
		if situation.is_infiltrating then
			widget.binder.infiltration_label:setVisible(true)
			widget.binder.infiltration_progress:setVisible(true)
		end
	end
end

local baseAddLocation = mapScreen.addLocation
function mapScreen:addLocation(situation, popin)
	local x, y = baseAddLocation(self, situation, popin)

	if self._campaign.difficultyOptions.CW_CAMPAIGN then
		--Weird way of tieing the widget to the situation...
		--TODO: The widget should always be the last element, reverselooping should be faster. Don't know if just taking the last element is safe though...
		local widget
		for _, _widget in ipairs(self._screen.binder.pnl.binder.maproot.binder.under:getChildren()) do
			local _wx, _wy = _widget:getPosition()
			if _wx == x and  _wy == y then
				situation_locations[situation] = _widget
				widget = _widget
				break
			end
		end

		--TODO: Set infiltration progress from the situation data
		widget.binder.infiltration_label:setText(STRINGS.C_WAR.UI.INFILTRATION_LABEL)
		widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.588235318660736)
		widget.binder.infiltration_progress:setText([[0 %]])

		table.insert(self._breachingBlinkThreads, 1, MOAICoroutine.new())
		self._breachingBlinkThreads[1]:run( function()
			local i = 0
			while true do
				i = i + 1
				if i % 120 == 0 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.588235318660736)

				elseif i % 120 == 5 or i % 120 == 115 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.539215709)

				elseif i % 120 == 10 or i % 120 == 110 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.490196099)

				elseif i % 120 == 15 or i % 120 == 105 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.441176489)

				elseif i % 120 == 20 or i % 120 == 100 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.392156879)

		                elseif i % 120 == 25 or i % 120 == 95 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.343137269)

				elseif i % 120 == 30 or i % 120 == 90 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.294117659)

		                elseif i % 120 == 35 or i % 120 == 85 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.245098049)

				elseif i % 120 == 40 or i % 120 == 80 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.196078439)

		                elseif i % 120 == 45 or i % 120 == 75 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.147058829)

				elseif i % 120 == 50 or i % 120 == 70 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.098039219)

		                elseif i % 120 == 55 or i % 120 == 65 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0.049019609)

				elseif i % 120 == 60 then
					widget.binder.infiltration_label:setColor(0.95686274766922, 1, 0.470588237047195, 0)

				end

				coroutine.yield()
			end
		end )
		self._breachingBlinkThreads[1]:resume()

		if not situation.is_infiltrating then
			widget.binder.infiltration_label:setVisible(false)
			widget.binder.infiltration_progress:setVisible(false)
		end
	end

	return x,y
end

local baseOnLoad = mapScreen.onLoad
function mapScreen:onLoad( campaign, suppress_intro )
	situation_locations = {}

	baseOnLoad( self, campaign, suppress_intro )

	self._breachingBlinkThreads = {}

	if self._campaign.difficultyOptions.CW_CAMPAIGN then
		self._clock = clock(self._campaign)
		self._screen:findWidget("scanPauseBtn").onClick = function () self:onClickScan( PAUSE_TIME ) end
		self._screen:findWidget("scanForBtn").onClick = function () self:onClickScan( NORMAL_TIME ) end
		self._screen:findWidget("scanFastBtn").onClick = function () self:onClickScan( FAST_TIME ) end
		self._screen:findWidget("scanPauseBtn"):setColor(0.956862745, 1, 0.470588235, 0.588235318660736)
		self._screen:findWidget("scanForBtn"):setColor(1, 1, 1, 1)
		self._screen:findWidget("scanFastBtn"):setColor(0.956862745, 1, 0.470588235, 0.588235318660736)

		self._screen:findWidget("scanPauseBtn"):setHotkey( mui_defs.K_SPACE )
		self._screen:findWidget("scanFastBtn"):setHotkey( mui_defs.K_TAB )

		local pnl = self._screen.binder.pnl
		pnl:findWidget("upgradeBtn"):setVisible(true)

		pnl:findWidget("regionsBtn").onClick = util.makeDelegate( nil, self.onClickRegions, self)
		pnl:findWidget("regionsBtn"):setTooltip("Regions")
	end
end

--Dont think this is needed because the thread must get killed on closing the region
local baseOnUnload = mapScreen.onUnload
function mapScreen:onUnload()
	baseOnUnload(self)

	if self._progressUpdateThread then
	    self._progressUpdateThread:stop()
	    self._progressUpdateThread = nil
    	end
end
