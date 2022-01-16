local STRINGS =
{
	OPTIONS =
	{
		PE_INTEGRATION = "Programs Extended - Integration",
		PE_INTEGRATION_DESC = "This will integrate content from Programs Extended into the Corporate War Campaign.",
		CW_CAMPAIGN = "Corporate War Campaign",
		CW_CAMPAIGN_DESC = "Description.",
	},
	AGENT_STATUS =
	{
		AVAILABLE = "AVAILABLE",
	},
	UI =
	{
		AGENTS = "AGENTS",
		INFILTRATION_LABEL = "BREACHING",
		LOADOUT_TITLE = "MISSION LOADOUT",
		LOADOUT_POPUP_TITLE = "SELECT AGENT",
		START_INFILTRATION = "> START BREACH",
		START_MISSION = "> START MISSION",
		CANCEL_INFILTRATION = "< CANCEL BREACH",
		BACK = "< BACK",
		SWITCH = "- SWITCH -",
		MAP_SCREEN_SITUATION_TIME = "%02d:%02d",
	},
	HUD =
	{
		GUARD_DAEMONS = "GUARD DAEMONS",
	},
	GUARD_DAEMONS =
	{
		IMPROVED_ARMOR =
		{
			NAME = "CHITON",
			DESC = "All guards get +1 ARMOR.",
			SHORT_DESC = "Boost Guard ARMOR",
			ACTIVE_DESC = "Guards have +1 ARMOR",
			REGION_DESC = "{1}'s guards will deploy with +1 armor.",
		},
		HOSTILE_AI =
		{
			NAME = "HOSTILE AI",
			DESC = "A hostile AI will assist the corporation with subroutines.",
			SHORT_DESC = "Deploys hostile AI",
			ACTIVE_DESC = "Deploys hostile AI",
			REGION_DESC = "{1} will deploy a hostile AI",
		},
		VIGILANCE =
		{
			NAME = "VIGILANCE",
			DESC = "The alarm level responses are improved.",
			SHORT_DESC = "Higher alarm responses",
			ACTIVE_DESC = "Higher alarm responses",
			REGION_DESC = "{1} will strenghen their alarm level responses.",
		},
	},
	PERSONEL_ACTIVITIES =
	{
		READY = "Ready",
		READY_DESC = "This employee is waiting for an assignment.",
		INTEL_RANDOM = "Finding mission",
		INTEL_RANDOM_DESC = "This employee is finding us the next best location in {1} territory we can strike.",
		INTEL_VAULT = "Finding vault",
		INTEL_VAULT_DESC = "This employee is finding us a suitable vault in {1} territory, were we can enrich ourselves.",
		INTEL_SERVER_FARM = "Finding Serverfarm",
		INTEL_SERVER_FARM_DESC = "This employee is finding us a {1} server, we can use to improve Incognita.",
		INTEL_NANOFAB = "Finding Nanofab",
		INTEL_NANOFAB_DESC = "This employee is finding us a nanofab in {1} territory, that is worth our while.",
		INTEL_DETENTION_CENTRE = "Finding detention centre",
		INTEL_DETENTION_CENTRE_DESC = "This employee is finding Invisible, Inc. agents or personnel in {1} custody, lost in the raid.",
		INTEL_CYBERLAB = "Finding cyberlab",
		INTEL_CYBERLAB_DESC = "This employee is finding us a {1} cyberlab, we can 'borrow' to improve our agents.",
		TRANSFER_REGION = "Transfer to an other region",
		TRANSFER_REGION_DESC = "Select a region for this employee to transfer to or select 'ready' to cancel the transfer. An agent needs {1} hours to transfer to an other region.",
		TO_FTM = "...to FTM",
		TO_SANKAKU = "...to Sankaku",
		TO_KO = "...to K&O",
		TO_PLASTECH = "...to Plastech",
		TO_CORP_DESC = "This employee is currently transferring to {1} territory. {2} h remaining until the transfer is complete.",
	},
}

return STRINGS
