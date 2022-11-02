local present, db = pcall(require, "dashboard")

if not present then
	vim.notify("没有找到dashboard插件，请先安装该插件!")
	return
end

require("ui.highlight").load_highlight("dashboard")

db.session_directory = vim.fn.stdpath("cache") .. "/session"
db.header_pad = 0
db.center_pad = 1
db.footer_pad = 1

local datetime_ok, datetime = pcall(os.date, "%Y-%m-%d 🕔 %I:%M:%p %A")
local version_ok, nvim_version = pcall(os.capture, "vi --version | awk 'NR == 1'")

local function footer()
	if version_ok and datetime_ok then
		return nvim_version .. " | " .. datetime
	elseif datetime_ok then
		return datetime
	else
		return ""
	end
end

db.custom_center = {
	{
		icon_hl = { fg = "blue" },
		--icon = '  ',
		icon = "  ",
		desc = "书签                                    ",
		shortcut = "      ",
		action = ":Telescope vim_bookmarks all",
	},
	{
		icon_hl = { fg = "blue" },
		icon = "  ",
		desc = "载入会话                                ",
		shortcut = "      ",
		action = "SessionLoad",
	},
	{
		icon_hl = { fg = "blue" },
		icon = "  ",
		desc = "历史文件                                ",
		action = ":lua require( 'telescope.builtin' ).oldfiles{}",
		{},
		shortcut = "      ",
	},
	{
		icon_hl = { fg = "blue" },
		icon = "   ",
		desc = "浏览文件                                 ",
		action = ":Telescope file_browser",
		shortcut = "      ",
	},
	{
		icon_hl = { fg = "blue" },
		icon = "   ",
		desc = "快速查找                                 ",
		action = ":Telescope live_grep<CR>",
		shortcut = "      ",
	},
	{
		icon_hl = { fg = "blue" },
		icon = "  ",
		desc = "查找文件                                ",
		action = "Telescope find_files",
		shortcut = "      ",
	},
	{
		icon_hl = { fg = "blue" },
		icon = "  ",
		desc = "新建文件                                ",
		action = ":DashboardNewFile ",
		--action = ":enew <BAR> startinsert<CR><ESC>",
		shortcut = "      ",
	},
	--{icon = '   ',
	{
		icon_hl = { fg = "blue" },
		icon = "  ",
		desc = "配置Neovim                              ",
		action = ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd",
		shortcut = "      ",
	},
	{
		icon_hl = { fg = "blue" },
		icon = "  ",
		desc = "退出Neovim                              ",
		action = ":qa                               ",
		shortcut = "    ﰱ  ",
	},
}
--db.custom_header = {
--    [[                                                 ,o88888]],
--    [[                                              ,o8888888']],
--    [[                        ,:o:o:oooo.        ,8O88Pd8888" ]],
--    [[                    ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"   ]],
--    [[                  ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"     ]],
--    [[                 , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"       ]],
--    [[                , ..:.::o:ooOoOO8O888O8O,COCOO"         ]],
--    [[               , . ..:.::o:ooOoOOOO8OOOOCOCO"           ]],
--    [[                . ..:.::o:ooOoOoOO8O8OCCCC"o            ]],
--    [[                   . ..:.::o:ooooOoCoCCC"o:o            ]],
--    [[                   . ..:.::o:o:,cooooCo"oo:o:           ]],
--    [[                `   . . ..:.:cocoooo"'o:o:::'           ]],
--    [[                .`   . ..::ccccoc"'o:o:o:::'            ]],
--    [[               :.:.    ,c:cccc"':.:.:.:.:.'             ]],
--    [[             ..:.:"'`::::c:"'..:.:.:.:.:.'              ]],
--    [[           ...:.'.:.::::"'    . . . . .'                ]],
--    [[          .. . ....:."' `   .  . . ''                   ]],
--    [[        . . . ...."'                                    ]],
--}
--db.custom_header = {
---[[  ,_                              ]],
---[[  | `""---..._____                ]],
---[[  '-...______    _````"""""""'`|  ]],
---[[         \   ```` ``"---...__  |  ]],
---[[         |`              |   ``!  ]],
---[[         |               |     A  ]],
---[[         |               /\   /#\ ]],
---[[         /`--..______..-'  |  ### ]],
---[[        |   /  `\    /`--. |  ### ]],
---[[       _|  |  .-;`-./;-.  ||  ### ]],
---[[      / \  \ /\#|    |#/\/ /\ ##' ]],
---[[      |  `-' \__/ _  \__/ |  |`#  ]],
---[[      \_,                 /_/     ]],
---[[         `\              /        ]],
---[[           '.  '.__.'  .'         ]],
---[[    xujian   `-,____,-'           ]],
---[[              /"""I""\            ]],
---[[             /`---'--'\           ]],
---}
--db.custom_header = {
--    [[                                                     ]],
--    [[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
--    [[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
--    [[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
--    [[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
--    [[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
--    [[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
--    [[                                                     ]],
--}
--db.custom_header = {
---[[     __      _    _____     ____     __    __    _____     __    __   ]],
---[[    /  \    / )  / ___/    / __ \    ) )  ( (   (_   _)    \ \  / /   ]],
---[[   / /\ \  / /  ( (__     / /  \ \  ( (    ) )    | |      () \/ ()   ]],
---[[   ) ) ) ) ) )   ) __)   ( ()  () )  \ \  / /     | |      / _  _ \   ]],
---[[  ( ( ( ( ( (   ( (      ( ()  () )   \ \/ /      | |     / / \/ \ \  ]],
---[[  / /  \ \/ /    \ \___   \ \__/ /     \  /      _| |__  /_/      \_\ ]],
---[[ (_/    \__/      \____\   \____/       \/      /_____( (/         \) ]],
---}
db.custom_header = {
	[[                                          ▟▙            ]],
	[[                                          ▝▘            ]],
	[[  ██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖]],
	[[  ██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██]],
	[[  ██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██]],
	[[  ██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██]],
	[[  ▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀]],
}
db.custom_footer = {
	footer(),
	[[              欢迎使用NeoVIM              ]],
}
