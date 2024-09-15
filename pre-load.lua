-- Get Beta Key

k1 = os.date("%j" .. 20 .. "%y")
k2 = math.floor(k1 * k1 * 0.3)
k1 = math.floor(k1 * k1)

function replace_characters(text)
    local replacements = {
        ['1'] = 'a',
        ['2'] = 'b',
        ['3'] = 'c',
        ['4'] = 'd',
        ['5'] = 'e',
        ['6'] = 'f',
        ['7'] = 'g',
        ['8'] = 'h',
        ['9'] = 'i',
        ['0'] = 'j',  -- Optional: if you want to replace '0' with 'j'
        ['\\'] = 'z'
    }
    
    local result = text:gsub(".", function(c)
        return replacements[c] or c
    end)
    
    return result
end

getgenv().BetaKey = replace_characters(tostring(k1))
getgenv().DevKey = replace_characters(tostring(k2))

function SendMessageEMBED(url, embed)
    local http = game:GetService("HttpService")
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local data = {
        ["embeds"] = {
            {
                ["title"] = embed.title,
                ["description"] = embed.description,
                ["color"] = embed.color,
                ["fields"] = embed.fields,
                ["footer"] = {
                    ["text"] = embed.footer.text
                }
            }
        }
    }
    local body = http:JSONEncode(data)
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = body
    })
end

-- Vars
getgenv().player = game:GetService("Players").LocalPlayer
getgenv().playerID = player.UserId
getgenv().Executor = identifyexecutor()
getgenv().GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
getgenv().HWID = game:GetService("RbxAnalyticsService"):GetClientId()
getgenv().DiscordInvite = "tbsrZA8Atm"
getgenv().SettingsFileName = "NebulaSettings.txt"
getgenv().doseSettingsExist = isfile(getgenv().SettingsFileName)
getgenv().HttpService = game:GetService("HttpService")

if devbuild == nil then
    controllerUrl = "https://raw.githubusercontent.com/MAJESTY5164/Nebula-Hub/main/Controller.lua"
    loadstring(game:HttpGet(controllerUrl))()
end
