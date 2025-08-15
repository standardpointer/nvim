local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
    "EdenEast/nightfox.nvim",
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            local screen = require("screen")
            dashboard.section.header.val = screen
            dashboard.section.header.opts.position = "center"
            alpha.setup(dashboard.config)
        end,
    },
    "epwalsh/obsidian.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "saadparwaiz1/cmp_luasnip",
    "anuvyklack/pretty-fold.nvim",
    "anuvyklack/fold-preview.nvim",
    "anuvyklack/keymap-amend.nvim",
    "preservim/nerdcommenter",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    "windwp/nvim-ts-autotag",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-lualine/lualine.nvim",
    "L3MON4D3/LuaSnip",
    "Vimjas/vim-python-pep8-indent",
    "windwp/nvim-autopairs",
    "nvimdev/lspsaga.nvim",
    "onsails/lspkind.nvim",
    "standardpointer/prettier.nvim",
    "standardpointer/none-ls.nvim",
    "lukas-reineke/indent-blankline.nvim",
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    "ziglang/zig.vim",
    "OXY2DEV/markview.nvim",
})
