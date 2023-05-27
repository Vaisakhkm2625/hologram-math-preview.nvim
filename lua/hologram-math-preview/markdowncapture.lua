local function setup()
	-- print("Hello world")
end

local function printtable(value)
	print(vim.inspect(value))
end

local bufrnumber = vim.api.nvim_get_current_buf()
local language_tree = vim.treesitter.get_parser(bufrnumber, "markdown_inline")
local syntax_tree = language_tree:parse()

local root = syntax_tree[1]:root()

printtable(syntax_tree[1])
printtable(getmetatable(syntax_tree[1]))

local query = vim.treesitter.query.parse("markdown_inline", "(latex_block)@lb")

for id, match, metadata in query:iter_matches(root, bufrnumber, root:start(), root:end_()) do
	print("------------")
	-- print(vim.inspect(getmetatable(match[1])))
	print(vim.treesitter.get_node_text(match[1]:child():next_sibling(), bufrnumber))
	--print(vim.treesitter.get_node_text(match[1], bufrnumber))
	print("------------")
end

-- printtable(lang_tree)
-- printtable(root)
-- printtable(language_tree:lang())

return {
	setup = setup,
}
