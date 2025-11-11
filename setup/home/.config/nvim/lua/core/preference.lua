-- Disabling netrw [ Must be done in beginning ]
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true -- 24 bit colour enable (16.7M)

-- Tab spacing preferences
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Setting Up Theme
function ColorSchemeSet(color_scheme)
    color_scheme = color_scheme or 'wildcharm'
    vim.cmd.colorscheme(color_scheme) -- setting up color scheme
    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' }) -- Transparency
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' }) -- Transparency
end
ColorSchemeSet()

-- Indexing
vim.opt.nu = true --enable line numbers
vim.opt.relativenumber = true -- relative line numbers

-- Diagnostics
vim.diagnostic.config ({
     virtual_text = true,
     signs = true,
     underline = true
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "ron",
    callback = function()
        vim.bo.commentstring = "// %s"
    end,
})

