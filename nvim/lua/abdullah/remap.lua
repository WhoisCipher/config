-- Set the leader key
vim.g.mapleader = ' '

local function launch_dosbox()
    print("Launching DOSBox...")  -- Debug print

    -- Get the current file path and name
    local file_path = vim.fn.expand("%:p")
    local file_name = vim.fn.expand("%:t")
    
    local dir_path = vim.fn.fnamemodify(file_path, ":h")
    local bat_file_name = "run.bat"
    local bat_file_path = dir_path .. "/" .. bat_file_name

    local bat_content = [[
@echo off
mount c ]] .. dir_path .. [[
c:
nasm ]] .. vim.fn.fnamemodify(file_name, ":t") .. [[ -o ]] .. vim.fn.fnamemodify(file_name, ":r") .. [[.com
afd ]] .. vim.fn.fnamemodify(file_name, ":r") .. [[.com
]]

    -- Write the content to the .bat file
    local file = io.open(bat_file_path, "w")
    if file then
        file:write(bat_content)
        file:close()
        print("Batch file created at " .. bat_file_path)
    else
        print("Error: Could not create .bat file.")
        return
    end

    local tmux_command = "tmux split-window -v 'dosbox \"" .. bat_file_name .. "\"'"
    os.execute(tmux_command)
end
vim.keymap.set('n', '<leader>d', launch_dosbox, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")

vim.keymap.set('v', "<leader>y", "\"+y")
vim.keymap.set('v', "<leader>y", "\"+y")

vim.keymap.set('n', "<C-d>", "<C-d>zz")
vim.keymap.set('n', "<C-u>", "<C-u>zz")

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
