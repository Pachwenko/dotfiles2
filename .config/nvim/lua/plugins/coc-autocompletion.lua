-- The autocompletion engine. Uses the VSCode LSP
-- https://github.com/neoclide/coc.nvim
--
-- See config file "autocomplete.lua"
--
-- Must install extensions you want with :CocInstall
-- Example: :CocInstall coc-json
-- See config file with :CocConfig
--
-- Python ones: https://github.com/neoclide/coc.nvim/wiki/Language-servers#python
-- 
-- suggest installing these: 
-- :CocInstall coc-pyright coc-tsserver coc-html coc-css coc-sh coc-sumneko-lua
--
-- TODO:
--   install these:
--   npm install -g dockerfile-language-server-nodejs
--   npm install -g @microsoft/compose-language-service
--


return {
  "neoclide/coc.nvim",
  branch = "release",
  build = "npm install"
}
