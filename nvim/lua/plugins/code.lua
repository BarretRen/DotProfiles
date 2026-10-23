return {
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
        -- dependencies = {
        --     "nvim-telescope/telescope.nvim",
        -- },
        keys = {
            {"fr", ":cexp[]<cr>:Gtagsfr -r <C-R>=expand(\"<cword>\")<cr><cr>"},
            {"fd", ":cexp[]<cr>:Gtagsfd <C-R>=expand(\"<cword>\")<cr><cr>"},
            {"fg", ":cexp[]<cr>:Gtagsfg<cr>"},
            {"fa", ":cexp[]<cr>:Gtagsfa<cr>"},
            {"fs", ":cexp[]<cr>:Gtagsfs<cr>"},
        },
        init = function()
            vim.g.Gtags_OpenQuickfixWindow = 0
            vim.g.Gtags_No_Auto_Jump = 1
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false, -- main分支强制不能懒加载，删掉 ft
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.setup({
                highlight = {
                    disable = function(lang, bufnr)
                        if lang == "cmake" or lang == "lua" or lang == "vim" then
                            return true
                        elseif vim.api.nvim_buf_line_count(bufnr) > 50000 then
                            return true
                        else
                            return false
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
            })
            -- 替换原来 ensure_installed
            ts.install({ "c", "cpp", "yang", "java" })
            -- ========== 这一段是新增核心！自动开启treesitter高亮 ==========
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "c", "cpp", "yang", "java" },
                callback = function(ev)
                    -- pcall防止parser没装时报错
                    pcall(vim.treesitter.start, ev.buf)
                end
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
                    -- "--compile-commands-dir=build",
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
}
