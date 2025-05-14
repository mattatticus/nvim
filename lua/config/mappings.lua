vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.command = ""

local function map(mode, key, fn, desc)
    local opts = { noremap = true, silent = true, desc = desc or "" }
    vim.keymap.set(mode, key, fn, opts)
end

local function cmd(s)
    return function() vim.cmd(s) end
end

map("", "<Space>", "<Nop>")
map("n", "<leader>n", "<C-w>w")
map("n", "<leader>a", cmd "bd|bp")
map("n", "<C-.>", cmd "bnext")
map("n", "<C-,>", cmd "bprev")
map("n", "<C-<>", cmd "tabprevious")
map("n", "<C->>", cmd "tabnext")
map("t", "<esc>", "<C-\\><C-n>")
map("t", "<C-[>", "<C-\\><C-n>")

map("n", "<leader>lD", vim.lsp.buf.declaration, "Lsp declaration")
map("n", "<leader>ld", vim.lsp.buf.definition, "Lsp definition")
map("n", "<leader>lt", vim.lsp.buf.type_definition, "Lsp type definition")
map("n", "<leader>lk", vim.lsp.buf.hover, "Lsp hover")
map("n", "<leader>li", vim.lsp.buf.implementation, "Lsp implementation")
map("n", "<leader>ls", vim.lsp.buf.signature_help, "Lsp signature help")
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Lsp add workspace folder")
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Lsp remove workspace folder")
map("n", "<leader>rn", vim.lsp.buf.rename, "Lsp rename")
map("n", "<leader>ca", vim.lsp.buf.code_action, "Lsp code action")
map("n", "<leader>rf", vim.lsp.buf.references, "Lsp references")

map("n", "<leader>L", function() vim.cmd "Lazy" end, "Open lazy")
