local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local utils = require("telescope.utils")
local sorters = require("telescope.sorters")
local make_entry = require("telescope.make_entry")
local api = vim.api

local cwd = vim.fn.expand("~/Documents/NvWork/data/")

return require("telescope").register_extension {
  exports = {
    select = function()
      local opts = {
        cwd = cwd,
        attach_mappings = function(prompt_bufnr, map)
          -- enter action
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local file_path = selection[1]

            require("nvwork").set_nvwork_selected_file(file_path)
          end)

          -- ctrl + enter action
          local create_new = function()
            local search_text = action_state.get_current_line()
            actions.close(prompt_bufnr)

            local file_path = cwd .. search_text

            require("nvwork").set_nvwork_selected_file(file_path)

            local create_cmd = "silent !New-Item -ItemType File -Force -Path " .. file_path
            vim.cmd(create_cmd)
          end

          map('i', '<A-CR>', create_new)
          map('n', '<A-CR>', create_new)

          return true
        end,
      }

      require'telescope.builtin'.find_files(opts)

    end
  }
}
