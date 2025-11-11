return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
        require('neo-tree').setup({ filesystem = { filtered_items = {
            visible = true,  -- This will show hidden files
            hide_dotfiles = false, -- Hide dotfiles (can be set to true to hide)
            hide_gitignored = true -- Hide gitignored files
        }}}) 
        -- keybinds
        vim.keymap.set("n", "<leader>b", ":Neotree toggle<cr>")
        vim.keymap.set("n", "<leader>e", ":Neotree focus<cr>")
        
    end
}
