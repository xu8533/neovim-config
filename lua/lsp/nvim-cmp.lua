local present, cmp = pcall(require, "cmp")

vim.notify = require("notify")

if not present then
	vim.notify("没有安装cmp插件，请先安装该插件!")
	return
end

require("ui.highlight").load_highlight("nvim-cmp")

vim.opt.completeopt = "menuone,noselect"
require("lsp.config.luasnip-conf")

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

local cmp_window = require("cmp.utils.window")

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
	local info = self:info_()
	info.scrollable = false
	return info
end

--- nvim-cmp补全引擎配置部分
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	--formatting = {
	--	fields = { "abbr", "kind", "menu" },
	--	format = function(_, vim_item)
	--		local icons = require("plugins-config.icons").lspkind
	--		vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
	--		return vim_item
	--	end,
	--},
	formatting = {
		format = function(_, vim_item)
			local icons = require("ui.icons").lspkind
			vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
			return vim_item
		end,
	},
	--formatting = require("lsp.config.lspkind").formatting,
	windows = {
		--        completion = cmp.config.window.bordered(),
		--        documentation = cmp.config.window.bordered(),
		completion = {
			border = border("CmpBorder"),
			winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
		},
		documentation = {
			border = border("CmpDocBorder"),
		},
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		--["<C-d>"] = cmp.mapping.scroll_docs(-4),
		--["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-x>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	sources = {
		{ name = "luasnip" }, -- cmp_luasnip插件源
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "nvim_lua" }, -- cmp-nvim-lua插件源
		{ name = "path" },
	},
})
-- cmdline complete --
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
