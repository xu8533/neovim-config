local dap = require("dap")

dap.adapters.perl = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/debugpy",
	name = "debugpy",
}
