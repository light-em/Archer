-- space bar leader key
vim.g.mapleader = " "

-- save, quit
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>c", vim.cmd.q)
vim.keymap.set("n", "<leader>l", vim.cmd.Lazy)
vim.keymap.set('t', '<C-c>', '<C-[>')

-- Poject Cmd
-- vim.keymap.set('n', '<leader><F7>', "<cmd>:!sh $PWD/run.sh<cr>")
