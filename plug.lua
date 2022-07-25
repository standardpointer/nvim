local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')
-- COLORSCHEMES
Plug 'EdenEast/nightfox.nvim'
Plug 'morhetz/gruvbox'
-- WORKFLOW PLUGINS
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'preservim/nerdtree'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'L3MON4D3/LuaSnip'
vim.call('plug#end')
