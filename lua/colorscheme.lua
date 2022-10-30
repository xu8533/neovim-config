--local colorscheme = "tokyonight-moon"
local colorscheme = "tokyonight-storm"
--local colorscheme = "onedarkpro"
--local colorscheme = "gruvbox"
if colorscheme == "gruvbox" then
	vim.o.background = "light"
	--    require( 'plugins-config.gruvbox' )
	--    return
end

local present, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not present then
	vim.notify("主题" .. colorscheme .. " 没找到，请先安装该主题!")
	return
end
