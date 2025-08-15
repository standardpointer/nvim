-- Functional wrapper for mapping custom keybindings
local map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map(
    "n",
    ";f",
    "<cmd>lua require('telescope.builtin').find_files({prompt_title = '~R0B07 S34RCH~', shorten_path = false, find_commands='rg'})<CR>"
    ,
    { silent = true }
)
map(
    "n",
    ";r",
    "<cmd>lua require('telescope.builtin').live_grep({ prompt_title = '~R0B07 S34RCH~', find_commands='rg'})<CR>",
    { silent = true }
)
map("n", ";;", "<cmd>lua require('telescope.builtin').help_tags()<CR>", { silent = true })
map("n", ";b", "<cmd>lua require('telescope.builtin').buffers()<CR>", { silent = true })
map("n", ";o", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", { silent = true })
local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        multi_icon = "<>",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        scroll_strategy = "cycle",
        color_devicons = true,

        mappings = {
            n = {
                ["Esc"] = actions.close,
            },
        },

        layout_config = {
            --       width = 0.95,
            --      height = 0.85,
            prompt_position = "top",
        },

    },
})
