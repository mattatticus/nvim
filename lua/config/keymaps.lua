local keymap = function(a, b, c)
	vim.api.nvim_set_keymap(a, b, c, { noremap = true, silent = true })
end

keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.command = ""

keymap("n", "<leader>n", "<C-w>w")

keymap("n", "<A-h>", "<Cmd> Telescope find_files<CR>")
keymap("n", "<A-s>", "<Cmd> NvimTreeToggle<CR>")

keymap("n", "<leader>f", "<Cmd> Format<CR>")

keymap("n", "<leader>b", "<Cmd> BufferLinePick<CR>")

keymap("n", "<A-.>", "<Cmd> bnext<CR>")
keymap("n", "<A-,>", "<Cmd> bprev<CR>")

keymap("n", "<A-<>", "<Cmd> tabnext<CR>")
keymap("n", "<A->>", "<Cmd> tabprevious<CR>")

keymap("t", "<esc>", "<C-\\><C-n>")
keymap("t", "<C-[>", "<C-\\><C-n>")
