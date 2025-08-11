vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', {noremap=true})

-- vim.api.nvim_set_keymap('n', '<leader><leader>',':w<CR>', {noremap=true})
-- vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', {noremap=true})

vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', {noremap=true}) --mapping backspace to delete the whole word

vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", {noremap=true})
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", {noremap=true})
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", {noremap=true})
vim.keymap.set("n", "<leader>bD", ":bdelete!<CR>", {noremap=true, desc = "Force delete buffer"})
vim.keymap.set("n", "<leader><tab>", ":tabnew<CR>", {noremap=true})
-- map leader shift tab to tab close
vim.keymap.set("n", "<leader><S-Tab>", ":tabclose<CR>", {noremap=true})


vim.keymap.set("n", "<CR>", "o<esc>", {noremap=true})
vim.keymap.set("n", "<C-CR>", "O<esc>", {noremap=true})
vim.keymap.set("n", "<C-l>", ":ToggleCheckbox<CR>", {noremap=true})

vim.keymap.set("n", "<leader>D", "d}")
vim.keymap.set("n", "<leader>A", "}kA")

vim.keymap.set("n", "<leader>n", ":tabnext<CR>")
vim.keymap.set("n", "<leader>p", ":tabprevious<CR>")


vim.keymap.set("x", "<leader>d", "ygvop", {desc = "Yank and insert opposite"})
vim.keymap.set("n", "<leader>w", ":w<CR>", {desc = "Write"})
vim.keymap.set("n", "<leader>W", ":wa<CR>", {desc = "Write All"})
vim.keymap.set("n", "<leader>q", ":q<CR>", {desc = "Quit buffer"})
vim.keymap.set("n", "<leader>Q", ":q!<CR>", {desc = "Force quit buffer"})

vim.keymap.set("n", "<leader>.", "<C-W>10>", {desc = "Move split right"})
vim.keymap.set("n", "<leader>,", "<C-W>10<", {desc = "Move split left"})

vim.keymap.set("n", "<leader>aa", function()
    local buffers = vim.fn.getbufinfo({buflisted = 1})
    local file_paths = {}
    for _, buf in ipairs(buffers) do
        if buf.name and buf.name ~= "" then
            -- Convert to absolute path
            local absolute_path = '"' .. vim.fn.fnamemodify(buf.name, ":p") .. '"'
            table.insert(file_paths, absolute_path)
        end
    end
    local files = table.concat(file_paths, " ")
    vim.cmd(string.format("!alacritty -e aider -- %s &", files))

end, {desc = "Open buffers in Aider"})

vim.keymap.set("n", "<leader>cc", function()
    local current_file = vim.fn.expand('%:p')
    if not current_file or current_file == "" then
        print("No file currently open")
        return
    end
    vim.cmd(string.format('!alacritty -e claude --dangerously-skip-permissions "%s" &', current_file))
end, {desc = "Open current file in Claude Code"})

vim.keymap.set("v", "<leader>cc", function()
    local current_file = vim.fn.expand('%:p')
    if not current_file or current_file == "" then
        print("No file currently open")
        return
    end
    
    -- Exit visual mode to get proper selection marks
    vim.cmd('normal! \\<esc>')
    
    -- Get visual selection bounds  
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local start_col = vim.fn.col("'<")
    local end_col = vim.fn.col("'>")
    
    local lines = vim.fn.getline(start_line, end_line)
    
    -- Handle partial line selections
    if #lines == 1 then
        lines[1] = string.sub(lines[1], start_col, end_col)
    elseif #lines > 1 then
        lines[1] = string.sub(lines[1], start_col)
        lines[#lines] = string.sub(lines[#lines], 1, end_col)
    end
    
    -- Format with line numbers
    local formatted_lines = {}
    for i, line in ipairs(lines) do
        table.insert(formatted_lines, string.format("%d\t%s", start_line + i - 1, line))
    end
    local selection_text = table.concat(formatted_lines, "\n")
    
    -- Create a temp file with the selection info
    local temp_file = "/tmp/claude_selection_" .. os.time() .. ".md"
    local file = io.open(temp_file, "w")
    if file then
        file:write("# Selected Code\n\n")
        file:write("From: `" .. vim.fn.expand('%:t') .. "` (lines " .. start_line .. "-" .. end_line .. ")\n\n")
        file:write("```" .. vim.bo.filetype .. "\n")
        file:write(selection_text)
        file:write("\n```\n")
        file:close()
        
        -- Open Claude with both files - selection context first, then main file
        vim.cmd(string.format('!alacritty -e bash -c "claude --dangerously-skip-permissions \'%s\' \'%s\'" &', 
            temp_file, current_file))
    else
        print("Failed to create temp file")
    end
end, {desc = "Open selection in Claude Code"})
