-- Ajoute le dossier du plugin au runtime de Neovim
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/42header.nvim")

-- Configuration du plugin
require("42header").setup({
  default_user = os.getenv("USER") or "student",
  default_mail = os.getenv("MAIL") or "student@student.42.fr",
})

-- Raccourci clavier F1
vim.keymap.set("n", "<F1>", "<cmd>Stdheader<CR>", { desc = "Insérer le header 42" })
