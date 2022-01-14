local mission_util = include("sim/missions/mission_util")
local util = include("client_util")

local baseMakeAgentConnection = mission_util.makeAgentConnection

function mission_util.makeAgentConnection( script, sim, ... )
	baseMakeAgentConnection( script, sim, ... )

	if sim:getParams().difficultyOptions.CW_CAMPAIGN then
		--PE integration
		if sim:getParams().difficultyOptions.PE_INTEGRATION then
			sim:getParams().difficultyOptions.W93_AI = -1
		end
		--Add the guard daemons to the game
		if sim:getParams().guardDaemons then
			for _, daemon in ipairs(sim:getParams().guardDaemons) do
				sim:getNPC():addGuardDaemonAbility(sim, daemon, sim:getNPC() )
			end
		end
	end
end
