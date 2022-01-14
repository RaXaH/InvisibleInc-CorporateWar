local hud = include("hud/hud")

local DP_MODE_DAEMON = 0
local DP_MODE_GUARD = 1

local function onDaemonPanelSwitch (mainframe_panel, mode)
	mainframe_panel._panel.binder.ControlPnl.binder.switchDaemonBtn:setInactiveImage( "gui/hud3/CW_daemon_red_btn_down.png" )
	mainframe_panel._panel.binder.ControlPnl.binder.switchDaemonBtn:setActiveImage( "gui/hud3/CW_daemon_red_btn_up.png" )
	mainframe_panel._panel.binder.ControlPnl.binder.switchDaemonBtn:setHoverImage( "gui/hud3/CW_daemon_red_btn_up.png" )
	mainframe_panel._panel.binder.ControlPnl.binder.switchGuardBtn:setInactiveImage( "gui/hud3/CW_daemon_yellow_btn_down.png" )
	mainframe_panel._panel.binder.ControlPnl.binder.switchGuardBtn:setActiveImage( "gui/hud3/CW_daemon_yellow_btn_up.png" )
	mainframe_panel._panel.binder.ControlPnl.binder.switchGuardBtn:setHoverImage( "gui/hud3/CW_daemon_yellow_btn_up.png" )

	if mode == DP_MODE_DAEMON then
		mainframe_panel._panel.binder.ControlPnl.binder.switchDaemonBtn:setImages( "gui/hud3/CW_daemon_red_btn_active.png" )
		mainframe_panel._panel.binder.daemonPanel:setVisible(true)
		mainframe_panel._panel.binder.guardPanel:setVisible(false)
	elseif mode == DP_MODE_GUARD then
		mainframe_panel._panel.binder.ControlPnl.binder.switchGuardBtn:setImages( "gui/hud3/CW_daemon_yellow_btn_active.png" )
		mainframe_panel._panel.binder.daemonPanel:setVisible(false)
		mainframe_panel._panel.binder.guardPanel:setVisible(true)
	end

	mainframe_panel:refresh()
end

local baseCreateHud = hud.createHud
hud.createHud = function( ... )
	local hud_i = baseCreateHud( ... )

	local mainframe_panel = hud_i._mainframe_panel
	if hud_i._game.simCore:getParams().difficultyOptions.CW_CAMPAIGN then
		onDaemonPanelSwitch (mainframe_panel, DP_MODE_DAEMON)
		mainframe_panel._panel.binder.guardPanel.binder.daemonPnlTitle:setText(STRINGS.C_WAR.HUD.GUARD_DAEMONS)
		mainframe_panel._panel.binder.ControlPnl.binder.switchDaemonBtn.onClick = function() onDaemonPanelSwitch( mainframe_panel,  DP_MODE_DAEMON) end
		mainframe_panel._panel.binder.ControlPnl.binder.switchGuardBtn.onClick = function() onDaemonPanelSwitch( mainframe_panel,  DP_MODE_GUARD) end
	end
	return hud_i
end
