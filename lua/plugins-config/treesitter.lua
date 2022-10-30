local status, treesitter = pcall(require, "nvim-treesitter.configs")

vim.notify = require("notify")

if not status then
	vim.notify("没有找到nvim-treesitter插件，请先安装该插件!")
	return
end

treesitter.setup({
	ensure_installed = { "lua", "perl", "python" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		--disable = function(lang, buf)
		--    local max_filesize = 100 * 1024 -- 100 KB
		--    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		--    if ok and stats and stats.size > max_filesize then
		--        return true
		--    end
		--end,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			--init_selection = "gnn",
			--node_incremental = "grn",
			--scope_incremental = "grc",
			--node_decremental = "grm",
			--init_selection = "<CR>",
			--node_incremental = "<CR>",
			--scope_incremental = "<BS>",
			--node_decremental = "<TAB>",
		},
	},
	ident = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
