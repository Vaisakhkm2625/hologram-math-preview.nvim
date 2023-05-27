local latexcapture = {}

local function printtable(value)
	print(vim.inspect(value))
end

function latexcapture.first_eq()
	local bufrnumber = vim.api.nvim_get_current_buf()
	local language_tree = vim.treesitter.get_parser(bufrnumber, "markdown_inline")
	local syntax_tree = language_tree:parse()

	local root = syntax_tree[1]:root()

	printtable(syntax_tree[1])
	printtable(getmetatable(syntax_tree[1]))

	local query = vim.treesitter.query.parse("markdown_inline", "(latex_block)@lb")

	local firsteq = {}

	for id, match, metadata in query:iter_matches(root, bufrnumber, root:start(), root:end_()) do
		--for id, match, metadata in query:iter_matches(root, bufrnumber, root:start(), root:end_()) do
		--print(root:start())

		print("------------")
		print(vim.inspect(getmetatable(match[1])))
		print(vim.treesitter.get_node_text(match[1], bufrnumber))
		print("-----xxxxxxx")

    firsteq.equation = vim.treesitter.get_node_text(match[1], bufrnumber)
    _, _, firsteq.row, _ = match[1]:range()
    -- local range = { match[1]:range() }

    break
		--print(vim.treesitter.get_node_text(match[1], bufrnumber))
		print("------------")
	end

	print("first equation ")
  printtable(firsteq)
	return firsteq

end

latexcapture.first_eq()

-- printtable(lang_tree)
-- printtable(root)
-- printtable(language_tree:lang())

return latexcapture
