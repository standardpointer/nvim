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
    "catppuccin/nvim",
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            local screen = require("screen")
            return screen
        end,
    },

    "justinhj/battery.nvim",
    "neovim/nvim-lspconfig",
    "lvimuser/lsp-inlayhints.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "anuvyklack/pretty-fold.nvim",
    "anuvyklack/fold-preview.nvim",
    "anuvyklack/keymap-amend.nvim",
    "danielo515/nvim-treesitter-reason",
    "preservim/nerdcommenter",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    "nvim-treesitter/playground",
    "windwp/nvim-ts-autotag",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-lualine/lualine.nvim",
    "kyazdani42/nvim-web-devicons",
    "L3MON4D3/LuaSnip",
    "Vimjas/vim-python-pep8-indent",
    "saadparwaiz1/cmp_luasnip",
    "windwp/nvim-autopairs",
    "nvimdev/lspsaga.nvim",
    "tpope/vim-surround",
    "onsails/lspkind.nvim",
    "MunifTanjim/prettier.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "nvim-tree/nvim-tree.lua",
    "ziglang/zig.vim",
    "OXY2DEV/markview.nvim",
    -- {
    --     "iamcco/markdown-preview.nvim",
    --     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    --     build = "pnpm install",
    --     ft = { "markdown" },
    --     init = function()
    --         vim.g.mkdp_filetypes = { "markdown" }
    --     end,
    --     config = function()
    --         require("markdown-preview")
    --     end,
    -- },
})
