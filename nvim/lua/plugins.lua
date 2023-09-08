local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function ts_disable(_, bufnr)
    return vim.api.nvim_buf_line_count(bufnr) > 50000
end

require("lazy").setup({
{
    "numToStr/FTerm.nvim",
    keys = {
        {"<C-j>", "<cmd>lua require(\"FTerm\").toggle()<cr>"},
        {"<C-j>", "<cmd>lua require(\"FTerm\").toggle()<cr>", mode="t"},
    },
},
{
    "tpope/vim-fugitive",
    keys = {{"<F7>", "<cmd>Git blame<cr>"}},
},
{
    "NTBBloodbath/daylight.nvim",
    dependencies = {"talha-akram/noctis.nvim"},
    config = function()
        require("daylight").setup{
            day = {
                name = "noctis_lilac",
                time = 8, -- 8 am
            },
            night = {
                name = "noctis_uva",
                time = 19, -- 7 pm
            },
            interval = 900000, -- Time in milliseconds, 15 minute
        }
    end,
},
{
    "majutsushi/tagbar",
    enabled = false,
    keys = {{"<F5>", "<cmd>TagbarToggle<cr>"}},
    init = function()
        vim.g.tagbar_width = 30
        vim.g.tagbar_singleclick = 1
        vim.g.tagbar_iconchars = "['+', '-']"
        vim.g.tagbar_position = "left"
    end,
},
{
    "xbot/gtags.vim",
    keys = {
        {"fr", ":cexp[]<cr>:Gtags -r <C-R>=expand(\"<cword>\")<cr><cr>:Telescope quickfix<cr>"},
        {"fd", ":cexp[]<cr>:Gtags <C-R>=expand(\"<cword>\")<cr><cr>:Telescope quickfix<cr>"},
        {"fg", ":<C-U><C-R>=printf(\"Gtags\")<cr><cr>"},
        {"fa", ":<C-U><C-R>=printf(\"Gtags -g\")<cr><cr>"},
        {"fs", ":<C-U><C-R>=printf(\"Gtags -s\")<cr><cr>"},
    },
    init = function()
        vim.g.Gtags_OpenQuickfixWindow = 0
    end,
},
{
    "inkarkat/vim-mark",
    dependencies = {
      "inkarkat/vim-ingo-library",
    },
    keys = {
        {"m", "lbve<Leader>m", remap=true},
        {"m", "<Leader>m", mode="v", remap=true},
        {"<Leader>M", "<Plug>MarkToggle"},
        {"<Leader>N", "<Plug>MarkAllClear"},
    },
    init = function()
        vim.g.mwDefaultHighlightingPalette = "extended"
        vim.g.mwIgnoreCase = 0
    end,
},
{
    "scrooloose/nerdcommenter",
    keys = {
        {"<C-\\>", "<Leader>ci", remap=true},
        {"<C-\\>", "<Leader>ci", mode="v", remap=true},
    },
    init = function()
        vim.g.NERDCompactSexyComs = 1
        vim.g.NERDDefaultAlign = "left"
        vim.g.NERDAltDelims_java = 1
        vim.g.NERDCommentEmptyLines = 1
        vim.g.NERDTrimTrailingWhitespace = 1
    end,
},
{
    "BarretRen/SearchOnSelectVim",
    enabled = false,
    keys = {
        {"n", mode="v"},
        {"<s-n>", mode="v"},
    },
    init = function()
        vim.g.SearchOnSelect_active = 1
    end,
},
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ft = { "c", "cpp", "yang", "java"},
    config = function()
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
    end,
},
{
    "vim-autoformat/vim-autoformat",
    enabled = false,
    config = function()
        vim.g.formatdef_astyle_c = '"astyle --mode=c --options=~/.astylerc"'
        vim.g.formatters_c = "['astyle_c', 'clangformat']"
        vim.g.formatdef_astyle_cpp = '"astyle --mode=c --options=~/.astylerc"'
        vim.g.formatters_cpp = "['astyle_cpp', 'clangformat']"
    end,
},
{
    "akinsho/bufferline.nvim",
    config = function()
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
    end,
},
{
    "nvim-lualine/lualine.nvim",
    config = function()
        require('lualine').setup{
            options = { theme = "papercolor_dark" },
            sections = {
                lualine_c = {{'filename', path = 1}},
                lualine_x = {'searchcount', 'encoding', 'filetype'},
            },
        }
    end,
},
{
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {"<F12>", "<cmd>Telescope oldfiles<cr>"},
        {"<C-p>", ":Telescope find_files<cr>"},
        {"<C-b>", ":Telescope buffers<cr>"},
        {"<C-f>", ":Telescope current_buffer_fuzzy_find<cr>"},
        {"fu", ":Telescope treesitter<cr>"},
        {"fx", ":Telescope quickfix<cr>"},
        {"lu", ":Telescope lsp_document_symbols<cr>"},
        {"lr", ":Telescope lsp_references<cr>"},
        {"ld", ":Telescope lsp_definitions<cr>"},
        {"ls", ":Telescope lsp_dynamic_workspace_symbols<cr>"}
    },
    config = function()
        require('telescope').setup{
          defaults = {
              wrap_results = true,
              layout_config = { width = 0.9 },
              vimgrep_arguments = {
                  "rg",
                  "-u",
                  "-w",
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
    end,
},
{
    "utilyre/barbecue.nvim",
    dependencies = {
        "SmiteshP/nvim-navic",
    },
    ft = { "c", "cpp"},
    config = function()
        require("barbecue").setup({
            attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
            show_navic = true,
        })
    end,
},
{
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    enabled = false,
    ft = { "c", "cpp"},
    config = function()
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
            },
            on_attach = function(client, bufnr)
                if client.server_capabilities["documentSymbolProvider"] then
                    require("nvim-navic").attach(client, bufnr)
                end
            end,
        }
    end,
},
{
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
    },
    keys = {
        {"<C-n>", mode="i"},
    },
    config = function()
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
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm       explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' }, -- For vsnip users.
            }, {
                { name = 'buffer' },
            })
        }
    end,
},
{
    "nvim-tree/nvim-tree.lua",
    keys = {{"nw", "<cmd>NvimTreeToggle<cr>"}},
    config = function()
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
    end,
},
{
    "nvim-pack/nvim-spectre",
    keys = {
        {"rg", "<cmd>lua require('spectre').open()<cr>"},
        {"gs", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>"},
        {"gs", "<esc><cmd>lua require('spectre').open_visual()<cr>", mode="v"},
        {"sf", "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>"},
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
},
},
{
git = {
    url_format = "https://github.com/%s.git",
},
})


