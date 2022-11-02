local M = {}

M.ui = {
	-- hl = highlights
	hl_add = {},
	hl_override = {},
	changed_themes = {},
	theme_toggle = { "tokyodark", "gruvbox", "gruvbox_light", "gruvbox_material" },
	theme = "tokyonight", -- default theme
	transparency = false,
}

M.get_theme_tb = function(type)
	local default_path = "ui.hl-group." .. M.ui.theme
	local user_path = "custom.themes." .. M.ui.theme

	local present1, default_theme = pcall(require, default_path)
	local present2, user_theme = pcall(require, user_path)

	if present1 then
		return default_theme[type]
	elseif present2 then
		return user_theme[type]
	else
		error("No such theme bruh >_< ")
	end
end

M.merge_tb = function(table1, table2)
	return vim.tbl_deep_extend("force", table1, table2)
end

--  credits to https://github.com/max397574 for this function
M.clear_highlights = function(hl_group)
	local highlights_raw = vim.split(vim.api.nvim_exec("filter " .. hl_group .. " hi", true), "\n")
	local highlight_groups = {}

	for _, raw_hi in ipairs(highlights_raw) do
		table.insert(highlight_groups, string.match(raw_hi, hl_group .. "%a+"))
	end

	for _, highlight in ipairs(highlight_groups) do
		vim.cmd([[hi clear ]] .. highlight)
	end
end

M.load_all_highlights = function()
	vim.opt.bg = require("ui.highlight").get_theme_tb("type") -- dark/light

	-- reload highlights for theme switcher
	local reload = require("plenary.reload").reload_module
	local clear_hl = require("ui.highlight").clear_highlights

	clear_hl("BufferLine")
	clear_hl("TS")

	reload("base46.integrations")
	reload("base46.chadlights")

	local hl_groups = require("base46.chadlights")

	for hl, col in pairs(hl_groups) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end

M.turn_str_to_color = function(tb_in)
	local tb = vim.deepcopy(tb_in)
	local colors = M.get_theme_tb("base_30")

	for _, groups in pairs(tb) do
		for k, v in pairs(groups) do
			if k == "fg" or k == "bg" then
				if v:sub(1, 1) == "#" or v == "none" or v == "NONE" then
				else
					groups[k] = colors[v]
				end
			end
		end
	end

	return tb
end

M.extend_default_hl = function(highlights)
	local polish_hl = M.get_theme_tb("polish_hl")

	-- polish themes
	if polish_hl then
		for key, value in pairs(polish_hl) do
			if highlights[key] then
				highlights[key] = M.merge_tb(highlights[key], value)
			end
		end
	end

	local overriden_hl = M.turn_str_to_color(M.ui.hl_override)

	for key, value in pairs(overriden_hl) do
		if highlights[key] then
			highlights[key] = M.merge_tb(highlights[key], value)
		end
	end
end

M.load_highlight = function(group)
	if type(group) == "string" then
		group = require("ui.hl-group." .. group)
		M.extend_default_hl(group)
	end

	for hl, col in pairs(group) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end

M.load_theme = function()
	M.load_highlight("defaults")
	M.load_highlight("statusline")
	--M.load_highlight("syntax")
	M.load_highlight(M.turn_str_to_color(M.ui.hl_add))
end

M.override_theme = function(default_theme, theme_name)
	local changed_themes = M.ui.changed_themes

	if changed_themes[theme_name] then
		return M.merge_tb(default_theme, changed_themes[theme_name])
	else
		return default_theme
	end
end

return M
