local present, toggle_term = pcall(require, "toggleterm")

if not present then
	vim.notify("没有安装toggleterm插件，请先安装该插件!")
	return
end

local toggleterm_config = {
	open_mapping = "<c-t>",
	hide_numbers = false, -- hide the number column in toggleterm buffers
	shade_terminals = true,
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true,
	persist_size = true,
	size = 20,
	--direction = "horizontal",
	direction = "float",
	close_on_exit = true, -- close the terminal window when the process exits
	float_opts = {
		border = "curved",
		width = 95,
		height = 20,
		winblend = 3,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
}

toggle_term.setup(toggleterm_config)
