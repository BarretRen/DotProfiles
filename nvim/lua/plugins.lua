local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugs')
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/EasyGrep'
Plug 'inkarkat/vim-mark'
Plug 'inkarkat/vim-ingo-library'
Plug 'scrooloose/nerdcommenter'
Plug 'NTBBloodbath/doom-one.nvim'
Plug 'NTBBloodbath/daylight.nvim'
Plug 'lifepillar/vim-solarized8'
Plug 'BarretRen/SearchOnSelectVim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'aceofall/gtags.vim'
Plug 'numToStr/FTerm.nvim'
Plug 'vim-autoformat/vim-autoformat'
--Plug 'ap/vim-buftabline'
Plug 'akinsho/bufferline.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
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
--vim.g.buftabline_numbers = 1
--vim.g.buftabline_show = 1
--vim.g.buftabline_indicators = 1
--vim.g.buftabline_plug_max = 0
-- autoformat
vim.g.formatdef_astyle_c = '"astyle --mode=c --options=/home/barretr/.astylerc"'
vim.g.formatters_c = "['astyle_c', 'clangformat']"
vim.g.formatdef_astyle_cpp = '"astyle --mode=c --options=/home/barretr/.astylerc"'
vim.g.formatters_cpp = "['astyle_cpp', 'clangformat']"
-- vim-solarized8
vim.g.solarized_italics = 0

require("bufferline").setup {
    options = {
        diagnostics = "false", --不显示告警
        --左侧让出 nvim-tree 的位置
        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
        }}
    },
    highlights = {
        buffer_selected = {
            italic = false,
        }
    }
}

local function ts_disable(_, bufnr)
    return vim.api.nvim_buf_line_count(bufnr) > 50000
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "yang", "java"},
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
     --disable = { "lua", "vim" },
     disable = function(lang, bufnr)
         return lang == "cmake" or lang == "lua" or lang == "vim" or ts_disable(lang, bufnr)
     end,

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
          "-tc",
          "-tcpp",
          "-tyang",
          "-tjava",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--case-sensitive"
        },
      path_display = {
          "truncate"
        },
      file_ignore_patterns = {
          "vendor/*",
          "%.lock",
          "__pycache__/*",
          "%.sqlite3",
          "%.ipynb",
          "node_modules/*",
          "%.jpg",
          "%.jpeg",
          "%.png",
          "%.svg",
          "%.otf",
          "%.ttf",
          ".git/",
          "%.webp",
          ".dart_tool/",
          ".github/",
          ".gradle/",
          ".idea/",
          ".settings/",
          ".vscode/",
          "__pycache__/",
          "build/",
          "env/",
          "gradle/",
          "node_modules/",
          "target/",
          "%.pdb",
          "%.dll",
          "%.class",
          "%.exe",
          "%.cache",
          "%.ico",
          "%.pdf",
          "%.dylib",
          "%.jar",
          "%.docx",
          "%.met",
          "smalljre_*/*",
          ".vale/",
      },
  },
  pickers = {
    find_files = { no_ignore = true },
    quickfix = { fname_width = 100 },
    lsp_document_symbols = { fname_width = 100 },
    lsp_references = { fname_width = 100 },
    lsp_definitions = { fname_width = 100 },
    lsp_dynamic_workspace_symbols = { fname_width = 100 },
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
    },
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
        update_root = true,
        ignore_list = { "FTerm", "term" },
    },
    view = {
        -- 宽度
        width = 40,
        -- 也可以 'right'
        side = 'left',
        -- 隐藏根目录
        hide_root_folder = false,
        -- 自定义列表中快捷键
        mappings = {
            custom_only = false,
            list = list_keys,
        },
        -- 不显示行数
        number = false,
        relativenumber = false,
    },
    actions = {
        open_file = {
            -- 首次打开大小适配
            resize_window = true,
            -- 打开文件时关闭
            quit_on_open = false,
        },
    },
}

require("diffview").setup{
    use_icons = false,
    view = {
        -- Configure the layout and behavior of different types of views.
        -- Available layouts: 
        --  'diff1_plain'
        --    |'diff2_horizontal'
        --    |'diff2_vertical'
        --    |'diff3_horizontal'
        --    |'diff3_vertical'
        --    |'diff3_mixed'
        --    |'diff4_mixed'
        -- For more info, see ':h diffview-config-view.x.layout'.
        default = {
            -- Config for changed files, and staged files in diff views.
            layout = "diff2_horizontal",
        },
        merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = "diff4_mixed",
            disable_diagnostics = true,   -- Temporarily disable diagnostics for conflict buffers while in the view.
        },
        file_history = {
            -- Config for changed files in file history views.
            layout = "diff2_horizontal",
        },
    },
}

local cmp = require'cmp'
cmp.setup{
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    window = {
         completion = cmp.config.window.bordered(),
         documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<M-Space>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
    }, {
        { name = 'buffer' },
    })
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.clangd.setup{
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--background-index",
        "--compile-commands-dir=build",
        "-j=4",
        "--all-scopes-completion",
        "--completion-style=detailed",
        "--header-insertion=never",
        "--clang-tidy",
        "--clang-tidy-checks=*",
        "--cross-file-rename",
        "--header-insertion-decorators",
        "--pch-storage=memory"
    }
}

require("daylight").setup{
    day = {
        name = "solarized8_flat",
        time = 8, -- 8 am
    },
    night = {
        name = "doom-one",
        time = 19, -- 7 pm, changes to dark theme on 07:01
    },
    interval = 900000, -- Time in milliseconds, 15 minute
}
