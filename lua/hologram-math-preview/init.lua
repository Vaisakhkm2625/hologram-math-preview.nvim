--local source = "/home/vaisakh/notes/img/datastructuretypes.png"

local hologram_math_preview = {}
local createlateximg = require("hologram-math-preview.createlatex")
local latexcapture = require("hologram-math-preview.markdowncapture")
local equations = require("hologram-math-preview.equations")

--[[
equation table

{
equation: (str) enitre equation as string including $$
imgpath: (str) image generated if any
end: (int) last row
inline: bool
}
]]

-- :lua require("hologram-math-preview").show_latex_equation(15,20,"$$\\frac{\\sqrt{2}}{2^3}$$")

function hologram_math_preview.show_latex_equation(eq)
	local imagepath = createlateximg.parse_latex(eq)

	local buf = vim.api.nvim_get_current_buf()
	local image = require("hologram.image"):new(imagepath, {})

	image:display(eq.location[3] + 1, 0, buf, {})

	-- vim.defer_fn(function()
	-- 	image:delete(0, { free = true })
	-- end, 5000)
end

function hologram_math_preview.update_first_equation()
	equations.update_equation(equations.equations[2])
	hologram_math_preview.show_latex_equation(equations.equations[2])
end

function hologram_math_preview.show_all_eq()
	vim.notify("Kindly wait until all equations are parsed...")

	latexcapture.extract_all_equations()
	print(vim.inspect(equations))

	-- print("---")
	-- print(vim.inspect(equations.equations[1].current_equation))
	for _, eq in ipairs(equations.equations) do
		hologram_math_preview.show_latex_equation(eq)
	end
end

-- function hologram_math_preview.show_all_eq()
-- 	vim.notify("Kindly wait until all equations are parsed...")
--
-- 	local eqarray = latexcapture.extract_all_equations()
-- 	print(vim.inspect(eqarray))
--
-- 	for _, eq in ipairs(eqarray) do
-- 		eq.imgpath = hologram_math_preview.show_latex_equation(eq.last_row + 1, 0, eq.equation)
-- 	end
-- end
--
function hologram_math_preview.show_sample_image()
	local imagepath = createlateximg.parse_latex("$\\frac{\\sqrt{2}}{2^3}$")

	local buf = vim.api.nvim_get_current_buf()
	local image = require("hologram.image"):new(imagepath, {})

	image:display(11, 0, buf, {})

	vim.defer_fn(function()
		image:delete(0, { free = true })
	end, 5000)
end

return hologram_math_preview
