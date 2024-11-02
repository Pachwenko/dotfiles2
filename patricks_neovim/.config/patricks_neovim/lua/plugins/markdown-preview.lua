-- install markdown-preview.nvim without yarn or npm
-- :Lazy build markdown-preview.nvim
return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
  build = "cd app && yarn install",
	-- build = function()
	-- 	vim.fn["mkdp#util#install"]()
	-- end,
}
