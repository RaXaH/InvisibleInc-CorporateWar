local mui_combobox = include("mui/widgets/mui_combobox")

function mui_combobox:setAlignment( hAlign, vAlign )
	local h, v = MOAITextBox.RIGHT_JUSTIFY, MOAITextBox.CENTER_JUSTIFY
	if hAlign then
		h = hAlign
	end
	if vAlign then
		v = vAlign
	end
	self._editBox:setAlignment( h, v )
end
