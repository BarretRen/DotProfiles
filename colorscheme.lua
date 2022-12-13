-- 样式
vim.o.background = "light"
vim.o.termguicolors = true
vim.opt.termguicolors = true
local colorscheme = "doom-one"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not Found")
    return
end
