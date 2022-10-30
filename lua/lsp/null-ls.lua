local present, null_ls = pcall(require, "null-ls")

if not present then
	vim.notify("没有安装null-ls插件，请先安装该插件!")
	return
end

local formatting = null_ls.builtins.formatting
--local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = false,
	-- 配置各种源，包括formatting, diagnostics, code_actions, hover, completion
	-- 目前只使用formatting
	sources = {
		formatting.black, -- python
		formatting.stylua, -- lua
		formatting.prettier.with({
			filetypes = {
				"html",
				"json",
				"yaml",
				"markdown",
				"less",
				"css",
			},
		}),
		formatting.taplo,
		formatting.perltidy, -- perl脚本缩进和格式化
		formatting.shfmt.with({
			command = "shfmt",
			args = {
				"-i",
				"4",
				"-ci",
				"-bn",
				"$FILENAME",
				"-w",
			},
		}),

		--        diagnostics.zsh,
		-- diagnostics.luacheck,
		--        diagnostics.pylint,
	},
	----    This function is for format on save.
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_sync(nil, 2000)
				end,
			})
		end
	end,
})
