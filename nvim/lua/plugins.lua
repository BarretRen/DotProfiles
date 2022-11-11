local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugs')
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/EasyGrep'
Plug 'inkarkat/vim-mark'
Plug 'inkarkat/vim-ingo-library'
Plug 'scrooloose/nerdcommenter'
Plug 'NTBBloodbath/doom-one.nvim'
Plug 'lifepillar/vim-solarized8'
Plug 'BarretRen/SearchOnSelectVim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'aceofall/gtags.vim'
Plug 'numToStr/FTerm.nvim'
Plug 'vim-autoformat/vim-autoformat'
Plug 'ap/vim-buftabline'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'sindrets/diffview.nvim'
--Plug 'nvim-tree/nvim-web-devicons'
vim.call('plug#end')

-- Tagbar
vim.g.tagbar_width = 30
vim.g.tagbar_singleclick = 1
vim.g.tagbar_iconchars = "['+', '-']"
vim.g.tagbar_position = "left"
-- gtags
vim.g.Gtags_OpenQuickfixWindow = 0
-- easyGrep
vim.g.EasyGrepMode = 1
vim.g.EasyGrepCommand = 0
vim.g.EasyGrepRecursive  = 0
vim.g.EasyGrepIgnoreCase = 1
vim.g.EasyGrepFilesToExclude = "*.bak, *~, cscope.*, *.a, *.o, *.pyc, *.bak"
-- vim-mark
vim.g.mwDefaultHighlightingPalette = "extended"
-- netrw
vim.g.netrw_browse_split = 4
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3
-- nerdcommenter
vim.g.NERDCompactSexyComs = 1
vim.g.NERDDefaultAlign = "left"
vim.g.NERDAltDelims_java = 1
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDTrimTrailingWhitespace = 1
-- SearchOnSelectVim
vim.g.SearchOnSelect_active = 1
vim.g.miniBufExplAutoStart = 1
-- bufTabline
vim.g.buftabline_numbers = 1
vim.g.buftabline_show = 1
vim.g.buftabline_indicators = 1
vim.g.buftabline_plug_max = 0
-- autoformat
vim.g.formatdef_astyle_c = '"astyle --mode=c --options=/home/barretr/.astylerc"'
vim.g.formatters_c = "['astyle_c', 'clangformat']"
vim.g.formatdef_astyle_cpp = '"astyle --mode=c --options=/home/barretr/.astylerc"'
vim.g.formatters_cpp = "['astyle_cpp', 'clangformat']"

require'lspconfig'.clangd.setup{}

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

require('lualine').setup{
    options = { theme = "papercolor_dark" },
    sections = {
        lualine_c = {{'filename', path = 1}},
        lualine_x = {'encoding', 'filetype'},
    },
}

--local builtins = require("telescope.builtin")
--local picker_config = { }
--for b, _ in pairs(builtins) do
  --picker_config[b] = { fname_width = 50 }
--end

require('telescope').setup{
  defaults = {
      wrap_results = true,
      layout_config = { width = 0.9 },
      vimgrep_arguments = {
          "rg",
          "-u",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case"
        },
      path_display = {
          "truncate"
        },
  },
  pickers = {
    find_files = { no_ignore = true },
    quickfix = { fname_width = 100 },
  },
  --pickers = vim.tbl_extend("force", picker_config, {
  --})
}
vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")

require('gitsigns').setup{
    signcolumn = false
}

require'nvim-tree'.setup {
    -- 不显示 git 状态图标
    git = {
        enable = false
    }
}

require("diffview").setup{
    use_icons = false,
}
