local present, surround = pcall(require, "nvim-surround")

if not present then
	vim.notify("没有找到surround插件，请先安装该插件!")
end

local config = {}

surround.setup(config)
