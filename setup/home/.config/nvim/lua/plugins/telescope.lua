return  {
    {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.8',
        dependencies = { 
            'nvim-lua/plenary.nvim',
            "debugloop/telescope-undo.nvim",
            'nvim-telescope/telescope-ui-select.nvim'
        },

        -- This is your opts table
        config = function() 
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = { require("telescope.themes").get_dropdown{} }
                },
                defaults = { mappings = { n = { 
                    ["dd"] = require('telescope.actions').delete_buffer }}
                },
                pickers = { find_files = { hidden = true }}
            }
            require('telescope').load_extension('undo')
            require("telescope").load_extension("ui-select")

            -- keybindings
            local builtin = require('telescope.builtin')
            vim.keymap.set("n", "<leader>fs", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.git_files, {}) 
            vim.keymap.set("n", "<leader>fz", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
            vim.keymap.set('n', '<leader>fp', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ")});
            end)
            vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>");
        end
    }
}
