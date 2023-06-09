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

local utils = require("hologram-math-preview.utils")

local M = {}
M._lastUsedID = 0
M.equations = {}
M.namespace = vim.api.nvim_create_namespace("hologramMathEquation")

M.add = function(buf, sr, sc, er, ec)
	local eq = {}
	M._lastUsedID = M._lastUsedID + 1
	eq.id = M._lastUsedID
	eq.buf = buf

	eq.location = { sr, sc, er, ec }
	vim.api.nvim_buf_set_extmark(buf, M.namespace, sr, sc, { id = eq.id, end_row = er, end_col = ec })

	eq.current_equation = utils.get_text_from_exmarks(buf, M.namespace, eq.id)

	M.equations[eq.id] = eq
end

M.update_equation = function(equation)
	-- vim.api.nvim_buf_set_extmark(buf, M.namespace, ir, ic, { id = eq.id, end_row = fr, end_col = fc })
	equation.current_equation = utils.get_text_from_exmarks(equation.buf, M.namespace, equation.id)
	equation.location = utils.get_extmark_location(equation.buf, M.namespace, equation.id)
end

-- 	for i, eq in pairs(M.equations) do
-- 		print("-----------")
-- 		print(vim.inspect(eq))
-- 	end
-- end
--
return M
