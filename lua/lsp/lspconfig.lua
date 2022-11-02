local present, lspconfig = pcall(require, "lspconfig")

if not present then
	vim.notify("没有安装lspconfig插件，请先安装该插件!")
	return
end

require("ui.highlight").load_highlight("lsp")
require("lsp.config.lsp-ui")

local M = {}
--local utils = require("utils.utils")

-- 配置on_attach和capabilities选项，lsp server需要使用
--M.on_attach = function(client, bufnr)
M.on_attach = function(client)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	-- 加入下列配置，确保正确使用null-ls作为代码格式化server
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false

	if client.server_capabilities.signatureHelpProvider then
		require("utils.signature").setup(client)
	end
	-- 从lua/utils/plugins-mappings中载入快捷键映射
	--utils.load_mappings("lspconfig", { buffer = bufnr })
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

lspconfig.sumneko_lua.setup({
	--lspconfig.stylua.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,

	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				--library = vim.api.nvim_get_runtime_file("", true),
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})

lspconfig.awk_ls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
})

lspconfig.bashls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
})

lspconfig.html.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
})

lspconfig.pyright.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,

	settings = {
		python = {
			analysis = {
				typeCheckingMode = "off",
			},
		},
	},
})

-- 使用perlnavigator server需要在"
-- $HOME/.local/share/nvim/site/pack/packer/start/nvim-lspconfig/lua/lspconfig/server_configurations
-- 目录下的perlnavigator.lua文件中加入以下命令
-- cmd = { 'node', '/home/xujian/.local/share/nvim/lsp_servers/perlnavigator/node_modules/perlnavigator-server/out/server.js', '--stdio' }
-- 才能使perlnavigator-server正常工作

lspconfig.perlnavigator.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	autostart = true,
})

return M
