local util = include("client_util")
local mui = include( "mui/mui" )
local simdefs = include("sim/simdefs")
local mui_screen = include( "mui/mui_screen" )
local simdefs = include("sim/simdefs")

--TODO: REMOVE THIS! Integrate with SC modAPI
local baseLoadUI = mui.loadUI
function mui.loadUI( filename )
	fullFilePath = mui.internals._internals.resolveFilename( filename )
	assert( fullFilePath ) -- Important assert, since loadfile's behaviour for nil filename is to read from stdin (can you say HANG?)
	local f,e = loadfile( fullFilePath )

	if simdefs.SCREENS[filename] then
		local filepath = mui.internals._internals.resolveFilename(  simdefs.SCREENS[filename] )
		assert( filepath )
		f,e = loadfile( filepath )
		return f()
	else
		return baseLoadUI( filename )
	end
end
