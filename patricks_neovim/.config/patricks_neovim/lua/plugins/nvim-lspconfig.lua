return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", version = "^1.0.0", config = true },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", function() Snacks.picker.lsp_definitions() end, "[G]oto [D]efinition")
				map("gr", function() Snacks.picker.lsp_references() end, "[G]oto [R]eferences")
				map("gI", function() Snacks.picker.lsp_implementations() end, "[G]oto [I]mplementation")
				map("<leader>D", function() Snacks.picker.lsp_type_definitions() end, "Type [D]efinition")
				map("<leader>ds", function() Snacks.picker.lsp_symbols() end, "[D]ocument [S]ymbols")
				map("<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local servers = {
			ts_ls = {},
			eslint = {},
			tailwindcss = {
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"handlebars",
				},
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							},
						},
					},
				},
			},
			pylsp = {
				capabilities = capabilities,
				filetypes = { "python" },
				configurationSources = { "pycodestyle", "flake8", "jedi_completion" },
				settings = {
					pylsp = {
						plugins = {
							black = {
								enabled = true,
								line_length = 120,
							},
							autopep8 = { enabled = false },
							jedi_hover = { enabled = true },
							jedi_references = { enabled = true },
							jedi_signature_help = { enabled = true },
							jedi_symbols = { enabled = true },
							mccabe = { enabled = false },
							preload = { enabled = true },
							pydocstyle = { enabled = false },
							pylint = { enabled = false },
							rope_autoimport = { enabled = false },
							rope_completion = { enabled = false },
							yapf = { enabled = false },
							pyflakes = { enabled = false },
							jedi_completion = {
								enabled = true,
								include_params = true,
								eager = true,
							},
							pycodestyle = {
								maxLineLength = 120,
								ignore = { "E251", "E202" },
								enabled = true,
							},
							flake8 = {
								maxLineLength = 120,
								enabled = true,
								ignore = { "E251", "E202" },
								hangClosing = false,
							},
						},
					},
				},
			},
			ember = {},
			biome = {},
			html = {},
			cssls = {},
			terraformls = {},
			yamlls = {},
			dockerls = {},
			docker_compose_language_service = {},
			jsonls = {
				commands = {
					Format = {
						function()
							vim.lsp.buf.format()
						end,
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
		}

		require("mason").setup()

		local ensure_installed = {
			"stylua",
			"html-lsp",
			"css-lsp",
			"terraform-ls",
			"biome",
			"ember-language-server",
			"json-lsp",
			"lua-language-server",
			"yaml-language-server",
			"typescript-language-server",
			"eslint-lsp",
			"tailwindcss-language-server",
			"docker-compose-language-service",
			"dockerfile-language-server",
			"black",
			"isort",
			"python-lsp-server",
		}
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		vim.lsp.config("*", { capabilities = capabilities })

		for server_name, config in pairs(servers) do
			if next(config) then
				vim.lsp.config(server_name, config)
			end
		end

		vim.lsp.enable(vim.tbl_keys(servers))
	end,
}
