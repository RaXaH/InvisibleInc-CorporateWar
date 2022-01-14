local array = include("modules/array")
local simdefs = include("sim/simdefs")
local abilitydefs = include( "sim/abilitydefs" )
local simability = include( "sim/simability" )

local simplayer = include("sim/simplayer")
local pcplayer = include("sim/pcplayer")
local aiplayer = include("sim/aiplayer")

--Change deploy units to only the units active for the mission
function simplayer:deployUnits( sim, agentDefs )
	local deploy_cell, deploycells = nil, {}
	sim:forEachCell(
		function( deploycell )
			if deploycell.deployID and #deploycell.units == 0 then
				table.insert(deploycells,deploycell)
			end
		end )

	agentDefsActive = {}
	if sim:getParams().difficultyOptions.CW_CAMPAIGN then
		for i, agentID in ipairs(sim:getParams().agency.activeAgents) do
			table.insert(agentDefsActive, agentDefs[agentID])
		end
	else
		agentDefsActive = agentDefs
	end
	-- Deploy the agents as ther last thing we do!
	for _, agentDef in ipairs( agentDefsActive ) do
		local i
		deploy_cell, i = array.findIf( deploycells, function( c ) return c.deployID == (agentDef.deployID or simdefs.DEFAULT_EXITID) end )
		if deploy_cell then
			    deploy_cell = table.remove(deploycells, i)
			    self:deployUnit( sim, agentDef.id, deploy_cell, deploy_cell.deployFacing )
		else
		    log:write( "WARNING: couldn't deploy %s, no deploy_cells", agentDef.template )
		end
	end
end

--add guard daemon ->see addMainframeAbility - no reversal, no TRG_DAEMON_INSTALL, no notification -> it shouldnt be considered a daemon gameplay wise
function simplayer:addGuardDaemonAbility(sim, abilityID, hostUnit)
	if not self._guardDaemons then
		self._guardDaemons = {}
	end

	local count = 0
	for _, ability in ipairs( self._guardDaemons ) do
		if ability:getID() == abilityID then
			count = count + 1
		end
	end

	local ability = simability.create( abilityID )

	if ability and count < (ability.max_count or math.huge) then
		table.insert( self._guardDaemons, ability )
		ability:spawnAbility( self._sim, self, hostUnit )
	end
end

function simplayer:getGuardAbilities()
	return self._guardDaemons or {}
end

pcplayer.deployUnits = simplayer.deployUnits
aiplayer.addGuardDaemonAbility = simplayer.addGuardDaemonAbility
aiplayer.getGuardAbilities = simplayer.getGuardAbilities
