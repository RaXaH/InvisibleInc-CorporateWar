local util = include( "client_util" )

local mainframe_common = include("sim/abilities/mainframe_common")


local DEFAULT_GUARD_DAEMON =
{

	getDuration = function(self, sim, duration)
		local player = sim:getPC()
		if type(duration) == "string" then
			return duration 
		else
			return math.max(duration + (player:getTraits().daemonDurationModd or 0),1)
		end
	end,

	canUseAbility = function( self, sim, player )
		-- Even though these are NPC abilities, only the PC can "use them" (eg. break the ice)
		return sim:getPC():getCpus() > 0
	end,

	onTooltip = function( self, hud, sim, player )
		local tooltip = util.tooltip( hud._screen )
		local section = tooltip:addSection()

		section:addLine( self.name )
		section:addAbility( self.shortdesc, self.desc, "gui/icons/action_icons/Action_icon_Small/icon-item_shoot_small.png" )

		if self.dlcFooter then
			section:addFooter(self.dlcFooter[1],self.dlcFooter[2])
		end

		return tooltip
	end,

	onTrigger = function( self, sim, evType, evData, userUnit )
		if evType == simdefs.TRG_END_TURN then
			local player = evData
			if player == sim:getCurrentPlayer() and player:isNPC() then
				if self.turns then
					self.turns = self.turns - 1
				
					if (self.turns or 0) == 0 then
						self:executeTimedAbility( sim, player )
					end					
				end
				if self.duration and not self.permanent then
					self.duration = self.duration - 1
					if (self.duration or 0) == 0 then
						self:executeTimedAbility( sim, player )
					end
				end
				if self.perpetual then
					self:executeTimedAbility( sim, player )
				end
			end
		end
	
	end,
}

function mainframe_common.createGuardDaemon(stringTbl)
	return util.extend( DEFAULT_GUARD_DAEMON )
		{
			name = stringTbl.NAME,
			desc = stringTbl.DESC,
			shortdesc = stringTbl.SHORT_DESC,
			activedesc = stringTbl.ACTIVE_DESC,
			guardDaemon = true,
			standardDaemon = false,
			reverseDaemon = false,
			ENDLESS_DAEMONS = false,
		     	PROGRAM_LIST = false,
		     	OMNI_PROGRAM_LIST_EASY = false,
		     	OMNI_PROGRAM_LIST = false,
		     	REVERSE_DAEMONS = false,
		}
end
