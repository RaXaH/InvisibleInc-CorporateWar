local util = include("client_util")
local agentdefs = include("sim/unitdefs/agentdefs")
local rand = include( "modules/rand" )
local simdefs = include("sim/simdefs")

local serverdefs = include( "modules/serverdefs" )

--TODO: Neptune support

--all of this is needed, because vanilla serverdefs.getCorpData requires a situation and not just corpName, so you can't get the corpData from serverdefs without a situation :/
--right now I just expose HEAD_CORP_TEMPLATES in serverdefs
--TODO: might need a better solution for neptune support
local BLOB_STYLES =
{
	FTM =
	{
		{
			size = 2,
			anims = { 'r3','p3' },
		},
		{
			size = 3,
			anims = { 'r4','p4' },
		},
		{
			size = 4,
			anims = { 'r5','p5' },
		},
		{
			size = 5,
			anims = { 'r5','p5' },
		},
	},
    KO =
	{
		{
			size = 2,
			anims = { 'g3','m3' },
		},
		{
			size = 3,
			anims = { 'g4','m4' },
		},
		{
			size = 4,
			anims = { 'g5','m5' },
		},
		{
			size = 5,
			anims = { 'g5','m5' },
		},
	},
    OMNI =
	{
		{
			size = 2,
			anims = { 'j3','y3' },
		},
		{
			size = 3,
			anims = { 'j4','y4' },
		},
		{
			size = 4,
			anims = { 'j5','y5' },
		},
		{
			size = 5,
			anims = { 'j5','y5' },
		},
	},
    SANKAKU =
	{
		{
			size = 2,
			anims = { 'c3','b3','p3' },
		},
		{
			size = 3,
			anims = { 'c4','b4','p4' },
		},
		{
			size = 4,
			anims = { 'c5','b5','p5' },
		},
		{
			size = 5,
			anims = { 'c5','b5','p5' },
		},
	},
    PLASTECH =
	{
		{
			size = 2,
			anims = { 'j3','y3' },
		},
		{
			size = 3,
			anims = { 'j4','y4' },
		},
		{
			size = 4,
			anims = { 'j5','y5' },
		},
		{
			size = 5,
			anims = { 'j5','y5' },
		},
	},
}

local HEAD_CORP_TEMPLATES = {
	ftm =
	{
		stringTable = STRINGS.CORP.FTM,
		shortname = "FTM", -- Not a UI string, used for debug and path concatenation purposes.
		logo = "gui/corp_preview/logo_sankaku.png",

		corpColor={ r=63/255,g=74/255,b=107/255 },
		imgs = {shop="gui/store/STORE_FTM_bg.png",logo="gui/menu pages/corp_select/CP_FTMLogo1.png",logoLarge = "gui/corps/logo_FTM.png"},
		music = "SpySociety/Music/music_FTM",
		region = "na",
		world = "ftm",
		overlayBlobStyles = BLOB_STYLES.FTM,
	},

	omni =
	{
		stringTable = STRINGS.CORP.OMNI,
		shortname = "OMNI", -- Not a UI string, used for debug and path concatenation purposes.
		logo = "gui/corp_preview/logo_sankaku.png",

		corpColor={r=148/255,g=12/255,b=12/255,a=1},
		imgs = {shop="gui/store/STORE_Sankaku_bg.png",logo="gui/menu pages/corp_select/CP_SankakuLogo1.png",logoLarge = "gui/corps/logo_omni.png"},
		music = "SpySociety/Music/music_FinalLevel",
		region = "omni",
		world = "omni",
		overlayBlobStyles = BLOB_STYLES.OMNI,
	},
	omni2 =
	{
		stringTable = STRINGS.CORP.OMNI,
		shortname = "OMNI", -- Not a UI string, used for debug and path concatenation purposes.
		logo = "gui/corp_preview/logo_sankaku.png",

		corpColor={r=148/255,g=12/255,b=12/255,a=1},
		imgs = {shop="gui/store/STORE_Sankaku_bg.png",logo="gui/menu pages/corp_select/CP_SankakuLogo1.png",logoLarge = "gui/corps/logo_omni.png"},
		music = "SpySociety/Music/music_FinalLevel",
		region = "omni",
		world = "omni2",
		overlayBlobStyles = BLOB_STYLES.OMNI,
	},

	sankaku =
	{
		stringTable = STRINGS.CORP.SANKAKU,
		shortname = "SANKAKU", -- Not a UI string, used for debug and path concatenation purposes.
		logo = "gui/corp_preview/logo_sankaku.png",

		corpColor={r=23/255,g=142/255,b=161/255,a=1},
		imgs = {shop="gui/store/STORE_Sankaku_bg.png",logo="gui/menu pages/corp_select/CP_SankakuLogo1.png",logoLarge = "gui/corps/logo_sankaku.png"},
		music = "SpySociety/Music/music_Sankaku",
		region = "asia",
		world = "sankaku",
		overlayBlobStyles = BLOB_STYLES.SANKAKU,
	},

	ko = {
		stringTable = STRINGS.CORP.KO,
		shortname = "KO", -- Not a UI string, used for debug and path concatenation purposes.
		logo = "gui/corp_preview/logo_k&o.png",

		corpColor={r=120/255,g=40/255,b=40/255,a=1},
		imgs = {shop="gui/store/STORE_KO_bg.png",logo="gui/menu pages/corp_select/CP_KOLogo1.png",logoLarge = "gui/corps/logo_KandO.png"},
		music = "SpySociety/Music/music_KandO",
		region = "europe",
		world = "ko",
		overlayBlobStyles = BLOB_STYLES.KO,
	},

	plastech = {
		stringTable = STRINGS.CORP.PLASTECH,
		shortname = "PLASTECH", -- Not a UI string, used for debug and path concatenation purposes.
		logo = "gui/corp_preview/logo_sankaku.png",

		corpColor={r=242/255,g=234/255,b=162/255,a=1},
		imgs = {shop="gui/store/STORE_Plastech_bg.png",logo="gui/menu pages/corp_select/CP_PlastechLogo1.png",logoLarge = "gui/corps/logo_plastech.png"},
		music = "SpySociety/Music/music_Plastek",
		region = "sa",
		world = "plastech",
		overlayBlobStyles = BLOB_STYLES.PLASTECH,
	}
}

