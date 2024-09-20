devbuild = true

-- Get Beta Key

plain = os.date("%j" .. 20 .. "%y")
Beta = math.floor(plain * plain)
Dev = math.floor(Beta * 0.3)

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

getgenv().BetaKey = replace_characters(tostring(Beta))
getgenv().DevKey = replace_characters(tostring(Dev))

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

-- Controller
function isInTable(tbl, str)
    for _, value in ipairs(tbl) do
        if value == str then
            return true
        end
    end
    return false
end

function SetExecScripts(script, scriptstatus)

    if script == "all" then
        getgenv().SupportedScripts = {
            discord = true,
            Debug = true
        }
    else
        getgenv().SupportedScripts[script] = scriptstatus
    end
end

SetExecScripts("all", nil)















-- Controller Tables/Vars

-- Users
Dev = {73321866, 72079310}
Beta = {73321866, 0}
Banned = {73321866, 0}
HWIDBanned = {"", 0}
-- Exec
Supported = {"Zorara", "Quantis"}
Unsupported = {"0", "0"}
Blacklisted = {"0", "0"}
-- Hub
Hub = {
HubStatus = true, -- true(online) or false(offline)
OfflineReason = "No Reason Given",
HubVersion = "1.1"
}

-- Exec Support

if getgenv().Executor == "Solara" then
    SetExecScripts("discord", false)
end

















getgenv().HubVersion = Hub["HubVersion"]

-- User Verification

if isInTable(Dev, getgenv().playerID) then
    getgenv().playerStatus = "Dev"
elseif isInTable(Beta, getgenv().playerID) then
    getgenv().playerStatus = "Beta"
elseif isInTable(Banned, getgenv().playerID) or isInTable(HWIDBanned, getgenv().HWID) then
    getgenv().playerStatus = "Banned"
    if isInTable(Banned, getgenv().playerID) and not(isInTable(HWIDBanned, getgenv().HWID)) then
        local url = "https://discord.com/api/webhooks/1284310958684246026/xanbf2qRI-cLGDAzDV_61zpNr241-yzRBCYr0z3pUCfev6Kn8W5bgUrTRCYaZsHnG-VT"
        
        local embed = {
            ["title"] = "Add this user to the HWID Ban list",
            ["description"] = "",
            ["color"] = 0,
            ["fields"] = {
                {
                    ["name"] = "Username",
                    ["value"] = tostring(getgenv().player)
                },
                {
                    ["name"] = "UserId",
                    ["value"] = tostring(getgenv().playerID)
                },
                {
                    ["name"] = "HWID",
                    ["value"] = tostring(getgenv().HWID)
                }
            },
            ["footer"] = {
                ["text"] = ""
            }
        }
        SendMessageEMBED(url, embed)
    end
    game:GetService("Players").LocalPlayer:Kick("Banned from Nebula")
else
    getgenv().playerStatus = "User"
end

-- Exec Verification

if isInTable(Supported, getgenv().Executor) then
    getgenv().execStatus = "Supported"
elseif isInTable(Unsupported, getgenv().Executor) then
    game:GetService("Players").LocalPlayer:Kick(getgenv().Executor .. " Cannot Run Nebula")
elseif isInTable(Blacklisted, getgenv().Executor) then
    game:GetService("Players").LocalPlayer:Kick(getgenv().Executor .. " is Blacklisted from Nebula")
else
    getgenv().execStatus = "Untested"
end

-- Hub status

if Hub["HubStatus"] == false then
    game:GetService("Players").LocalPlayer:Kick(Hub["OfflineReason"])
end

if getgenv().playerStatus == "User" then
    if getgenv().doseSettingsExist == true then
 if getgenv().HttpService:JSONDecode(readfile("NebulaSettings.txt"))["BetaKeyUsed"] == getgenv().BetaKey then
    getgenv().playerStatus = "Beta"
 elseif getgenv().HttpService:JSONDecode(readfile("NebulaSettings.txt"))["DevKeyUsed"] == getgenv().DevKey then
    getgenv().playerStatus = "Dev"
 end
