local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local flying = true
local speed = 1

local function fly()
    -- Teleport the player 200 studs up
    character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame + Vector3.new(0, 200, 0))

    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Parent = character.HumanoidRootPart

    while flying do
        bodyVelocity.Velocity = Vector3.new(0, speed, 0)
        wait(0.1)
    end
    
    bodyVelocity:Destroy()
end

local function onInput(input, gameProcessed)
    if gameProcessed then return end

    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.F then
            flying = not flying
            if flying then
                fly()
            end
        end
    end
end

game:GetService("UserInputService").InputBegan:Connect(onInput)
