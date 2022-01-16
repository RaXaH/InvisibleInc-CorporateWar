local simdefs = include("sim/simdefs")

--TODO: remove this! Use SC implementation instead
simdefs.SCREENS =
{
	["upgrade_screen.lua"] = "upgrade_screen.lua",
	["map_screen.lua"] = "map_screen.lua",
}

simdefs.CAMPAIGN_EV =
{
	NEW_DAY = 1,
	NEW_SITUATION = 2,
	SITUATION_EXPIRED = 3,
}