---------------------------------------
----Stuff for Infiltration mechanic----
---------------------------------------
--add infiltration data to SITUATIONS
local SITUATIONS_CW =
{
	default =
	{
		duration = 1440,		--how long will that situation be available on the map in minutes
		intel_threshold = {min=3300, max=4300},
		infiltration_time = 720,			--infiltration time in minutes needed for 100%
		infiltration_penalty = {0, 120, 180, 240},	--additional infiltration time needed in minutes for 1st, 2nd, 3rd, 4th agent
		random_weight = 0,
	},
	vault =
	{
		duration = 1440,
		intel_threshold = {min=3300, max=4300},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
		random_weight = 1,
	},
	server_farm =
	{
		duration = 1440,
		intel_threshold = {min=3300, max=4300},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
		random_weight = 1,
	},
	nanofab =
	{
		duration = 1440,
		intel_threshold = {min=3300, max=4300},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
		random_weight = 1,
	},
	detention_centre =
	{
		duration = 1440,
		intel_threshold = {min=3300, max=4300},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
		random_weight = 1,
	},
	ceo_office =
	{
		duration = 1440,
		intel_threshold = {min=3300, max=4300},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
		random_weight = 0
	},
	cyberlab =
	{
		duration = 1440,
		intel_threshold = {min=3300, max=4300},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
		random_weight = 1,
	},
	executive_terminals =
	{
		duration = 1440,
		intel_threshold = {min=3300, max=4300},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
		random_weight = 0,
	},

}

local function AppendSituations()
	local SITUATIONS = {}
	for name, data in pairs(serverdefs.SITUATIONS) do
		SITUATIONS[name] = util.extend(serverdefs.SITUATIONS[name]) (SITUATIONS_CW[name] or SITUATIONS_CW["default"])
	end
	serverdefs.SITUATIONS = SITUATIONS
end

serverdefs.HEAD_CORP_TEMPLATES = HEAD_CORP_TEMPLATES
AppendSituations()

--------------------------------------
----Stuff for corporation progress----
--------------------------------------
serverdefs.GUARD_DAEMON_LEVEL = {}
serverdefs.GUARD_DAEMON_LEVEL_FORCE = {}

local regions = {"ftm", "sankaku", "ko", "plastech"}
--TODO: replace this by generation options or manipulate it...
local guard_xp_per_level = 1500

