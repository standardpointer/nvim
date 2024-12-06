-- Safe require alpha. No point in continuing if alpha is not present
package.path = "C:/Users/jonah/.config/nvim/after/plugin/?.lua;;" .. package.path
local status, alpha = pcall(require, "alpha")
if not status then
    return
end
local header_status, headers = pcall(require, "headers")
if not header_status then
    return
end

local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position = "center",
        text = txt,
        shortcut = sc,
        cursor = 5,
        width = 36,
        align_shortcut = "right",
        hl = "AlphaButtons",
    }

    if keybind then
        opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
    end

    return {
        type = "button",
        val = txt,
        on_press = function()
            local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
            vim.api.nvim_feedkeys(key, "normal", false)
        end,
        opts = opts,
    }
end

local function footer()
    local date = os.date("  %d/%m/%Y ")
    local time = os.date("  %H:%M:%S ")

    local v = vim.version()
    local version = "  v" .. v.major .. "." .. v.minor .. "." .. v.patch

    return date .. time .. version
end

local options = {
    header = {
        type = "text",
        val = headers["random"],
        opts = {
            position = "center",
            hl = "AlphaHeader",
        },
    },

    buttons = {
        type = "group",
        val = {
            button(":n", "  New File", ":ene <BAR> startinsert <CR>"),
            button(";f", "  Find File", ":Telescope find_files<CR>"),
            button(";", "  Recent File", ":Telescope oldfiles<CR>"),
            button(";r", "  Find Word", ":Telescope live_grep<CR>"),
            button(";b", "  Bookmarks", ":Telescope marks<CR>"),
            button(";q", "  Exit Neovim", ":qa<CR>"),
        },
        opts = { spacing = 1 },
    },

    footer = {
        type = "text",
        val = footer(),
        opts = {
            position = "center",
            hl = "Constant",
        },
    },
}

local padd = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) })

alpha.setup({
    layout = {
        { type = "padding", val = padd },
        options.header,
        { type = "padding", val = 1 },
        options.buttons,
        { type = "padding", val = 1 },
        options.footer,
    },
    opts = {},
})
