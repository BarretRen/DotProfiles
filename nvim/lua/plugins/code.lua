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
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
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
            }
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
        "utilyre/barbecue.nvim",
        enabled = false,
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
}
