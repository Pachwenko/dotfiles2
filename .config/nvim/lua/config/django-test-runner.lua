local ts_utils = require('nvim-treesitter.ts_utils')

function run_command_in_terminal(command)
  local output = vim.fn.system(command)
  print(output)
end

function print_class_and_function_info()
  local node = ts_utils.get_node_at_cursor()
  
  if not node then
    print("No node found")
    return
  end

  -- Initialize variables for class and function names
  local function_name = "No function found"
  local class_name = "No class found"

  -- Traverse up the tree to find class and function nodes
  while node do
    local node_type = node:type()

    -- Check for function-like nodes
    if node_type == 'function_declaration' or node_type == 'method_declaration' or node_type == 'function_definition' then
      for i = 0, node:child_count() - 1 do
        local child = node:child(i)
        if child:type() == 'identifier' or child:type() == 'name' then
          function_name = ts_utils.get_node_text(child)[1]
          break
        end
      end
    end

    -- Check for class-like nodes
    if node_type == 'class_declaration' or node_type == 'class_definition' then
      for i = 0, node:child_count() - 1 do
        local child = node:child(i)
        if child:type() == 'identifier' or child:type() == 'name' then
          class_name = ts_utils.get_node_text(child)[1]
          break
        end
      end
    end
    
    -- Move up the tree
    node = node:parent()
  end

  -- Get the file path
  -- Get the current file path
  local full_path = vim.fn.expand("%:p")

  -- Get the current working directory
  local cwd = vim.fn.getcwd()

  -- Get the file path relative to the current working directory
  local relative_path = full_path:sub(#cwd + 2)

  -- Print the information
  -- print("Class: " .. class_name)
  -- print("Function: " .. function_name)
  -- print("File Path: " .. relative_path)
  local command_to_run = ""
  if string.match(relative_path, 'lambda') then
    command_to_run = "docker compose run test -k " .. function_name
  else
    local python_path = string.gsub(relative_path, "/", ".")
    python_path = string.match(python_path, "^(.*)%..*$")
    command_to_run = "docker compose run test " ..  python_path .. ":" .. class_name .. "." .. function_name
  end
  print("Command to run: " .. command_to_run)
  run_command_in_terminal(command_to_run)
end

-- Keymap to trigger the function
vim.api.nvim_set_keymap('n', '<leader>dm', ':lua print(print_class_and_function_info())<CR>', { noremap = true, silent = true })

