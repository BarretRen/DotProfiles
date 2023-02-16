-- 样式
vim.o.background = "light"
vim.o.termguicolors = true
vim.g.solarized_italics = 0
local colorscheme = "solarized8_flat"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not Found")
    return
end
