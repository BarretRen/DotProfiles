return {
    {
        "talha-akram/noctis.nvim",
    },
    {
        "numToStr/FTerm.nvim",
        keys = {
            {"<C-j>", "<cmd>lua require(\"FTerm\").toggle()<cr>"},
            {"<C-j>", "<cmd>lua require(\"FTerm\").toggle()<cr>", mode="t"},
        },
        config = function()
            require("FTerm").setup{
                cmd = vim.g.sysop == "win" and "cmd" or "bash",
            }
        end
    },
    {
        "tpope/vim-fugitive",
        keys = {{"<F7>", "<cmd>Git blame<cr>"}},
    },
    {
        "NTBBloodbath/daylight.nvim",
        enabled = false,
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
        "mhartington/formatter.nvim",
        keys = {
            {"fm", "<cmd>Format<cr>"},
        },
        enabled = false,
        config = function()
            require("formatter").setup {
                filetype = {
                    -- configure formatter for each filetype
                    markdown = {
                        require("formatter.filetypes.markdown").prettier,
                    },
                },
            }
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
                -- options = { theme = "papercolor_dark" },
                sections = {
                    lualine_c = {{'filename', path = 1}},
                    lualine_x = {'searchcount', 'encoding', 'filetype'},
                },
            }
        end,
    },
    {
        "olimorris/persisted.nvim",
        config = function()
            require("persisted").setup({
                use_git_branch = false,
                autosave = false,
            })
        end
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
            {"ls", ":Telescope lsp_dynamic_workspace_symbols<cr>"},
            {"wp", ":Telescope persisted<cr>"},
        },
        config = function()
            require("telescope").load_extension("persisted")
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
                    preview = {
                        treesitter = false,
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
                extensions = {
                    persisted = {
                        layout_config = { width = 0.55, height = 0.55 }
                    }
                },
            }
            vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
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
                    -- 不显示行数
                    number = false,
                    relativenumber = false,
                },
                renderer = {
                    root_folder_label = true,
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
            {"rg", "<cmd>lua require('spectre').toggle()<cr>"},
            {"sw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>"},
            {"sw", "<esc><cmd>lua require('spectre').open_visual()<cr>", mode="v"},
            {"sf", "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>"},
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "numToStr/Comment.nvim",
        keys = {
            -- map key C-/
            {"<C-_>", "gcc", remap=true},
            {"<C-_>", "gbc", mode="v", remap=true},
        },
        opts = {
            mappings = {
                ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                basic = true,
                ---Extra mapping; `gco`, `gcO`, `gcA`
                extra = false,
            },
        },
    },
}
