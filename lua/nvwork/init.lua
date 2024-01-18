local M = {}

-- Define the path to the config file
local config_file_path = vim.fn.expand("~/Documents/NvWork/config")

M.setup = function()
    vim.g.nvwork_selected_file = vim.fn.readfile(config_file_path)[1]
end

M.open_nvwork_selected_file = function()
    local current_buff_file_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())

    if current_buff_file_path == vim.g.nvwork_selected_file then
        require("nvchad.tabufline").close_buffer()
    else
        vim.api.nvim_command("e " .. vim.g.nvwork_selected_file)
    end
end

M.set_nvwork_selected_file = function(file_path)
    vim.g.nvwork_selected_file = file_path
    require("nvwork.utils").replace_file_content(config_file_path, file_path)
end

return M