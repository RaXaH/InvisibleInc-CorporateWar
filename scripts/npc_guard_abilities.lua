local mainframe_common = include("sim/abilities/mainframe_common")
local util = include( "modules/util" )

local createGuardDaemon = mainframe_common.createGuardDaemon

--guard daemons
--deploy limit: maximum number of instances, that can be deployed in one corp
--deploy table: list of guard levels, on which it can be deployed (weighted list inside)
--I chose this format, so I can just util.extend it to the serverdefs list
--TODO: Further split for different corps. Not all guard daemons might make sense for all corps (aka camera stuff for K&O or drone stuff only for sankaku...)
--force_deploy: list of guard levels, on which this daemon is forced to be picked
local guard_abilities =
{
	improved_armor = util.extend( createGuardDaemon( STRINGS.C_WAR.GUARD_DAEMONS.IMPROVED_ARMOR ) )
	{
		icon = "gui/icons/daemon_icons/Daemons_chiten.png",

		deploy_limit = 4,
		deploy_table =
		{
			[-1] =
			{
				improved_armor = 1,
			},
			[4] =
			{
				improved_armor = 1,
			},
			[5] =
			{
				improved_armor = 1,
			},
			[6] =
			{
				improved_armor = 1,
			},
			[7] =
			{
				improved_armor = 1,
			},
		},

		onSpawnAbility = function( self, sim, player)
			print("improved armor - onSpwan")
			if not player:getTraits().boostArmor then
				player:getTraits().boostArmor = 0
			end
			player:getTraits().boostArmor = player:getTraits().boostArmor + 1
		end,
		onDespawnAbility = function( self, sim )
			local player = sim:getNPC()
			player:getTraits().boostArmor = player:getTraits().boostArmor - 1
		end,
	},
}

return guard_abilities
