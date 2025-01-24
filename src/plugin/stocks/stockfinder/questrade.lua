local api = {}

local https = require("ssl.https")  -- HTTPS support
local json = require("cjson")       -- JSON parsing
local questrade_api_server = ""


function api.auth(token)

    local url = "https://login.questrade.com/oauth2/token?grant_type=refresh_token&refresh_token=" .. token
    -- Send an HTTPS GET request
    local response, status_code, headers = https.request(url)

    if status_code == 200 then
        -- Parse the JSON response
        local data = json.decode(response)
        if data and data.refresh_token then
            -- print("Result:", data.refresh_token)
            questrade_api_server = data.api_server
            return data.refresh_token
            -- return data
        else
            print("Unexpected response format")
        end
    else
        print("HTTPS request failed with status:", status_code)
    end
end

-- GET https://api01.iq.questrade.com/v1/symbols/search?prefix=BMO
function api.search_questrade(ticker)

    local url = questrade_api_server .. "/v1/symbols/search?prefix=" .. ticker

    local response, status_code, header = https.request(url)

    if status_code == 200 then
        local data = json.decode(response)
        if data then
            return data[1].symbol
        else
            print("Unexpected response format")
        end
    else
      print("HTTPS request failed with status:", status_code)

    end

end

return api
