return {
    'akinsho/bufferline.nvim',
    version = "*",
    lazy=false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('bufferline').setup{}
        -- keybinds
        vim.keymap.set("n", "<leader>n", vim.cmd.bn) -- switch to next buffer (opened file)
        vim.keymap.set("n", "<leader>p", vim.cmd.bp) -- switch to prev buffer (opened file)
        vim.keymap.set("n", "<leader>x", vim.cmd.bd) -- switch to delete buffer (opened file)
    end
}

