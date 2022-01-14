print("LOADING mainframe_panel.lua from CorporateWar")
local util = include("client_util")

local panel = include("hud/mainframe_panel").panel

--Background colors for daemonPanel
local COLORS =
{
	DAEMON = { 140/255, 0, 0, 1 },
	REVERSE = { 0/255, 164/255, 0/255, 1 },
	GUARD = { 210/255, 126/255, 0/255, 1 },
}

local function onClickDaemonIcon( panel )
	if not panel._hud:isMainframe() then
		panel._hud:showMainframe()
	end
end

--Changes from vanilla function:
--1. yellow color for guard daemons
--2. don't make guard daemons clickable
--technically we don't need to handle standard or reverse daemons, but lets just leave it in
local function setDaemonPanel( self, widget, ability, player )
	local sim = self._hud._game.simCore
	local clr = ( ability.reverseDaemon and COLORS.REVERSE ) or ( ability.guardDaemon and COLORS.GUARD ) or COLORS.DAEMON

	widget:setVisible( true )
	if not ability.guardDaemon then
    		widget.binder.btn.onClick = util.makeDelegate( nil, onClickDaemonIcon, self )
	end
	widget.binder.btn:setTooltip( ability:onTooltip( self._hud, sim, player ) )
	widget.binder.btn:setColor(unpack(clr) )
	widget.binder.icon:setImage( ability:getDef().icon )

	if ability.turns then
		widget.binder.firewallNum:setText(ability.turns)
	elseif ability.duration then
		widget.binder.firewallNum:setText(ability.duration)
	else
		widget.binder.firewallNum:setText("-")
	end
end

--Basically same as vanilla function, just does the same things to the guardPanel as to the daemonPanel
local function updateDaemonButtonsPlus( self, widgetName, player )
	local sim = self._hud._game.simCore

	local isBusy = false

	local panel = self._panel

	--not sure if this is really necessary, but better leave it in
	for i, widget in panel.binder.guardPanel.binder:forEach( widgetName ) do
		isBusy = isBusy or (widget.thread and widget.thread:isBusy())
   	end
   	if isBusy then
		return
   	end
	--

	local pnlVisible = false

	pnlVisible = false
	for i, widget in panel.binder.guardPanel.binder:forEach( widgetName ) do
		local ability
		if player then
			ability = player:getGuardAbilities()[i]
		end

		if ability == nil or sim:getCurrentPlayer() == nil then
			widget:setVisible( false )
		else
			setDaemonPanel( self, widget, ability, player )

			widget:setVisible( true )
			pnlVisible = true
		end
	end
	panel.binder.guardPanel.binder.daemonPnlTitle:setVisible(pnlVisible)

end

--Refresh guardPanels aswell
local baseRefresh = panel.refresh
function panel:refresh(primeRefresh)
	baseRefresh(self, primeRefresh)

	if self._hud._game.simCore:getParams().difficultyOptions.CW_CAMPAIGN then
		updateDaemonButtonsPlus( self, "enemyAbility", self._hud._game.simCore:getNPC() )
	end
end
