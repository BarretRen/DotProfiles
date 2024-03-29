-- utf8
vim.opt.encoding = "UTF-8"
vim.opt.fileencoding = "utf-8"
-- true color
vim.o.termguicolors = true
-- 不启动netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- jk移动时光标下上方保留8行
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
-- 使用行号
vim.opt.number = true
-- 高亮所在行
vim.opt.cursorline = true
-- 显示左侧图标指示列
--vim.opt.signcolumn = "yes"
-- 右侧参考线，超过表示代码太长了，考虑换行
vim.opt.colorcolumn = "120"
-- 退格键可用
vim.opt.backspace = "2"
-- tab宽度
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
-- 换行时自动缩进宽度
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
-- 新行对齐当前行，空格替代tab
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
-- 搜索大小写不敏感，除非包含大写
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- 替换时所有的行内匹配都被替换
vim.opt.gdefault = true
-- 搜索高亮, 输入即查找
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- 使用增强状态栏后不再需要 vim 的模式
vim.opt.showmode = false
-- 当文件被外部程序修改时，自动加载
vim.opt.autoread = true
-- 禁止折行
vim.opt.wrap = true
-- 行结尾可以跳到下一行
vim.opt.whichwrap = 'b,s,<,>,[,],h,l'
-- Enable break indent.
vim.opt.breakindent = true
-- 允许隐藏被修改过的buffer
vim.opt.hidden = true
-- 鼠标支持
vim.opt.mouse = "a"
-- 禁止创建备份文件
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = false
-- smaller updatetime
vim.opt.updatetime = 3000
-- 设置 timeoutlen 为等待键盘快捷键连击时间
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 100
-- split window 从下边和右边出现
vim.opt.splitbelow = true
vim.opt.splitright = true
-- 自动补全不自动选中
vim.opt.completeopt = "menu,menuone,noselect"
-- 代码缩进
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 10
-- 不可见字符的显示
vim.opt.list = false
vim.opt.listchars = { space = '.', tab = '→ '}
-- 补全增强
vim.opt.wildmenu = true
-- 显示状态栏
vim.opt.laststatus = 2
-- 不显示tabline
vim.opt.showtabline = 1
-- viminfo
vim.opt.shada="'50,<50,s10,h,/10,:10"
