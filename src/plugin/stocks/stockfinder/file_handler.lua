local configuration = {}

local Configuration_file = "../stocks.conf"

-- see if the file exists
local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- Used to debug the working directory to find where the local files
-- need to be.
local function get_working_directory()
    local handle = io.popen("pwd")  -- Execute the shell command
    if handle then
        local current_directory = handle:read("*line")  -- Read the first line of output
        handle:close()
    end
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {get_working_directory()} end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

local function printFile(file)
    -- tests the functions above
    local lines = lines_from(file)

   -- print all line numbers and their contents
    for k,v in pairs(lines) do
    print('line[' .. k .. ']', v)
    end
end

local function get_first_pair(t)
    for key, value in pairs(t) do
        return key, value
    end
end

function configuration.save_refresh_token(token)
    local configuration = lines_from(Configuration_file)
    configuration[1] = token

    local file, err = io.open(Configuration_file, "w")   -- Open the file in write mode

    if not file then
        print("Error opening file: " .. (err or "unknown error"))
    else
        for key, value in pairs(configuration) do
            file:write(value)                -- Write the value to the file
        end
        file:close()                              -- Close the file
    end
end

function configuration.get_refresh_token()
    local configuration = lines_from(Configuration_file)
    local first_key, first_value = get_first_pair(configuration)
    return first_value
end

return configuration