end
end

if Hub["HubStatus"] == true and getgenv().playerStatus == not("Banned") and devbuild == nil then
    loadHub = "https://raw.githubusercontent.com/MAJESTY5164/Nebula-Hub/main/Hub.lua"
    loadstring(game:HttpGet(loadhub))()
end















-- Start of Hub

setfpscap(0)

-- functions
function SendMessage(url, message)
    local http = game:GetService("HttpService")
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local data = {
        ["content"] = message
    }
    local body = http:JSONEncode(data)
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = body
    })
end

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

function UpdateSettings()
    writefile(getgenv().SettingsFileName, getgenv().HttpService:JSONEncode(Settings))
end

-- Reset Settings

function ResetSettings()
    Settings = {
        BetaKeyUsed = 0,
        DevKeyUsed = 0,
        Username = true,
        Game = true,
        Executor = true,
        SendOnExec = false,
    }

    writefile(getgenv().SettingsFileName, getgenv().HttpService:JSONEncode(Settings))
end

-- Read Settings

if getgenv().doseSettingsExist == false then
    ResetSettings()
else
    Settings = getgenv().HttpService:JSONDecode(readfile("NebulaSettings.txt"))
end

-- Scripts
Scripts = {
    Discord = 'https://raw.githubusercontent.com/MAJESTY5164/Majestys-scripts/main/Discord%20Invite.lua',
    Debug = "https://raw.githubusercontent.com/MAJESTY5164/Nebula-Hub/main/Debug%20Menu",
    Graphics = "https://raw.githubusercontent.com/MAJESTY5164/Nebula-Hub/main/Reduce%20Graphics.lua",
    IY = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
    Shaders = "https://raw.githubusercontent.com/MAJESTY5164/Nebula-Hub/main/Shaders.lua",
    ItemGiver = "https://raw.githubusercontent.com/MAJESTY5164/Nebula-Hub/main/DebugItemGiver.lua",
    Dex = "https://raw.githubusercontent.com/MAJESTY5164/Majestys-scripts/main/Dex.lua",
    BaB = "https://raw.githubusercontent.com/MAJESTY5164/Nebula-Hub/refs/heads/main/Buildaboat.lua",
    DebugTool = "https://raw.githubusercontent.com/MAJESTY5164/Nebula-Hub/refs/heads/main/DebugTool.lua",
}

function Execute(Script)
    loadstring(game:HttpGet((Scripts[Script])))()
end




if Settings["Username"] then
User = tostring(getgenv().player)
else
User = "Hidden"
end
if Settings["Game"] then
Game = getgenv().GameName
else
Game = "Hidden"
end
if Settings["Executor"] then
Exec = getgenv().Executor
else
Exec = "Hidden"
end




local url = "https://discord.com/api/webhooks/1284639359118737469/wTyi0PhH_UGNhpqjQ7c6ljUp14ghYEW_7ZcBirIf6yOZ-UfbjZ5zpTVoil8wQ-tlUOWy"

if Settings["SendOnExec"] == false then
        
local embed = {
    ["title"] = "Hub was Executed",
    ["description"] = "",
    ["color"] = 0,
    ["fields"] = {
        {
            ["name"] = "Username",
            ["value"] = User
        },
        {
            ["name"] = "Game",
            ["value"] = Game
        },
        {
            ["name"] = "Executor",
            ["value"] = Exec
        }
    },
    ["footer"] = {
        ["text"] = ""
    }
}
SendMessageEMBED(url, embed)

end







-- getgenv().playerStatus

getgenv().Icon = "Orion" -- Orion or paste a custom rbxassetid
getgenv().Name = "Majestic"
         Theme = "Custom" -- Orion, Majestic, or Custom

if getgenv().playerStatus == "User" then

    getgenv().StrokeRed = 32
    getgenv().StrokeGreen = 252
    getgenv().StrokeBlue = 3

elseif getgenv().playerStatus == "Beta" then

    getgenv().StrokeRed = 3
    getgenv().StrokeGreen = 78
    getgenv().StrokeBlue = 252

