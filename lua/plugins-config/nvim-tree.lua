local status, nvim_tree = pcall(require, "nvim-tree")

if not status then
	vim.notify("未找到nvim-tree,请先安装该插件!")
	return
end

local tree_cb = require("nvim-tree.config").nvim_tree_callback

--- 自定义配置
nvim_tree.setup({
	-- 按大小写排序
	--sort_by = "name | case_sensitive | modification_time | extension",
	sort_by = "modification_time",
	open_on_tab = false,
	update_cwd = true,
	disable_netrw = true,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	open_on_setup = false,
	hijack_cursor = true,
	-- ahmedkhalf/project插件集成配置
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	-- 不显示git状态图标
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	filesystem_watchers = {
		enable = true,
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		update_cwd = false,
	},

	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	-- 隐藏.文件和node_modules文件夹
	filters = {
		dotfiles = false,
		custom = {
			"node_modules",
			".git",
			".cache",
			"__pycache__",
		},
	},
	view = {
		--adaptive_size = true,
		-- 宽度
		--width = 25,
		width = math.floor(vim.fn.winwidth(0) * 0.20), --占用窗口的20%作为宽度
		-- 位置
		side = "left",
		-- 隐藏顶部目录显示
		hide_root_folder = false,
		-- 保存窗口属性
		preserve_window_proportions = false,
		-- 不显示行号
		number = false,
		relativenumber = false,
		-- 显示图标
		signcolumn = "yes",
		-- 居中显示选中文件
		centralize_selection = true,
		-- 自定义快捷键
		mappings = {
			custom_only = false,
			list = {
				-- 关闭nvim-tree窗口, 可以使用Esc或q键关闭窗口，默认为q键
				{ key = "<Esc>", action = "close" },
				-- 打开文件或文件夹
				{ key = { "<CR>", "<2-LeftMouse>" }, action = "edit" },
				{ key = { "o" }, action = "tabnew" },
				-- 新窗口打开文件
				{ key = "v", action = "vsplit" },
				{ key = "h", action = "split" },
				-- 显示隐藏文件
				{ key = "i", action = "toggle_custome" }, -- 对应filters中的custom (node_modules)
				{ key = "<C-h>", action = tree_cb("toggle_dotfiles") }, -- 显示或不显示隐藏文件
				-- 文件操作
				{ key = "<F5>", action = "refresh" },
				{ key = "a", action = "create" },
				{ key = "d", action = "remove" },
				{ key = "r", action = "rename" },
				{ key = "R", action = "full_rename" },
				{ key = "x", action = "cut" },
				{ key = "c", action = "copy" },
				{ key = "p", action = "paste" },
				{ key = "s", action = "system_open" },
				{ key = "u", action = "dir_up" },
				{ key = "<C-r>", action = "run_file_command" },
			},
		},
	},
	renderer = {
		--add_trailing = false,
		-- 高亮显示已打开的文件
		highlight_opened_files = "all",
		highlight_git = true,
		add_trailing = false,
		-- 目录显示方式，具体可见:help filename-modifiers
		root_folder_modifier = ":p:~",
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "signcolumn",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				bookmark = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
		open_file = {
			quit_on_open = false,
			resize_window = false,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = {
						"notify",
						"packer",
						"qf",
						"diff",
						"fugitive",
						"fugitiveblame",
						"Outline",
						"toggleterm",
						"alpha",
						"dashboard",
					},
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
})

-- 书签配置, 默认使用m键设置或取消书签
--vim.keymap.set( "n", "<leader>mn", require( "nvim-tree.api" ).marks.navigate.next )
--vim.keymap.set( "n", "<leader>mp", require( "nvim-tree.api" ).marks.navigate.prev )
--vim.keymap.set( "n", "<leader>ms", require( "nvim-tree.api" ).marks.navigate.select)
--vim.keymap.set( "n", "<leader>ml", require( "nvim-tree.api" ).marks.list(node) )

--- 自动关闭
vim.cmd([[
    autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
    ]])
