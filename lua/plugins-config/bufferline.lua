local status, bufferline = pcall(require, "bufferline")

vim.notify = require("notify")

if not status then
	vim.notify("没有找到bufferline插件，请先安装该插件!")
	return
end

require("ui.highlight").load_highlight("bufferline")

--- bufferline配置
--vim.opt.termguicolors = true
bufferline.setup({
	options = {
		-- mode = "tabs | buffers",
		-- 关闭Tab
		close_command = "bdelete! %d",
		right_mouse_command = "bdelete! %d",
		numbers = "ordinal",
		-- from CodeArt
		--        numbers = function(opts)
		--            return string.format("%s", opts.id)
		--        end,
		-- 侧边栏配置
		-- 左侧空出nvim-tree位置，显示文件“文件管理器”
		offsets = {
			{
				filetype = "NvimTree",
				text = "文件管理器",
				highlight = "Directory",
				text_align = "center",
				--separator = true
				--padding = 1,
			},
		},
		indicator = {
			icon = "▎", -- this should be omitted if indicator style is not 'icon'
			style = "icon",
		},
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		-- 使用内置LSP
		diagnostics = "nvim_lsp",
		-- 显示LSP报错图标，可选
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and "" or (e == "warning" and "" or "")
				s = s .. n .. sym
			end
			return s
		end,
		color_icons = true,
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_buffer_default_icon = true,
		show_close_icon = true,
		show_tab_indicators = true,
		separator_style = "slant",
		--separator_style = 'padded_slant',
		--separator_style = { '', '' }, 可自定义，不好用
		always_show_bufferline = true,
		sort_by = "id",
	},
})
