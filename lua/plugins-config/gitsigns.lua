local present, gitsigns = pcall(require, "gitsigns")

if not present then
	vim.notify("没有找到gitsigns插件，请先安装该插件!")
	return
end

require("ui.highlight").load_highlight("git")

local options = {
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	attach_to_untracked = true,
	current_line_blame = false,
	sign_priority = 1,
	update_debounce = 100,
	max_file_length = 40000,
	keymaps = {
		noremap = true,
		buffer = true,
	},
	signs = {
		--add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		--change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		--delete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		--topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		--changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
}

gitsigns.setup(options)
