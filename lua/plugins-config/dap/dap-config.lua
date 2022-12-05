local present = pcall(require, "dap")

if not present then
	vim.notify("没有找到nvim-dap插件，请先安装该插件!")
	return
end

local M = {}

local function config_dapi_and_sign()
	-- dap-install configurations
	local dap_install = require("dap-install")
	dap_install.setup({
		installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
	})

	local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

	for _, debugger in ipairs(dbg_list) do
		dap_install.config(debugger)
	end

	vim.fn.sign_define("DapBreakpoint", {
		text = "🛑",
		texthl = "DiagnosticSignError",
		linehl = "",
		numhl = "",
	})
	vim.fn.sign_define("DapBreakpointCondition", {
		text = "",
		texthl = "DiagnosticSignWarn",
		linehl = "",
		numhl = "",
	})
	vim.fn.sign_define("DapLogPoint", {
		text = "",
		texthl = "DiagnosticSignInfo",
		linehl = "",
		numhl = "",
	})
	vim.fn.sign_define("DapStopped", {
		text = "",
		texthl = "DiagnosticSignWarn",
		linehl = "",
		numhl = "",
	})
	vim.fn.sign_define("DapBreakpointReject", {
		text = "",
		texthl = "DiagnosticSignHint",
		linehl = "",
		numhl = "",
	})
end

local function config_dapui()
	local dap, dapui = require("dap"), require("dapui")

	local debug_open = function()
		dapui.open()
		vim.api.nvim_command("DapVirtualTextEnable")
	end
	local debug_close = function()
		dap.repl.close()
		dapui.close()
		vim.api.nvim_command("DapVirtualTextDisable")
		-- vim.api.nvim_command("bdelete! term:")   -- close debug temrinal
	end

	dap.listeners.after.event_initialized["dapui_config"] = function()
		debug_open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		debug_close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		debug_close()
	end
	dap.listeners.before.disconnect["dapui_config"] = function()
		debug_close()
	end
end

local function config_debuggers()
	local dap = require("dap")
	dap.defaults.fallback.terminal_win_cmd = "ToggleTerm"
	dap.set_log_level("DEBUG")

	-- load from json file
	require("dap.ext.vscode").load_launchjs("${env:HOME}/.config/vscode", { cppdbg = { "perl", "cpp" } })
	-- config per launage
	--require("plugins-config.dap.dap-python")
	--require("plugins-config.dap.dap-lua")
	require("plugins-config.dap.dap-bashdb")
end

function M.setup()
	config_dapi_and_sign()
	config_dapui()
	config_debuggers() -- Debugger
end

return M
