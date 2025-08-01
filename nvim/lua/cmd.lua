-- 记忆上次编辑的位置
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*" },
    callback = function()
            -- Get a list of all buffers
            local buffers = vim.api.nvim_list_bufs()
            -- Iterate over each buffer
            for _, bufnr in ipairs(buffers) do
                -- Check if the buffer is empty and doesn't have a name
                if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_name(bufnr) == '' and
                    vim.api.nvim_buf_get_option(bufnr, 'buftype') == '' then

                    -- Get all lines in the buffer
                    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

                    -- Initialize a variable to store the total number of characters
                    local total_characters = 0

                    -- Iterate over each line and calculate the number of characters
                    for _, line in ipairs(lines) do
                        total_characters = total_characters + #line
                    end

                    -- Close the buffer if it's empty:
                    if total_characters == 0 then
                        vim.api.nvim_buf_delete(bufnr, {
                            force = true
                        })
                    end
                end
            end

        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.fn.setpos(".", vim.fn.getpos("'\""))
            -- how do I center the buffer in a sane way??
            -- vim.cmd('normal zz')
            vim.cmd("silent! foldopen")
        end
        --[[ local is_supported = false
        local support_types = { "c", "cpp", "yang", "java"}
        for i = 0, #support_types do
            if support_types[i] == vim.bo.filetype then
                is_supported = true
                break
            end
        end
        if is_supported then
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        else
            vim.opt.foldmethod = "indent"
        end ]]
    end,
})

-- remove auto-comments
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "java" },
    callback = function()
        vim.opt.commentstring = "// %s"
    end,
    desc = "Change commentstring for c/c++ files",
})

-- osc52 copy text to host clipboard, nvim 0.10 supports this by default, no need this
--[[ vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = { "*" },
    callback = function()
        local c = vim.fn.join(vim.v.event.regcontents, "\n")
        local c64 = vim.fn.system("base64", c)
        local osc52str = string.format("\x1b]52;c;%s\x07", vim.fn.trim(c64))
        vim.fn.chansend(vim.v.stderr, osc52str)
    end,
}) ]]

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

vim.api.nvim_create_user_command("Gtagsfd", function(ctx)
    local symbol = ctx.args
    if symbol:len() ~= 0 then
        vim.cmd("Gtags " .. symbol)
        vim.cmd("ShowJumpQf")
    end
end, { bang=true, nargs = "+", complete = "custom,GtagsCandidate", desc = "symbol define via Gtags" })

vim.api.nvim_create_user_command("Gtagsfr", function(ctx)
    local symbol = ctx.args
    if symbol:len() ~= 0 then
        vim.cmd("Gtags -r " .. symbol)
        local qf_counts = vim.fn.getqflist({size = true}).size
        if qf_counts == 0 then
            vim.cmd("Gtags -s " .. symbol)
        end
        vim.cmd("ShowJumpQf")
    end
end, { bang=true, nargs = "+", complete = "custom,GtagsCandidate", desc = "symbol reference via Gtags" })

vim.api.nvim_create_user_command("Gtagsfg", function(ctx)
    local symbol = vim.fn.input("Gtags for pattern: ")
    if symbol:len() ~= 0 then
        vim.cmd("Gtags " .. symbol)
        vim.cmd("ShowJumpQf")
    end
end,
{ desc = "find symbol define via Gtags" })

vim.api.nvim_create_user_command("Gtagsfa", function(ctx)
    local symbol = vim.fn.input("Gtags for pattern: ")
    if symbol:len() ~= 0 then
        vim.cmd("Gtags -g " .. symbol)
        vim.cmd("ShowJumpQf")
    end
end, { desc = "find all symbol via Gtags" })

vim.api.nvim_create_user_command("Gtagsfs", function(ctx)
    local symbol = vim.fn.input("Gtags for pattern: ")
    if symbol:len() ~= 0 then
        vim.cmd("Gtags -s " .. symbol)
        vim.cmd("ShowJumpQf")
    end
end, { desc = "search symbol via Gtags" })

vim.api.nvim_create_user_command('TigBlame', function()
    local file = vim.fn.expand("%:t")
    local ln = vim.fn.line(".")
    local path = vim.fn.expand("%:h")
    vim.cmd("terminal " .. string.format("cd %s && tig blame +%d %s", path, ln, file))
    -- local termb = require("FTerm"):new({
    --     -- cmd = "bash",
    --     dimensions = {
    --         height = 0.9,
    --         width = 0.9,
    --     },
    -- })
    -- termb:run(string.format("cd %s && tig blame +%d %s", path, ln, file))
end, { bang = true })
