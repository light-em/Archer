return 
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
        local configs = require("nvim-treesitter.configs")
        configs.setup ({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "css", "python", "java", "cpp", "rust" },
            highlight = { enable = true },
            indent = { enable = true },
            sync_install = false,
            auto_install = true,
            additional_vim_regex_highlighting = false,
        })
    end
}
