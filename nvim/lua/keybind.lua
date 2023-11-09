vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
local opt2 = { noremap = true, silent = false }

-- Inser 和Command mode下光标移动
map("i", "<M-h>", '<Left>', opt)
map("i", "<M-j>", '<Down>', opt)
map("i", "<M-k>", '<Up>', opt)
map("i", "<M-l>", '<Right>', opt)
map("c", "<M-h>", '<Left>', opt2)
map("c", "<M-j>", '<Down>', opt2)
map("c", "<M-k>", '<Up>', opt2)
map("c", "<M-l>", '<Right>', opt2)
-- Fx键
map("n", "<F2>", ':BufferDelete<cr>', opt)
map("n", "<F3>", ':q<cr>', opt)
map("n", "<F4>", ':w<cr>', opt)
-- 16进制模式
map("n", "xd", ':%!xxd<cr>', opt)
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
map("n", "w=", "<C-W>=", opt)
-- 行号
map("n", "<Leader>ln", ":set nu!<cr>", opt)
-- 清除行尾空格
map("n", "cS", ":%s/\\s\\+$//g<cr>:noh<cr>", opt)
-- 清除行尾 ^M 符号
map("n", "cM", ":%s/\\r$//g<cr>:noh<cr>", opt)
-- tab键是否转换为空格
map("n", "tb", ":set et!<cr>", opt)
-- 是否显示tab等不可见字符
map("n", "ts", ":set list!<cr>", opt)
-- 是否高亮search结果
map("n", "<Leader>hl", ":set hls!<cr>", opt)
-- quickfix
map("n", "co", ":copen<cr>", opt)
map("n", "cc", ":cclose<cr>", opt)
map("n", "cn", ":cn<cr>", opt)
map("n", "cp", ":cp<cr>", opt)
-- bufTabline
map("n", "<m-n>", ":bnext<cr>", opt)
map("n", "<m-p>", ":bprev<cr>", opt)
