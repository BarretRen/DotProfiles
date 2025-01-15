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
                blend = 20,
                dimensions = {
                    height = 0.9,
                    width = 0.9,
                },
            }
        end
    },
    {
        "tpope/vim-fugitive",
        enabled = false,
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
            {"m", "<Leader>m", remap=true},
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
        "tiagovla/scope.nvim",
        event = {"BufRead","TabEnter", "BufWinEnter"},
        config = true,
    },
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("bufferline").setup {
                options = {
                    mode = "buffers",
                    diagnostics = "false", --不显示告警
                    --左侧让出 nvim-tree 的位置
                    offsets = {{
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left"
                    }},
                    name_formatter = function(buf)
                        return buf.name
                    end,
                },
                highlights = {
                    buffer_selected = {
                        fg = '#FF5733',
                        italic = false,
                    },
                    tab_selected = {
                        fg = '#F1C40F',
                        bg = '#5D6D7E',
                    },
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
                    lualine_c = {'filename'},
                    -- lualine_c = {{'filename', path = 1}},
                    lualine_x = {'searchcount', 'encoding', 'fileformat', 'filetype'},
                },
            }
        end,
    },
    {
        "olimorris/persisted.nvim",
        lazy = true,
        config = function()
            require("persisted").setup({
                use_git_branch = false,
                autostart = false,
                autosave = false,
            })
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim"
        },
        keys = {
            {"<F12>", "<cmd>Telescope oldfiles<cr>"},
            {"<C-p>", ":Telescope find_files<cr>"},
            {"<C-b>", ":Telescope buffers<cr>"},
            {"<C-f>", ":Telescope current_buffer_fuzzy_find<cr>"},
            {"fu", ":Telescope treesitter<cr>"},
            {"fx", ":Telescope quickfix<cr>"},
            {"fh", ":Telescope quickfixhistory<cr>"},
            {"fl", ":Telescope loclist<cr>"},
            {"lu", ":Telescope lsp_document_symbols<cr>"},
            {"lr", ":Telescope lsp_references<cr>"},
            {"ld", ":Telescope lsp_definitions<cr>"},
            {"ls", ":Telescope lsp_dynamic_workspace_symbols<cr>"},
            {"wp", ":Telescope persisted<cr>"},
            {"wk", ":Telescope keymaps<cr>"},
            {"rg", ":Telescope live_grep_args<cr>"},
            {"rw", ":Telescope grep_string<cr>"},
        },
        config = function()
            require("telescope").load_extension("persisted")
            require("telescope").load_extension("live_grep_args")
            require('telescope').setup{
                defaults = {
                    -- wrap_results = true,
                    winblend = 20,
                    layout_strategy = 'vertical',
                    layout_config = {
                        vertical = {
                            width = 0.9,
                            preview_cutoff = 0,
                        },
                    },
                    vimgrep_arguments = {
                        "rg",
                        "-uu",
                        -- "-w",
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
                    mappings = {
                        i = {
                            ["<C-l>"] = require("telescope.actions").send_to_loclist,
                        },
                        n = {
                            ["<C-l>"] = require("telescope.actions").send_to_loclist,
                        },
                    },
                },
                pickers = {
                    find_files = { no_ignore = true },
                    grep_string = { additional_args = {"-w"} },
                    quickfix = { fname_width = 0.6 },
                    lsp_document_symbols = { fname_width = 0.6 },
                    lsp_references = { fname_width = 0.6 },
                    lsp_definitions = { fname_width = 0.6 },
                    lsp_dynamic_workspace_symbols = { fname_width = 0.6 },
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
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
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
        enabled = false,
        keys = {
            {"rg", "<cmd>lua require('spectre').toggle()<cr>"},
            {"sw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>"},
            {"sw", "<esc><cmd>lua require('spectre').open_visual()<cr>", mode="v"},
            {"sf", "<cmd>lua require('spectre').open_file_search({select_word=true})<cr>"},
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require('spectre').setup({
                mapping={
                    ['toggle_search_whole'] = {
                        map = "tw",
                        cmd = "<cmd>lua require('spectre').change_options('search-whole')<CR>",
                        desc = "toggle search whole word"
                    },
                },
                find_engine = {
                    ['rg'] = {
                        options = {
                            ['hidden'] = {
                                value="-uu",
                                desc="hidden file",
                                icon="[H]"
                            },
                            ['search-whole'] = {
                                value= "--word-regexp",
                                icon="[W]",
                                desc="search whole word"
                            },
                        },
                    },
                },
            })
        end,
    },
    {
        "numToStr/Comment.nvim",
        enabled = false, --nvim 0.10 supports this by default, no need this
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
