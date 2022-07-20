﻿"##################################################################
"########################## start Of Vimrc ##########################
"##################################################################

" -----------------------------------------------------------------------------
" 判断Windows和Linux
" -----------------------------------------------------------------------------
let g:iswindows = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
endif

" -----------------------------------------------------------------------------
" 判断是否是终端
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

"--------------------------------------------------------------------------------
" 编码设置
"--------------------------------------------------------------------------------
set enc=utf-8  "vim内部编码
set termencoding=utf-8 "ssh term 使用的编码
" 下面两行用于防止gvim提示和软件显示出现问题
set fenc=utf-8 "文件新建编码

"--------------------------------------------------------------------------------
" GUI设置
"--------------------------------------------------------------------------------
"去除声音和闪屏
set vb t_vb=
au GuiEnter * set t_vb=

"###############################################################################
" 插件管理
"###############################################################################
if g:iswindows
    call plug#begin('~/AppData/Local/nvim/plugs')
else
    call plug#begin('~/.config/nvim/plugs')
endif

Plug 'majutsushi/tagbar'
Plug 'vim-scripts/EasyGrep'
Plug 'inkarkat/vim-mark'
Plug 'inkarkat/vim-ingo-library'
Plug 'scrooloose/nerdcommenter'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'lifepillar/vim-solarized8'
" Plug 'EdenEast/nightfox.nvim'
Plug 'Mofiqul/vscode.nvim'
Plug 'BarretRen/SearchOnSelectVim'
Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'lukas-reineke/indent-blankline.nvim'
" Plug 'aceofall/gtags.vim'
Plug 'skywind3000/vim-terminal-help'
Plug 'vim-autoformat/vim-autoformat' "自动格式化
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'ap/vim-buftabline'
Plug 'nvim-lualine/lualine.nvim'

call plug#end()

"--------------------------------------------------------------------------------
" 基础配置
"--------------------------------------------------------------------------------
set shortmess=atI "去掉欢迎界面
set nu!             " 显示行号,默认启动，ln开关控制
set mouse=a      "任何模式使用鼠标
"set mouse=nv      "只在普通和可视模式使用鼠标
" set ttymouse=sgr
set cc=120 "行长度参考线
set wrap           " 自动换行
"set nowrap         " 不自动换行
set linebreak       " 整词换行
set whichwrap=b,s,<,>,[,]       " 光标从行首和行末时可以跳到另一行去
set list                       " 显示制表符
set listchars=tab:>-,trail:-     " 将制表符显示为'>---',将行尾空格显示为'-'
"set autochdir                   " 自动设置目录为正在编辑的文件所在的目录
set hidden          " 没有保存的缓冲区可以自动被隐藏
set scrolloff=5
set clipboard+=unnamed   "复制到剪贴板，默认是寄存器
"set expandtab    "将Tab键转换为空格
set tabstop=4    "设置Tab键的宽度，可以更改，如：宽度为2
set shiftwidth=4  "换行时自动缩进宽度，可更改（宽度同tabstop）
set smarttab      "指定按一次backspace就删除shiftwidth宽度
set backspace=2       " 设置退格键可用
set writebackup     "保存文件前建立备份，保存成功后删除该备份
set nocompatible
"设置无备份文件
set nobackup
set noundofile
set noswapfile
"设置viminfo
if g:iswindows
    set viminfo='20,<20,s10,h,rA:,rB:,/10,:10
else
    set viminfo='20,<20,s10,h,/10,:10
endif
" 设置Esc超时时间为100ms,尽快生效
set ttimeout
set ttimeoutlen=100
" 高亮光标所在行
set cursorline
" 当文件在外部被修改，自动更新该文件
set autoread

"--------------------------------------------------------------------------------
" 状态栏配置
"--------------------------------------------------------------------------------
set statusline=
set statusline+=[%F]%r%m%=%#IncSearch#%y%*
set statusline+=%#IncSearch#[%{&fileformat}]
set statusline+=%#MarkWord3#
set statusline+=[Row:%l/%L\ Col:%v\ %p%%]

