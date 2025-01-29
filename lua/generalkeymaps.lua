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
