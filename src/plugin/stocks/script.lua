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
        print("No configuration file found, Current Directory: " .. current_directory)
        return current_directory
    end
end


-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
local function lines_from(file)
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


local script_path = debug.getinfo(1, "S").source:sub(2)
local script_dir = script_path:match("(.*/)")
-- Configuration_file = get_working_directory() .. "/stocks/stocks.conf"
Configuration_file = script_dir .. "stocks.conf"

local function save_refresh_token(token)
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

local function get_refresh_token()
    local configuration = lines_from(Configuration_file)
    local first_key, first_value = get_first_pair(configuration)
    return first_value
end

local function auth(token)
    local https = require("ssl.https")  -- HTTPS support
    local json = require("cjson")       -- JSON parsing

    local url = "https://login.questrade.com/oauth2/token?grant_type=refresh_token&refresh_token=" .. token
    -- Send an HTTPS GET request
    local response, status_code, headers = https.request(url)

    if status_code == 200 then
      -- Parse the JSON response
      local data = json.decode(response)
      if data and data.refresh_token then
        print("Result:", data.refresh_token)
        return data
      else
        print("Unexpected response format")
      end
    else
      print("HTTPS request failed with status:", status_code)
    end
end



local function run()

    -- save_refresh_token("Gq5MZMKSlWRPnanjs6-tHlt_BlW28sjK0")


    -- Working code:
    -- local refresh_token = get_refresh_token()
    --
    -- if refresh_token then
    -- local data = auth(refresh_token)
    -- save_refresh_token(data.refresh_token)



        -- if data then
-- os.execute("sleep 20")

    -- save_refresh_token(data["refresh_token"])
    -- save_refresh_token("BqYnrVmziZH5u4EF_vpGqP_cAzkB9K5Y0")
    -- print(get_refresh_token())
        -- end
    -- end
end

run()
