local M = {}

M.get_extmark_location = function(bufnr, ns_id, extmark_id)
	local extmark_info = vim.api.nvim_buf_get_extmark_by_id(bufnr, ns_id, extmark_id, { details = true })

	local startrow = extmark_info[1]
	local startcol = extmark_info[2]
	local endrow = extmark_info[3].end_row
	local endcol = extmark_info[3].end_col
	print("exmark")

	print(vim.inspect({ startrow, startcol, endrow, endcol }))
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

return M
