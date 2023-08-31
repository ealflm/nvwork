local M = {}

M.setup = function()
    local config_file_path = vim.fn.expand("~/.nvworkconfig")
    vim.g.nvwork_selected_file = vim.fn.readfile(config_file_path)[1]
    print(vim.g.nvwork_selected_file)
end

M.open_nvwork_selected_file = function()
    local current_buff_file_path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())

    if current_buff_file_path == vim.g.nvwork_selected_file then
        require("nvchad.tabufline").close_buffer()
    else
        vim.api.nvim_command("e " .. vim.g.nvwork_selected_file)
    end
end

M.get_nvwork_files = function()
    local directory = vim.fn.expand("~/.nvwork/")
    local file_paths = {}

    for _, entry in ipairs(vim.fn.readdir(directory)) do
        local full_path = directory .. entry
        if vim.fn.isdirectory(full_path) == 0 then
            table.insert(file_paths, full_path)
        end
    end

    return file_paths
end

return M
