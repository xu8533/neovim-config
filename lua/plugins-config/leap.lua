local present, leap = pcall(require, "leap")

if not present then
	vim.notify("没有找到leap插件，请先安装该插件!")
end

-- true to override conflicts
leap.add_default_mappings(true)
leap.opts.ighlight_unlabeled_phase_one_targets = true

vim.keymap.set({ "x", "o", "n" }, "s", "<Plug>(leap-forward-to)", { silent = true })
