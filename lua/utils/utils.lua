local M = {}
local merge_tb = vim.tbl_deep_extend
local fn = vim.fn
-- Finding os name and packer instalation path.
M.plugins_path = fn.stdpath("data") .. "/site/pack/packer"
-- 插件快捷健绑定文件
M.mappings = require("utils.plugin-mappings")

M.load_mappings = function(section, mapping_opt)
	local function set_section_map(section_values)
		if section_values.plugin then
			return
		end
		section_values.plugin = nil

		for mode, mode_values in pairs(section_values) do
			local default_opts = merge_tb("force", { mode = mode }, mapping_opt or {})
			for keybind, mapping_info in pairs(mode_values) do
				-- merge default + user opts
				local opts = merge_tb("force", default_opts, mapping_info.opts or {})

				mapping_info.opts, opts.mode = nil, nil
				opts.desc = mapping_info[2]

				vim.keymap.set(mode, keybind, mapping_info[1], opts)
			end
		end
	end

	local mappings = M.mappings

	if type(section) == "string" then
		mappings[section]["plugin"] = nil
		mappings = { mappings[section] }
	end

	for _, sect in pairs(mappings) do
		set_section_map(sect)
	end
end

-- Check for instalation status of plugin.
function M.is_plugin_installed(plugins_name)
	if
		fn.empty(fn.glob(M.plugins_path .. "/start/" .. plugins_name)) > 0
		and fn.empty(fn.glob(M.plugins_path .. "/opt/" .. plugins_name)) > 0
	then
		return false
	else
		return true
	end
end

function M.telescope_projects()
	--vim.cmd("PackerLoad project.nvim")
	if not packer_plugins["project.nvim"].loaded then
		vim.cmd("PackerLoad project.nvim")
	end
	require("telescope").load_extension("projects")
	require("telescope").extensions.projects.projects({})
	--vim.cmd("Telescope projects")
end

function M.telescope_bookmarks()
	--vim.cmd("PackerLoad vim-bookmarks")
	if not packer_plugins["vim-bookmarks"].loaded and packer_plugins["telescope-vim-bookmarks.nvim"].loaded then
		vim.cmd("PackerLoad vim-bookmarks")
		vim.cmd("PackerLoad telescope-vim-bookmarks.nvim")
	end
	local bookmark_actions = require("telescope").extensions.vim_bookmarks.actions
	require("telescope").extensions.vim_bookmarks.all({
		prompt_title = "所有书签",
		attach_mappings = function(_, map)
			map("n", "dd", bookmark_actions.delete_selected_or_at_cursor)
			return true
		end,
	})
end

return M
