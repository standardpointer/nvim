local status, markview = pcall(require, "markview")
if not status then
    return
end

local config = {
    filetypes = { "markdown", "tex", "latex", "html" },
    latex = {
        enable = true,
        subscript = {
            enable = true,
            hl = "MarkviewLatexSubscript",
        },
        superscript = {
            enable = true,
            hl = "MarkviewLatexSuperscript",
        },
    },
    html = {
        enable = true,

        tags = {
            enable = true,

            default = {
                conceal = false
            },

            configs = {
                b = { conceal = true, hl = "Bold" },
                strong = { conceal = true, hl = "Bold" },

                u = { conceal = true, hl = "Underlined" },

                i = { conceal = true, hl = "Italic" },
                emphasize = { conceal = true, hl = "Italic" },

                marked = { conceal = true, hl = "Special" },
            }
        },

        entities = {
            enable = true
        }
    }
}

markview.setup(config)
