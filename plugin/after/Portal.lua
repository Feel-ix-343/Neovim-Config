require("portal").setup({
    ---@type "debug" | "info" | "warn" | "error"
    log_level = "warn",

    ---The default queries used when searching the jumplist. An entry can
    ---be a name of a registered query item, an anonymous predicate, or
    ---a well-formed query item. See Queries section for more information.
    ---@type Portal.QueryLike[]
    query = { "modified", "different", "valid", "harpoon" },

    ---An ordered list of keys that will be used for labelling available jumps.
    ---Labels will be applied in same order as `query`.
    ---@type string[]
    labels = { "j", "k", "h", "l" },

    ---Keys used for exiting portal selection. To disable a key, set its value
    ---to `nil` or `false`.
    ---@type table<string, boolean | nil>
    escape = {
        ["<esc>"] = true,
    },

    ---The jumplist is fixed at 100 items, which has the possibility to impact
    ---portal performance. Set this to a value less than 100 to limit the number
    ---of jumps in the jumplist that will be queried.
    lookback = 100,

    portal = {
        title = {
            --- When a portal is empty, render an default portal title
            render_empty = true,

            --- The raw window options used for the portal title window
            options = {
                relative = "cursor",
                width = 80,
                height = 1,
                col = 2,
                style = "minimal",
                focusable = false,
                border = "single",
                noautocmd = true,
                zindex = 98,
            },
        },

        body = {
            -- When a portal is empty, render an empty buffer body
            render_empty = false,

            --- The raw window options used for the portal body window
            options = {
                relative = "cursor",
                width = 80,
                height = 3,
                col = 2,
                focusable = false,
                border = "single",
                noautocmd = true,
                zindex = 99,
            },
        },
    },
})

vim.keymap.set("n", "<leader>o", require("portal").jump_backward, {})
vim.keymap.set("n", "<leader>i", require("portal").jump_forward, {})