elseif getgenv().playerStatus == "Dev" then

    getgenv().StrokeRed = 255
    getgenv().StrokeGreen = 0
    getgenv().StrokeBlue = 182

end

    getgenv().MainRed = 10
    getgenv().MainGreen = 10
    getgenv().MainBlue = 10

    getgenv().SecondRed = 10
    getgenv().SecondGreen = 10
    getgenv().SecondBlue = 10

    getgenv().DividerRed = 60
    getgenv().DividerGreen = 70
    getgenv().DividerBlue = 60

    getgenv().TextRed = 240
    getgenv().TextGreen = 240
    getgenv().TextBlue = 240

    getgenv().TextDarkRed = 150
    getgenv().TextDarkGreen = 150
    getgenv().TextDarkBlue = 150

    getgenv().Theme = "Custom"


local MajesticLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/CeleryHub-official/Majestic-Lib/main/Lib%20Source')))()

local Window = MajesticLib:MakeWindow({Name = "Nebula", HidePremium = false, SaveConfig = true, ConfigFolder = "MajesticTest"})

local Tab = Window:MakeTab({
	Name = "Info",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddLabel("Nebula Hub access level - " .. getgenv().playerStatus)
Tab:AddLabel("Nebula Hub Version - " .. getgenv().HubVersion)
Tab:AddLabel("Executor - " .. getgenv().Executor)
Tab:AddLabel("Join our discord at discord.gg/" .. getgenv().DiscordInvite)

print("UserID ".. getgenv().playerID)

if getgenv().SupportedScripts["discord"] == true then
    
    Tab:AddButton({
        Name = "Join the discord!",
        Callback = function()
            Execute("Discord")
          end    
    })
end

if getgenv().playerStatus == "Dev" then
local Tab = Window:MakeTab({
	Name = "Dev",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddButton({
    Name = "Debug Menu",
    Callback = function()
        Execute("Debug")
      end    
})

Tab:AddButton({
    Name = "Toggle Dex",
    Callback = function()
    if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Dex") then
        game.Players.LocalPlayer.PlayerGui:FindFirstChild("Dex"):Destroy()
    else
        Execute("Dex")
    end
      end    
})

Tab:AddButton({
    Name = "Tool Giver",
    Callback = function()
        Execute("ItemGiver")
      end    
})

Tab:AddButton({
    Name = "Object Debug tool",
    Callback = function()
        Execute("DebugTool")
      end    
})

end

-- Universals

local Tab = Window:MakeTab({
	Name = "Universals",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddButton({
    Name = "Reduce Graphics",
    Callback = function()
        Execute("Graphics")
      end    
})

Tab:AddButton({
    Name = "Infinite Yeild",
    Callback = function()
        Execute("IY")
      end    
})

getgenv().Shaders = false

Tab:AddButton({
    Name = "Shaders",
    Callback = function()
        if getgenv().Shaders == false then
        getgenv().Shaders = true
        Execute("Shaders")
        else
            MajesticLib:MakeNotification({
                Name = "Shaders Are already active",
                Content = "",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
      end    
})

local Tab = Window:MakeTab({
	Name = "MAJESTY's Scripts",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddButton({
    Name = "Build a Boat",
    Callback = function()
        Execute("BaB")
      end    
})

local Tab = Window:MakeTab({
	Name = "Settings",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddTextbox({
	Name = "Set Fps",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		if tonumber(Value) == nil then
            MajesticLib:MakeNotification({
                Name = "Fps has not been changed",
                Content = "Please use a number",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        else
            if Value == "0" then
            MajesticLib:MakeNotification({
                Name = "Fps Set",
                Content = "Fps has been uncapped",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            setfpscap(Value)
        else
            MajesticLib:MakeNotification({
                Name = "Fps Set",
                Content = "Fps has been set to ".. Value,
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            setfpscap(Value)
        end
        end
	end	  
})

local Section = Tab:AddSection({
	Name = "Info Sent to Discord"
})

Tab:AddToggle({
	Name = "Username",
	Default = Settings["Username"],
	Callback = function(Value)
		Settings["Username"] = Value
        UpdateSettings()
	end    
})

Tab:AddToggle({
	Name = "Game",
	Default = Settings["Game"],
	Callback = function(Value)
		Settings["Game"] = Value
        UpdateSettings()
	end    
})

Tab:AddToggle({
	Name = "Executor",
	Default = Settings["Executor"],
	Callback = function(Value)
		Settings["Executor"] = Value
        UpdateSettings()
	end    
})

Tab:AddToggle({
	Name = "Disable sending executed message",
	Default = Settings["SendOnExec"],
	Callback = function(Value)
		Settings["SendOnExec"] = Value
        UpdateSettings()
	end    
})

Tab:AddButton({
    Name = "Reset Settings",
    Callback = function()
        ResetSettings()
      end    
})



function CheckKey(Key)
    if Key == getgenv().BetaKey then
        MajesticLib:MakeNotification({
            Name = "Success!",
            Content = "Beta key has been verified",
            Image = "rbxassetid://4483345998",
            Time = 5
        })

        Settings["BetaKeyUsed"] = Key

        UpdateSettings()
        
        --Examples 
        
        local url = "https://discord.com/api/webhooks/1284273292621910179/Xsm8wRzDWgRPfc2lj3oDWJ5aDlWGL4xHIwA-9LCudgq5sdUztcmZfPMJQtcqsOSRAiNy"
        
        local embed = {
            ["title"] = "Beta Key was used",
            ["description"] = "",
            ["color"] = 0,
            ["fields"] = {
                {
                    ["name"] = "Username",
                    ["value"] = tostring(getgenv().player)
                },
                {
                    ["name"] = "UserId",
                    ["value"] = tostring(getgenv().playerID)
                },
                {
                    ["name"] = "HWID",
                    ["value"] = tostring(getgenv().HWID)
                }
            },
            ["footer"] = {
                ["text"] = ""
            }
        }
        SendMessageEMBED(url, embed)

    elseif Key == getgenv().DevKey then
        MajesticLib:MakeNotification({
            Name = "Success!",
            Content = "Dev key has been verified",
            Image = "rbxassetid://4483345998",
            Time = 5
        })

        Settings["DevKeyUsed"] = Key

        UpdateSettings()
        
        --Examples 
        
        local url = "https://discord.com/api/webhooks/1284995170387103845/fc8-v75TG3IrUzVx3ad952OpvwrOe6LEJuhVS1Kgh2_lC9NrYL3kCnzMB8xBpdrKBcdZ"
        
        local embed = {
            ["title"] = "Dev Key was used",
            ["description"] = "",
            ["color"] = 0,
            ["fields"] = {
                {
                    ["name"] = "Username",
                    ["value"] = tostring(getgenv().player)
                },
                {
                    ["name"] = "UserId",
                    ["value"] = tostring(getgenv().playerID)
                },
                {
                    ["name"] = "HWID",
                    ["value"] = tostring(getgenv().HWID)
                }
            },
            ["footer"] = {
                ["text"] = ""
            }
        }
        SendMessageEMBED(url, embed)
    else
            MajesticLib:MakeNotification({
                Name = "Failed!",
                Content = "The key has been denied",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end



    local Section = Tab:AddSection({
        Name = "Use Keys"
    })

Tab:AddTextbox({
    Name = "Enter Key",
    TextDisappear = true,
    Callback = function(Key)
        CheckKey(Key)
    end	  
})
    
local Tab = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddLabel("MAJESTY: Made the Hub and some Scripts")

-- Beta Script

-- Beta
if getgenv().playerStatus == "Beta" or getgenv().playerStatus == "Dev" then

    local BetaTab = Window:MakeTab({
        Name = "Beta",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
    


BetaTab:AddButton({
    Name = "N/A",
    Callback = function()













        --[[
        
        
        
        
        BETA SCRIPT START
        
        
        
        
        --]]











--[[










            BETA SCRIPT END





--]]











      end    
})
end
