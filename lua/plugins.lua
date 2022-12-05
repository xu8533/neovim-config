--local fn = vim.fn
--local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
--
--if fn.empty(fn.glob(install_path)) > 0
--	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
--	print("packer插件管理器下载中)
--	fn.system({
--		"git",
--		"clone",
--		"--depth",
--		"1",
--		"https://github.com/wbthomason/packer.nvim",
--		install_path,
--	})
--	vim.cmd([[packadd packer.nvim]])
--end
-- 插件管理器
local packer = require("packer")

packer.startup({
	function(use)
		-- Packer自我更新升级
		use({
			"wbthomason/packer.nvim",
		})
		-- lazy-load, 加快启动速度
		-- 使用lazy-load配置选项时插件会被安装到~/.local/share/nvim/site/pack/packer/opt目录下
		use({
			"lewis6991/impatient.nvim",
		})
		use({ "nvim-lua/plenary.nvim", module = { "plenary" } })
		-- 修改通知样式
		use({
			"rcarriga/nvim-notify",
			--event = "VimEnter",
			config = function()
				require("plugins-config.nvim-notify")
			end,
		})
		-- 主题
		-- use { 'mhartington/oceanic-next' }
		use({ "folke/tokyonight.nvim", disable = false })
		use({
			"olimorris/onedarkpro.nvim",
			disable = false,
			cmd = "colorscheme onedarkpro",
			module = { "onedarkpro" },
		})
		use({
			"ellisonleao/gruvbox.nvim",
			disable = false,
			cmd = "colorscheme gruvbox",
			module = { "gruvbox" },
		})
		-- 终端图标
		use({ "nvim-tree/nvim-web-devicons" })
		-- 侧边栏目录
		use({
			"nvim-tree/nvim-tree.lua",
			cmd = {
				"NvimTreeOpen",
				"NvimTreeFocus",
				"NvimTreeToggle",
			},
			config = function()
				require("plugins-config.nvim-tree")
			end,
			tag = "nightly",
		})
		-- 顶部buffer栏美化
		use({
			"akinsho/bufferline.nvim",
			event = { "BufRead", "BufNewFile" },
			config = function()
				require("plugins-config.bufferline")
			end,
			tag = "v2.*",
		})
		-- 底部状态栏美化
		use({
			"nvim-lualine/lualine.nvim",
			event = { "BufRead", "BufNewFile" },
			config = function()
				require("plugins-config.lualine")
			end,
		})
		use({ "arkav/lualine-lsp-progress", after = "lualine.nvim" })

		-- telescope插件合集
		use({
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
		})
		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.0",
			--setup = function()
			--	require("plugins-config/telescope").config()
			--end,
			-- branch = '0.1.x',
			--module = { "telescope" },
			--cmd = "Telescope",
			config = function()
				require("plugins-config.telescope")
			end,
		})
		use({
			"nvim-telescope/telescope-file-browser.nvim",
			--keys = {
			--	"<Leader>fb",
			--},
			--cmd = "Telescope file_browser",
		})
		use({
			"tom-anders/telescope-vim-bookmarks.nvim",
			keys = {
				"<Leader>fB",
			},
		})
		-- 工程管理
		use({
			"ahmedkhalf/project.nvim",
			cmd = "Telescope projects",
			keys = { "<Leader>fp" },
			config = function()
				require("plugins-config.project")
			end,
		})
		-- 图片视频预览
		use({ "nvim-lua/popup.nvim", disable = false })
		use({ "nvim-telescope/telescope-media-files.nvim", disable = true })
		-- 快速查找优化插件
		use({
			"nvim-telescope/telescope-live-grep-args.nvim",
			after = "telescope.nvim",
			disable = true,
		})
		use({
			"folke/trouble.nvim",
			cmd = { "TroubleToggle" },
		})

		-- debug
		use({
			"mfussenegger/nvim-dap",
			keys = {
				"<Leader>db",
				"<Leader>dB",
				"<Leader>dd",
				"<Leader>dl",
				"<Leader>dsb",
				"<Leader>dsc",
				"<F4>",
				"<F5>",
				"<F6>",
				"<F7>",
				"<F8>",
				"<F9>",
				"<F10>",
			},
		})
		use({
			"ravenxrz/DAPInstall.nvim",
			after = "nvim-dap",
			module = "dap-install",
			config = function()
				require("plugins-config.dap")
			end,
		})
		use({
			"theHamsta/nvim-dap-virtual-text",
			after = "nvim-dap",
			config = function()
				require("plugins-config.dap.dap-virtual-text")
			end,
		})
		use({
			"jbyuki/one-small-step-for-vimkind",
			after = "nvim-dap",
			module = "osv",
		}) -- lua debugger
		use({
			"rcarriga/nvim-dap-ui",
			after = "nvim-dap",
			config = function()
				require("plugins-config.dap.dap-ui")
			end,
		})

		-- 语法高亮
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			event = { "BufRead", "BufNewFile" },
			cmd = {
				"TSInstall",
				"TSInstallInfo",
				"TSInstallSync",
				"TSUninstall",
				"TSUpdate",
				"TSUpdateSync",
				"TSDisableAll",
				"TSEnableAll",
			},
			config = function()
				require("plugins-config.treesitter")
			end,
		})

		--- lsp插件合集,自动补全
		use({
			"williamboman/mason.nvim", -- 补全server安装工具
			event = { "BufRead", "BufNewFile" },
			cmd = {
				"Mason",
				"MasonInstall",
				"MasonInstallAll",
				"MasonUninstall",
				"MasonUninstallAll",
				"MasonLog",
			},
			config = function()
				require("lsp.mason")
			end,
		})
		use({
			"jose-elias-alvarez/null-ls.nvim",
			after = "mason.nvim",
			config = function()
				require("lsp.null-ls")
			end,
		}) -- 代码格式化
		use({
			"neovim/nvim-lspconfig", -- lsp客户端配置工具
			after = "null-ls.nvim",
			config = function()
				require("lsp.lspconfig")
			end,
		})
		-- 自动补全引擎，核心功能
		use({
			"hrsh7th/nvim-cmp",
			after = "friendly-snippets",
			config = function()
				require("lsp.nvim-cmp")
			end,
		})
		-- 补全源
		use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }) -- { name = nvim_lsp }
		use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" }) -- { name = 'buffer' },
		use({ "hrsh7th/cmp-path", after = "nvim-cmp" }) -- { name = 'path' }
		use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" }) -- { name = 'cmdline' }
		use({
			"L3MON4D3/LuaSnip",
			wants = "friendly-snippets",
			after = "nvim-cmp",
			config = function()
				require("lsp.config.luasnip-conf")
			end,
		}) -- 代码段引擎
		use({
			"saadparwaiz1/cmp_luasnip",
			after = "LuaSnip",
		}) -- luasinp补全源
		use({
			"rafamadriz/friendly-snippets", -- 常用编程语言代码段, nvim-cmp代码段补全源
			--module = {"cmp", "cmp_nvim_lsp"},
			event = "VimEnter",
		})
		use({
			"hrsh7th/cmp-nvim-lua",
			ft = "lua",
			after = "cmp_luasnip",
		}) -- Neovim Lua API补全源
		use({
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			keys = {
				{ "i", "(" },
				{ "i", "[" },
				{ "i", "{" },
				{ "i", "<" },
				{ "i", "'" },
				{ "i", '"' },
				{ "i", "<BS>" },
			},
			config = function()
				require("plugins-config.autopairs")
			end,
		}) -- 标点符号自动补全，如[], {}, ""等
		use({
			"glepnir/lspsaga.nvim",
			after = "nvim-lspconfig",
			--cmd = "Lspsaga",
			config = function()
				require("lsp.config.lspsaga")
			end,
			branch = "main",
		}) -- lsp ui优化
		use({
			"simrat39/symbols-outline.nvim",
			cmd = {
				"SymbolsOutline",
				"SymbolsOutlineOpen",
				"SymbolsOutlineClose",
			},
			config = function()
				require("plugins-config.symbols-outline")
			end,
		})
		-- 快捷键管理
		use({
			"folke/which-key.nvim",
			keys = {
				"<Leader>",
				"g",
				"d",
				"y",
				"!",
				"z",
				">",
				"<",
				"]",
				"[",
				"v",
				"c",
				--"s",
				"b",
				'"',
				"'",
				"`",
			},
			config = function()
				require("plugins-config.which-key")
			end,
		})
		-- 彩色标尺线
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = { "BufRead", "BufNewFile" },
			config = function()
				require("plugins-config.indent-blankline")
			end,
		})

		-- 启动界面
		use({
			"glepnir/dashboard-nvim",
			cmd = { "Dashboard", "DashboardNewFile" },
			setup = function()
				vim.api.nvim_create_autocmd("VimEnter", {
					callback = function()
						if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
							vim.cmd("Dashboard")
						end
					end,
				})
			end,
			config = function()
				require("plugins-config.dashboard")
			end,
		})

		-- git集成
		use({
			"lewis6991/gitsigns.nvim",
			ft = "gitcommit",
			event = { "BufRead", "BufNewFile" },
			config = function()
				require("plugins-config.gitsigns")
			end,
		})
		-- 颜色拾取和修改器
		use({
			"norcalli/nvim-colorizer.lua",
			--event = { "BufRead", "BufNewFile" },
			cmd = { "ColorizerAttachToBuffer" },
			config = function()
				require("plugins-config.colorizer")
				--vim.cmd("ColorizerAttachToBuffer")
			end,
		})
		-- 添加注释插件
		use({
			"numToStr/Comment.nvim",
			keys = {
				--"<Plug>(comment_toggle_linewise_current)",
				--"<Plug>(comment_toggle_linewise_visual)",
				"gc",
				"gb",
				"<leader>/",
			},
			config = function()
				require("plugins-config.comment")
			end,
		})
		use({
			"JoosepAlviste/nvim-ts-context-commentstring",
			after = "Comment.nvim",
		})
		-- 外部终端
		use({
			"akinsho/toggleterm.nvim",
			tag = "*",
			keys = "<C-t>",
			module = { "toggleterm", "toggleterm.terminal" },
			config = function()
				require("plugins-config/toggleterm")
			end,
		})
		-- 书签
		use({
			"MattesGroeger/vim-bookmarks",
			cmd = {
				"BookmarkShowAll",
				"BookmarkClear",
				"BookmarkMoveToLine",
				"BookmarkAnnotate",
				"BookmarkToggle",
				"BookmarkNext",
				"BookmarkPrev",
				"BookmarkClearAll",
				"BookmarkMoveDown",
				"BookmarkMoveUp",
				"Telescope vim_bookmarks",
			},
		})
		use({
			"phaazon/hop.nvim",
			branch = "v2", -- optional but strongly recommended
			cmd = {
				"HopWord",
				"HopWordAC",
				"HopWordBC",
				"HopWordMW",
				"HopWordCurrentLine",
				"HopWordCurrentLineAC",
				"HopWordCurrentLineBC",
				"HopLine",
				"HopLineAC",
				"HopLineBC",
				"HopLineMW",
				"HopLineStart",
				"HopLineStartAC",
				"HopLineStartBC",
				"HopLineStartMW",
				"HopVertical",
				"HopVerticalAC",
				"HopVerticalBC",
				"HopVerticalMW",
				"HopPattern",
				"HopPatternAC",
				"HopPatternBC",
				"HopPatternMW",
				"HopPatternCurrentLine",
				"HopPatternCurrentLineAC",
				"HopPatternCurrentLineBC",
				"HoptChar1",
				"HoptChar1AC",
				"HoptChar1BC",
				"HoptChar1MW",
				"HoptChar1CurrentLine",
				"HoptChar1CurrentLineAC",
				"HoptChar1CurrentLineBC",
				"HoptChar2",
				"HoptChar2AC",
				"HoptChar2BC",
				"HoptChar2MW",
				"HoptChar2CurrentLine",
				"HoptChar2CurrentLineAC",
				"HoptChar2CurrentLineBC",
			},
			module = { "hop" },
			config = function()
				require("plugins-config.hop")
			end,
		}) --- EasyMotion like motion
		use({
			"ggandor/leap.nvim",
			keys = { "s", "S", "gs" },
			config = function()
				require("plugins-config.leap")
			end,
		}) --- sneak like motion
		use({
			"ggandor/flit.nvim",
			after = { "leap.nvim" },
			config = function()
				require("plugins-config.flit")
			end,
		}) --- leap extension for f, F, t, T motion
		use({
			"kylechui/nvim-surround",
			tag = "*", -- Use for stability; omit to use `main` branch for the latest features
			keys = {
				{ "n", "cs" },
				{ "n", "ds" },
				{ "n", "ys" },
				{ "n", "yss" },
				{ "n", "yS" },
				{ "i", "<C-g>s" },
				{ "i", "<C-g>S" },
				{ "v", "S" },
				{ "v", "gS" },
			},
			config = function()
				require("plugins-config.surround")
			end,
		})
	end,
	config = {
		compile_on_sync = true,
		profile = {
			enable = true,
			threshold = 0,
		},
		-- 并发限制
		max_jobs = 60,
		-- 浮动窗口打开安装列表
		display = {
			working_sym = "ﲊ",
			error_sym = "✗ ",
			done_sym = " ",
			removed_sym = " ",
			moved_sym = "",
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
		-- 自定义源
		git = {
			--default_url_format = "https://cnd.githubjs.cf/%s",
			--default_url_format = "https://gitclone.com/github.com/%s",
			clone_timeout = 60,
		},
	},
})
--- 每次保存plugins.lua后自动更新安装插件
--pcall(
--    vim.cmd,
--    [[
--        augroup packer_user_config
--        autocmd!
--        autocmd BufWritePost plugins.lua source <afile> | PackerSync
--        augroup end
--    ]]
--)
