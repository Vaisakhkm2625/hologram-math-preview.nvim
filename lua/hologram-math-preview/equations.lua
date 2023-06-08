-- require("hologram.image")
--	:new("/home/vaisakh/notes/img/datastructuretypes.png", {})
--	:display(10, 10, vim.api.nvim_get_current_buf())

--[[
{
  current_equation: (str) enitre equation as string including $$
  id
  buf
  imgpath: (str) image generated if any
  end: (int) last row
  inline: bool
}
]]

local M = {}
M._lastUsedID = 0
M.equations = {}
M.namespace = vim.api.nvim_create_namespace("hologramMathEquation")

local function get_text_from_exmarks(bufnr, ns_id, extmark_id)
	local extmark_info = vim.api.nvim_buf_get_extmark_by_id(bufnr, ns_id, extmark_id, { details = true })

	local startrow = extmark_info[1]
	local endrow = extmark_info[3].end_row

	local text_list = vim.api.nvim_buf_get_lines(bufnr, startrow, endrow + 1, false)
	local text = table.concat(text_list, "\n")
	return text
end

M.add = function(buf, ir, ic, fr, fc)
	local eq = {}
	M._lastUsedID = M._lastUsedID + 1
	eq.id = M._lastUsedID
	eq.buf = buf
	eq.location = { ir, ic, fr, fc }

	vim.api.nvim_buf_set_extmark(buf, M.namespace, ir, ic, { id = eq.id, end_row = fr, end_col = fc })

	eq.current_equation = get_text_from_exmarks(buf, M.namespace, eq.id)

	table.insert(M.equations, eq)
end

return M
