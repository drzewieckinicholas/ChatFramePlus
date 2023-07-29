--- @class Private
local Private = select(2, ...)

--- @class ColorUtils
local ColorUtils = {}

--- Returns a hex color string from RGB values.
--- @param r number
--- @param g number
--- @param b number
--- @return string
function ColorUtils.RGBToHex(r, g, b)
	if r and g and b then
		return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
	else
		return "|cffffffff"
	end
end

Private.ColorUtils = ColorUtils
