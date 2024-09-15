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
Dev = {733218668, 720793101}
Beta = {733218668, 0}
Banned = {733218668, 0}
HWIDBanned = {"", 0}
-- Exec
Supported = {"Zorara", "0"}
Unsupported = {"0", "0"}
Blacklisted = {"0", "0"}
-- Hub
Hub = {
HubStatus = true, -- true(online) or false(offline)
OfflineReason = "No Reason Given",
HubVersion = "1.0"
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
    loadstring(game:HttpGet(controllerUrl))()
end
