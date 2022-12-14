local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
	impatient.enable_profile()
end
---基础配置---
require("options")
---插件管理---
require("plugins")
---快捷键映射---
require("keybindings")
---主题设置---
require("colorscheme")
---默认色彩---
require("ui.highlight").load_theme()
