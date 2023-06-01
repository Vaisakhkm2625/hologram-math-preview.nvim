local latexcapture = {}

local function printtable(value)
	print(vim.inspect(value))
end

--[[
{
  equation: (str) enitre equation as string including $$
  is_generic_command: (bool) generic_command -> \frac, generic environment-> begin
  imgpath: (str) image generated if any
  end: (int) last row
  inline: bool
}
]]

function latexcapture.get_equation_array()
	local bfnu = vim.api.nvim_get_current_buf()
	local equation_array = {}
	local node_array = {}

	local language_tree = vim.treesitter.get_parser(bfnu, "latex")
	local syntax_tree = language_tree:parse()
	local root = syntax_tree[1]:root()
	local inline_formula_query = vim.treesitter.query.parse("latex", "(inline_formula) @inf")

	for id, match, metadata in inline_formula_query:iter_matches(root, bfnu, root:start(), root:end_()) do
		local eq = {}
		eq.equation = vim.treesitter.get_node_text(match[1], bfnu)
		_, _, eq.last_row, _ = match[1]:range()
		print(eq.last_row .. " " .. vim.treesitter.get_node_text(match[1], bfnu))
		--- eq.node = match[1]
		table.insert(equation_array, eq)
	end

	return equation_array
end

return latexcapture
