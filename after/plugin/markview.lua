local status, markview = pcall(require, "markview")
if not status then
    return
end

local config = {
    experimental = {
        check_rtp_message = false,
    },
    markdown_inline = {
        entities = {
            enable = true,
        },
    },
    preview = {
        filetypes = { "markdown", "tex", "latex", "html" },
    },
    latex = {
        enable = true,
        subscripts = {
            enable = true,
            hl = "MarkviewLatexSubscript",
        },
        superscripts = {
            enable = true,
            hl = "MarkviewLatexSuperscript",
        },
    },
    html = {
        enable = true,

        tags = {
            enable = true,

            default = {
                conceal = false,
            },

            configs = {
                b = { conceal = true, hl = "Bold" },
                strong = { conceal = true, hl = "Bold" },

                u = { conceal = true, hl = "Underlined" },

                i = { conceal = true, hl = "Italic" },
                emphasize = { conceal = true, hl = "Italic" },

                marked = { conceal = true, hl = "Special" },
            },
        },
    },
}

markview.setup(config)
