-- INIT CONFIG; WINDOWS
vim.cmd([[
    set number
    set ve+=onemore
    set nocompatible
    filetype off
    set clipboard=unnamed
    set ruler
    set mouse=a
    set hidden
    set completeopt-=preview
    set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
    hi LineNr ctermfg=8
    let g:python3_host_prog = 'E:/msys64/mingw64/bin/python.exe'

    augroup set_colorscheme
        autocmd!
        autocmd Colorscheme * highlight Normal guibg=NONE ctermbg=NONE
        autocmd ColorScheme * highlight EndOfBuffer guibg=NONE ctermbg=NONE
        autocmd ColorScheme * highlight NormalNC guibg=NONE ctermbg=NONE
    augroup end
    luafile ~/.config/nvim/maps.lua
    luafile ~/.config/nvim/plug.lua
    colorscheme nightfox

    augroup set_fold_specs
        autocmd!
        autocmd VimEnter * set foldlevel=99
        autocmd VimEnter * set foldcolumn=0
        autocmd VimEnter * set foldmethod=expr
        autocmd VimEnter * set foldexpr=nvim_treesitter#foldexpr()
    augroup END

    augroup remember_folds
      autocmd!
      autocmd BufWinLeave *.* mkview
      autocmd BufWinEnter *.* silent! loadview
    augroup END

    autocmd BufReadPost,FileReadPost * normal zR
]])