-- Add 42-header.nvim to Neovim's runtime path
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/42header.nvim")

-- Configuration
require("42header").setup({
    user = os.getenv("USER") or "student",
    mail = os.getenv("MAIL") or "student@student.42.fr",
    default_map = false,
    auto_update = true,
})

-- F1 shortcut
vim.keymap.set("n", "<F1>", "<cmd>Stdheader<CR>", {
    desc = "Insert 42 header",
})
