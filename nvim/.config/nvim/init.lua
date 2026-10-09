-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.keymap.set("n", "<leader>h", vim.diagnostic.open_float, { desc = "Afficher les diagnostics de la ligne" })
