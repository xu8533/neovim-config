local present, lualine = pcall(require, "lualine")

if not present then
	vim.notify("没有找到lualine插件，请先安装该插件!")
	return
end

--- lualine配置
local config = {
	options = {
		icons_enabled = true,
		--theme = 'papercolor_dark',
		theme = "solarized_light",
		--theme = 'tokyonight',
		--theme = 'gruvbox_light',
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			"TelescopePrompt",
			"TelescopeResults",
			"dap-repl",
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		--lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_b = {
			{ "branch", icon = "" },
			{ "diff", symbol = { added = "  ", modified = "柳", removed = " " } },
			{
				"diagnostics",
				--source = {'null-ls'},
				--source = {'nvim'},
			},
		},
		lualine_c = {
			{ "filename", padding = { left = 1, right = 1 } },
			{ "filetype", icon_only = false, padding = { left = 1, right = 0 }, separator = " " },
		},
		lualine_x = {
			"os.date('%m月%d号 %A')",
			"encoding",
			{
				"fileformat",
				symbols = {
					unix = "", -- e712
					dos = "", -- e70f
					mac = "", -- e711
				},
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	--  winbar = {},
	--  inactive_winbar = {},
	extensions = { "nvim-tree", "fzf", "man", "quickfix", "toggleterm" },
}

-- Color for highlights
local colors = {
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

ins_left({
	"lsp_progress",
	--display_components = { "lsp_client_name", { "title", "percentage", "message" } },
	-- With spinner
	colors = {
		percentage = colors.cyan,
		title = colors.cyan,
		message = colors.cyan,
		spinner = colors.cyan,
		lsp_client_name = colors.magenta,
		use = true,
	},
	separators = {
		component = " ",
		progress = " | ",
		percentage = { pre = "", post = "%% " },
		title = { pre = "", post = ": " },
		lsp_client_name = { pre = "[", post = "]" },
		spinner = { pre = "", post = "" },
		message = {
			pre = "(",
			post = ")",
			commenced = "处理中",
			completed = "完成",
		},
	},
	display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
	timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
	spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
})

lualine.setup(config)

--   { left = " ", right = "" },
--    { left = " ", right = " " },
--  },
--   section_separators = { left = '', right = '' },
--   component_separators = { left = '', right = '' }
--  {
--    { left = "", right = "" },
--    { left = " ", right = " " },
--  },
--  {
--    { left = "", right = "" },
--    { left = "", right = "" },
--  },
--  {
--    { left = "", right = "" },
--    { left = " ", right = " " },
--
--Inserts a component in lualine_x ot right section
--local function ins_right(component)
--  table.insert(config.sections.lualine_x, component)
--end
