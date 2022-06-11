-- My custom lua functions 
local M = {}

function M.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup '..group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
        -- if type(def) == 'table' and type(def[#def]) == 'function' then
        --  def[#def] = lua_callback(def[#def])
        -- end
        local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
        vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

-- function auto_switch_project()
--   -- Get current file fullpath
--   local file_path = vim.api.command('expand("%:p:h")')
--   vim.api.nvim_command(':lua echo file_path')
-- end

return M
