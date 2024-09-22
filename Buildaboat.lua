getgenv().Icon = "Orion" -- Orion or paste a custom rbxassetid
getgenv().Name = "Majestic(Builda)"
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

local Window = MajesticLib:MakeWindow({Name = "Nebula Hub Build a boat", HidePremium = false, SaveConfig = true, ConfigFolder = "MajesticTest"})

local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "Item Giver",
	Callback = function()
		itemgiver = "https://raw.githubusercontent.com/MAJESTY5164/Nebula-Hub/main/DebugItemGiver.lua"
			getgenv().Game = {"Build a Boat", 210851291}
		loadstring(game:HttpGet(itemgiver))()
  	end    
})

if getgenv().AutoFarm == nil then
	getgenv().AutoFarm = false
end

Tab:AddToggle({
	Name = "Auto Grind",
	Default = getgenv().AutoFarm,
	Callback = function(Value)
		getgenv().AutoFarm = Value
	end    
})

Tab:AddButton({
	Name = "Click this if auto farm breaks",
	Callback = function()
		getgenv().AutoFarmLoaded = nil
		buildafarm = "https://raw.githubusercontent.com/MAJESTY5164/Nebula-Hub/main/buildafarm.lua"
		loadstring(game:HttpGet(buildafarm))()
  	end    
})

buildafarm = "https://raw.githubusercontent.com/MAJESTY5164/Nebula-Hub/main/buildafarm.lua"
loadstring(game:HttpGet(buildafarm))()
