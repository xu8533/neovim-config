local opt = vim.opt
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

g.vim_version = vim.version().minor
-- 使用filetype.lua替换filetype.vim
if g.vim_version < 8 then
	g.did_load_filetypes = 0
	g.do_filetype_lua = 1
end

--- 汉字编码
g.encoding = "utf-8"
--opt.fileencoding = "utf-8,ucs-bom,shift-jis,gb18030,bgk,gb2312,cp936"
opt.fileencoding = "cp936"
opt.fileencoding = "utf-8"
--- 保留光标周围行数
opt.scrolloff = 8
opt.sidescrolloff = 8
--- 使用相对行号
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
--- 高亮所在行
opt.cursorline = true
--- 显示左侧图标指示列
opt.signcolumn = "yes"
--- 右侧颜色标尺位置
--vim.wo.colorcolumn = "114"
--- 自动缩进，将<tab>替换为4个空格
--opt.shiftround = true
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
--- 大小写不敏感搜索
opt.ignorecase = true
opt.smartcase = true
--- 高亮搜索
opt.hlsearch = true
--- 渐进式搜索
opt.incsearch = true
--- 命令行高为2,显示更多信息
opt.cmdheight = 2
--- 当文件被外部程序修改时自动刷新
opt.autoread = true
--- 自动保存文件，防止丢失
opt.autowrite = true
--- 开启自动折行
--opt.wrap = false
-- Without this option some times backspace did not work correctly.
opt.backspace = "indent,eol,start"
--- 光标在行首尾时下列键可以跳到下一行
opt.whichwrap:append("<>[]hl")
--- 允许隐藏被修改过的buffer
opt.hidden = true
--- 禁止创建备份文件
opt.backup = false
opt.writebackup = false
opt.swapfile = false
--- 缩短更新时间
opt.updatetime = 300
--- 设置键盘快捷键连击等待时间为500毫秒
opt.timeoutlen = 500
--- 分屏配置
opt.splitbelow = true
opt.splitright = true
--- 自动补全不自动选中
opt.completeopt = { "menuone,noselect" }
--- 补全增强
--opt.wildmenu = true
--- 禁用nvim自我介绍
opt.shortmess:append("sI")
--- 补全列表长度为10
opt.pumheight = 10
--- 永远显示tabline
--opt.showtabline = 2
--- 使用增强状态栏插件后不再需要vim的模式提示
opt.showmode = false
--- 关闭语法高亮, 使用treesitter
--opt.syntax = "disable"
--- 显示不可见字符
opt.list = true
--opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")
--opt.list = false
--opt.listchars = "space:."
--- 鼠标支持
opt.mouse = "a"
--- 剪切板，让系统和neovim之间进行复制粘贴
opt.clipboard = "unnamedplus"
--- 背景和颜色支持
opt.background = "dark"
opt.termguicolors = true
-- 全局状态栏
opt.laststatus = 3
opt.title = true
-- 不用~符显示空行
opt.fillchars = { eob = " " }

opt.ruler = false

-- Setting colorcolumn. This is set because of
-- this (https://github.com/lukas-reineke/indent-blankline.nvim/issues/59)
-- indent-blankline bug.
opt.colorcolumn = "9999"

-- 开启折叠模块
-- 默认不要折叠，需要是用zc或zo操作
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

-- Set line number for help files.
local help_config = vim.api.nvim_create_augroup("help_config", { clear = true })
autocmd("FileType", {
	pattern = "help",
	callback = function()
		opt.number = true
	end,
	group = help_config,
})

-- Add/Diasable cursorline and statusline in some buffers and filetypes.
local statusline_hide = {
	"Dashboard",
	"TelescopePrompt",
	"TelescopeResults",
	"packer",
	"lspinfo",
	"lsp-installer",
}

function hide_statusline(types)
	for _, type in pairs(types) do
		if vim.bo.filetype == type or vim.bo.buftype == type then
			opt.laststatus = 0
			opt.ruler = false
			opt.cursorline = false
			break
		else
			opt.laststatus = 3
			opt.ruler = true
			opt.cursorline = true
		end
	end
end

-- Remove signcolumn and cursorline in toggleterm.
autocmd({ "BufEnter", "BufRead", "BufWinEnter", "FileType", "WinEnter" }, {
	pattern = "*",
	callback = function()
		hide_statusline(statusline_hide)
		if vim.bo.filetype == "toggleterm" then
			opt.signcolumn = "no"
			opt.cursorline = false
		end
	end,
})

-- 禁用一些自带插件
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
}
for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end

-- 禁用java, perl, python3, ruby支持，加快启动速度
local default_providers = {
	"node",
	"perl",
	"python3",
	"python3",
	"ruby",
}

for _, provider in ipairs(default_providers) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end