--pick a guard daemon from weighted list
--TODO: add force deploy
local function pickGuardDaemon(level, gen)
	local daemonList = serverdefs.GUARD_DAEMON_LEVEL[level] or serverdefs.GUARD_DAEMON_LEVEL[-1]
	local dameonListWeighted = util.weighted_list(daemonList)
	local wt = gen:nextInt(1, dameonListWeighted:getTotalWeight())
	local daemon = dameonListWeighted:getChoice( wt )

	return daemon
end

--advance the progress of a corp
--1xp = 1minute
--TODO: probably needs to be exposed? --> use own gen then
local function advanceGuardProgress(campaign, corp, value, gen)
	local level_ups = 0
	local corpProgress = campaign.corpProgress[corp]
	if value and corpProgress then
		corpProgress.guard_xp = corpProgress.guard_xp + value
		if corpProgress.guard_xp >= guard_xp_per_level then
			level_ups = math.floor(corpProgress.guard_xp / guard_xp_per_level)
			corpProgress.guard_xp = corpProgress.guard_xp % guard_xp_per_level
		end
	end
	while level_ups > 0 do
		level_ups = level_ups - 1
		local daemon = pickGuardDaemon(corpProgress.guard_level, gen)
		print("add ", daemon, " to ", corp)
		table.insert(corpProgress.guard_daemons, daemon)
		corpProgress.guard_level = corpProgress.guard_level + 1
	end
end

function serverdefs.getGuardProgress(campaign, corp)
	return (campaign.corpProgress[corp].guard_xp / guard_xp_per_level)
end

--------------------------------------------
----Stuff for agency personel management----
--------------------------------------------
--TODO: everything XD
--Personel can have jobs assigned, which gives a benefit for the region they are in.
--Main purpose of this is to have them collect intel, to find missions. Intel can be collected towards a certain mission type. This is, so run variance is decreased, since getting detention centres early on will be extremely important in this mode.
--But additional activities can be implemented as wished, like collecting credits, crafting items, maybe in far far future: do research...
serverdefs.ALL_ACTIVITIES = {"ready", "intel_random", "intel_vault", "intel_server_farm", "intel_nanofab", "intel_detention_centre", "intel_cyberlab", "transfer_region"}
serverdefs.TRANSFER_ACTIVITIES = {"ready", "to_ftm", "to_sankaku", "to_ko", "to_plastech"}

