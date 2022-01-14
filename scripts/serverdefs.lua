local util = include("client_util")
local agentdefs = include("sim/unitdefs/agentdefs")
local rand = include( "modules/rand" )

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
		duration = {min=1440, max=1920},		--how long will that situation be available on the map in minutes
		infiltration_time = 720,			--infiltration time in minutes needed for 100%
		infiltration_penalty = {0, 120, 180, 240},	--additional infiltration time needed in minutes for 1st, 2nd, 3rd, 4th agent
	},
	vault =
	{
		duration = {min=1440, max=1920},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
	},
	server_farm =
	{
		duration = {min=1440, max=1920},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
	},
	nanofab =
	{
		duration = {min=1440, max=1920},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
	},
	detention_centre =
	{
		duration = {min=1440, max=1920},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
	},
	ceo_office =
	{
		duration = {min=1440, max=1920},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
	},
	cyberlab =
	{
		duration = {min=1440, max=1920},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
	},
	executive_terminals =
	{
		duration = {min=1440, max=1920},
		infiltration_time = 720,
		infiltration_penalty = {0, 120, 180, 240},
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
local PERSONEL_ACTIVITIES =
{
	ready =
	{
		ui = STRINGS.C_WAR.UI.PERSONEL_ACTIVITIES.READY,
		onMinutePassed = function(self, personel, campaign)

		end,
		getAvailableActivities = function(self, personel, campaign)
			local activities =
			{

			}

			return activities
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

	local old_hour = math.floor(campaign.game_time / 60)
	campaign.game_time = campaign.game_time + minutes
	local new_hour = math.floor(campaign.game_time / 60)
	if old_hour ~= new_hour then
		--log:write("New Hour!")
	end

	--advance guard level
	for _, corp in ipairs(regions) do
		advanceGuardProgress(campaign, corp, minutes, gen)
	end

	while minutes > 0 do
		minutes = minutes - 1
		--perform personel activities
		if campaign.personel then
			for _, personel in ipairs(campaign.personel) do
				if PERSONEL_ACTIVITIES[personel.assignedActivity].onMinutePassed then
					PERSONEL_ACTIVITIES[personel.assignedActivity]:onMinutePassed(personel, campaign)
				end
			end
		end
	end
	campaign.seed = gen._seed
end

local baseCreateNewCampaign = serverdefs.createNewCampaign
function serverdefs.createNewCampaign(agency, campaignDifficulty, difficultyOptions)
	local campaign = baseCreateNewCampaign(agency, campaignDifficulty, difficultyOptions)
	print("CW campaign creation")
	campaign.game_time = 0
	campaign.corpProgress =
	{
		ftm =
		{
			guard_level = 1,
			guard_xp = 0,
			guard_daemons = {},
		},
		sankaku =
		{
			guard_level = 1,
			guard_xp = 0,
			guard_daemons = {},
		},
		ko =
		{
			guard_level = 1,
			guard_xp = 0,
			guard_daemons = {},
		},
		plastech =
		{
			guard_level = 1,
			guard_xp = 0,
			guard_daemons = {},
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
