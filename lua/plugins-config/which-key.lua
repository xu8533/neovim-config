local present, which_key = pcall(require, "which-key")

if not present then
	vim.notify("没有安装which-key插件，请先安装该插件!")
	return
end

local is_plugin_installed = require("utils.utils").is_plugin_installed
require("toggleterm")

local which_key_config = {
	plugins = {
		marks = false, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			nav = true, -- misc bindings to work with windows
			windows = false, -- default bindings on <c-w>
			z = false, -- bindings for folds, spelling and others prefixed with z
			g = false, -- bindings for prefixed with g
		},
	},
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		["<space>"] = "SPC",
		["<leader>"] = "SPC",
		["<localleader>"] = ",",
		["<cr>"] = "ENT",
		["<CR>"] = "ENT",
		["<tab>"] = "TAB",
		["<Tab>"] = "TAB",
		["<a>"] = "ALT",
		["<s>"] = "SHI",
		["<c>"] = "CTR",
		["<A>"] = "ALT",
		["<S>"] = "SHI",
		["<C>"] = "CTR",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "  ", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		--winblend = 0
	},
	layout = {
		--height = { min = 4, max = 25 }, -- min and max height of the columns
		--width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 6, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
	-- disable the WhichKey popup for certain buf types and file types.
	-- Disabled by deafult for Telescope
	disable = {
		buftypes = {},
		filetypes = { "TelescopePrompt" },
	},
}

which_key.setup(which_key_config)

-- is_plugin_installed的参数使用
-- $HOME/.local/share/nvim/site/pack/packer/start/
-- 目录下的目录名

-- Packer
if is_plugin_installed("packer.nvim") then
	which_key.register({
		p = {
			name = "Packer",
			i = { ":PackerInstall<CR>", "Install packages" },
			u = { ":PackerUpdate<CR>", "Update packages" },
			r = { ":PackerClean<CR>", "Uninstall unnecessary packages" },
			s = { ":PackerSync<CR>", "Sync packages" },
			c = { ":PackerCompile<CR>", "Compile packages" },
		},
	}, { prefix = "<leader>" })
end

-- NvimTree
if is_plugin_installed("nvim-tree.lua") then
	which_key.register({
		n = {
			name = "NvimTree",
			o = { ":NvimTreeOpen<CR>", "open NvimTree" },
			t = { ":NvimTreeToggle<CR>", "Toggle NvimTree" },
			f = { ":NvimTreeFocus<CR>", "Focus on NvimTree" },
		},
	}, { prefix = "<leader>" })
end

local buffer_maps = {
	b = {
		name = "Buffer",
		C = { ":bdelete! <CR>", "关闭Buffer" },
		e = { ":noh<CR>", "消除高亮搜索" },
		n = { ":ene <BAR> startinsert<CR>", "新建Buffer" },
		["]"] = { ":BufferLineMoveNext<CR>", "右移buffer" },
		["["] = { ":BufferLineMovePrev<CR>", "左移buffer" },
	},
}

if is_plugin_installed("bufferline.nvim") then
	buffer_maps.b.c = { ":BufferLinePickClose<CR>", "关闭Buffer" }
	buffer_maps.b.h = { ":BufferLineCyclePrev<CR>", "移动到左边buffer" }
	buffer_maps.b.l = { ":BufferLineCycleNext<CR>", "移动到右边Buffer" }
	buffer_maps.b.p = { ":BufferLineTogglePin<CR>", "Buffer Pin" }
	buffer_maps.b.s = { ":BufferLinePick<CR>", "Pick Buffer" }
	buffer_maps.b.D = { ":BufferLineSortByDirectory<CR>", "按目录排序buffer" }
	buffer_maps.b.L = { ":BufferLineSortByExtension<CR>", "按语言排序buffer" }
	buffer_maps.b1 = { ":BufferLineGoToBuffer 1<CR>", "Move To Buffer No.1" }
	buffer_maps.b2 = { ":BufferLineGoToBuffer 2<CR>", "Move To Buffer No.2" }
	buffer_maps.b3 = { ":BufferLineGoToBuffer 3<CR>", "Move To Buffer No.3" }
	buffer_maps.b4 = { ":BufferLineGoToBuffer 4<CR>", "Move To Buffer No.4" }
	buffer_maps.b5 = { ":BufferLineGoToBuffer 5<CR>", "Move To Buffer No.5" }
	buffer_maps.b6 = { ":BufferLineGoToBuffer 6<CR>", "Move To Buffer No.6" }
	buffer_maps.b7 = { ":BufferLineGoToBuffer 7<CR>", "Move To Buffer No.7" }
	buffer_maps.b8 = { ":BufferLineGoToBuffer 8<CR>", "Move To Buffer No.8" }
	buffer_maps.b9 = { ":BufferLineGoToBuffer 9<CR>", "Move To Buffer No.9" }
	buffer_maps.b0 = { ":BufferLineGoToBuffer -1<CR>", "Move To Buffer last" }
