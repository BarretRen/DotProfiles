"##################################################################
"########################## start Of Vimrc ##########################
"##################################################################

" -----------------------------------------------------------------------------
" 判断Windows和Linux
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
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
"下面两行用于防止gvim提示和软件显示出现问题
set fenc=utf-8 "文件新建编码
if g:iswindows
    set guifont=Courier_New:h10
else
    set guifont=Courier_New\ 10 "字体设置在终端下无效
endif

"###############################################################################
" 插件管理
"###############################################################################
if g:iswindows
	call plug#begin('~/vimfiles/bundle')
else
	call plug#begin('~/.vim/bundle')
endif
	
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/EasyGrep'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/Mark--Karkat'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/a.vim'
Plug 'https://github.com/skywind3000/asyncrun.vim.git'
Plug 'jlanzarotta/bufexplorer'
Plug 'Renxiuhu/vim-colorscheme'
Plug 'Renxiuhu/SearchOnSelectVim'
Plug 'jiangmiao/auto-pairs'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'aceofall/gtags.vim'
Plug 'vim-scripts/YankRing.vim'
"Plug 'Shougo/neocomplcache.vim'
if has("python") || has("python3")
	Plug 'Renxiuhu/LeaderF'
else
	Plug 'kien/ctrlp.vim'
endif
Plug 'godlygeek/csapprox'

call plug#end()

"--------------------------------------------------------------------------------
" 基础配置
"--------------------------------------------------------------------------------
set shortmess=atI "去掉欢迎界面
set nu!             " 显示行号,默认启动，ln开关控制
set mouse=a      "任何模式使用鼠标
"set mouse=nv      "只在普通和可视模式使用鼠标
set wrap           " 自动换行
"set nowrap         " 不自动换行
set linebreak       " 整词换行
set whichwrap=b,s,<,>,[,]       " 光标从行首和行末时可以跳到另一行去
"set list                       " 显示制表符
"set listchars=tab:>-,trail:-     " 将制表符显示为'>---',将行尾空格显示为'-'
set autochdir                   " 自动设置目录为正在编辑的文件所在的目录
set hidden          " 没有保存的缓冲区可以自动被隐藏
set scrolloff=5
set clipboard+=unnamed   "复制到剪贴板，默认是寄存器
set expandtab    "将Tab键转换为空格
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
nmap <C-n> :new<cr> "新建文件
"去除声音和闪屏
set vb t_vb=
au GuiEnter * set t_vb=
"--------------------------------------------------------------------------------
" 状态栏配置
"--------------------------------------------------------------------------------
set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c]
set laststatus=2    " always show the status line
"set ruler           " 在编辑过程中，在右下角显示光标位置的状态行
set guioptions-=m " 隐藏菜单栏
set guioptions-=T " 隐藏工具栏
"set guioptions-=L " 隐藏左侧滚动条
"set guioptions-=r " 隐藏右侧滚动条
set guioptions-=b " 隐藏底部滚动条

"--------------------------------------------------------------------------------
" 查找/替换相关的设置
"--------------------------------------------------------------------------------
set hlsearch        " 高亮显示搜索结果
set incsearch       " 查询时非常方便，如要查找book单词，当输入到/b时，会自动找到
                    " 第一个b开头的单词，当输入到/bo时，会自动找到第一个bo开头的
                    " 单词，依次类推，进行查找时，使用此设置会快速找到答案，当你
                    " 找要匹配的单词时，别忘记回车
set gdefault        " 替换时所有的行内匹配都被替换，而不是只有第一个
set ignorecase

"--------------------------------------------------------------------------------
" 主题设置
"--------------------------------------------------------------------------------
"Vim colorscheme
set t_Co=256

