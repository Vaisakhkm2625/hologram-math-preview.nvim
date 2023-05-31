-- copy pasta - vhirryo
-- https://github.com/nvim-neorg/neorg/commit/73ca7b63c79a76d5cd8a3f0b39c5d171c1406fdc

local dpi = 300

local create_latex_document = function(snippet)
	local tempname = vim.fn.tempname()

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
			-- "latex  --interaction=nonstopmode --output-dir=" .. cwd .. " --output-format=dvi " .. document_name,
			"tectonic "
				.. document_name
				.. " --outdir="
				.. cwd,
			{ cwd = cwd }
		),
	})

	local png_result = vim.fn.tempname()

	-- TODO: Make the conversions async via `on_exit`

	local comnd = "pdftocairo -transp -singlefile " .. document_name .. ".pdf -png " .. png_result

	print(comnd)
	vim.fn.jobwait({
		vim.fn.jobstart(comnd, { cwd = vim.fn.fnamemodify(document_name, ":h") }),
	})

	-- TODO: for debuging
	print(png_result)
	return png_result .. ".png"
end

return {
	parse_latex = parse_latex,
}
