local M = {}

function M.map(lhs, rhs, opts, mode)
	mode = mode or "n"
	local final_opts = { noremap = true, silent = true }
	if type(opts) == "string" then
		final_opts.desc = opts
	elseif type(opts) == "table" then
		final_opts = opts
	end
	vim.keymap.set(mode, lhs, rhs, final_opts)
end

return M
