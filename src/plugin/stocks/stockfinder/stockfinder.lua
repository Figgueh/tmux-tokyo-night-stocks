local config = require("file_handler")
local api = require("questrade")

local function welcome()
    print("Welcome to the companion application for the stock market plugin")

    print("Enter the ticker you would like to search for")
    local search_ticker = io.read()

    print("Questrade search for " .. search_ticker .. ":")

    local token = config.get_refresh_token()
    token = api.auth(token)
    print("passes auth")
    config.save_refresh_token(token)

    print(api.search_questrade(search_ticker))



end

welcome()
