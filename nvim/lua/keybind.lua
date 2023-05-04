vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
local optl = { silent = true }

-- Fx键
map("n", "<F2>", ':bd<cr>', opt)
map("n", "<F3>", ':q<cr>', opt)
map("n", "<F4>", ':w<cr>', opt)
map("n", "<F5>", ':TagbarToggle<cr>', opt)
map('n', '<F7>', '<cmd>lua require("spectre").open()<CR>', {
    desc = "Open Spectre"
})
map('n', '<F8>', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
map('v', '<F8>', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
map('n', '<leader>sf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})
map("n", "<F9>", ':Gitsigns blame_line<cr>', opt)
map("n", "<F12>", ':Telescope oldfiles<cr>', opt)
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
-- gtags
map("n", "fr", ":cexp[]<cr>:Gtags -r <C-R>=expand(\"<cword>\")<cr><cr>:Telescope quickfix<cr>", opt)
--map("n", "fs", ":cexp[]<cr>:Gtags -s <C-R>=expand(\"<cword>\")<cr><cr>:Telescope quickfix<cr>", opt)
map("n", "fd", ":cexp[]<cr>:Gtags <C-R>=expand(\"<cword>\")<cr><cr>:Telescope quickfix<cr>", opt)
map("n", "fg", ":<C-U><C-R>=printf(\"Gtags \")<cr><cr>", opt)
map("n", "fs", ":<C-U><C-R>=printf(\"Gtags -s\")<cr><cr>", opt)
-- quickfix
map("n", "co", ":copen<cr>", opt)
map("n", "cc", ":cclose<cr>", opt)
map("n", "cn", ":cn<cr>", opt)
map("n", "cp", ":cp<cr>", opt)
-- vim-mark
map("n", "m", "lbve<Leader>m", optl)
map("v", "m", "<Leader>m", optl)
map("n", "<Leader>M", "<Plug>MarkToggle", opt)
map("n", "<Leader>N", "<Plug>MarkAllClear", opt)
-- Tree
map("n", "nw", ":NvimTreeToggle<cr>", opt)
-- nerdcommenter
map("n", "<C-\\>", "<Leader>ci", optl)
map("v", "<C-\\>", "<Leader>ci", optl)
-- bufTabline
map("n", "<m-n>", ":bnext<cr>", opt)
map("n", "<m-p>", ":bprev<cr>", opt)
-- FTerm
map("n", "<C-j>", "<cmd>lua require(\"FTerm\").toggle()<cr>", opt)
map("t", "<C-j>", "<cmd>lua require(\"FTerm\").toggle()<cr>", opt)
-- telescope
map("n", "<C-p>", ":Telescope find_files<cr>", opt)
map("n", "<C-b>", ":Telescope buffers<cr>", opt)
map("n", "<C-f>", ":Telescope current_buffer_fuzzy_find<cr>", opt)
map("n", "<F12>", ":Telescope oldfiles<cr>", opt)
map("n", "fu", ":Telescope treesitter<cr>", opt)
map("n", "rg", ":Telescope live_grep<cr>", opt)
map("n", "gs", ":Telescope grep_string<cr>", opt)
map("n", "fx", ":Telescope quickfix<cr>", opt)
map("n", "lu", ":Telescope lsp_document_symbols<cr>", opt)
map("n", "lr", ":Telescope lsp_references<cr>", opt)
map("n", "ld", ":Telescope lsp_definitions<cr>", opt)
map("n", "ls", ":Telescope lsp_dynamic_workspace_symbols<cr>", opt)
-- Diffview
--map("n", "df", ":DiffviewOpen<cr>", opt)
--map("n", "dc", ":DiffviewClose<cr>", opt)
