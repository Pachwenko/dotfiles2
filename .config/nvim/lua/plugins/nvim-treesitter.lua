-- Treesitter provides better syntax highlighting and some autocomplete help
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
}
