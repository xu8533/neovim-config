local present, hop = pcall(require, "hop")

if not present then
	vim.notify("没有找到hop插件，请先安装该插件!")
end

local hop_config = {
	keys = "asdghklqwertyuiopzxcvbnmfj",
	quit_key = "<ESC>",
	case_insensitive = false,
	create_hl_autocmd = false, -- 使用hop自带高亮色
	multi_windows = true, -- 多个窗口同时启用
	uppercase_labels = true,
}

hop.setup(hop_config)
