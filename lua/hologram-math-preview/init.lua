-- new api
-- require("hologram.image"):new("./notes/img/datastructuretypes.png", {}):display(1, 1, vim.api.nvim_get_current_buf())

--old api (current)

local source = "/home/vaisakh/notes/img/datastructuretypes.png"
local buf = vim.api.nvim_get_current_buf()
local image = require("hologram.image"):new(source, {})

-- Image should appear below this line, then disappear after 5 seconds

image:display(11, 0, buf, {})

vim.defer_fn(function()
	image:delete(0, { free = true })
end, 5000)
