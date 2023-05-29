--local source = "/home/vaisakh/notes/img/datastructuretypes.png"

local hologram_math_preview = {}
local createlateximg = require("hologram-math-preview.createlatex")
local latexcapture = require("hologram-math-preview.markdowncapture")

--[[

equation table

{
equation: (str) enitre equation as string including $$
is_generic_command: (bool) generic_command -> \frac, generic environment-> begin
imgpath: (str) image generated if any
end: (int) last row
inline: bool
}


]]

function hologram_math_preview.show_sample_image()
	local imagepath = createlateximg.parse_latex("$$\\frac{\\sqrt{2}}{2^3}$$")

	local buf = vim.api.nvim_get_current_buf()
	local image = require("hologram.image"):new(imagepath, {})

	image:display(11, 0, buf, {})

	vim.defer_fn(function()
		image:delete(0, { free = true })
	end, 5000)
end

-- :lua require("hologram-math-preview").show_latex_equation(15,20,"$$\\frac{\\sqrt{2}}{2^3}$$")

function hologram_math_preview.show_latex_equation(row, col, equation)
	local imagepath = createlateximg.parse_latex(equation)

	local buf = vim.api.nvim_get_current_buf()
	local image = require("hologram.image"):new(imagepath, {})

	image:display(row, col, buf, {})

	vim.defer_fn(function()
		image:delete(0, { free = true })
	end, 5000)
end

function hologram_math_preview.show_first_eq()
	local eq = latexcapture.equation_array()
	hologram_math_preview.show_latex_equation(eq.row + 1, 2, eq.equation)
end

return hologram_math_preview
