-- copy pasta - vhirryo
-- https://github.com/nvim-neorg/neorg/commit/73ca7b63c79a76d5cd8a3f0b39c5d171c1406fdc

local M = {}

local dpi = 300

local create_latex_document = function(equation)
	local tempname = vim.fn.tempname()

	local snippet = equation.current_equation
	local tempfile = io.open(tempname, "w")

	if not tempfile then
		return
	end

	local content = table.concat({
		"\\documentclass[12pt]{standalone}",
		"\\usepackage{amsmath}",
		"\\usepackage{amssymb}",
		"\\usepackage{xcolor}",
		"\\begin{document}",
		"\\color{white}", -- TODO: Later expose this as a user option
		snippet,
		"\\end{document}",
	}, "\n")

	tempfile:write(content)
	tempfile:close()

	equation.documentname = tempfile
	return tempname
end

-- Returns a handle to an image containing
-- the rendered snippet.
-- This handle can then be delegated to an external renderer.
M.parse_latex = function(equation)
	local document_name = create_latex_document(equation)

	if not document_name then
		return
	end

	local cwd = vim.fn.fnamemodify(document_name, ":h")
	local png_result = vim.fn.tempname()
	vim.fn.jobstart(
		-- "latex  --interaction=nonstopmode --output-dir=" .. cwd .. " --output-format=dvi " .. document_name,
		"tectonic "
			.. document_name
			.. " --outdir="
			.. cwd,
		{
			cwd = cwd,
			on_exit = function()
				vim.fn.jobstart("pdftocairo -transp -singlefile " .. document_name .. ".pdf -png " .. png_result, {
					cwd = vim.fn.fnamemodify(document_name, ":h"),
					on_exit = function()
						print(vim.inspect(equation))
						print(document_name .. "generated")
						print(png_result .. "generated")
						equation.imagepath = png_result .. ".png"
						M.set_equation_image(equation)
					end,
				})
			end,
		}
	)
	-- TODO: for debuging

	return png_result .. ".png"
end

M.set_equation_image = function(equation)
	equation.image = require("hologram.image"):new(equation.imagepath, {})
	equation.image:display(equation.location[3] + 1, 0, equation.buf, {})
end

M.show_latex_equation_image = function(equation)
	M.parse_latex(equation)
end

M.update_latex_equation_image = function(equation)
	equation.image:delete(0, { free = true })
	local imagepath = M.parse_latex(equation)
	equation.image = require("hologram.image"):new(imagepath, {})
	equation.image:display(equation.location[3] + 1, 0, equation.buf, {})
end

return M
