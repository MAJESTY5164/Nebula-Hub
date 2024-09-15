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
    Dex = "",
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
    Name = "Tool Giver",
    Callback = function()
        Execute("ItemGiver")
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

-- Beta
if getgenv().playerStatus == "Beta" or getgenv().playerStatus == "Dev" then

local Tab = Window:MakeTab({
	Name = "Beta",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

end

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
