local M = {}

M.border = {
	-- We keep the strip and saturate filters so the border pops!
	c1 = "{{color1 | saturate(0.6) | strip}}",
	c2 = "{{color2 | saturate(0.6) | strip}}",
	c3 = "{{color3 | saturate(0.6) | strip}}",
	c4 = "{{color4 | saturate(0.6) | strip}}",
	c5 = "{{color5 | saturate(0.6) | strip}}",
	c6 = "{{color6 | saturate(0.6) | strip}}",

	-- Inactive border (color0)
	inactive = "{{color0 | strip}}",
}

return M
