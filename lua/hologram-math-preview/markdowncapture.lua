local M = {}

local equations = require("hologram-math-preview.equations")

local function printtable(value)
	print(vim.inspect(value))
end

--[[
{
  equation: (str) enitre equation as string including $$
  buf
  imgpath: (str) image generated if any
  end: (int) last row
  inline: bool
}
]]

function M.extract_all_equations()
	local buf = vim.api.nvim_get_current_buf()
	local equation_array = {}
	local node_array = {}

	local language_tree = vim.treesitter.get_parser(buf, "latex")
	local syntax_tree = language_tree:parse()
	local root = syntax_tree[1]:root()
	local inline_formula_query = vim.treesitter.query.parse("latex", "(inline_formula) @inf")

	for id, match, metadata in inline_formula_query:iter_matches(root, buf, root:start(), root:end_()) do
		local eq = {}
		eq.equation = vim.treesitter.get_node_text(match[1], buf)
		local ir, ic, fr, fc = match[1]:range()

		-- print(eq.last_row .. " " .. vim.treesitter.get_node_text(match[1], buf))
		--- eq.node = match[1]
		equations.add(buf, ir, ic, fr, fc)
	end
end

return M
