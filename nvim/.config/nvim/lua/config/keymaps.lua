-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local function jump_to_prev_buffer()
  local current_buf = vim.api.nvim_get_current_buf()
  local jumplist, current_pos = unpack(vim.fn.getjumplist())

  for i = current_pos, 1, -1 do
    local entry = jumplist[i]
    if entry and entry.bufnr ~= current_buf and vim.api.nvim_buf_is_valid(entry.bufnr) then
      local steps = (current_pos + 1) - i
      vim.cmd("normal! " .. steps .. "\15") -- \15 is <C-o>
      return
    end
  end

  vim.notify("No previous buffer found in jumplist", vim.log.levels.WARN)
end

-- Map directly to <leader>o
vim.keymap.set("n", "<leader>o", jump_to_prev_buffer, { desc = "Jump to prev buffer in jumplist" })

-- lua/config/keymaps.lua

-- 1. Remove default Alt + j / k bindings across modes
local modes = { "n", "i", "v" }
for _, mode in ipairs(modes) do
  pcall(vim.keymap.del, mode, "<M-j>")
  pcall(vim.keymap.del, mode, "<M-k>")
end

-- 2. Move lines with Alt + Shift + j / k using native Vim commands
-- Normal mode
vim.keymap.set("n", "<M-S-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<M-S-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })

-- Insert mode
vim.keymap.set("i", "<M-S-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<M-S-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

-- Visual mode
vim.keymap.set("v", "<M-S-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<M-S-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
