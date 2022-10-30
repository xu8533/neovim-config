local present, notify = pcall( require, "notify" )

if not present then
    vim.notify( "没有安装nvim-notify插件，请先安装该插件!" )
    return
end

notify.setup{
    stages = "fade_in_slide_out",
    render = "default",
}

-- 使用nvim-notify插件替换neovim自带的notify功能
vim.notify = notify
