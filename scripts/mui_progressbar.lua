local mui_progressbar = include("mui/widgets/mui_progressbar")

function mui_progressbar:setImages(bgImg, progressImg)
	if bgImg then
		self._bgImg:setImage(bgImg)
	end
	if progressImg then
		self._progressImg:setImage(progressImg)
	end
end

