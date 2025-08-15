local status, npairs = pcall(require, "nvim-autopairs")
if not status then
    return
end

npairs.setup({
    disable_filetype = { "TelescopePrompt", "vim" },
    check_ts = true,
})
