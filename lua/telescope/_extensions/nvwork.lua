local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local utils = require("telescope.utils")
local sorters = require("telescope.sorters")
local make_entry = require("telescope.make_entry")
local api = vim.api

return require("telescope").register_extension {
  exports = {
    select = function()
      local opts = {
        cwd = vim.fn.expand("~/.nvwork/"),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local file_path = getmetatable(selection).cwd .. selection[1]
            require("nvwork").set_nvwork_selected_file(file_path)
          end)
          return true
        end,
      }

      require'telescope.builtin'.find_files(opts)

    end
  }
}
