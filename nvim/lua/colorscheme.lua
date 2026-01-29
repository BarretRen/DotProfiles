local colorscheme
local ctime = os.date("*t")
if ctime.hour < 17 and ctime.hour >= 8 then -- 8 am ~ 6 pm
    -- colorscheme = "noctis_minimus"
    colorscheme = "noctis_lilac"
    -- vim.opt.background = "light"
else
    colorscheme = "noctis_minimus"
    -- colorscheme = "noctis_lilac"
    -- vim.opt.background = "dark"
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not Found")
    return
end
-- fix nvim 0.10 color issue
vim.cmd("hi clear NormalFloat")
