local mui_image = include("mui/widgets/mui_image")

--TODO: change this from getting the texture to rather providing a setShader function
function mui_image:getTexture()
	return self._cont
end

