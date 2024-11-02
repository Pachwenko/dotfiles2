-- Auto loads all plugins in the directory
local function load_lua_files(directory)
	for _, file in ipairs(vim.fn.globpath(directory, "*.lua", 0, 1)) do
		local module_name = file:match(".*/(.*).lua$")
		if module_name and module_name ~= "load_files" then -- Avoid loading self
			require("custom_stuff." .. module_name) -- Correct module path
		end
	end
end

load_lua_files(vim.fn.stdpath("config") .. "/lua/custom_stuff/")

