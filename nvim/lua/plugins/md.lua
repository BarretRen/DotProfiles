return {
    {
        "equalsraf/neovim-gui-shim", -- used for nvim-qt
        enabled = false,
    },
    {
        "iamcco/markdown-preview.nvim",
        enabled = false,
        keys = {
            {"mp", "<cmd>MarkdownPreviewToggle<cr>"},
        },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        'zaiic/pinmd.nvim',
        enabled = false,
        keys = {
            {"mv", "<cmd>PinmdPaste<cr>"},
        },
        ft = { "markdown" },
        opts = {
            files = {
                location_for_new_attachments = "specified_folder_in_vault",
                attachment_folder_path = vim.fn.expand("%:r") .. ".assets"
            },
            images = {
                name = function()
                    local dir = vim.fn.expand("%:r") .. ".assets"
                    if not vim.loop.fs_stat(dir) then
                        return "image"
                    else
                        local filelist = vim.fn.readdir(dir, [[v:val =~ '.png$']])
                        local img_cnt = vim.fn.len(filelist)
                        if img_cnt == 0 then
                            return "image"
                        else
                            return "image-" .. tostring(img_cnt)
                        end
                    end

                end,
            },
        },
    },
}
