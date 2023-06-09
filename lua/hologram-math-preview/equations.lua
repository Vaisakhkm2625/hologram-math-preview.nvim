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

M.add = function(buf, sr, sc, er, ec)
	local eq = {}
	M._lastUsedID = M._lastUsedID + 1
	eq.id = M._lastUsedID
	eq.buf = buf

	eq.location = { sr, sc, er, ec }
	vim.api.nvim_buf_set_extmark(buf, M.namespace, sr, sc, { id = eq.id, end_row = er, end_col = ec })

	eq.current_equation = get_text_from_exmarks(buf, M.namespace, eq.id)

	M.equations[eq.id] = eq
end

M.update_equation = function(equation)
	-- vim.api.nvim_buf_set_extmark(buf, M.namespace, ir, ic, { id = eq.id, end_row = fr, end_col = fc })
	equation.current_equation = get_text_from_exmarks(equation.buf, M.namespace, equation.id)
	equation.location = M.get_extmark_location(equation.buf, M.namespace, equation.id)
end

-- 	for i, eq in pairs(M.equations) do
-- 		print("-----------")
-- 		print(vim.inspect(eq))
-- 	end
-- end
--
return M
