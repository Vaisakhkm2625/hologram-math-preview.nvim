local latexcapture = {}

local function printtable(value)
	print(vim.inspect(value))
end

function latexcapture.first_eq()
	local bfnu = vim.api.nvim_get_current_buf()
	local language_tree = vim.treesitter.get_parser(bfnu, "markdown_inline")
	local syntax_tree = language_tree:parse()

	local root = syntax_tree[1]:root()

	printtable(syntax_tree[1])
	printtable(getmetatable(syntax_tree[1]))

	local query = vim.treesitter.query.parse("markdown_inline", "(latex_block)@lb")
	-- (displayed_equation(generic_command)) @e
	-- (displayed_equation(generic_environment)) @r

	--[[
{
  equation: (str) enitre equation as string including $$
  is_generic_command: (bool) generic_command -> \frac, generic environment-> begin
  imgpath: (str) image generated if any
  end: (int) last row
  inline: bool
}
]]

	local firsteq = {}

	for id, match, metadata in query:iter_matches(root, bfnu, root:start(), root:end_()) do
		-- print("------------")
		-- print(vim.inspect(getmetatable(match[1])))
		-- print(vim.treesitter.get_node_text(match[1], bfnu))
		-- print("-----xxxxxxx")

		firsteq.equation = vim.treesitter.get_node_text(match[1], bfnu)
		_, _, firsteq.row, _ = match[1]:range()
		-- local range = { match[1]:range() }

		-- print(vim.treesitter.get_node_text(match[1], bfnu))
		-- print("------------")
	end

	print("first equation ")
	printtable(firsteq)
	return firsteq
end

function latexcapture.get_equation_array()
	local bfnu = vim.api.nvim_get_current_buf()
	local equation_array = {}
	local node_array = {}

	local language_tree = vim.treesitter.get_parser(bfnu, "latex")
	local syntax_tree = language_tree:parse()
	local root = syntax_tree[1]:root()
	local generic_commands_query = vim.treesitter.query.parse("latex", "(displayed_equation(generic_command)) @gc")
	local generic_environments_query =
		vim.treesitter.query.parse("latex", "(displayed_equation(generic_environment)) @ge")

	for id, match, metadata in generic_commands_query:iter_matches(root, bfnu, root:start(), root:end_()) do
		local eq = {}
		eq.equation = vim.treesitter.get_node_text(match[1], bfnu)
		eq.is_generic_command = true
		_, _, eq.last_row, _ = match[1]:range()
		-- print(eq.last_row .. " " .. vim.treesitter.get_node_text(match[1], bfnu))
		--- eq.node = match[1]
		table.insert(equation_array, eq)
	end

	print("environment")
	for id, match, metadata in generic_environments_query:iter_matches(root, bfnu, root:start(), root:end_()) do
		local eq = {}
		eq.equation = vim.treesitter.get_node_text(match[1], bfnu)
		_, _, eq.last_row, _ = match[1]:range()
		-- print(vim.treesitter.get_node_text(match[1], bfnu))
		-- eq.node = match[1]
		table.insert(equation_array, eq)
	end

	return equation_array
end

return latexcapture
