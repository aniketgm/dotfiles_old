-- # ------------------- #
-- # Package Manangement #
-- # ------------------- #

local fn = vim.fn
local execute = vim.api.nvim_command

-- Bootstrap packer if not installed
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty( fn.glob(install_path) ) > 0 then
  fn.system({
    "git", "clone", "https://github.com/wbthomason/packer.nvim",
    install_path
  })
  execute "packadd packer.nvim"
end

require('packer').startup( function()

  -- Package management and Lua Support
  use 'wbthomason/packer.nvim'                      -- Package manager for Neovim written in Lua
  use 'nvim-lua/plenary.nvim'                       -- Lua support for Neovim

  -- LSP and other language support
  use {
    'neoclide/coc.nvim',                            -- Conqueror of Completion
    branch = 'master',                              -- LSP, completion, syntax highlighting, etc..
    run = 'yarn install --frozen-lockfile'
  }
  use 'mattn/emmet-vim'                             -- Emmet support for Vim
  use 'kchmck/vim-coffee-script'                    -- Support for coffee-script
  use 'maxmellon/vim-jsx-pretty'                    -- Support for jsx files

  -- Navigation
  use 'kyazdani42/nvim-tree.lua'                    -- File Explorer for Neovim written in Lua
  use {
    'junegunn/fzf',                                 -- Dependency plugin required for fzf.vim
    run = fn['fzf#install']
  }
  use 'junegunn/fzf.vim'                            -- Fuzzy Searching in Neovim
  use 'nvim-telescope/telescope.nvim'               -- Extensible Fuzzy Finder 
  use {
    'nvim-telescope/telescope-fzf-native.nvim',     -- Support for fzf native search plugin.
    run = 'make'
  }
  use 'nvim-telescope/telescope-file-browser.nvim'  -- File Browsing support in Telescope
  use 'nvim-telescope/telescope-project.nvim'       -- Project management support in Telescope
  -- use 'cljoly/telescope-repo.nvim'                  -- Search repos on the system for Neovim
  use 'airblade/vim-rooter'                         -- Switch repo on file load

  -- Themes and Icons
  -- use 'vim-airline/vim-airline'                  -- Status bar configurations
  -- use 'vim-airline/vim-airline-themes'           -- Themes for Airline
  use 'nvim-lualine/lualine.nvim'                   -- Status line for Neovim written in lua
  use 'EdenEast/nightfox.nvim'                      -- NightFox themes for Neovim
  use 'jacoborus/tender.vim'                        -- Tender theme for Vim
  use {
    'folke/tokyonight.nvim',                        -- Tokyonight theme for Neovim
    branch = 'main'
  }
  use 'sainnhe/gruvbox-material'                    -- Modified version of Gruvbox
  use {
    'dracula/vim',                                  -- Dracula theme for Vim
    as = 'dracula'
  }
  use 'sainnhe/sonokai'                             -- Sonokai theme for Vim
  use "projekt0n/github-nvim-theme"                 -- Github themes for Neovim
  use 'ryanoasis/vim-devicons'                      -- Developer Icons
  use 'kyazdani42/nvim-web-devicons'                -- Fork of vim-devicons for Neovim

  -- Git Support
  use 'kdheepak/lazygit.nvim'                       -- Lazygit for Neovim
  use 'sindrets/diffview.nvim'                      -- Git diff view
  use 'lewis6991/gitsigns.nvim'                     -- Show git changes while working
  use 'samoshkin/vim-mergetool'                     -- Vim as mergetool support
  use 'APZelos/blamer.nvim'                         -- Git Blame

  -- Terminal Support
  use 'voldikss/vim-floaterm'                       -- Floating terminal for Vim

  -- Other ease of life utilities
  use 'tpope/vim-surround'                          -- Surround text with parentheses, brackets, etc.
  use 'tpope/vim-commentary'                        -- For Commenting code
  use 'sbdchd/neoformat'                            -- Neovim plugin to format code
  use {
    'rmagatti/session-lens',                        -- Session switcher in Telescope
    requires = {
      'rmagatti/auto-session',                      -- Extends auto-session.
      'nvim-telescope/telescope.nvim'
    }
  }
  use 'vimwiki/vimwiki'                             -- Note taking for Vim
  use 'ap/vim-css-color'                            -- Display CSS colors in css files
  use 'pmalek/toogle-maximize.vim'                  -- Toggle Maximize of split window
  use 'SirVer/ultisnips'                            -- Snippet for Vim
  use 'mlaursen/vim-react-snippets'                 -- React snippets
  use 'jiangmiao/auto-pairs'                        -- Auto insert brackets, parentheses, quotes, etc.
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
	  "SmiteshP/nvim-gps",                            -- Breadcrumb for functions, variables, etc
	  requires = "nvim-treesitter/nvim-treesitter"
  }
  use {
    "ghillb/cybu.nvim",                             -- Cycle buffer with live preview
    branch = 'main',
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      local ok, cybu = pcall(require, "cybu")
      if not ok then
        return
      end
    end,
  }
  -- use 'tools-life/taskwiki'                         -- Taskwarrior support for Vimwiki

end)