set background=light
colorscheme tatami
"--------------------------------------------------------------------------------
" 编程相关的设置
"--------------------------------------------------------------------------------
set completeopt=longest,menu    " 关掉智能补全时的预览窗口
filetype plugin indent on       " 加了这句才可以用智能补全
syntax enable             " 打开语法高亮
syntax on
set showmatch       " 设置匹配模式，类似当输入一个左括号时会匹配相应的那个右括号
set smartindent     " 智能对齐方式
set shiftwidth=4    " 换行时行间交错使用4个空格
set autoindent      " 自动对齐
set ai!             " 设置自动缩进
"set foldmethod=indent "代码折叠
set foldmethod=syntax
set foldlevel=100       " Don't autofold anything (but I can still fold manually)
"set foldopen-=search   " don't open folds when you search into them
"set foldopen-=undo     " don't open folds when you undo stuff
"set foldcolumn=4
"autocmd BufWritePre * :%s/\s\+$//e "保存时删除行尾空格
"--------------------------------------------------------------------------------
" 快捷键
"--------------------------------------------------------------------------------
"复制粘贴快捷键
if g:isGUI
    vmap <C-c> "+yy
    vmap <C-x> "+yd
    nmap <C-v> "+yp
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
nmap wx     <C-w>s     " 水平分割当前窗口

" 保存，退出，历史文件等快捷键
nmap <F4> :w<cr>    "保存文件修改
nmap <F3> :q<cr>    "退出vim
nmap <F12> :bro ol<cr>  "浏览文件打开记录
nmap <F2> :bd<cr>    "关闭minibufexplorer中的某个文件
nmap ln :set nu!<cr>
nmap fx :copen<cr>
nmap as :AsyncRun
nmap t :terminal<cr>

"--------------------------------------------------------------------------------
" 其他配置
"--------------------------------------------------------------------------------
"让vim记忆上次编辑的位置
autocmd BufReadPost *
			\ if line("'\"")>0&&line("'\"")<=line("$") |
						\	exe "normal g'\"" |
								\ endif


"###############################################################################
" 各插件配置
"###############################################################################
"--------------------------------------------------------------------------------
" Tagbar :比TagList好用，分类更清晰，推荐
"--------------------------------------------------------------------------------
let g:tagbar_width = 30
let g:tagbar_singleclick = 1 "点击一次跳转
let g:tagbar_iconchars = ['+', '-']
nmap <F6> :TagbarToggle<CR>

"--------------------------------------------------------------------------------
"" BufExplorer
"--------------------------------------------------------------------------------
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new windo
nmap bu \bs

"--------------------------------------------------------------------------------
" gtags
"--------------------------------------------------------------------------------
let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1
let GtagsCscope_Absolute_Path = 1

"--------------------------------------------------------------------------------
" cscope
"--------------------------------------------------------------------------------
":set cscopequickfix=s-,g-,c-,d-,i-,t-,e-,f-   "是否使用 quickfix 窗口来显示 cscope 结果
:set cscopetag
set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope
" 按下面这种组合键有技巧,按了<C-_>后要马上按下一个键,否则屏幕一闪
" 就回到nomal状态了
" <C-_>s的按法是先按"Ctrl+Shift+-",然后很快再按"s"
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<cr><cr>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<cr><cr>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<cr><cr>
"设置自动更新cscope索引文件的快捷键
if strridx(getcwd(),"tmp") == -1
    if strridx(getcwd(),"repo2") == -1
        nmap <F9> :AsyncRun find /repo/barretr/fdt1265 -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' -o -iname '*.cc' -o -iname '*.hh' -o -iname "*.idl" > ./cscope.files<CR>
    else
        nmap <F9> :AsyncRun find /repo2/barretr/workspace/fdt1265 -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' -o -iname '*.cc' -o -iname '*.hh' -o -iname "*.idl" > ./cscope.files<CR>
    endif