set laststatus=2    " always show the status line
" set ruler           " 在编辑过程中，在右下角显示光标位置的状态行

"--------------------------------------------------------------------------------
" 查找/替换相关的设置
"--------------------------------------------------------------------------------
set hlsearch        " 高亮显示搜索结果
set incsearch       " 查询时非常方便，如要查找book单词，当输入到/b时，会自动找到
" 第一个b开头的单词，当输入到/bo时，会自动找到第一个bo开头的
" 单词，依次类推，进行查找时，使用此设置会快速找到答案，当你
" 找要匹配的单词时，别忘记回车
set gdefault        " 替换时所有的行内匹配都被替换，而不是只有第一个
set ignorecase "忽略大小写
set smartcase  "如果搜索模式包含大写字符，不使用 'ignorecase' 选项

"--------------------------------------------------------------------------------
" 主题设置
"--------------------------------------------------------------------------------
"Vim colorscheme
if (has('termguicolors'))
  set termguicolors
endif

set background=dark
colorscheme vscode
" let g:solarized_italics = 0
" colorscheme solarized8

"--------------------------------------------------------------------------------
" 编程相关的设置
"--------------------------------------------------------------------------------
set completeopt=longest,menu    " 关掉智能补全时的预览窗口
filetype plugin indent on       " 加了这句才可以用智能补全
syntax enable             " 打开语法高亮
"syntax on
"set showmatch       " 设置匹配模式，类似当输入一个左括号时会匹配相应的那个右括号
set smartindent     " 智能对齐方式
set shiftwidth=4    " 换行时行间交错使用4个空格
set autoindent      " 自动对齐
set ai!             " 设置自动缩进
set foldmethod=indent "代码折叠
set foldlevel=10       " Don't autofold anything (but I can still fold manually)
"set foldopen-=search   " don't open folds when you search into them
"set foldopen-=undo     " don't open folds when you undo stuff
"set foldcolumn=4
" autocmd BufWritePre * :%s/\s\+$//e "保存时删除行尾空格

"16进制模式
nmap hx :%!xxd<cr>

"--------------------------------------------------------------------------------
" 快捷键
"--------------------------------------------------------------------------------
" nmap <C-n> :new<cr> "新建文件
"复制粘贴快捷键
if has("clipboard")
    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X> "+x
    vnoremap <S-Del> "+x

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C> "+y
    vnoremap <C-Insert> "+y

    " CTRL-V and SHIFT-Insert are Paste
    map <C-V>       "0P
    map <S-Insert>      "+gP

    " cmap <S-Insert>     <C-R>+
    inoremap <silent>  <S-Insert>  <C-R>+
    nmap <C-a> ggvG$
else
    vmap <C-c> "yy
    vmap <C-x> "yd
    nmap <C-v> "yp
    nmap <C-a> ggvG$
endif

" 多窗口操作的快捷键
nmap wv     <C-w>v     " 垂直分割当前窗口
nmap wc     <C-w>c     " 关闭当前窗口
nmap wh     <C-w>s     " 水平分割当前窗口

" 保存，退出，历史文件等快捷键
nmap <F4> :w<cr>    "保存文件修改
nmap <F3> :q<cr>    "退出vim
nmap <F12> :bro ol<cr>  "浏览文件打开记录
nmap <F2> :bd<cr>    "关闭minibufexplorer中的某个文件
set pastetoggle=<F9> "插入粘贴模式
nmap ln :set nu!<cr>

if g:isGUI
    noremap <C-Z> u
    noremap <C-Y> <C-R>
else
    noremap <C-Y> <C-R>
    nmap <C-t> :terminal<cr>
endif

" vimmerge 快捷键
map <silent> <leader>1 :diffget 1<CR> :diffupdate<CR>
map <silent> <leader>2 :diffget 2<CR> :diffupdate<CR>
map <silent> <leader>3 :diffget 3<CR> :diffupdate<CR>
map <silent> <leader>4 :diffget 4<CR> :diffupdate<CR>

" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<CR>:noh<CR>
" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

"--------------------------------------------------------------------------------
" 其他配置
"--------------------------------------------------------------------------------
"让vim记忆上次编辑的位置
autocmd BufReadPost *
            \ if line("'\"")>0&&line("'\"")<=line("$") |
            \   exe "normal g'\"" |
            \ endif
" if g:iswindows
    " exec 'cd ' . fnameescape('E:\')
" endif

"###############################################################################
" 各插件配置
"###############################################################################
"--------------------------------------------------------------------------------
" Tagbar :比TagList好用，分类更清晰，推荐
"--------------------------------------------------------------------------------
let g:tagbar_width = 30
let g:tagbar_singleclick = 1 "点击一次跳转
let g:tagbar_iconchars = ['+', '-']
let g:tagbar_position = 'left'
nmap <F5> :TagbarToggle<CR>

"--------------------------------------------------------------------------------
" gtags
"--------------------------------------------------------------------------------
" let GtagsCscope_Auto_Load = 1
" let CtagsCscope_Auto_Map = 1
" let GtagsCscope_Quiet = 1
" let GtagsCscope_Absolute_Path = 1

"--------------------------------------------------------------------------------
" cscope
"--------------------------------------------------------------------------------
" :set cscopequickfix=s-,g-,c-,d-,i-,t-,e-,f-   "是否使用 quickfix 窗口来显示 cscope 结果
" :set cscopetag
" set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope
" find symbol,defination, caller
" if g:iswindows
    " nmap fr :Gtags -r <C-R>=expand("<cword>")<cr><cr>
    " nmap fd :Gtags <C-R>=expand("<cword>")<cr><cr>
" else
    " nmap fr :cs find s <C-R>=expand("<cword>")<cr><cr>
    " nmap fd :cs find g <C-R>=expand("<cword>")<cr><cr>
    " nmap fc :cs find c <C-R>=expand("<cword>")<cr><cr>
    " nmap ff :<C-U><C-R>=printf("cs find f ")<CR>
" endif

"--------------------------------------------------------------------------------
" quickfix
"--------------------------------------------------------------------------------
nmap co :copen<cr>     "打开quickfix窗口
nmap cc :cclose<cr>
"设置quickfix窗口前进后退
nmap cn :cn<cr>
nmap cp :cp<cr>

"--------------------------------------------------------------------------------
" EasyGrep
" 快捷键：\vv: 正则查找光标下单词；\V：全词匹配光标下单词; \vr：全局替换
"--------------------------------------------------------------------------------
let g:EasyGrepMode = 1     " All:0, Open Buffers:1, TrackExt:2,
let g:EasyGrepCommand = 0  " Use vimgrep:0, grepprg:1
let g:EasyGrepRecursive  = 0 " Recursive searching
let g:EasyGrepIgnoreCase = 1 " not ignorecase:0
let g:EasyGrepFilesToExclude = "*.bak, *~, cscope.*, *.a, *.o, *.pyc, *.bak"
nmap <F7> \vv
nmap <F8> \vr
vmap <F7> \vv
vmap <F8> \vr

"--------------------------------------------------------------------------------
" mark插件
"--------------------------------------------------------------------------------
" 给不同的单词高亮，表明不同的变量
nmap m lbve\m
nmap <Leader>M <Plug>MarkToggle
nmap <Leader>N <Plug>MarkAllClear
let g:mwDefaultHighlightingPalette = 'extended'

"--------------------------------------------------------------------------------
" netrw: vim自带目录浏览
"--------------------------------------------------------------------------------
nmap nw :Vex<cr>       "文件浏览器
let g:netrw_browse_split = 4
let g:netrw_banner = 0  "隐藏横幅
let g:netrw_winsize = 25 "宽度
let g:netrw_liststyle = 3

"--------------------------------------------------------------------------------
"" nerdcommenter 注释插件
"--------------------------------------------------------------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/'  }  }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
nmap <C-\> \ci
vmap <C-\> \ci

