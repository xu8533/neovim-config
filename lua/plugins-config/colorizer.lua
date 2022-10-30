local present, colorizer = pcall(require, "colorizer")

if not present then
    vim.notify( "没有安装colorizer插件，请先安装该插件!" )
    return
end

local options = {
    filetypes = {
        "*",
    },
    user_default_options = {
        RGB = true, -- #RGB hex codes #920
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Pink Blue Red Grey Black White
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        mode = "background", -- Set the display mode.
    },
}

colorizer.setup(options)
-- execute colorizer as soon as possible
vim.defer_fn(function()
    require("colorizer").attach_to_buffer(0)
end, 0)
