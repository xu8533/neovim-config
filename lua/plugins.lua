-- 安装packer插件管理器
--local fn = vim.fn
--local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
--
--if fn.empty(fn.glob(install_path)) > 0 then
--	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
--	print("packer插件管理器下载中..")
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
		use({
			"lewis6991/impatient.nvim",
			config = function()
				require("impatient")
			end,
		})
		use({ "nvim-lua/plenary.nvim" })
		-- 修改通知样式
		use({
			"rcarriga/nvim-notify",
			-- 在使用选项配置选项时插件会被安装到~/.local/share/nvim/site/pack/packer/opt目录下
			--event = "VimEnter",
			config = function()
				require("plugins-config.nvim-notify")
			end,
		})
		-- 主题
		--        use { 'mhartington/oceanic-next' }
		use({ "folke/tokyonight.nvim", disable = false })
		use({ "olimorris/onedarkpro.nvim", disable = false, cmd = "colorscheme" })
		use({ "ellisonleao/gruvbox.nvim", disable = false, cmd = "colorscheme" })
		-- 终端图标
		use({ "nvim-tree/nvim-web-devicons", event = { "BufRead", "BufNewFile" } })
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
		})
		use({
			"tom-anders/telescope-vim-bookmarks.nvim",
		})
		-- 工程管理
		use({
			"ahmedkhalf/project.nvim",
		})
		-- 图片视频预览
		use({ "nvim-lua/popup.nvim", disable = true })
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
			keys = { "<leader>d" },
			--event = { "BufRead", "BufNewFile" },
		})
		use({
			"Pocco81/dap-buddy.nvim",
			after = "nvim-dap",
			branch = "dev",
			commit = "3679132",
			config = function()
				require("plugins-config.dap")
			end,
		})
		use({
			"rcarriga/nvim-dap-ui",
			after = "dap-buddy.nvim",
			config = function()
				require("plugins-config.dap-ui")
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
				"<leader>",
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
				"s",
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
				require("plugins-config.toggleterm")
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
			},
		})
	end,
	config = {
		profile = {
			enable = true,
			threshold = 0,
		},
		-- 并发限制
		max_jobs = 60,
		-- 浮动窗口打开安装列表
		display = {
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