"--------------------------------------------------------------------------------
" SearchOnSelectVim
"--------------------------------------------------------------------------------
let g:SearchOnSelect_active = 1
let g:miniBufExplAutoStart = 1

"--------------------------------------------------------------------------------
" nvim-treesitter关键字高亮
"--------------------------------------------------------------------------------
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "yang"},
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    additional_vim_regex_highlighting = false,
  },
}
EOF

"--------------------------------------------------------------------------------
" lualine
"--------------------------------------------------------------------------------
lua <<EOF
require('lualine').setup{
	--options = { theme = "papercolor_dark" },
	sections = {
		lualine_c = {{'filename', path = 1}},
		lualine_x = {'encoding', 'filetype'},
	},
}
EOF
"--------------------------------------------------------------------------------
" bufTabline
"--------------------------------------------------------------------------------
let g:buftabline_numbers = 1
let g:buftabline_show = 1
let g:buftabline_indicators = 1
let g:buftabline_plug_max = 0
nmap <m-n> :bnext<CR>
nmap <m-p> :bprev<CR>

"--------------------------------------------------------------------------------
" Indentline
"--------------------------------------------------------------------------------
" let g:indentLine_setColors = 0
" let g:indentLine_char_list = ['|']

"--------------------------------------------------------------------------------
" autoformat
"--------------------------------------------------------------------------------
" au BufWrite * :Autoformat "自动格式化
let g:formatdef_astyle_c = '"astyle --mode=c --options=/home/barretr/.astylerc"'
let g:formatters_c = ['astyle_c', 'clangformat']
let g:formatdef_astyle_cpp = '"astyle --mode=c --options=/home/barretr/.astylerc"'
let g:formatters_cpp = ['astyle_cpp', 'clangformat']

"--------------------------------------------------------------------------------
" vim-terminal-help
"--------------------------------------------------------------------------------
let g:terminal_close = 1
let g:terminal_height = 100

"--------------------------------------------------------------------------------
" LeaderF
"--------------------------------------------------------------------------------
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let Lf_PopupWidth = 0.8
" let g:Lf_PopupPosition = [float2nr(&lines * 0.6), 0]

let g:Lf_ShortcutF = '<c-p>' " search file
let g:Lf_ShortcutB = '<c-b>' " list buffer
let g:Lf_ShowRelativePath = 0
" let g:Lf_ReverseOrder = 1  "最优结果在最下面显示
let g:Lf_DefaultMode = 'NameOnly'
let g:Lf_CommandMap = {'<C-C>': ['<Esc>', '<C-C>']}
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.D','*.cmd','*.ti']
            \}
let g:Lf_UseVersionControlTool = 0
let g:Lf_DefaultExternalTool = "rg"
"列出当前文件函数列表
nmap tg :LeaderfBufTag!<cr>
nmap fu :LeaderfFunction<cr>
"当前文件搜索符合的行
nmap fl :LeaderfLine<cr>
"历史文件列表
nmap hf :LeaderfMru<cr>
" quickfix
nmap fx :LeaderfQuickFix<cr>
"当前目录搜索光标下文本
" nmap fs :Leaderf rg -w <C-R>=expand("<cword>")<cr><cr>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_GtagsAutoUpdate = 0
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_GtagsSource = 2
let g:Lf_GtagsfilesCmd = {
        \ '.git': 'rg --no-messages --files -u',
        \ '.hg': 'rg --no-messages --files -u',
        \ 'default': 'rg --no-messages --files -u'
        \}
noremap fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap fg :<C-U><C-R>=printf("Leaderf! gtags -g %s --auto-jump", expand("<cword>"))<CR><CR>
noremap fs :<C-U><C-R>=printf("Leaderf gtags -g ")<CR>
noremap fa :<C-U><C-R>=printf("Leaderf gtags --all ")<CR><CR>
noremap fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
"##################################################################
"########################## End Of Vimrc ##########################
"##################################################################
