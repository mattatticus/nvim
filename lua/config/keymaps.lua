local keymap = function(a, b, c)
	vim.api.nvim_set_keymap(a, b, c, { noremap = true, silent = true })
end

keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.command = ""

keymap("n", "<leader>n", "<C-w>w")
-- keymap("n", "<leader>mh", "<C-w>h")
-- keymap("n", "<leader>mj", "<C-w>j")
-- keymap("n", "<leader>mk", "<C-w>k")
-- keymap("n", "<leader>ml", "<C-w>l")

keymap("n", "<leader>u", "<Cmd> UndotreeToggle<CR>")
keymap("n", "<leader>h", "<Cmd> Telescope find_files<CR>")
keymap("n", "<leader>s", "<Cmd> NvimTreeToggle<CR>")

keymap("n", "<leader>f", "<Cmd> Format<CR>")

keymap("n", "<leader>a", "<Cmd> BufferlineCycleNext<CR>")
keymap("n", "<leader>m", "<Cmd> BufferlineCyclePrev<CR>")

keymap("t", "<esc>", "<C-\\><C-n>")
