return {
    {
        "talha-akram/noctis.nvim",
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
        enabled = true,
        config = function()
            require("formatter").setup {
                filetype = {
                    -- configure formatter for each filetype
                    markdown = {
                        require("formatter.filetypes.markdown").prettier,
                    },
                    c = {
                        require("formatter.filetypes.c").clangformat,
                    },
                    cpp = {
                        require("formatter.filetypes.cpp").clangformat,
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
            local inactive_bg = "#606060"
            local inactive_fg = "#e0e0e0"
            local visible_bg = "#e0e0e0"
            local visible_fg = "#404040"
            local selected_bg = "#f3f3f3"
            local selected_fg = "#000000"
            local background  = "#606060"
            local inactive_set = { fg = inactive_fg, bg = inactive_bg, }
            local visible_set = { fg = visible_fg, bg = visible_bg, }
            local active_set = { fg = selected_fg, bg = selected_bg, }
            require("bufferline").setup {
                highlights = {
                    background = inactive_set,
                    buffer_visible = visible_set,
                    buffer_selected = active_set,

                    numbers = inactive_set,
                    numbers_visible = visible_set, 
                    numbers_selected = active_set,

                    close_button = inactive_set,
                    close_button_visible = visible_set, 
                    close_button_selected = active_set,

                    tab_selected = visible_set,

                    separator = { fg = background, bg = inactive_bg },
                    separator_visible = { fg = background, bg = visible_bg },
                    separator_selected = { fg = background, bg = selected_bg },

                    modified = { fg = '#ff0000', bg = inactive_bg, },
                    modified_visible = { fg = '#ff0000', bg = visible_bg, },
                    modified_selected = { fg = '#ff0000', bg = selected_bg, },

                    fill = { bg = background, }
                },
                options = {
                    themable = true,
                    style_preset = {
                        require("bufferline").style_preset.no_italic,
                        require("bufferline").style_preset.no_bold,
                    },
                    separator_style = 'slant',
                    indicator = { style = 'none'},
                    mode = "buffers",
                    -- show_buffer_icons = false,
                    -- show_buffer_close_icons = false,
                    -- show_close_icon = false,
                    show_tab_indicators = true,
                    tab_size = 5,
                    diagnostics = "false", --不显示告警
                    --左侧让出 snacks_picker_list 的位置
                    offsets = {{
                        filetype = "snacks_picker_list",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left"
                    }},
                    name_formatter = function(buf)
                        return buf.name
                    end,
                }
            }
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "arkav/lualine-lsp-progress",
        },
        config = function()
            require('lualine').setup{
                -- options = { theme = "papercolor_dark" },
                sections = {
                    lualine_c = {'filename', 'lsp_progress'},
                    -- lualine_c = {{'filename', path = 1}},
                    lualine_x = {'searchcount', 'encoding', 'fileformat', 'filetype'},
                },
            }
        end,
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            picker = {
                winblend = 20,
                layout = {
                    preset = "vertical",
                    width = 0.9,
                    preview = { cutoff = 0 },
                },
                ignore = {
                    "vendor/*",
                    "%.lock",
                    "__pycache__/*",
                    "%.sqlite3",
                    "%.ipynb",
                    "node_modules/*",
                    "%.jpg", "%.jpeg", "%.png", "%.svg", "%.otf", "%.ttf",
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
                    "%.pdb", "%.dll", "%.class", "%.exe", "%.cache",
                    "%.ico", "%.pdf", "%.dylib", "%.jar", "%.docx", "%.met",
                    "smalljre_*/*",
                    ".vale/",
                },
                grep = {
                    args = {
                        "-uu",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--case-sensitive",
                    },
                },
            },
            session = {
                autosave = false,
                autoload = false,
            },
             -- ===== explorer 文件管理器（替代 oil.nvim / nvim-tree） =====
            explorer = {
                -- 是否显示隐藏文件（原 nvim-tree 默认不显示，但可开启）
                hidden = true,
                -- 窗口宽度（与之前 nvim-tree 的 width = 40 一致）
                width = 40,
                -- 自动关闭 explorer 当打开文件时（保持行为与之前类似）
                auto_close = false,
                -- 显示 git 状态（原 nvim-tree 禁用了，此处也禁用）
                git = false,
                -- 是否在 root 目录显示项目名（类似原 root_folder_label）
                show_root = true,
                -- 排序方式
                sort = { "type", "name" },
                -- 快捷键映射（可保留默认或自定义）
                mappings = {
                    ["<CR>"] = "open",
                    ["<C-c>"] = "close",
                    ["<C-h>"] = "parent",
                    ["<C-l>"] = "refresh",
                },
                -- 启动时自动聚焦
                focus = true,
            },
            -- ===== terminal 浮动终端（替代 FTerm） =====
            terminal = {
                -- 可选配置，默认已合理
                win = {
                    style = "float",
                    relative = "editor",
                    width = 0.7,
                    height = 0.8,
                    row = 0.1,
                    col = 0.15,
                    blend = 30,
                    border = "rounded",
                    title = "Terminal",
                },
                -- 默认 shell 使用系统配置，也可指定
                -- cmd = vim.g.sysop == "win" and "cmd" or "bash",
            },
        },
        keys = {
            { "<F12>", function() require("snacks").picker.recent() end, desc = "Find oldfiles" },
            { "<C-p>", function() require("snacks").picker.files() end, desc = "Find files" },
            { "<C-b>", function() require("snacks").picker.buffers() end, desc = "Find buffers" },
            { "<C-f>", function() require("snacks").picker.lines() end, desc = "Find in current buffer" },
            { "fu", function() require("snacks").picker.treesitter() end, desc = "Treesitter symbols" },
            { "fx", function() require("snacks").picker.qflist() end, desc = "Quickfix list" },
            -- 原 fh 为 quickfixhistory，snacks 无直接对应，暂时映射为 quickfix
            { "fh", function() require("snacks").picker.qflist() end, desc = "Quickfix (no history)" },
            { "fl", function() require("snacks").picker.loclist() end, desc = "Loclist" },
            { "lu", function() require("snacks").picker.lsp_symbols() end, desc = "LSP document symbols" },
            { "lr", function() require("snacks").picker.lsp_references() end, desc = "LSP references" },
            { "ld", function() require("snacks").picker.lsp_definitions() end, desc = "LSP definitions" },
            { "ls", function() require("snacks").picker.lsp_workspace_symbols() end, desc = "LSP workspace symbols" },
            { "wp", function() require("snacks").picker.sessions() end, desc = "Sessions" },
            { "wk", function() require("snacks").picker.keymaps() end, desc = "Keymaps" },
            { "rg", function() require("snacks").picker.grep() end, desc = "Live grep" },
            { "rw", function() require("snacks").picker.grep_word() end, desc = "Grep word under cursor" },
            { "nw", function() require("snacks").picker.explorer() end, desc = "Open file explorer" },
            -- 正常模式下 toggle 终端
            { "<C-j>", function() require("snacks").terminal.toggle() end, desc = "Toggle terminal" },
            -- 终端模式下也映射 <C-j> 退出终端（或 toggle 回 normal）
            { "<C-j>", function() require("snacks").terminal.toggle() end, mode = "t", desc = "Toggle terminal" },
        },
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
