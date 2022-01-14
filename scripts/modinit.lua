local util = include("client_util")

local function earlyInit(modApi)
	modApi.requirements =
	{
		"Sim Constructor",
		"Contingency Plan",
		"Scrolling Daemons",
		"Programs Extended",
	}
end

local function initStrings( modApi )
	local dataPath = modApi:getDataPath()
	local scriptPath = modApi:getScriptPath()

	local C_WAR_STRINGS = include( scriptPath .. "/strings" )
	modApi:addStrings( dataPath, "C_WAR", C_WAR_STRINGS )
end

local function init( modApi )
	local scriptPath = modApi:getScriptPath()
	local dataPath = modApi:getDataPath()

	KLEIResourceMgr.MountPackage( dataPath .. "/gui.kwad", "data" )

	include( scriptPath.."/mui_group" )
	include( scriptPath.."/mui_image" )
	include( scriptPath.."/mui_progressbar" )
	include( scriptPath.."/mui_combobox" )
	include( scriptPath.."/mui_imagebutton" )

	include( scriptPath.."/mainframe_common" )
	include( scriptPath.."/state-upgrade-screen" )
	include( scriptPath.."/state-map-screen" )
	include( scriptPath.."/simdefs" )
	include( scriptPath.."/mui" )
	include( scriptPath.."/serverdefs" )
	include( scriptPath.."/simplayer" )
	--include( scriptPath.."/pcplayer" )
	include( scriptPath.."/mission_util" )
	include( scriptPath.."/simparams" )
	include( scriptPath.."/hud" )
	include( scriptPath.."/mainframe_panel" )
	include( scriptPath.."/mainframe_panel_scrolling" )

	modApi:addGenerationOption( "CW_campaign", STRINGS.C_WAR.OPTIONS.CW_CAMPAIGN, STRINGS.C_WAR.OPTIONS.CW_CAMPAIGN_DESC )

	if mod_manager:findModByName("Programs Extended") then
		modApi:addGenerationOption( "PE_integration", STRINGS.C_WAR.OPTIONS.PE_INTEGRATION, STRINGS.C_WAR.OPTIONS.PE_INTEGRATION_DESC, {noUpdate = true, value = true})
	end
end

local function load( modApi, options, params, mod_options )
	local scriptPath = modApi:getScriptPath()
	local dataPath = modApi:getDataPath()
	package.loaded[scriptPath .. "/serverdefs"] = nil
	include( scriptPath.."/serverdefs" )

	local serverdefs = include( "modules/serverdefs" )

	modApi:insertUIElements( include( scriptPath.."/CW_hud_x" ) )

	--TODO: Temporary option! Remove this after integration with SC!
	local simdefs = include("sim/simdefs")
	simdefs.SCREENS["upgrade_screen.lua"] = "upgrade_screen.lua"
	simdefs.SCREENS["map_screen.lua"] = "map_screen.lua"
	---------
	if params then
		params.CW_CAMPAIGN = false
	end

	if options["CW_campaign"].enabled then
		--------------
		simdefs.SCREENS["upgrade_screen.lua"] = "CW_upgrade_screen.lua"
		simdefs.SCREENS["map_screen.lua"] = "CW_map_screen.lua"
		--------------
		local npc_guard_abilities = include( scriptPath .. "/npc_guard_abilities" )
		for name, ability in pairs(npc_guard_abilities) do
	    	modApi:addDaemonAbility( name, ability )
			if ability.deploy_table then
				local GUARD_DAEMON_LEVEL_NEW = util.extend(serverdefs.GUARD_DAEMON_LEVEL) (ability.deploy_table)
				serverdefs.GUARD_DAEMON_LEVEL = GUARD_DAEMON_LEVEL_NEW
			end
			if ability.force_deploy then
				local GUARD_DAEMON_LEVEL_FORCE_NEW = util.extend(serverdefs.GUARD_DAEMON_LEVEL_FORCE) (ability.force_deploy)
				serverdefs.GUARD_DAEMON_LEVEL_FORCE = GUARD_DAEMON_LEVEL_FORCE_NEW
			end
		end
		if params then
			params.CW_CAMPAIGN = true
		end
	end

	----------------------
	----PE Integration----
	----------------------
	local PE_id = mod_manager:findModByName("Programs Extended").id
	if params then
		params.PE_INTEGRATION = false
	end
	if options["PE_integration"] and options["PE_integration"].enabled and PE_id and mod_options[PE_id] and mod_options[PE_id].enabled then
		if mod_options[PE_id].options["counter_ai"].value >= 1 then
			if params then
				params.PE_INTEGRATION = true
			end
			local guard_abilities_PE = include(scriptPath.."/npc_guard_abilities_PE")
			for name, ability in pairs(guard_abilities_PE) do
				modApi:addDaemonAbility( name, ability )
				if ability.deploy_table then
					local GUARD_DAEMON_LEVEL_NEW = util.extend(serverdefs.GUARD_DAEMON_LEVEL) (ability.deploy_table)
					serverdefs.GUARD_DAEMON_LEVEL = GUARD_DAEMON_LEVEL_NEW
				end
				if ability.force_deploy then
					local GUARD_DAEMON_LEVEL_FORCE_NEW = util.extend(serverdefs.GUARD_DAEMON_LEVEL_FORCE) (ability.force_deploy)
					serverdefs.GUARD_DAEMON_LEVEL_FORCE = GUARD_DAEMON_LEVEL_FORCE_NEW
				end
			end
		end
	end
	----------------------------------
end

local function unload( modApi, mod_options, params )
	local simdefs = include("sim/simdefs")
	simdefs.SCREENS["upgrade_screen.lua"] = "upgrade_screen.lua"
	simdefs.SCREENS["map_screen.lua"] = "map_screen.lua"

	if params then
		params.CW_CAMPAIGN = false
	end
end

return {
	init = init,
	load = load,
	unload = unload,
	initStrings = initStrings,
	earlyInit = earlyInit,
}
