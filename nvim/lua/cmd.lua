-- 记忆上次编辑的位置
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*" },
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.fn.setpos(".", vim.fn.getpos("'\""))
            -- how do I center the buffer in a sane way??
            -- vim.cmd('normal zz')
            vim.cmd("silent! foldopen")
        end
    end,
})

-- remove auto-comments
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    end,
})

-- keep layout after delete buffer
vim.api.nvim_create_user_command("BufferDelete", function(ctx)
    ---@diagnostic disable-next-line: missing-parameter
    local file_exists = vim.fn.filereadable(vim.fn.expand("%p"))
    local modified = vim.api.nvim_buf_get_option(0, "modified")

    if file_exists == 0 and modified then
        local user_choice = vim.fn.input("The file is not saved, whether to force delete? Press enter or input [y/n]:")
        if user_choice == "y" or user_choice:len() == 0 then
            vim.cmd("bd!")
        end
        return
    end

    local force = not vim.bo.buflisted or vim.bo.buftype == "nofile"

    vim.cmd(force and "bd!" or ("bp | bd! %s"):format(vim.api.nvim_get_current_buf()))
end, { desc = "Delete the current Buffer while maintaining the window layout" })

-- show quickfix if more than one item
vim.api.nvim_create_user_command("ShowJumpQf", function(ctx)
    local qf_counts = vim.fn.getqflist({size = true}).size

    if qf_counts == 1 then
        vim.cmd("cc 1")
    elseif qf_counts > 1 then
        vim.cmd("Telescope quickfix")
    end
end, { desc = "check if need to shouw telescope quickfix or jump to first one" })
