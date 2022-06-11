-- # -------------------- #
-- # Neovim Configuration #
-- # -------------------- #

-- This file sets all configuration options and variables for Neovim
local gv  = vim.g
local cmd = vim.cmd

-- #-------------
-- # Vim Options
-- #-------------
local myopts = {
  -- background = 'dark',
  -- colorcolumn    = '80',                         -- Show column bar to avoid going beyond 80 chars
  cmdheight      = 1,                            -- Command height from bottom of window
  cursorline     = true,                         -- Highlight current line
  expandtab      = true,                         -- Convert tab to spaces
  foldenable     = false,                        -- Disable auto folding when a file is opened
  foldmethod     = "expr",                       -- Set foldmethod to expr for nvim-treesitter
  foldexpr       = "nvim_treesitter#foldexpr()", -- Set foldexpr to nvim-treesitter foldexpr method
  fillchars = {
    diff         = '⣿',                          -- Show the specified symbol for Diff
    vert         = '¦'                           -- Show the specified symbol for vertical split
  },
  listchars = {
    space        = '·',                          -- Show space with the symbol set
    tab          = '│ '                          -- Show tabs with the symbol set
  },
  list           = true,                         -- Activate listing of char for options that are set 
  mouse          = 'a',                          -- Enable mouse interaction in Neovim
  number         = true,                         -- Enable numbering
  relativenumber = true,                         -- Enable relativenumber option
  shiftwidth     = 4,                            -- When inside a function, shift with the following value
  showmode       = false,                        -- Hide display of mode in command section
  smartindent    = true,                         -- Smartly, autoindent when required
  splitbelow     = true,                         -- Split below during a horizontal split
  splitright     = true,                         -- Split right during a vertical split
  swapfile       = false,                        -- No swapfile. (I hate swapfiles)
  tabstop        = 4,                            -- Tab is 4 spaces
  termguicolors  = true,                         -- Required for Sonokai theme
  wrap           = false                         -- No Wrapping of lines that exceed window
}

-- Actual setting of options happens here. Set each defined options above.
for k,v in pairs(myopts) do
  vim.opt[k] = v
end

-- Make comments italic
gv.python3_host_prog = '/usr/bin/python3'

-- Git Blame enable
gv.blamer_enabled = 1

-- Autocommands
local autocmds = {
  fileconfig = {
    {"FileType", "coffee", "setlocal noexpandtab"};
    {"FileType", "html", "setlocal noexpandtab"};
    {"FileType", "javascript", "setlocal tabstop=2 shiftwidth=2"};
    -- {"FileType", "javascript.jsx", "setlocal commentstring={/*\\ %s\\ */}"};
    {"FileType", "lua", "setlocal tabstop=2 shiftwidth=2"};
    {"FileType", "vimwiki", "setlocal tabstop=2 shiftwidth=2"};
    {"BufWritePost,FileWritePost", "*.coffee", ":silent !coffee --compile %"};
  };
}
local customfuncs = require('myfuncs')
customfuncs.nvim_create_augroups(autocmds)

-- Leader key changed from '\' to ';'
gv.mapleader = ';'

-- Enable Github theme
require('github-theme').setup()

-- #------------------------
-- # Nvim-Treesitter Config
-- #------------------------
require('nvim-treesitter.configs').setup{
  ensure_installed = { "html", "css", "javascript", "python", "lua" },
  sync_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  }
}

-- #-----------------
-- # Nvim-GPS Config
-- #-----------------
require("nvim-gps").setup()
local gps = require("nvim-gps")

-- #-----------------
-- # Set Colorscheme
-- #-----------------
gv.sonokai_style = 'andromeda'
gv.sonokai_enable_italic = 1
-- gv.tokyonight_style = 'storm'
-- gv.gruvbox_material_foreground = 'mix'
-- gv.gruvbox_material_background = 'hard'

cmd('colorscheme sonokai')
-- cmd('colorscheme duskfox')
-- cmd('colorscheme nightfox')
-- cmd('colorscheme tokyonight')
-- cmd('colorscheme tender')
-- cmd('colorscheme gruvbox-material')
-- cmd('colorscheme dracula')
-- cmd('colorscheme github_dimmed')

