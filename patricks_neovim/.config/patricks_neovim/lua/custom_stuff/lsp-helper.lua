-- A tool to find all the hidden configuration options for your LSP
-- This is useful because the official documentation for most LSP is typically incomplete and hidden behind the implementation.
--
-- Show info for lsp            :InspectLspClient
-- Show info for by lsp name    :InspectLspClient ruff


local render_lsp_info = function (client_name)
  -- Create a temporary buffer to show the configuration
  local client = vim.lsp.get_clients { name = client_name }
  if #client == 0 then
    vim.notify('No active LSP clients found with this name: ' .. client_name, vim.log.levels.WARN)
    return
  end
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = math.floor(vim.o.columns * 0.75),
    height = math.floor(vim.o.lines * 0.90),
    col = math.floor(vim.o.columns * 0.125),
    row = math.floor(vim.o.lines * 0.05),
    style = 'minimal',
    border = 'rounded',
    title = ' ' .. (client_name:gsub('^%l', string.upper)) .. ': LSP Configuration ',
    title_pos = 'center',
  })

  local lines = {}
  for i, this_client in ipairs(client) do
    if i > 1 then
      table.insert(lines, string.rep('-', 80))
    end
    table.insert(lines, 'Client: ' .. this_client.name)
    table.insert(lines, 'ID: ' .. this_client.id)
    table.insert(lines, '')
    table.insert(lines, 'Configuration:')

    local config_lines = vim.split(vim.inspect(this_client.config), '\n')
    vim.list_extend(lines, config_lines)
  end

  -- Set the lines in the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Set buffer options
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = 'lua'
  vim.bo[buf].bh = 'delete'
end

---Options passed to command
---@param opts { fargs: string[]; bang: boolean }
local function inspect_lsp_client(opts)
  if opts.bang then
    -- Select lsps attached in current buffer in fzf
    select_client_fzf()
  elseif opts.fargs[1] ~= nil then
    -- Argument passed to command
    render_lsp_info(opts.fargs[1])
  else
    vim.ui.input({ prompt = 'Enter LSP Client name: ' }, render_lsp_info)
  end
end

local select_client_fzf = function ()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local client_names = {}
  for _, client in ipairs(clients) do
    table.insert(client_names, client.name)
  end

  if #client_names == 0 then
    return
  elseif #client_names == 1 then
    -- single client open settings directly
    render_lsp_info(client_names[1])
    return
  end

  local sink = function (selected)
    if #selected < 2 then
      return
    end
    render_lsp_info(selected[2])
  end

  local wrapped_opts = vim.fn['fzf#wrap']({ source = client_names, options = { '--prompt', 'Buffer Clients> ' } })
  wrapped_opts['sink*'] = sink
  vim.fn['fzf#run'](wrapped_opts)
end



-- local function inspect_lsp_client()
--   vim.ui.input({ prompt = 'Enter LSP Client name: ' }, function(client_name)
--     if client_name then
--       local client = vim.lsp.get_clients { name = client_name }
--
--       if #client == 0 then
--         vim.notify('No active LSP clients found with this name: ' .. client_name, vim.log.levels.WARN)
--         return
--       end
--
--       -- Create a temporary buffer to show the configuration
--       local buf = vim.api.nvim_create_buf(false, true)
--       local win = vim.api.nvim_open_win(buf, true, {
--         relative = 'editor',
--         width = math.floor(vim.o.columns * 0.75),
--         height = math.floor(vim.o.lines * 0.90),
--         col = math.floor(vim.o.columns * 0.125),
--         row = math.floor(vim.o.lines * 0.05),
--         style = 'minimal',
--         border = 'rounded',
--         title = ' ' .. (client_name:gsub('^%l', string.upper)) .. ': LSP Configuration ',
--         title_pos = 'center',
--       })
--
--       local lines = {}
--       for i, this_client in ipairs(client) do
--         if i > 1 then
--           table.insert(lines, string.rep('-', 80))
--         end
--         table.insert(lines, 'Client: ' .. this_client.name)
--         table.insert(lines, 'ID: ' .. this_client.id)
--         table.insert(lines, '')
--         table.insert(lines, 'Configuration:')
--
--         local config_lines = vim.split(vim.inspect(this_client.config), '\n')
--         vim.list_extend(lines, config_lines)
--       end
--
--       -- Set the lines in the buffer
--       vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
--
--       -- Set buffer options
--       vim.bo[buf].modifiable = false
--       vim.bo[buf].filetype = 'lua'
--       vim.bo[buf].bh = 'delete'
--
--       -- vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
--     end
--   end)
-- end

---@param client { fargs: string; }
vim.api.nvim_create_user_command('InspectLspClient', inspect_lsp_client, { nargs = '?', bang = true })
