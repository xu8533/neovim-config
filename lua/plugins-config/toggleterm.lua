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

local exec = vim.fn.executable

if exec("lazygit") == 1 then
	function _G.LAZYGIT_TOGGLE()
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
		lazygit:toggle()
	end
end

if exec("node") == 1 then
	function _G.NODE_TOGGLE()
		local Terminal = require("toggleterm.terminal").Terminal
		local node = Terminal:new({ cmd = "node", hidden = true, direction = "float" })
		node:toggle()
	end
end

if exec("perl") == 1 then
	function _G.PERL_TOGGLE()
		local Terminal = require("toggleterm.terminal").Terminal
		local perl = Terminal:new({ cmd = "perl", hidden = true, direction = "float" })
		perl:toggle()
	end
end

if exec("htop") == 1 then
	function _G.HTOP_TOGGLE()
		local Terminal = require("toggleterm.terminal").Terminal
		local htop = Terminal:new({ cmd = "htop", hidden = true, direction = "float" })
		htop:toggle()
	end
end

if exec("python") == 1 then
	function _G.PYTHON_TOGGLE()
		local Terminal = require("toggleterm.terminal").Terminal
		local python = Terminal:new({ cmd = "python", hidden = true, direction = "float" })
		python:toggle()
	end
end

if exec("ranger") == 1 then
	function _G.RANGER_TOGGLE()
		local Terminal = require("toggleterm.terminal").Terminal
		local ranger = Terminal:new({ cmd = "ranger", hidden = true, direction = "float" })
		ranger:toggle()
	end
end

toggle_term.setup(toggleterm_config)