end
which_key.register(buffer_maps, { prefix = "" })

-- Finding different stuf.
if is_plugin_installed("telescope.nvim") then
	local ts_builtin = require("telescope.builtin")
	local ts_extensions = require("telescope").extensions
	which_key.register({
		f = {
			name = "Telescope Find",
			f = { ts_builtin.find_files, "查找文件" },
			h = { ts_builtin.help_tags, "查找帮助" },
			o = { ":Telescope oldfiles<CR>", "历史记录" },
			p = { ":Telescope projects<CR>", "工程管理" },
			b = { ts_extensions.file_browser.file_browser, "浏览文件" },
			g = { ts_builtin.live_grep, "搜索文件" },
			B = { ":Telescope vim_bookmarks all<CR>", "查找书签" },
			H = { ":Telescope highlights<CR>", "查找颜色" },
			M = { "<cmd>Telescope man_pages<cr>", "帮助手册" },
			P = {
				"<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
				"主题预览",
			},
			--m = { ":Telescope media_files<CR>", "多媒体" },
			--g = { ts_extensions.live_grep_args.live_grep_args, "搜索文件" },
		},
	}, { prefix = "<leader>" })
end

-- Git keybinds.
if is_plugin_installed("telescope.nvim") or is_plugin_installed("gitsigns.nvim") then
	local git_maps = { g = { name = "Git" } }
	if is_plugin_installed("telescope.nvim") then
		git_maps.g.s = { ":Telescope git_status<CR>", "Status + Git Diff" }
		git_maps.g.c = { ":Telescope git_commits<CR>", "Commit History" }
		git_maps.g.C = { ":Telescope git_bcommits<CR>", "Buffer Commit History" }
		git_maps.g.b = { ":Telescope git_branches<CR>", "Branches history" }
	end
	if is_plugin_installed("gitsigns.nvim") then
		git_maps.g.k = { ":Gitsigns prev_hunk<CR>", "Prev Hunk" }
		git_maps.g.j = { ":Gitsigns next_hunk<CR>", "Next Hunk" }
		git_maps.g.p = { ":Gitsigns preview_hunk<CR>", "Preview Hunk" }
		git_maps.g.r = { ":Gitsigns reset_hunk<CR>", "Reset Hunk" }
		git_maps.g.R = { ":Gitsigns reset_buffer<CR>", "Reset Buffer" }
		git_maps.g.d = { ":Gitsigns diffthis<CR>", "Git Diff" }
		git_maps.g.l = { ":Gitsigns blame_line<CR>", "Blame For Current Line" }
		git_maps.g.S = { ":Gitsigns stage_hunk<CR>", "Stage Hunk" }
		git_maps.g.u = { ":Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk" }
	end
	which_key.register(git_maps, { prefix = "<leader>" })
end

