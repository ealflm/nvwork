local M = {}

M.replace_file_content = function(file_path, new_content)
    -- Open the file in write mode to clear old content
    local file = io.open(file_path, "w")

    -- Check if the file was opened successfully
    if file then
        -- Write new content to the file
        file:write(new_content)

        -- Close the file
        file:close()
        print("nvwork config file updated")
    else
        print("error opening nvwork config file.")
    end
end

return M
