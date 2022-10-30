--- 设置Leader键
vim.g.mapleader = " "
vim.g.maplocalleader = ","
local map = vim.api.nvim_set_keymap
--- 复用 opt 参数
local opt = { noremap = true, silent = true }

map("n", "s", "", opt) -- 取消s键默认功能
map("n", "sn", "<C-w>n", opt) -- 水平新建窗口
map("n", "sN", ":vnew<CR>", opt) -- 垂直新建窗口
map("n", "sv", ":vsplit<CR>", opt) -- 垂直分屏
map("n", "sh", ":split<CR>", opt) -- 水平分屏
map("n", "sc", "<C-w>c", opt) -- 关闭当前窗口
map("n", "so", "<C-w>o", opt) -- 关闭其他窗口
map("n", "s=", "<C-w>=", opt) -- 等比例调整窗口
map("n", "s,", ":vertical resize -20<CR>", opt) -- 左移20列
map("n", "s.", ":vertical resize +20<CR>", opt) -- 右移20列
map("n", "sj", ":resize +10<CR>", opt) -- 上移10行
map("n", "sk", ":resize -10<CR>", opt) -- 下移10行

-- Alt + hjkltb在窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt) -- 移到左面窗口
map("n", "<A-j>", "<C-w>j", opt) -- 移到下面窗口
map("n", "<A-k>", "<C-w>k", opt) -- 移到上面窗口
map("n", "<A-l>", "<C-w>l", opt) -- 移到右面窗口
map("n", "<A-t>", "<C-w>t", opt) -- 移到顶部窗口
map("n", "<A-b>", "<C-w>b", opt) -- 移到底部窗口

map("n", "<S-h>", ":vertical resize -3<CR>", opt) -- 左移3列
map("n", "<S-l>", ":vertical resize +3<CR>", opt) -- 右移3列
map("n", "<S-k>", ":resize -1<CR>", opt) -- 上移1行
map("n", "<S-j>", ":resize +1<CR>", opt) -- 下移1行
map("n", "<C-Left>", ":vertical resize -2<CR>", opt) -- 左移1列
map("n", "<C-Right>", ":vertical resize +2<CR>", opt) -- 右移1列
map("n", "<C-Down>", ":resize -2<CR>", opt) -- 上移2行
map("n", "<C-Up>", ":resize +2<CR>", opt) -- 下移2行
map("n", "<C-w>", ":bdelete!<CR>", opt) -- 关闭当前buffer

map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opt) -- 下一个buffer
map("n", "<Tab>", ":BufferLineCycleNext<CR>", opt) -- 上一个buffer

-- 上下滚动浏览
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)
-- ctrl + u / ctrl + d只移动9行，默认移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

-- 退出
--map("n", "<ESC>q", ":qa!<CR>", opt)
map("n", "<ESC>", ":q<CR>", opt)
--
-- 保存文件
map("n", "<C-s>", ":update<CR>", opt)
-- 复制整个文件
map("n", "<C-c>", "<cmd> %y+ <CR>", opt)

-- 粘贴
map("n", "<C-p>", '"*p', opt)

--- visual模式
-- 左右移动选中文本
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)
-- 复制
map("v", "<C-y>", '"+y', opt)
map("v", "p", '"_dP', opt) -- 在粘贴后不复制被替换的文本
--- insert模式快捷键
-- 跳到行首行尾
map("i", "<C-b>", "<ESC>^i", opt)
map("i", "<C-e>", "<End>", opt)
-- 插入模式移动光标
map("i", "<C-h>", "<Left>", opt)
map("i", "<C-l>", "<Right>", opt)
map("i", "<C-j>", "<Down>", opt)
map("i", "<C-k>", "<Up>", opt)

-- ToggleTerm
function _G.set_terminal_keymaps()
	map("t", "<esc>", "<C-\\><C-n>", opt)
	map("t", "<A-h>", "<c-\\><c-n><c-w>h", opt)
	map("t", "<A-j>", "<c-\\><c-n><c-w>j", opt)
	map("t", "<A-k>", "<c-\\><c-n><c-w>k", opt)
	map("t", "<A-l>", "<c-\\><c-n><c-w>l", opt)

	map("t", "<S-h>", "<c-\\><C-n>:vertical resize +3<CR>", opt)
	map("t", "<S-j>", "<c-\\><C-n>:resize -1<CR>", opt)
	map("t", "<S-k>", "<c-\\><C-n>:resize +1<CR>", opt)
	map("t", "<S-l>", "<c-\\><C-n>:vertical resize -3<CR>", opt)
end
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		set_terminal_keymaps()
	end,
})

-- Alt+m打开或关闭nvim-tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)

-- 调用Telescope
--local ts_builtin = require("telescope.builtin")
--local ts_extensions = require("telescope").extensions
--- 三种设置快捷键的方式
--map( "n", "<leader>fb", ":Telescope file_browser<CR>", opt )
--map( "n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opt )
--vim.keymap.set( 'n', '<leader>fb', require('telescope').extensions.file_browser.file_browser, opt )
--vim.keymap.set("n", "<leader>ff", ts_builtin.find_files, opt)
--vim.keymap.set("n", "<leader>fh", ts_builtin.help_tags, opt)
--vim.keymap.set("n", "<leader>fb", ts_extensions.file_browser.file_browser, opt)
--vim.keymap.set("n", "<leader>fg", ts_extensions.live_grep_args.live_grep_args, opt)
--vim.keymap.set("n", "<leader>fp", "<CMD>Telescope projects<CR>", opt)
