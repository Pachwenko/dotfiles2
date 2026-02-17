return {
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
			black = {
				prepend_args = { "--fast", "--line-length=120" },
			},
			isort = {
				prepend_args = { "--profile=black" },
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			python = {
				"isort",
				"black",
			},
			terraform = { "terraform_fmt" },
			tf = { "terraform_fmt" },
			["terraform-vars"] = { "terraform_fmt" },
		},
	},
}