else
    if strridx(getcwd(),"repo2") == -1
        nmap <F9> :AsyncRun find /repo/barretr/fdt1265_tmp -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' -o -iname '*.cc' -o -iname '*.hh' -o -iname "*.idl" > ./cscope.files<CR>
    else
        nmap <F9> :AsyncRun find /repo2/barretr/workspace/fdt1265_tmp -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' -o -iname '*.cc' -o -iname '*.hh' -o -iname "*.idl" > ./cscope.files<CR>
    endif
endif
nmap <F10> :AsyncRun gtags -f cscope.files<CR>

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

"--------------------------------------------------------------------------------
" IndentLines:显示对齐线
"--------------------------------------------------------------------------------
nmap <F11> :IndentLinesToggle<cr>
let g:indentLine_char = '|'
let g:indentLine_color_term = 239
let g:indentLine_setColors = 0

"--------------------------------------------------------------------------------
" mark插件
"--------------------------------------------------------------------------------
" 给不同的单词高亮，表明不同的变量
nmap m lbve\m

"--------------------------------------------------------------------------------
" NERDTree
"--------------------------------------------------------------------------------
nmap <F5> :exec("NERDTree ".expand('%:h'))<CR>
let NERDTreeIgnore=['desktop.ini$']

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

"--------------------------------------------------------------------------------
" neocomplcache补全
"--------------------------------------------------------------------------------
" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
" " Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
" " Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
" " Set minimum syntax keyword length.
"let g:neocomplcache_min_syntax_length = 3"

"--------------------------------------------------------------------------------
" vim-cpp-enhanced-highlight,C++关键字高亮
"--------------------------------------------------------------------------------
"let g:cpp_class_scope_highlight = 1
"let g:cpp_member_variable_highlight = 1
"let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
"let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

"--------------------------------------------------------------------------------
"" YankRing, 可视化多选择剪切板
"--------------------------------------------------------------------------------
""显示yankring中的内容
nmap ys :YRShow<CR>
nmap yc :YRClear<CR>
let g:yankring_replace_n_pkey = ''
let g:yankring_replace_n_nkey = ''

"--------------------------------------------------------------------------------
" LeaderF and ctrlp
"--------------------------------------------------------------------------------
if has("python") || has("python3")
	let g:Lf_ShortcutF = '<c-p>' " search file
	let g:Lf_ShortcutB = '<c-b>' " list buffer
	let g:Lf_ShowRelativePath = 0
	let g:Lf_CommandMap = {'<C-C>': ['<Esc>', '<C-C>']}
	let g:Lf_WildIgnore = {
		\ 'dir': ['.svn','.git','.hg'],
		\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.D','*.cmd','*.ti']
		\}
	nmap fu :LeaderfBufTag<cr>
else
"按键映射
	let g:ctrlp_map = '<c-p>'
	" let g:ctrlp_cmd = 'CtrlP'
	let g:ctrlp_working_path_mode = 'ra'
	let g:ctrlp_regexp = 1
	let g:ctrlp_match_window_bottom=1
	let g:ctrlp_max_height=15
	let g:ctrlp_match_window_reversed=0
	let g:ctrlp_mruf_max=500
	let g:ctrlp_follow_symlinks=1
	"设置扫描文件最大数目（不限制)
	let g:ctrlp_max_files = 0
	"加快hg库文件扫描速度
    if g:iswindows
        let g:ctrlp_user_command = {
	        \ 'types': {
		        \ 1: ['.git', 'cd %s && git ls-files'],
		        \ 2: ['.hg', 'hg --cwd %s files .'],
		        \ },
	        \ 'fallback': 'dir %s /-n /b /s /a-d'
	    \ }
    else
        let g:ctrlp_user_command = {
	        \ 'types': {
		        \ 1: ['.git', 'cd %s && git ls-files'],
		        \ 2: ['.hg', 'hg --cwd %s files .'],
		        \ },
	        \ 'fallback': 'find %s -type f'
	    \ }
    endif
	let g:ctrlp_custom_ignore = {
		\ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
		\ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
		\ }
	set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
	set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
endif
"##################################################################
"########################## End Of Vimrc ##########################
"##################################################################
