require("standardpointer.maps")
require("standardpointer.plug")
local os = require("os")
local vim = vim
local group = vim.api.nvim_create_augroup
local highlight = vim.api.nvim_set_hl

local nightfox = require("nightfox")

local name = vim.loop.os_uname().sysname
local home = os.getenv("home")

if name == "Windows_NT" then
    -- INIT CONFIG; WINDOWS
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
    vim.opt.shell = '"C:\\Program Files\\Git\\usr\\bin\\zsh"'

    vim.g.python3_host_prog = home .. "/AppData/Local/Programs/Python/Python311/python"
elseif name == "Darwin" then
    vim.cmd([[let g:python3_host_prog = '/usr/bin/python']])
end
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typescriptreact",
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
    end,
})
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.encoding = "utf-8"
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamed"
vim.opt.cb = "unnamed"
vim.opt.syntax = "on"
vim.opt.mouse = "a"
vim.opt.foldenable = false
vim.opt.termguicolors = true
vim.opt.inccommand = "nosplit"
vim.opt.hidden = true
vim.opt.ruler = true
vim.opt.virtualedit = vim.opt.virtualedit + "onemore"
vim.opt.completeopt = vim.opt.completeopt - "preview"
vim.opt.title = true
vim.wo.number = true
vim.g.nocompatible = 1
vim.opt.backup = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.si = true
vim.opt.ai = true
vim.opt.pumheight = 30
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
highlight(0, "DiagnosticsVirtualTextError", { bg = "#ff0000" })
vim.g.mapleader = " "
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
vim.cmd([[let &t_ut='']])
vim.o.shellcmdflag = "-c"

vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })

vim.opt.modifiable = true
vim.opt.fixendofline = false

vim.api.nvim_set_hl(0, "LineNR", { cterm = {}, ctermfg = "Yellow", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLineNR", { cterm = { bold = true }, ctermfg = "Black", ctermbg = "NONE" })

vim.opt.foldlevel = 99
vim.opt.foldcolumn = "0"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldtext = "v:lua.nvim_treesitter#foldtext()"

vim.opt.fileencoding = "utf-8"
vim.env.LANG = "en_US.UTF-8"

vim.g.SimpylFold_docstring_preview = 1

vim.api.nvim_set_hl(
    0,
    "LspDiagnosticsVirtualTextWarning",
    { fg = "orange", bold = true, italic = true, underline = true }
)
vim.api.nvim_set_hl(
    0,
    "LspDiagnosticsVirtualTextInformation",
    { fg = "yellow", bold = true, italic = true, underline = true }
)
vim.api.nvim_set_hl(0, "LspDiagnosticsVirtualTextHint", { fg = "green", bold = true, italic = true, underline = true })

-- Set the fold method to 'expr' for TreeSitter folding
vim.wo.foldmethod = "expr"

-- Define the fold expression using TreeSitter
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- Optional: Configure the foldtext to display fold levels
vim.wo.foldtext = "v:lua.nvim_treesitter#foldtext()"

vim.cmd([[

    augroup remember_folds
      autocmd!
      autocmd BufWinLeave *.* mkview
      autocmd BufWinEnter *.* silent! loadview
    augroup END
]])

group("nobg", { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    desc = "Make all backgrounds transparent",
    group = "nobg",
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, "Pmenu", { bg = "#252525" })
    end,
})
--

local palettes = {
    nordfox = {
        comment = "#828fa1",
    },
    -- Custom duskfox with black background
}

if vim.fn.expand("%:e") == "re" then
    vim.cmd([[set filetype=reason]])
end
local specs = {
    nordfox = {
        syntax = {
            variable = "#ededd5",
            builtin0 = "#67b2a0",
            -- builtin1 = "#93ccdc",
            builtin1 = "#a4cfdb",
            builtin2 = "#d89079",
            builtin3 = "#d06f79",
            conditional = "#c895bf",
            type = "#ebcb8b",
        },
    },
}

--catp.setup({
--flavour = "mocha",
--color_overrides = {
--all = {
--overlay0 = "#99a4b2",
--},
--},
--})
nightfox.setup({ palettes = palettes, specs = specs })
-- vim.cmd.colorscheme("catppuccin")
vim.cmd.colorscheme("nordfox")
-- vim.cmd.colorscheme("kanagawa-paper")

local original_notify = vim.notify

vim.notify = function(msg, level, opts)
    if
        type(msg) == "string"
        and msg:match('vim%.tbl_islist is deprecated, Run ":checkhealth vim.deprecated" for more information')
    then
        return -- Suppress the warning
    end
    original_notify(msg, level, opts) -- Show other notifications normally
end
