local present, dap = pcall(require, "dap")
if not present then
	vim.notify("没有找到nvim-dap插件，请先安装该插件!")
	return
end

-- dap-install configurations
local dap_install = require("dap-install")
dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger)
end

dap.defaults.fallback.terminal_win_cmd = "ToggleTerm"
vim.fn.sign_define("DapBreakpoint", { text = "● ", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "● ", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "● ", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "→ ", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointReject", { text = "●", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })
