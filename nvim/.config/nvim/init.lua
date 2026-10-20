-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.header")
vim.keymap.set("n", "<leader>h", vim.diagnostic.open_float, { desc = "Afficher les diagnostics de la ligne" })
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = false
  end,
})
