-- copy pasta - vhirryo
-- https://github.com/nvim-neorg/neorg/commit/73ca7b63c79a76d5cd8a3f0b39c5d171c1406fdc

local dpi = 300

local create_latex_document = function(snippet)
	local tempname = vim.fn.tempname()

	local tempfile = io.open(tempname, "w")

	if not tempfile then
		return
	end

	-- TODO:use \\begin only for single line statements
	local content = table.concat({
		"\\documentclass[12pt]{standalone}",
		"\\usepackage{amsmath}",
		"\\usepackage{amssymb}",
		"\\begin{document}",
		--"\\begin{align}",
		snippet,
		--"\\end{align}",
		"\\end{document}",
	}, "\n")

	tempfile:write(content)
	tempfile:close()

	return tempname
end

-- Returns a handle to an image containing
-- the rendered snippet.
-- This handle can then be delegated to an external renderer.
local parse_latex = function(snippet)
	local document_name = create_latex_document(snippet)

	if not document_name then
		return
	end

	local cwd = vim.fn.fnamemodify(document_name, ":h")
	vim.fn.jobwait({
		vim.fn.jobstart(
			"latex  --interaction=nonstopmode --output-dir=" .. cwd .. " --output-format=dvi " .. document_name,
			{ cwd = cwd }
		),
	})

	local png_result = vim.fn.tempname()
	png_result = png_result .. ".png"
	-- TODO: Make the conversions async via `on_exit`
	vim.fn.jobwait({
		vim.fn.jobstart(
			"dvipng -D "
				.. tostring(dpi)
				.. " -T tight -bg Transparent -fg 'cmyk 0.00 0.04 0.21 0.02' -o "
				.. png_result
				.. " "
				.. document_name
				.. ".dvi",
			{ cwd = vim.fn.fnamemodify(document_name, ":h") }
		),
	})

	-- TODO: for debuging
	print(png_result)
	return png_result
end

return {
	parse_latex = parse_latex,
}
