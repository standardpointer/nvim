local vim = vim
-- Mappings
-- Functional wrapper for mapping custom keybindings
vim.g.mapleader = " "
local bufnr = vim.api.nvim_get_current_buf()
local bufname = vim.api.nvim_buf_get_name(bufnr)

local name = vim.loop.os_uname().sysname

local map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    callback = function()
        if name == "Windows_NT" then
            map("n", "<C-g>", ":!gcc -Wall -std=gnu2x % -o %:r.exe<CR>")
            map("n", "<C-f>", ":!./%:r.exe<CR>")
        else
            map("n", "<C-g>", ":!gcc -Wall -std=gnu2x % -o %:r.exe<CR>")
            map("n", "<C-f>", ":!./%:r.exe<CR>")
        end
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        if name == "Windows_NT" then
            map("n", "<C-g>", ":!g++ -Wall % -o %:r.exe<CR>")
            map("n", "<C-f>", ":!./%:r.exe<CR>")
        else
            map("n", "<C-g>", ":!g++ -Wall -std=c++2a % -o %:r.exe<CR>")
            map("n", "<C-f>", ":!./%:r.exe<CR>")
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        map("n", "<C-m>", "<Plug>MarkdownPreview", { noremap = true, silent = true })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescriptreact", "javascript", "html", "css", "javascriptreact", "astro" },
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
    end,
})

if name == "Darwin" then
    map("n", "<C-p>", ":!python3 %<CR>")
elseif vim.fn.has("win32") then
    map("n", "<C-p>", ":!python %<CR>")
end

map("n", "<S-t>", "::tabnew<CR>")
map("n", "<leader>m", ":lua vim.diagnostic.open_float()<CR>")
map("n", "<S-?>", ":!node %<CR>")
map("n", "<A-q>", ":q<kEnter>")
map("n", "<Tab>", ">>", { noremap = true })
map("n", "<S-Tab>", "<<", { noremap = true, silent = true })
map("v", "<Tab>", ">gv", { noremap = true })
map("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
map("n", "<C-S-\\>", ":split<CR>")
map("n", "<shift>", ":echo hello")
map("n", "<C-\\>", ":vsplit<CR>")
map("n", "<C-n>", ':vsplit | enew | echo "Save the file with :w filename"<CR>', { noremap = true, silent = false })
map("n", "<S-Right>", "<C-w>l <CR>")
map("n", "<C-b>", ":NvimTreeToggle<kEnter>")
map("n", "<S-Left>", "<C-w>h <CR>")
map("n", "<C-0>", "<cmd>TroubleToggle<CR>", { noremap = true })
map("n", "gp", "`[v`]")
if name == "Windows_NT" then
    map("v", "<C-_>", ':call nerdcommenter#Comment(0, "toggle")<CR>', { noremap = true, silent = true })
    map("n", "<C-_>", ':call nerdcommenter#Comment(0, "toggle")<CR>', { noremap = true, silent = true })
else
    map("v", "<C-/>", ':call nerdcommenter#Comment(0, "toggle")<CR>', { noremap = true, silent = true })
    map("n", "<C-/>", ':call nerdcommenter#Comment(0, "toggle")<CR>', { noremap = true, silent = true })
end
