-- Start of Hub

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

-- Scripts
Scripts = {
    Discord = 'https://raw.githubusercontent.com/MAJESTY5164/Majestys-scripts/main/Discord%20Invite.lua',
    Debug = "https://raw.githubusercontent.com/MAJESTY5164/MAJESTIC-Hub/main/Debug%20menu"
}

function Execute(Script)
    loadstring(game:HttpGet((Scripts[Script])))()
end






getgenv().Icon = "Orion" -- Orion or paste a custom rbxassetid
getgenv().Name = "Majestic"
         Theme = "Majestic" -- Orion, Majestic, or Custom

if Theme == "Custom" then
    getgenv().MainRed = 0
    getgenv().MainGreen = 0
    getgenv().MainBlue = 0

    getgenv().SecondRed = 0
    getgenv().SecondGreen = 0
    getgenv().SecondBlue = 0

    getgenv().StrokeRed = 0
    getgenv().StrokeGreen = 0
    getgenv().StrokeBlue = 0

    getgenv().DividerRed = 0
    getgenv().DividerGreen = 0
    getgenv().DividerBlue = 0

    getgenv().TextRed = 0
    getgenv().TextGreen = 0
    getgenv().TextBlue = 0

    getgenv().TextDarkRed = 0
    getgenv().TextDarkGreen = 0
    getgenv().TextDarkBlue = 0

    getgenv().Theme = "Custom"
else
    getgenv().Theme = Theme
end

local MajesticLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/CeleryHub-official/Majestic-Lib/main/Lib%20Source')))()

local Window = MajesticLib:MakeWindow({Name = "Nebula", HidePremium = false, SaveConfig = true, ConfigFolder = "MajesticTest"})

local Tab = Window:MakeTab({
	Name = "Info",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddLabel("Celery Hub access level - " .. getgenv().playerStatus)
Tab:AddLabel("Celery Hub Version - " .. getgenv().HubVersion)
Tab:AddLabel("Executor - " .. getgenv().Executor)
Tab:AddLabel("Join our discord at discord.gg/" .. getgenv().DiscordInvite)

if getgenv().SupportedScripts["discord"] == true then
    
    Tab:AddButton({
        Name = "Join the discord!",
        Callback = function()
            Execute("Discord")
          end    
    })
end

local Tab = Window:MakeTab({
	Name = "Universals",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

if getgenv().SupportedScripts["Debug"] == true then
    
    Tab:AddButton({
        Name = "Debug Menu",
        Callback = function()
            Execute("Debug")
          end    
    })
end

local BetaTab = Window:MakeTab({
	Name = "Beta",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

if getgenv().playerStatus ~= "Beta" then
    BetaTab:AddTextbox({
        Name = "Beta Key",
        TextDisappear = true,
        Callback = function(Key)
            KeyInput = Key
        end	  
    })
end

function CheckKey(Key)
    if Key == getgenv().BetaKey then
        MajesticLib:MakeNotification({
            Name = "Success!",
            Content = "The key has been verified",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
        
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
        else
            MajesticLib:MakeNotification({
                Name = "Failed!",
                Content = "The key has been denied",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end


BetaTab:AddButton({
	Name = "Check Key",
	Callback = function()
        print(KeyInput)
        CheckKey(KeyInput)
  	end    
})
    
local Tab = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddLabel("MAJESTY: Made the Hub and some Scripts")
