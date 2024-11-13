-- https://github.com/stevearc/conform.nvim
return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fm",
			function()
				require("conform").format()
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = false,
		formatters = {
			-- yapf = {
			-- 	prepend_args = {
			-- 		"--style",
			-- 		"{based_on_style: facebook, COLUMN_LIMIT: 120, BLANK_LINE_BEFORE_NESTED_CLASS_OR_DEF: true, ALLOW_SPLIT_BEFORE_DICT_VALUE: false}",
			-- 	},
			-- },
			black = {
				prepend_args = { "--fast", "--line-length=120" },
			},
			isort = {
				prepend_args = { "--profile=black" },
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform can also run multiple formatters sequentially
			python = {
				"isort",
				"black",
				-- "yapf",
			},
			--
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
		},
	},
}