-- #----------------
-- # Lualine Config
-- #----------------
require('lualine').setup {
  options = {
    -- theme = 'solarized_light',
    -- theme = 'duskfox',
    -- theme = 'nightfox',
    -- theme = 'tokyonight',
    -- theme = 'gruvbox-material',
    theme = 'sonokai',
    -- theme = 'github_dimmed',
    -- theme = 'dracula',
    -- section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' }
    -- component_separators = '|'
  },
  sections = {
    lualine_a = {
      {
        'mode', fmt = function(res) return res:sub(1,1) end,
        -- separator = { left = '' },
      }
    },
    lualine_b = {},
    lualine_c = { 'diagnostics' },
    lualine_x = {},
    lualine_y = { 'fileformat', 'filetype' },
    lualine_z = {
      { 'location' } --separator = { right = '' } },
    }
  },
  tabline = {
    lualine_a = {
      {
        'filename',
        symbols = {
          -- modified = ' ●'
          modified = ' ʍ',
          readonly = ' ʀ'
        }
      },
      { gps.get_location, cond = gps.is_available }
    },
    lualine_z = {
      {
        'diff',
        diff_color = {
          -- added = { fg = "#274003" },
          -- modified = { fg = "#17574c" },
          -- removed = { fg = "#4a211a" },
          added = { fg = "darkgreen" },
          modified = { fg = "darkblue" },
          removed = { fg = "darkred" },
        }
      },
      'branch'
    }
  }
}

-- #----------------
-- # VimWiki Config
-- #----------------
gv.vimwiki_folding = 'expr'
gv.vimwiki_listsyms = ' ρςτ✓'
-- gv.vimwiki_listsyms = ' ρςτX'
gv.vimwiki_list = {{
  path = '~/Documents/VimWikiNotes',
  template_path = '~/Documents/VimWikiNotes/templates/',
  template_default = 'default',
  syntax = 'markdown',
  ext = '.md',
  path_html = '~/Documents/VimWikiNotes/site_html/',
  custom_wiki2html = 'vimwiki_markdown',
  template_ext = '.tpl'
}}

-- #------------
-- # FZF Config
-- #------------
gv.fzf_layout = { ['window'] = { ['width'] = 0.9, ['height'] = 0.8 } }
-- gv.fzf_layout = { ['down'] = '~40%' }
gv.fzf_preview_window = ''
gv.fzf_history_dir = '/home/aniketgm/.config/nvim/fzf_history'

-- #-----------------
-- # Gitsigns Config
-- #-----------------
require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>H', gs.get_hunks)
  end
}

-- #-----------------
-- # NvimTree Config
-- #-----------------
require('nvim-tree').setup {
  ignore_ft_on_setup = {
    '*.pyc',
  },
}

-- #-----------------
-- # Floaterm Config
-- #-----------------
gv.floaterm_keymap_new = '<F7>'
gv.floaterm_keymap_toggle = '<F9>'
gv.floaterm_keymap_prev = '<F8>'
gv.floaterm_keymap_next = '<F10>'
gv.floaterm_height = 0.8
gv.floaterm_width = 0.9
gv.floaterm_autoclose = 1
gv.floaterm_title = '─[-($1/$2)-Terminal-]─'
gv.floaterm_borderchars = '─│─│╭╮╯╰'

-- #------------------
-- # Telescope Config
-- #------------------
require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
require("telescope").setup {
  defaults = {
    -- prompt_prefix = "🔎 ",
    prompt_prefix = "🔭 ",
    -- selection_caret = "👉 ",
    -- selection_caret = "ᗒ ",
    -- selection_caret = "» ",
    selection_caret = "↪ ",
    layout_config = {
      height = 0.8,
      width = 0.9
    },
    path_display = { truncate = true }
  },
  extensions = {
    file_browser = {
      respect_gitignore = true,
      layout_config = { preview_width = 70 }
    },
    project = {
      base_dirs = {
        '~/codebase/src/setup',
        '~/codebase/src/zuko',
        '~/codebase/src/pypandora'
      }
    }
  },
  pickers = {
    find_files = {
      no_ignore = true,
      hidden = true,
      layout_config = { preview_width = 70 }
    },
    live_grep = {
      previewer = false,
      shorten_path = true
    },
    buffers = {
      sort_lastused = true,
      previewer = false,
      mappings = {
        i = { ["<C-d>"] = "delete_buffer" }
      }
    },
    current_buffer_fuzzy_find = { previewer = false },
    git_files = {
      layout_config = { preview_width = 70 }
    },
    git_commits = {
      layout_strategy = 'vertical',
      layout_config = { preview_cutoff = 20 }
    },
    git_status = {
      shorten_path = true,
      layout_config = { preview_width = 75 },
    },
    marks = {
      layout_strategy = 'vertical',
      layout_config = { preview_cutoff = 20 }
    },
    help_tags = {
      layout_config = { preview_width = 75 }
    },
    jumplist = {
      layout_strategy = 'vertical',
      layout_config = { preview_cutoff = 20 },
      trim_text = true
    },
  }
}
require("telescope").load_extension("file_browser")
require('telescope').load_extension("session-lens")

-- #-------------
-- # CyBu Config
-- #-------------
require("cybu").setup({
  position = {
    max_win_height = 7,
    max_win_width = 0.7
  },
  style = {
    border = "rounded"
  }
})
