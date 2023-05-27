--local source = "/home/vaisakh/notes/img/datastructuretypes.png"

local hologram_math_preview = {}
local createlateximg = require("hologram-math-preview.createlatex")

function hologram_math_preview.show_image()
	imagepath = createlateximg.parse_latex("$$2^3$$")

	local buf = vim.api.nvim_get_current_buf()
	local image = require("hologram.image"):new(imagepath, {})

	image:display(11, 0, buf, {})

	vim.defer_fn(function()
		image:delete(0, { free = true })
	end, 5000)
end

return hologram_math_preview
