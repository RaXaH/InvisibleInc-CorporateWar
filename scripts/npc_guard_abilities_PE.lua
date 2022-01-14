local mainframe_common = include("sim/abilities/mainframe_common")
local util = include( "modules/util" )

local createGuardDaemon = mainframe_common.createGuardDaemon

--PE specific guard daemons
--see npc_guard_abilities.lua
local guard_abilities =
{
	hostile_ai = util.extend( createGuardDaemon( STRINGS.C_WAR.GUARD_DAEMONS.HOSTILE_AI ) )
	{
		icon = "gui/icons/daemon_icons/icon-daemon_AI.png",

		deploy_limit = 1,
		force_deploy = {[6] = {"hostile_ai",},},
		deploy_table =
		{
			[0] =
			{
				hostile_ai = 1,
			},
			[1] =
			{
				hostile_ai = 1,
			},
			[2] =
			{
				hostile_ai = 1,
			},
			[3] =
			{
				hostile_ai = 1,
			},
			[4] =
			{
				hostile_ai = 1,
			},
			[5] =
			{
				hostile_ai = 1,
			},
		},

		onSpawnAbility = function( self, sim, player)
			print("hostile AI - on spawn")
			sim:getParams().difficultyOptions.W93_AI = 1
		end,
		onDespawnAbility = function( self, sim )
			sim:getParams().difficultyOptions.W93_AI = -1
		end,
	},
}

return guard_abilities
