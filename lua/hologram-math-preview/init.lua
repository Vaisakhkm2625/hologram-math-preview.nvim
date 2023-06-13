--local source = "/home/vaisakh/notes/img/datastructuretypes.png"

local hologram_math_preview = {}
local createlatex = require("hologram-math-preview.createlatex")
local latexcapture = require("hologram-math-preview.markdowncapture")
local equations = require("hologram-math-preview.equations")
local utils = require("hologram-math-preview.utils")

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

function hologram_math_preview.update_first_equation()
	equations.update_equation(equations.equations[2])
	createlatex.show_latex_equation_image(equations.equations[2])
end

function hologram_math_preview.remove_first_equation()
	print(vim.inspect(equations.equations[2]))
	equations.remove(equations.equations[2])
	print(vim.inspect(equations.equations[2]))
	-- createlatex.show_latex_equation_image(equations.equations[2])
end

function hologram_math_preview.show_all_eq()
	vim.notify("Kindly wait until all equations are parsed...")

	latexcapture.extract_all_equations()

	-- print("---")
	-- print(vim.inspect(equations.equations[1].current_equation))
	for _, eq in ipairs(equations.equations) do
		createlatex.show_latex_equation_image(eq)
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
	local imagepath = createlatex.parse_latex("$\\frac{\\sqrt{2}}{2^3}$")

	local buf = vim.api.nvim_get_current_buf()
	local image = require("hologram.image"):new(imagepath, {})

	image:display(11, 0, buf, {})

	--	vim.defer_fn(function()
	--		image:delete(0, { free = true })
	--	end, 5000)
end

function hologram_math_preview.update_under_cursor()
	local cursor = vim.api.nvim_win_get_cursor(0)
	-- print(vim.inspect(cursor))
	local bufnr = vim.api.nvim_get_current_buf()
	local exmark_id = utils.get_extmarks_around_pos(bufnr, equations.namespace, cursor[1], cursor[2])
	-- print(exmark_id)
	equations.update_equation(equations.equations[exmark_id])
	createlatex.show_latex_equation_image(equations.equations[exmark_id])
end

function hologram_math_preview.inspect_equation_table()
	print(vim.inspect(equations))
end

return hologram_math_preview