-- Terminal.
if is_plugin_installed("toggleterm.nvim") then
	local terminal_maps = {
		t = {
			name = "Terminal",
			f = { ":ToggleTerm direction=float<CR>", "浮动终端" },
			h = { ":ToggleTerm direction=horizontal<CR>", "水平终端" },
			v = { ":ToggleTerm direction=vertical<CR>", "垂直终端" },
		},
	}
	local exec = vim.fn.executable
	if exec("node") == 1 then
		terminal_maps.t.n = { ":lua NODE_TOGGLE()<CR>", "打开node.js" }
	end
	if exec("htop") == 1 then
		terminal_maps.t.H = { ":lua HTOP_TOGGLE()<CR>", "打开Htop" }
	end
	if exec("python") == 1 then
		terminal_maps.t.p = { ":lua PYTHON_TOGGLE()<CR>", "打开Python" }
	end
	if exec("ranger") == 1 then
		terminal_maps.t.r = { ":lua RANGER_TOGGLE()<CR>", "打开Ranger" }
	end
	if exec("lazygit") == 1 then
		terminal_maps.t.l = { ":lua LAZYGIT_TOGGLE()<CR>", "打开LazyGit" }
	end
	which_key.register(terminal_maps, { prefix = "<leader>" })
end

-- Lsp
local lsp_maps = {
	l = {
		name = "LSP",
		s = { ":lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
		f = {
			function()
				vim.diagnostic.open_float()
			end,
			"floating diagnostic",
		},
		g = {
			name = "GOTO",
			D = { ":lua vim.lsp.buf.declaration()<CR>", "Go To Declaration" },
			i = { ":lua vim.lsp.buf.implementation()<CR>", "Go To Implementation" },
			--d = { ":lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
			t = { ":lua vim.lsp.buf.type_definition()<CR>", "Go To Type Definition" },
		},
		w = {
			name = "Workspace",
			a = { ":lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace Folder" },
			l = { ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspace Folder" },
			r = { ":lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspace Folder" },
		},
		l = {
			name = "List Reference/Diagnostic",
			d = { ":lua vim.lsp.diagnostic.set_loclist()<CR>", "List Diagnostic" },
			r = { ":lua vim.lsp.buf.references()<CR>", "Show References" },
		},
	},
}
if is_plugin_installed("lspsaga.nvim") then
	lsp_maps.l.a = { ":Lspsaga code_action<cr>", "Code Action" }
	lsp_maps.l.d = { ":Lspsaga show_line_diagnostics<CR>", "Show Current Line Diagnostics" }
	lsp_maps.l.i = { ":LspInfo<CR>", "Lsp Info" }
	lsp_maps.l.I = { ":Mason<CR>", "Mason Info" }
	lsp_maps.l.f = { ":Lspsaga lsp_finder<cr>", "查找定义和引用" }
	lsp_maps.l.r = { ":Lspsaga rename<CR>", "重命名" }
	lsp_maps.l.h = { ":Lspsaga hover_doc<CR>", "Display Information Of Symbol" }
	lsp_maps.l.g.d = { ":Lspsaga peek_definition()<CR>", "Peek Definition" }
	lsp_maps.l.g.k = { ":Lspsaga diagnostic_jump_prev<CR>", "Go To Next Diagnostics" }
	lsp_maps.l.g.j = { ":Lspsaga diagnostic_jump_next<CR>", "Go To Previous Diagnostics" }
end
if is_plugin_installed("telescope.nvim") then
	lsp_maps.l.l.D = { ":Telescope diagnostics<CR>", "Show Diagnostics list via Telescope" }
end
which_key.register(lsp_maps, { prefix = "<leader>" })
which_key.register({
	K = { "<cmd>Lspsaga hover_doc<CR>", "lsp hover" },
	e = {
		name = "lsp error",
		["["] = {
			function()
				require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end,
			"Go To Previous Error",
		},
		["]"] = {
			function()
				require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
			end,
			"Go To Next Error",
		},
	},
}, { prefix = "", noremap = false, mode = "n" })
which_key.register({
	ca = { ":Lspsaga code_action<cr>", "range code action" },
}, { prefix = "<leader>", noremap = false, mode = "v" })

-- Debugger
if is_plugin_installed("nvim-dap") or is_plugin_installed("nvim-dap-ui") then
	local debug_maps = {
		d = {
			name = "Debugging",
		},
	}
	if is_plugin_installed("nvim-dap") then
		debug_maps.d.c = { ':lua require("dap").continue()<CR>', "Continue" }
		debug_maps.d.t = { ':lua require("dap").terminate()<CR>', "Terminate" }
		debug_maps.d.l = { ':lua require("dap").run_last()<CR>', "Run Last Debugging Config" }
		debug_maps.d.d = { ':lua require("dap").repl.open()<CR>', "Open Debug Console" }
		debug_maps.d.b = {
			name = "Breakpoint",
			t = { ':lua require("dap").toggle_breakpoint()<CR>', "Toggle" },
			c = { ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', "Set conditional" },
			l = {
				':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
				"With Log Point Message",
			},
		}
		debug_maps.d.s = {
			name = "Step",
			o = { ':lua require("dap").step_over()<CR>', "Step Over" },
			O = { ':lua require("dap").step_into()<CR>', "Step Into" },
			i = { ':lua require("dap").step_out()<CR>', "Step Out" },
			b = { ':lua require("dap").step_back()<CR>', "Step Back" },
			c = { ':lua require("dap").run_to_cursor()<CR>', "Run To Cursor" },
		}
	end
	if is_plugin_installed("nvim-dap-ui") then
		debug_maps.d.u = { ':lua require("dapui").toggle()<CR>', "Toggle UI" }
	end
	which_key.register(debug_maps, { prefix = "<leader>" })
end

-- Comment
-- 不使用api方式，因为每次source该脚本都会自动注释当前行
if is_plugin_installed("Comment.nvim") then
	which_key.register({
		["/"] = {
			"<Plug>(comment_toggle_linewise_current)",
			"行注释",
		},
	}, { prefix = "<leader>", noremap = false, mode = "n" })
	which_key.register({
		["/"] = {
			"<Plug>(comment_toggle_linewise_visual)",
			"块注释",
		},
	}, { prefix = "<leader>", noremap = false, mode = "v" })
end

if is_plugin_installed("which-key.nvim") then
	which_key.register({
		w = {
			name = "which key",
			k = {
				function()
					local input = vim.fn.input("WhichKey: ")
					vim.cmd("WhichKey " .. input)
				end,
				"快捷键查询",
			},
			K = {
				function()
					vim.cmd("WhichKey")
				end,
				"所有快捷键",
			},
		},
	}, { prefix = "<leader>" })
end

if is_plugin_installed("trouble.nvim") then
	which_key.register({
		x = {
			name = "troubleshooting",
			x = { ":TroubleToggle<CR>", "打开troubleshooting" },
			w = { ":TroubleToggle workspace_diagnostics<CR>", "workspace diagnostics" },
			d = { ":TroubleToggle document_diagnostics<CR>", "document diagnostics" },
			l = { ":TroubleToggle loclist<CR>", "location list" },
			q = { ":TroubleToggle quickfix<CR>", "quickfix list" },
		},
	}, { prefix = "<leader>", noremap = false, mode = "n" })
end
which_key.register({
	gR = { ":TroubleToggle lsp_references<CR>", "lsp reference trouble" },
})

if is_plugin_installed("vim-bookmarks") then
	which_key.register({
		m = {
			name = "书签",
			a = { "<Plug>BookmarkShowAll", "显示所有书签" },
			c = { "<Plug>BookmarkClear", "删除该书签" },
			g = { "<Plug>BookmarkMoveToLine", "移动书签到指定行" },
			i = { "<Plug>BookmarkAnnotate", "书签标注" },
			m = { "<Plug>BookmarkToggle", "设置或取消书签" },
			n = { "<Plug>BookmarkNext", "下一个书签" },
			p = { "<Plug>BookmarkPrev", "上一个书签" },
			x = { "<Plug>BookmarkClearAll", "删除所有书签" },
			jj = { "<Plug>BookmarkMoveDown", "下移标签" },
			kk = { "<Plug>BookmarkMoveUp", "上移标签" },
		},
	})
end
