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