local PERSONEL_ACTIVITIES =
{
	ready =
	{
		ui = STRINGS.C_WAR.PERSONEL_ACTIVITIES.READY,
		onMinutePassed = function(self, personel, campaign)

		end,
		getAvailableActivities = function(self, personel, campaign)
			local activities = serverdefs.ALL_ACTIVITIES

			return activities
		end,
		onSelectAbility = function(self, personel, campaign)
			print("ready assigned")
		end,
		onTooltip = function(self, tooltip, personel, campaign)
			local corp = personel.assignedRegion
			local section = tooltip:addSection()
			section:addLine(STRINGS.C_WAR.PERSONEL_ACTIVITIES.READY)
			section:addDesc(STRINGS.C_WAR.PERSONEL_ACTIVITIES.READY_DESC)
		end,
	},

	intel_random =
	{
		ui = STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_RANDOM,
		onMinutePassed = function(self, personel, campaign)
			local corp = personel.assignedRegion
			if campaign.corpProgress[corp].situation_intel["random"] then
				if campaign.corpProgress[corp].situation_intel["random"].presented then
					campaign.corpProgress[corp].situation_intel["random"] = nil
				end
			end
			if not campaign.corpProgress[corp].situation_intel["random"] then
				--create new situation
				local gen = rand.createGenerator( campaign.seed )
				local situation_choices = util.weighted_list()
				for situation_name, potential_situation in pairs(serverdefs.SITUATIONS) do
					if potential_situation.random_weight > 0 then
						situation_choices:addChoice( potential_situation.tags, potential_situation.random_weight )
					end
				end
				local wt = gen:nextInt(1, situation_choices:getTotalWeight())
				local situation_location = situation_choices:getChoice( wt )[1]
				local tags = {situation_location, corp}
				local day = math.floor(campaign.game_time/1440) +1
				campaign.seed = gen._seed --do it here, before createCampaignSituations messes with it again
				serverdefs.createCampaignSituations( campaign, 1, tags, day )
				campaign.corpProgress[corp].situation_intel["random"] = campaign.situations[#campaign.situations]
			end
			campaign.corpProgress[corp].situation_intel["random"].intel = campaign.corpProgress[corp].situation_intel["random"].intel + 4
		end,
		getAvailableActivities = function(self, personel, campaign)
			local activities = serverdefs.ALL_ACTIVITIES

			return activities
		end,
		onSelectAbility = function(self, personel, campaign)
			print("intel random assigned")
		end,
		onTooltip = function(self, tooltip, personel, campaign)
			local corp = personel.assignedRegion
			local section = tooltip:addSection()
			section:addLine(STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_RANDOM)
			section:addDesc( util.sformat(STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_RANDOM_DESC, serverdefs.HEAD_CORP_TEMPLATES[corp].stringTable.SHORTNAME) )
		end,
	},

	intel_vault =
	{
		ui = STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_VAULT,
		onMinutePassed = function(self, personel, campaign)
			local corp = personel.assignedRegion
			if campaign.corpProgress[corp].situation_intel["vault"] then
				if campaign.corpProgress[corp].situation_intel["vault"].presented then
					campaign.corpProgress[corp].situation_intel["vault"] = nil
				end
			end
			if not campaign.corpProgress[corp].situation_intel["vault"] then
				--create new situation
				local situation_location = "vault"
				local tags = {situation_location, corp}
				local day = math.floor(campaign.game_time/1440) +1
				serverdefs.createCampaignSituations( campaign, 1, tags, day )
				campaign.corpProgress[corp].situation_intel["vault"] = campaign.situations[#campaign.situations]
			end
			campaign.corpProgress[corp].situation_intel["vault"].intel = campaign.corpProgress[corp].situation_intel["vault"].intel + 3
		end,
		getAvailableActivities = function(self, personel, campaign)
			local activities = serverdefs.ALL_ACTIVITIES

			return activities
		end,
		onSelectAbility = function(self, personel, campaign)
			print("intel vault assigned")
		end,
		onTooltip = function(self, tooltip, personel, campaign)
			local corp = personel.assignedRegion
			local section = tooltip:addSection()
			section:addLine(STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_VAULT)
			section:addDesc( util.sformat(STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_VAULT_DESC, serverdefs.HEAD_CORP_TEMPLATES[corp].stringTable.SHORTNAME) )
		end,
	},

	intel_server_farm =
	{
		ui = STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_SERVER_FARM,
		onMinutePassed = function(self, personel, campaign)
			local corp = personel.assignedRegion
			if campaign.corpProgress[corp].situation_intel["server_farm"] then
				if campaign.corpProgress[corp].situation_intel["server_farm"].presented then
					campaign.corpProgress[corp].situation_intel["server_farm"] = nil
				end
			end
			if not campaign.corpProgress[corp].situation_intel["server_farm"] then
				--create new situation
				local situation_location = "server_farm"
				local tags = {situation_location, corp}
				local day = math.floor(campaign.game_time/1440) +1
				serverdefs.createCampaignSituations( campaign, 1, tags, day )
				campaign.corpProgress[corp].situation_intel["server_farm"] = campaign.situations[#campaign.situations]
			end
			campaign.corpProgress[corp].situation_intel["server_farm"].intel = campaign.corpProgress[corp].situation_intel["server_farm"].intel + 3
		end,
		getAvailableActivities = function(self, personel, campaign)
			local activities = serverdefs.ALL_ACTIVITIES

			return activities
		end,
		onSelectAbility = function(self, personel, campaign)
			print("intel server_farm assigned")
		end,
		onTooltip = function(self, tooltip, personel, campaign)
			local corp = personel.assignedRegion
			local section = tooltip:addSection()
			section:addLine(STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_SERVER_FARM)
			section:addDesc( util.sformat(STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_SERVER_FARM_DESC, serverdefs.HEAD_CORP_TEMPLATES[corp].stringTable.SHORTNAME) )
		end,
	},

	intel_nanofab =
	{
		ui = STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_NANOFAB,
		onMinutePassed = function(self, personel, campaign)
			local corp = personel.assignedRegion
			if campaign.corpProgress[corp].situation_intel["nanofab"] then
				if campaign.corpProgress[corp].situation_intel["nanofab"].presented then
					campaign.corpProgress[corp].situation_intel["nanofab"] = nil
				end
			end
			if not campaign.corpProgress[corp].situation_intel["nanofab"] then
				--create new situation
				local situation_location = "nanofab"
				local tags = {situation_location, corp}
				local day = math.floor(campaign.game_time/1440) +1
				serverdefs.createCampaignSituations( campaign, 1, tags, day )
				campaign.corpProgress[corp].situation_intel["nanofab"] = campaign.situations[#campaign.situations]
			end
			campaign.corpProgress[corp].situation_intel["nanofab"].intel = campaign.corpProgress[corp].situation_intel["nanofab"].intel + 3
		end,
		getAvailableActivities = function(self, personel, campaign)
			local activities = serverdefs.ALL_ACTIVITIES

			return activities
		end,
		onSelectAbility = function(self, personel, campaign)
			print("intel nanofab assigned")
		end,
		onTooltip = function(self, tooltip, personel, campaign)
			local corp = personel.assignedRegion
			local section = tooltip:addSection()
			section:addLine(STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_NANOFAB)
			section:addDesc( util.sformat(STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_NANOFAB_DESC, serverdefs.HEAD_CORP_TEMPLATES[corp].stringTable.SHORTNAME) )
		end,
	},

	intel_detention_centre =
	{
		ui = STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_DETENTION_CENTRE,
		onMinutePassed = function(self, personel, campaign)
			local corp = personel.assignedRegion
			if campaign.corpProgress[corp].situation_intel["detention_centre"] then
				if campaign.corpProgress[corp].situation_intel["detention_centre"].presented then
					campaign.corpProgress[corp].situation_intel["detention_centre"] = nil
				end
			end
			if not campaign.corpProgress[corp].situation_intel["detention_centre"] then
				--create new situation
				local situation_location = "detention_centre"
				local tags = {situation_location, corp}
				local day = math.floor(campaign.game_time/1440) +1
				serverdefs.createCampaignSituations( campaign, 1, tags, day )
				campaign.corpProgress[corp].situation_intel["detention_centre"] = campaign.situations[#campaign.situations]
			end
			campaign.corpProgress[corp].situation_intel["detention_centre"].intel = campaign.corpProgress[corp].situation_intel["detention_centre"].intel + 3
		end,
		getAvailableActivities = function(self, personel, campaign)
			local activities = serverdefs.ALL_ACTIVITIES

			return activities
		end,
		onSelectAbility = function(self, personel, campaign)
			print("intel detention_centre assigned")
		end,
		onTooltip = function(self, tooltip, personel, campaign)
			local corp = personel.assignedRegion
			local section = tooltip:addSection()
			section:addLine(STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_DETENTION_CENTRE)
			section:addDesc( util.sformat(STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_DETENTION_CENTRE_DESC, serverdefs.HEAD_CORP_TEMPLATES[corp].stringTable.SHORTNAME) )
		end,
	},

	intel_cyberlab =
	{
		ui = STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_CYBERLAB,
		onMinutePassed = function(self, personel, campaign)
			local corp = personel.assignedRegion
			if campaign.corpProgress[corp].situation_intel["cyberlab"] then
				if campaign.corpProgress[corp].situation_intel["cyberlab"].presented then
					campaign.corpProgress[corp].situation_intel["cyberlab"] = nil
				end
			end
			if not campaign.corpProgress[corp].situation_intel["cyberlab"] then
				--create new situation
				local situation_location = "cyberlab"
				local tags = {situation_location, corp}
				local day = math.floor(campaign.game_time/1440) +1
				serverdefs.createCampaignSituations( campaign, 1, tags, day )
				campaign.corpProgress[corp].situation_intel["cyberlab"] = campaign.situations[#campaign.situations]
			end
			campaign.corpProgress[corp].situation_intel["cyberlab"].intel = campaign.corpProgress[corp].situation_intel["cyberlab"].intel + 3
		end,
		getAvailableActivities = function(self, personel, campaign)
			local activities = serverdefs.ALL_ACTIVITIES

			return activities
		end,
		onSelectAbility = function(self, personel, campaign)
			print("intel cyberlab assigned")
		end,
		onTooltip = function(self, tooltip, personel, campaign)
			local corp = personel.assignedRegion
			local section = tooltip:addSection()
			section:addLine(STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_CYBERLAB)
			section:addDesc( util.sformat(STRINGS.C_WAR.PERSONEL_ACTIVITIES.INTEL_CYBERLAB_DESC, serverdefs.HEAD_CORP_TEMPLATES[corp].stringTable.SHORTNAME) )
		end,
	},

	transfer_region =
	{
		ui = STRINGS.C_WAR.PERSONEL_ACTIVITIES.TRANSFER_REGION,
		onMinutePassed = function(self, personel, campaign) end,
		getAvailableActivities = function(self, personel, campaign)
			local activities = serverdefs.TRANSFER_ACTIVITIES
			for index, activity in ipairs(activities) do
				if activity == "to_" .. personel.assignedRegion then
					table.remove(activities, index)
					break
				end
			end

			return activities
		end,
		onSelectAbility = function(self, personel, campaign)
			print("transfer assigned")
		end,
		onTooltip = function(self, tooltip, personel, campaign)
			local section = tooltip:addSection()
			section:addLine(STRINGS.C_WAR.PERSONEL_ACTIVITIES.TRANSFER_REGION)
			section:addDesc( util.sformat(STRINGS.C_WAR.PERSONEL_ACTIVITIES.TRANSFER_REGION_DESC, "3" ) )
		end,
	},

	to_ftm =
	{
		ui = STRINGS.C_WAR.PERSONEL_ACTIVITIES.TO_FTM,
		onMinutePassed = function(self, personel, campaign)
			personel.cooldown = personel.cooldown - 1
			if personel.cooldown <= 0 then
				personel.assignedActivity = "ready"
				personel.assignedRegion = "ftm"
				personel.cooldown = 0
			end
		end,
		getAvailableActivities = function(self, personel, campaign)
			local activities = {}

			return activities
		end,
		onSelectAbility = function(self, personel, campaign)
			print("transfer to ftm assigned")
			personel.cooldown = 180
		end,
		onTooltip = function(self, tooltip, personel, campaign)
			local corp = "ftm"
			local section = tooltip:addSection()
			section:addLine(STRINGS.C_WAR.PERSONEL_ACTIVITIES.TO_FTM)
			local hours = math.floor(personel.cooldown / 60)
			local minutes = personel.cooldown % 60
			section:addDesc( util.sformat(STRINGS.C_WAR.PERSONEL_ACTIVITIES.TO_CORP_DESC, serverdefs.HEAD_CORP_TEMPLATES[corp].stringTable.SHORTNAME, string.format(STRINGS.C_WAR.UI.MAP_SCREEN_SITUATION_TIME, hours, minutes) ) )
		end,
	},

	to_sankaku =
	{
		ui = STRINGS.C_WAR.PERSONEL_ACTIVITIES.TO_SANKAKU,
		onMinutePassed = function(self, personel, campaign)
			personel.cooldown = personel.cooldown - 1
			if personel.cooldown <= 0 then
				personel.assignedActivity = "ready"
				personel.assignedRegion = "sankaku"
				personel.cooldown = 0
			end
		end,
		getAvailableActivities = function(self, personel, campaign)
			local activities = {}

			return activities
		end,
		onSelectAbility = function(self, personel, campaign)
			print("transfer to ftm assigned")
			personel.cooldown = 180
		end,
		onTooltip = function(self, tooltip, personel, campaign)
			local corp = "sankaku"
			local section = tooltip:addSection()
			section:addLine(STRINGS.C_WAR.PERSONEL_ACTIVITIES.TO_SANKAKU)
			local hours = math.floor(personel.cooldown / 60)
			local minutes = personel.cooldown % 60
			section:addDesc( util.sformat(STRINGS.C_WAR.PERSONEL_ACTIVITIES.TO_CORP_DESC, serverdefs.HEAD_CORP_TEMPLATES[corp].stringTable.SHORTNAME, string.format(STRINGS.C_WAR.UI.MAP_SCREEN_SITUATION_TIME, hours, minutes) ) )
		end,
	},

	to_ko =
	{
		ui = STRINGS.C_WAR.PERSONEL_ACTIVITIES.TO_KO,
		onMinutePassed = function(self, personel, campaign)
			personel.cooldown = personel.cooldown - 1
			if personel.cooldown <= 0 then
				personel.assignedActivity = "ready"
				personel.assignedRegion = "ko"
				personel.cooldown = 0
			end
		end,
		getAvailableActivities = function(self, personel, campaign)
			local activities = {}

			return activities
		end,
		onSelectAbility = function(self, personel, campaign)
			print("transfer to ftm assigned")
			personel.cooldown = 180
		end,
		onTooltip = function(self, tooltip, personel, campaign)
			local corp = "ko"
			local section = tooltip:addSection()
			section:addLine(STRINGS.C_WAR.PERSONEL_ACTIVITIES.TO_KO)
			local hours = math.floor(personel.cooldown / 60)
			local minutes = personel.cooldown % 60
			section:addDesc( util.sformat(STRINGS.C_WAR.PERSONEL_ACTIVITIES.TO_CORP_DESC, serverdefs.HEAD_CORP_TEMPLATES[corp].stringTable.SHORTNAME, string.format(STRINGS.C_WAR.UI.MAP_SCREEN_SITUATION_TIME, hours, minutes) ) )
		end,
	},

	to_plastech =
	{
		ui = STRINGS.C_WAR.PERSONEL_ACTIVITIES.TO_PLASTECH,
		onMinutePassed = function(self, personel, campaign)
			personel.cooldown = personel.cooldown - 1
			if personel.cooldown <= 0 then
				personel.assignedActivity = "ready"
				personel.assignedRegion = "plastech"
				personel.cooldown = 0
			end
		end,
		getAvailableActivities = function(self, personel, campaign)
			local activities = {}

			return activities
		end,
		onSelectAbility = function(self, personel, campaign)
			print("transfer to ftm assigned")
			personel.cooldown = 180
		end,
		onTooltip = function(self, tooltip, personel, campaign)
			local corp = "plastech"
			local section = tooltip:addSection()
			section:addLine(STRINGS.C_WAR.PERSONEL_ACTIVITIES.TO_PLASTECH)
			local hours = math.floor(personel.cooldown / 60)
			local minutes = personel.cooldown % 60
			section:addDesc( util.sformat(STRINGS.C_WAR.PERSONEL_ACTIVITIES.TO_CORP_DESC, serverdefs.HEAD_CORP_TEMPLATES[corp].stringTable.SHORTNAME, string.format(STRINGS.C_WAR.UI.MAP_SCREEN_SITUATION_TIME, hours, minutes) ) )
		end,
	},
}

local function createPersonel(region)
	local personel =
	{
		assignedRegion = region,
		assignedActivity = "ready",
		cooldown = 0,			--minutes left until that personel can be assigned a different activity
	}

	return personel
end

serverdefs.PERSONEL_ACTIVITIES = PERSONEL_ACTIVITIES

---------------------------------
----Basic campaign management----
---------------------------------
--TODO: many many things
--1. Advance situations infiltration state
--2. Catch new days for story events, since they shouldnt be tied to mission endings anymore.
--3. Map Screen must be informed somehow, about events like new situations, situations about to expire etc...
--	->How to do this? Have advanceTimeCustom return eventData?
--4. For player actions, that require gen, there needs to be an autosave implementation to prevent savescumming.
--	Doing periodical autosaves anyway would also be good (maybe every hour or so?)
function serverdefs.advanceTimeCustom (campaign, minutes)
	local gen = rand.createGenerator( campaign.seed )
	local events = {}

	local old_hour = math.floor(campaign.game_time / 60)
	--campaign.game_time = campaign.game_time + minutes
	local new_hour = math.floor( (campaign.game_time + minutes) / 60)
	if old_hour ~= new_hour then
		--log:write("New Hour!")
		if math.floor(old_hour / 24) ~= math.floor(new_hour / 24) then
			local day_new = math.floor(new_hour / 24)
			table.insert( events, { evType = simdefs.CAMPAIGN_EV.NEW_DAY, evData = {day = day_new} } )
		end
	end

	--advance guard level
	for _, corp in ipairs(regions) do
		advanceGuardProgress(campaign, corp, minutes, gen)
	end

	while minutes > 0 do
		minutes = minutes - 1
		campaign.game_time = campaign.game_time + 1
		--perform personel activities
		if campaign.personel then
			for _, personel in ipairs(campaign.personel) do
				if PERSONEL_ACTIVITIES[personel.assignedActivity].onMinutePassed then
					PERSONEL_ACTIVITIES[personel.assignedActivity]:onMinutePassed(personel, campaign)
				end
			end
		end

		local mark_for_removal = {}
		for _, situation in ipairs(campaign.situations) do
			--advance infiltration
			if situation.is_infiltrating then
				situation.infiltration_progress = math.min(situation.infiltration_progress + ( 100 / serverdefs.SITUATIONS[situation.name].infiltration_time ), 200)
			end
			--situation expired?
			if situation.spawn_time + serverdefs.SITUATIONS[situation.name].duration < campaign.game_time then
				table.insert(mark_for_removal, situation)
				table.insert( events, { evType = simdefs.CAMPAIGN_EV.SITUATION_EXPIRED, evData = {situation = situation} } )
			end
			--new situation?
			if not situation.presented then
				if situation.intel >= situation.intel_threshold then
					situation.presented = true
					table.insert( events, { evType = simdefs.CAMPAIGN_EV.NEW_SITUATION, evData = {situation = situation} } )
				end
			end
		end

		for _, situation_to_remove in ipairs(mark_for_removal) do
			for index, situation in ipairs(campaign.situations) do
				if situation_to_remove == situation then
					table.remove(campaign.situations, index)
					break
				end
			end
		end
	end

	campaign.seed = gen._seed

	return events
end

local baseCreateCampaignSituations = serverdefs.createCampaignSituations
function serverdefs.createCampaignSituations( campaign, count, tags, difficulty )
	baseCreateCampaignSituations( campaign, count, tags, difficulty )
	local gen = rand.createGenerator( campaign.seed )
	for _, situation in ipairs(campaign.situations) do
		if not situation.infiltration_progress then
			situation.infiltration_progress = 0
		end
		if not situation.presented then
			situation.presented = false
		end
		if not situation.spawn_time then
			situation.spawn_time = campaign.game_time or 0
		end
		if not situation.is_infiltrating then
			situation.is_infiltrating = false
		end
		if not situation.intel then
			situation.intel = 0
		end
		if not situation.intel_threshold then
			local min = serverdefs.SITUATIONS[situation.name].intel_threshold.min
			local max = serverdefs.SITUATIONS[situation.name].intel_threshold.max
			situation.intel_threshold = gen:nextInt(min, max)
		end
		if not situation.loadout then
			situation.loadout = {-1, -1, -1, -1}
		end
	end
	campaign.seed = gen._seed
end

local baseCreateNewCampaign = serverdefs.createNewCampaign
function serverdefs.createNewCampaign(agency, campaignDifficulty, difficultyOptions)
	local campaign = baseCreateNewCampaign(agency, campaignDifficulty, difficultyOptions)
	print("CW campaign creation")
	campaign.situations = {}
	campaign.game_time = 0
	campaign.corpProgress =
	{
		ftm =
		{
			guard_level = 1,
			guard_xp = 0,
			guard_daemons = {},
			situation_intel = {},
		},
		sankaku =
		{
			guard_level = 1,
			guard_xp = 0,
			guard_daemons = {},
			situation_intel = {},
		},
		ko =
		{
			guard_level = 1,
			guard_xp = 0,
			guard_daemons = {},
			situation_intel = {},
		},
		plastech =
		{
			guard_level = 1,
			guard_xp = 0,
			guard_daemons = {},
			situation_intel = {},
		},
	}
	campaign.personel = {}

	--TODO: adjusted by generation options
	for _, region in ipairs(regions) do
		table.insert(campaign.personel, createPersonel(region))
	end
	return campaign
end

---------------
----TESTING----
---------------
--TODO: Remove! JUST TEMPORARY FOR TESTING!!!!
-- function serverdefs.createAgency(agentIDs, programIDs )
--     agentIDs = agentIDs or { "stealth_1", "engineer_2" }
--     programIDs = programIDs or { "remoteprocessor", "lockpick_1" }
--
-- 	local agency = util.extend(serverdefs.TEMPLATE_AGENCY)
-- 	{
-- 		id = 1,
-- 		abilities = programIDs,
-- 		alwaysUnlocked = true,
-- 		startLocation = 23,
-- 	}
--
-- 	agentIDs = {"stealth_1", "sharpshooter_1", "engineer_1", "stealth_2", "engineer_2", "sharpshooter_2", "cyborg_1", "disguise_1"}
--
-- 	for k,v in ipairs(agentIDs) do
-- 		serverdefs.assignAgent( agency, serverdefs.createAgent( v, util.tcopy( agentdefs[v].upgrades )))
-- 	end
--
--
-- 	return agency
-- end
