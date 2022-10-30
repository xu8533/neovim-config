local present, telescope_setup = pcall(require, "telescope")

if not present then
	vim.notify("未找到telescope插件，请先安装该插件!")
	return
end

--local lga_actions = require("telescope-live-grep-args.actions")
--local fb_picker = require("telescope").extensions.file_browser.picker
--local fb_config = require("telescope").extensions.file_browser.config
--local fb_finders = require("telescope").extensions.file_browser.finders
local fb_actions = require("telescope").extensions.file_browser.actions
--local is_plugin_installed = require("utils.utils").is_plugin_installed

local telescope_config = {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "   ",
		selection_caret = "❯  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				--preview_width = 0.67,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			-- 当窗口列数小于该数字时，不会预览文件,即不会出现预览窗口
			preview_cutoff = 114,
		},
		file_ignore_patterns = { "node_modules" },
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		results_title = "搜索结果",
		color_devicons = true,
		--set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		preview = { treesitter = true },
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		--mappings = {
		--	n = { ["<Ecs>"] = require("telescope.actions").close },
		--	n = { ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble },
		--	i = { ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble },
		--},
	},
	pickers = {},
	--pickers = {
	--    -- 内置pickers配置
	--    find_files = {
	--        -- picker皮肤，dropdown, cursor, ivy三种
	--        theme = "dropdown",
	--    }
	--},
	-- fzf扩展配置
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		--	live_grep_args = {
		--		auto_quoting = true,
		--		-- overrde default mappiings
		--		mappings = {
		--			i = {
		--				["<C-k>"] = lga_actions.quote_prompt(),
		--			},
		--		},
		--	},
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				-- 默认快捷键映射，根据需要修改
				["i"] = {
					["A-c"] = fb_actions.create,
					["S-CR"] = fb_actions.create_from_prompt,
					["A-r"] = fb_actions.rename,
					["A-m"] = fb_actions.move,
					["A-y"] = fb_actions.copy,
					["A-d"] = fb_actions.remove,
					["C-o"] = fb_actions.open,
					["C-g"] = fb_actions.goto_parent_dir,
					["C-e"] = fb_actions.goto_home_dir,
					["C-w"] = fb_actions.goto_cwd,
					["C-t"] = fb_actions.change_cwd,
					["C-f"] = fb_actions.toggle_browser,
					["C-h"] = fb_actions.toggle_hidden,
					["C-s"] = fb_actions.toggle_all,
				},
				["n"] = {
					c = fb_actions.create,
					cp = fb_actions.create_from_prompt,
					r = fb_actions.rename,
					m = fb_actions.move,
					y = fb_actions.copy,
					d = fb_actions.remove,
					o = fb_actions.open,
					g = fb_actions.goto_parent_dir,
					e = fb_actions.goto_home_dir,
					w = fb_actions.goto_cwd,
					t = fb_actions.change_cwd,
					f = fb_actions.toggle_browser,
					h = fb_actions.toggle_hidden,
					s = fb_actions.toggle_all,
				},
			},
		},
		--	--		media_files = {
		--	--			-- filetypes whitelist
		--	--			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
		--	--			filetypes = { "png", "jpg", "jpeg", "mp4", "mkv", "gif", "pdf" },
		--	--			find_cmd = "rg", -- find command (defaults to `fd`)
		--	--		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
			-- pseudo code / specification for writing custom displays, like the one
			-- for "codeactions"
			specific_opts = {
				--   [kind] = {
				--     make_indexed = function(items) -> indexed_items, width,
				--     make_displayer = function(widths) -> displayer
				--     make_display = function(displayer) -> function(e)
				--     make_ordinal = function(e) -> string
				--   },
				--   -- for example to disable the custom builtin "codeactions" display
				--      do the following
				codeactions = false,
			},
		},
	},
}

telescope_setup.setup(telescope_config)

-- 配置完telescope扩展后需要载入扩展才可以正常使用
require("telescope").load_extension("fzf")
require("telescope").load_extension("projects")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("notify")
require("telescope").load_extension("vim_bookmarks")
--require("telescope").load_extension("media_files")
--require("telescope").load_extension("ui-select")
--require("telescope").load_extension("live_grep_args")
--require("telescope").load_extension("dap")
