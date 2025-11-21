-- space bar leader key
vim.g.mapleader = " "

-- save, quit
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>c", vim.cmd.q)
vim.keymap.set("n", "<leader>l", vim.cmd.Lazy)
vim.keymap.set('t', '<C-c>', '<C-[>')

-- Poject Cmd
vim.keymap.set('n', '<leader>r1', "<cmd>:!kitty --title run-nvim -e $PWD/.nvim/run1.sh & disown<cr>")
vim.keymap.set('n', '<leader>r2', "<cmd>:!kitty --title run-nvim -e $PWD/.nvim/run2.sh & disown<cr>")
vim.keymap.set('n', '<leader>r3', "<cmd>:!kitty --title run-nvim -e $PWD/.nvim/run3.sh & disown<cr>")
