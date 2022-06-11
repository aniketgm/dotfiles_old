-- #------------------
-- # All Key bindings
-- #------------------
local nvmap = vim.api.nvim_set_keymap

-- Toogle : Toggle window maximization
nvmap('n', '<M-m>', '<cmd>call ToggleMaximizeCurrentWindow()<cr>', { silent = true })

-- Lazygit
nvmap('n', '<leader>lg', '<cmd>LazyGit<cr>', { noremap = true })

-- Diffview
nvmap('n', '<F2>', '<cmd>DiffviewToggleFiles<cr>', {})
nvmap('n', '<leader>do', '<cmd>DiffviewOpen -uno<cr>', { noremap = true, silent = true })
nvmap('n', '<leader>dc', '<cmd>DiffviewClose<cr>', { noremap = true, silent = true })

-- NvimTree
nvmap('n', '<F3>', '<cmd>NvimTreeFindFileToggle<cr>', {})

-- CoC
if vim.fn.has('nvim') == 1 then
  nvmap('i', '<C-Space>', 'coc#refresh()',{ noremap = true, silent = true, expr = true})
else
  nvmap('i', '<C-@>', 'coc#refresh()',{ noremap = true, silent = true, expr = true})
end
nvmap('n', 'gd', '<Plug>(coc-definition)', { silent = true })
nvmap('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
nvmap('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
nvmap('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- Telescope
nvmap('n', '<space>fb',  '<cmd>Telescope file_browser path=%:p:h<cr>', { noremap = true })
nvmap('n', '<leader>b',  '<cmd>Telescope buffers<cr>', { noremap = true })
nvmap('n', '<leader>h',  '<cmd>Telescope help_tags<cr>', { noremap = true })
nvmap('n', '<leader>j',  '<cmd>Telescope jumplist<cr>', { noremap = true })
nvmap('n', '<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { noremap = true })
nvmap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true })
nvmap('n', '<leader>fm', '<cmd>Telescope marks<cr>', { noremap = true })
nvmap('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', { noremap = true })
nvmap('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', { noremap = true })
nvmap('n', '<leader>gf', '<cmd>Telescope git_files<cr>', { noremap = true })
nvmap('n', '<leader>of', '<cmd>Telescope oldfiles<cr>', { noremap = true })
nvmap('n', '<leader>ss', '<cmd>Telescope session-lens search_session<cr>', { noremap = true })
nvmap('n', '<C-p>', '<cmd>lua require"telescope".extensions.project.project{}<cr>', { noremap = true, silent = true })
-- nvmap('n', '<leader>vw', '<cmd>Telescope vimwiki<cr>', { noremap = true })
-- nvmap('n', '<leader>vf', '<cmd>Telescope vimwiki live_grep<cr>', { noremap = true })

-- FZF
-- nvmap('n', '<leader>fb', '<cmd>BLines<cr>', { noremap = true })
-- nvmap('n', '<leader>fd', '<cmd>BLines def<cr>', { noremap = true })
-- nvmap('n', '<leader>fc', '<cmd>BLines class<cr>', { noremap = true })
nvmap('n', '<leader>fl', '<cmd>Lines<cr>', { noremap = true })
-- nvmap('n', '<leader>fm', '<cmd>Marks<cr>', { noremap = true })
nvmap('n', '<leader>fr', '<cmd>Rg<cr>', { noremap = true })

-- Floaterm
local floaterm_opts = { noremap = true, silent = true }
nvmap('n', '<leader>lc', '<cmd>FloatermNew --title=─[-($1/$2)-CeleryLogs-]─ docker logs zinrelodevapp_celery_1 --follow<cr>', floaterm_opts)
nvmap('n', '<leader>ld', '<cmd>FloatermNew --title=─[-($1/$2)-MongoDBLogs-]─ docker logs zinrelodevapp_mongo_1 --follow<cr>', floaterm_opts)
nvmap('n', '<leader>le', '<cmd>FloatermNew --title=─[-($1/$2)-ElasticSrchLogs-]─ docker logs zinrelodevapp_elasticsearch_1 --follow<cr>', floaterm_opts)
nvmap('n', '<leader>lw', '<cmd>FloatermNew --title=─[-($1/$2)-Weblogs-]─ docker logs zinrelodevapp_web_1 --follow<cr>', floaterm_opts)
nvmap('n', '<leader>pw', '<cmd>FloatermNew --title=─[-($1/$2)-ZukoPrompt-]─ docker exec -it zinrelodevapp_web_1 /bin/bash<cr>', floaterm_opts)
nvmap('n', '<leader>pd', '<cmd>FloatermNew --title=─[-($1/$2)-DBPrompt-]─ docker exec -it zinrelodevapp_mongo_1 /bin/bash<cr>', floaterm_opts)

-- CyBu
nvmap('n', 'K', '<Plug>(CybuPrev)', {})
nvmap('n', 'J', '<Plug>(CybuNext)', {})

-- Window movement
nvmap('n', '<M-h>', '<C-w>h', { noremap = true })       -- Move to window left
nvmap('n', '<M-j>', '<C-w>j', { noremap = true })       -- Move to window down
nvmap('n', '<M-k>', '<C-w>k', { noremap = true })       -- Move to window up
nvmap('n', '<M-l>', '<C-w>l', { noremap = true })       -- Move to window right

-- Copy to Clipboard
nvmap('n', '<leader>y', '"+y', { noremap = true })
nvmap('v', '<leader>y', '"+y', { noremap = true })

-- Paste to Clipboard --
nvmap('n', '<leader>p', '"+p', { noremap = true })
nvmap('v', '<leader>p', '"+p', { noremap = true })

