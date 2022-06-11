--              __________________ 
--          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
--         /  \  \  \         __/  /  \  /  \          Description : Lua based neovim configurations. This neovim configuration
--        /    \  \       _____   /    \/    \                       is divided into other files, as shown below.
--       /  /\  \  \     /    /  /            \                      The division consists of plugins, options &
--      /        \  \        /  /      \/      \                     variables, and keymaps in different files.
--     /          \  \      /  /                \
--    /            \  \    /  /                  \     Github Repo : https://github.com/aniketgm/dotfiles
--   /              \  \  /  /                    \
--  /__            __\  \/  /__                  __\
--

require('plugins')      -- # Plugin Management.
require('myfuncs')      -- # Lua functions to ease life
require('configs')      -- # Vim/Neovim Options, Variables, etc..
require('keymaps')      -- # Custom Keymaps
