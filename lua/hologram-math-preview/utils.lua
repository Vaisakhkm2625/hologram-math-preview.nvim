local M = {}

M.get_extmark_location = function(bufnr, ns_id, extmark_id)
	local extmark_info = vim.api.nvim_buf_get_extmark_by_id(bufnr, ns_id, extmark_id, { details = true })

	local startrow = extmark_info[1]
	local startcol = extmark_info[2]
	local endrow = extmark_info[3].end_row
	local endcol = extmark_info[3].end_col
	-- print("exmark")

	-- print(vim.inspect({ startrow, startcol, endrow, endcol }))
	return { startrow, startcol, endrow, endcol }
end

M.get_text_from_exmarks = function(bufnr, ns_id, extmark_id)
	local extmark_info = vim.api.nvim_buf_get_extmark_by_id(bufnr, ns_id, extmark_id, { details = true })

	local startrow = extmark_info[1]
	local endrow = extmark_info[3].end_row

	local text_list = vim.api.nvim_buf_get_lines(bufnr, startrow, endrow + 1, false)
	local text = table.concat(text_list, "\n")
	return text
end

-- TODO: get search with in equations table than directly from extmark and meausure performance
-- TODO: find an effient algorithm to do the searching
-- TODO: getting treesitter node that updated and searching for extmark within that range would be better?? - ig it's worse

M.get_extmarks_around_pos = function(bufnr, ns_id, row, col)
	-- include start and end rows
	local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {})

	-- print("this exmark: ")
	-- print(vim.inspect(extmarks))

	-- Filter the extmarks to include only the ones around the current cursor position
	for _, extmark in ipairs(extmarks) do
		local extmark_id = extmark[1]
		local exm = vim.api.nvim_buf_get_extmark_by_id(bufnr, ns_id, extmark_id, { details = true })

		-- TODO: handle col also
		local start_row = exm[1] + 1
		local end_row = exm[3].end_row + 1

		-- print(start_row .. " " .. end_row)

		if start_row <= row and row <= end_row then
			-- print("found exmark:" .. extmark_id)
			return extmark_id
		end
	end

	-- return filtered_extmarks
end

return M
