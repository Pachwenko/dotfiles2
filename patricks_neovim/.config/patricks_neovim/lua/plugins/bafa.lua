-- https://github.com/mistweaverco/bafa.nvim
-- alternatively, enable telescope buffers in telescople plugin after disabling this one
-- see repo for usage, this is puleld frm the source code:
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<Cmd>lua require('bafa.ui').toggle()<CR>", { silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<ESC>", "<Cmd>lua require('bafa.ui').toggle()<CR>", { silent = true })
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<CR>", "<Cmd>lua require('bafa.ui').select_menu_item()<CR>", {})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "dd", "<Cmd>lua require('bafa.ui').delete_menu_item()<CR>", {})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "D", "<Cmd>lua require('bafa.ui').delete_menu_item()<CR>", {})
--
return {
  'mistweaverco/bafa.nvim',
  config = function()
    local bafa = require("bafa.init").setup({})
    vim.keymap.set("n", "<leader>bb", ":lua require('bafa.ui').toggle()<CR>", { desc = "[B]afa [B]uffer Menu" })
  end,
  opts = {
    width = 60,
    height = 10,
    title = "Bafa",
    title_pos = "center",
    relative = "editor",
    border = "rounded",
    style = "minimal",
    diagnostics = true,
  }
}
