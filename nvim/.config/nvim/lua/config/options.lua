-- Options globales d'indentation par défaut
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.clipboard = "unnamedplus"
-- Indentation globale pour TOUS les langages
vim.opt.tabstop = 4 -- Largeur visuelle d'une tabulation (4 espaces)
vim.opt.shiftwidth = 4 -- Largeur des blocs lors de l'indentation (>> ou <<)
vim.opt.softtabstop = 4 -- Nombre d'espaces insérés lors d'un appui sur Tab
vim.opt.expandtab = true -- Convertit systématiquement les tabulations en espaces
-- Autocmd spécifique pour forcer la norme 42 sur les fichiers C
-- Désactive le formatage automatique à la sauvegarde pour le C/C++
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h" },
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h" },
  callback = function()
    vim.schedule(function()
      vim.bo.tabstop = 4
      vim.bo.shiftwidth = 4
      vim.bo.softtabstop = 4
      vim.bo.expandtab = false
    end)
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})
