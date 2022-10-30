local present1, autopairs = pcall( require, "nvim-autopairs" )
local present2, cmp = pcall( require, "cmp" )

if not (present1 and present2) then
    vim.notify( "没有找到nvim-autopairs插件，请先安装该插件!" )
    return
end

local options = {
    check_ts = true,
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
    },
    fast_wrap = {
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
    disable_filetype = { "TelescopePrompt", "vim" },
}

autopairs.setup(options)

local cmp_autopairs = require "nvim-autopairs.completion.cmp"

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
