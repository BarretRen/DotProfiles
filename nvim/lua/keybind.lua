vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
local optl = { silent = true }

-- Fx键
map("n", "<F2>", ':bd<cr>', opt)
map("n", "<F3>", ':q<cr>', opt)
map("n", "<F4>", ':w<cr>', opt)
-- 16进制模式
map("n", "hx", ':%!xxd', opt)
-- 复制粘贴
map("n", "<C-a>", 'ggvG$', opt)
map("v", "<C-x>", '"+x', opt)
map("v", "<C-c>", '"+y', opt)
map("v", "<C-v>", '"+p', opt)
map("n", "<C-v>", '"+p', opt)
map("v", "<S-Insert>", '+gP', opt)
map("n", "<S-Insert>", '+gP', opt)
-- 多窗口操作
map("n", "wv", "<C-W>v", opt)
map("n", "wh", "<C-W>s", opt)
map("n", "wc", "<C-W>c", opt)
-- 行号
map("n", "ln", ":set nu!<cr>", opt)
-- 清除行尾空格
map("n", "cS", ":%s/\\s\\+$//g<cr>:noh<cr>", opt)
-- 清除行尾 ^M 符号
map("n", "cM", ":%s/\\r$//g<cr>:noh<cr>", opt)
-- quickfix
map("n", "co", ":copen<cr>", opt)
map("n", "cc", ":cclose<cr>", opt)
map("n", "cn", ":cn<cr>", opt)
map("n", "cp", ":cp<cr>", opt)
-- bufTabline
map("n", "<m-n>", ":bnext<cr>", opt)
map("n", "<m-p>", ":bprev<cr>", opt)
