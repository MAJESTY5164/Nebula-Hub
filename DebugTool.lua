-- Create the Debug Tool
local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

local debugTool = Instance.new("Tool")
debugTool.Name = "Debug Tool"
debugTool.RequiresHandle = true

-- Create a handle for the tool
local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(1, 4, 1)  -- Adjust size as needed
handle.Anchored = false
handle.CanCollide = false
handle.Material = Enum.Material.SmoothPlastic
handle.BrickColor = BrickColor.new("Bright red")  -- Change color if needed
handle.Transparency = 1  -- Make the handle invisible
handle.Parent = debugTool

-- Function to print object name and path when clicked
local function onActivated()
    local mouse = player:GetMouse()
    local target = mouse.Target

    if target then
        -- Print the object's name and path
        print("Object Name: " .. target.Name)
        print("Object Path: " .. target:GetFullName())
    end
end

-- Connect the tool's activated event to the onActivated function
debugTool.Activated:Connect(onActivated)

-- Parent the tool to the player's backpack
debugTool.Parent = backpack
