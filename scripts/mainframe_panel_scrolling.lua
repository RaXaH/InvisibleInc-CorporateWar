--Copy Pasta from Cyberboy2000s Scrolling Daemons
local util = include("modules/util")
local mui_defs = include("mui/mui_defs")
local mui_scroller = include("mui/widgets/mui_scroller")

local panel = include("hud/mainframe_panel").panel
local oldRefresh = panel.refresh

local guardHandler = {
	daemonCount = 0,
	maxDaemons = 8,
	_scrollIndex = 0,
	refreshing = true,

	scrollItems = function( self, idx )
		local maxIndex = self.daemonCount - self.maxDaemons

		self._scrollIndex = math.max( 0, math.min( maxIndex, idx ))

		self.panel._panel.binder.guardPanel.binder.daemonScrollbar.binder.scrollbar:setValue( self._scrollIndex )

		if not self.refreshing then
			self.panel:refresh()
		end
	end,
}

local function _forEachIterator( state, i )
	local widget = state.binder:tryBind( state.name .. tostring(i + 1 - state.offset) )
	if widget == nil then
		return nil
	else
		return i + 1, widget
	end
end

function panel:refresh(primeRefresh)
	if self._hud._game.simCore:getParams().difficultyOptions.CW_CAMPAIGN then
		local daemonBinder = self._panel.binder.guardPanel.binder

		if not self.guardHandler then
			self.guardHandler = util.tcopy(guardHandler)
			self.guardHandler.panel = self

			daemonBinder.daemonScroller._cont.handleInputEvent = function( container, ev )
				if ev.eventType == mui_defs.EVENT_MouseWheel and self.guardHandler.daemonCount > self.guardHandler.maxDaemons then
					if ev.delta > 0 then
						self.guardHandler:scrollItems( self.guardHandler._scrollIndex - 1 )
					elseif ev.delta < 0 then
						self.guardHandler:scrollItems( self.guardHandler._scrollIndex + 1 )
					end
					return true
				end

				return false
			end

			daemonBinder.daemonScrollbar.binder.scrollbar:setSize(nil,468)
			daemonBinder.daemonScrollbar.binder.scrollbar.onValueChanged = function( scrollbar, value )
				self.guardHandler:scrollItems( value )
			end

			daemonBinder.forEach = function( binder, name, i )
				local offset = 0

				if name == "enemyAbility" then
					offset = self.guardHandler._scrollIndex
				end

				return _forEachIterator, { name = name, binder = binder, offset = offset }, i or offset
			end
			self._panel.binder.forEach = daemonBinder.forEach
		end

		self.guardHandler.refreshing = true
		local W, H = self._hud._screen:getResolution()
		local daemons = #self._hud._game.simCore:getNPC():getGuardAbilities()

		if daemons ~= self.guardHandler.daemonCount or H ~= self.guardHandler.resolution then
			self.guardHandler.resolution = H
			H = math.min(1080, math.max(720, H))
			local max = math.floor((H - 365) / 59)
			self.guardHandler.maxDaemons = max

			daemonBinder.daemonScrollbar.binder.scrollbar:setSize(nil,59 * max - 5)
			daemonBinder.daemonScrollbar.binder.scrollbar:setPosition(nil,-29.5 * max + 188.5)
			daemonBinder.daemonScroller:setSize(nil,59 * max - 5)
			daemonBinder.daemonScroller:setPosition(nil,-29.5 * max - 13)

			self.guardHandler.daemonCount = daemons
			local count = daemons - self.guardHandler.maxDaemons
			if count > 0 then
				daemonBinder.daemonScrollbar.binder.scrollbar:setRange( 0, count )
				daemonBinder.daemonScrollbar:setVisible( true )
				daemonBinder.daemonScroller:setVisible( true )
			else
				daemonBinder.daemonScrollbar.binder.scrollbar:setRange( 0, 0 )
				daemonBinder.daemonScrollbar:setVisible( false )
				daemonBinder.daemonScroller:setVisible( false )
			end
		end
	end

	oldRefresh(self,primeRefresh)

	if self._hud._game.simCore:getParams().difficultyOptions.CW_CAMPAIGN then
		for i, widget in _forEachIterator, { name = "enemyAbility", binder = daemonBinder, offset = 0 }, 0 do
			if i > self.guardHandler.maxDaemons then
				widget:setVisible(false)
			end
		end

		self.guardHandler.refreshing = false
	end
end
