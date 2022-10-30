local present, mason = pcall(require, "mason")

if not present then
	vim.notify("没有安装Mason插件，请先安装该插件!")
	return
end

mason.setup({
	--ensure_installed = { "" }, -- not an option from mason.nvim
	ensure_installed = { "lua-language-server" }, -- not an option from mason.nvim

	max_concurrent_installers = 10,
	ui = {
		icons = {
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ﮊ",
		},
	},
})
