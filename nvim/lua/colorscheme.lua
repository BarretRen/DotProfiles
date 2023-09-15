local colorscheme
local ctime = os.date("*t")
if ctime.hour <= 18  and ctime.hour >= 8 then -- 8 am ~ 6 pm
    colorscheme = "noctis_lilac"
else
    colorscheme = "noctis_uva"
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not Found")
    return
end
