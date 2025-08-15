local status, web_devicons = pcall(require, "nvim-web-devicons")

if not status then
    return
end
web_devicons.setup({
    -- your personnal icons can go here (to override)
    -- DevIcon will be appended to `name`
    override = {},
    color_icons = true,
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true,
})
