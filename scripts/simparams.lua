local serverdefs = include( "modules/serverdefs" )
local util = include("client_util")

local simparams = include( "sim/simparams" )

local baseCreateCampaign = simparams.createCampaign
function simparams.createCampaign( campaignData )
	assert( campaignData )

	local situationData = serverdefs.SITUATIONS[ campaignData.situation.name ]
	assert( situationData, campaignData.situation.name )
	local corpData = serverdefs.getCorpData( campaignData.situation )

	local params = baseCreateCampaign(campaignData)

	local corp = corpData.world
	if campaignData.difficultyOptions.CW_CAMPAIGN then
		params.guardDaemons = campaignData.corpProgress[corp].guard_daemons
	end

	return params
end
