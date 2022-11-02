local bookmark_actions = require("telescope").extensions.vim_bookmarks.actions

require("telescope").extensions.vim_bookmarks.all({
	prompt_title = "书签",
	attach_mappings = function(_, map)
		map("n", "dd", bookmark_actions.delete_selected_or_at_cursor)
		return true
	end,
})
