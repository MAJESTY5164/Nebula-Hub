if getgenv().Game[1] == "all" or getgenv().Game[2] == getgenv().GameId then

local ToolGiverGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local TextButton = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local TextButton_2 = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")  -- Close Button

-- Variables for Close Button position and size
local CloseX = 0.9  -- Change this for horizontal positioning
local CloseY = 0.016     -- Change this for vertical positioning
local CloseSize = UDim2.new(0, 18, 0, 18)  -- Close Button size

ToolGiverGui.Parent = game:GetService("CoreGui")
ToolGiverGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToolGiverGui.ResetOnSpawn = false

Frame.Parent = ToolGiverGui
Frame.Active = true
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(255, 0, 255)
Frame.Position = UDim2.new(0.0610425249, 0, 0.0939490423, 0)
Frame.Size = UDim2.new(0, 218, 0, 225)  -- Original size

ScrollingFrame.Parent = Frame
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BorderColor3 = Color3.fromRGB(255, 0, 255)
ScrollingFrame.Position = UDim2.new(0.0871559605, 0, 0.155555561, 0)
ScrollingFrame.Size = UDim2.new(0, 187, 0, 136)  -- Original size
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 35, 0)

UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

TextButton.Parent = ScrollingFrame
TextButton.BackgroundColor3 = Color3.fromRGB(117, 117, 117)
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.Size = UDim2.new(0, 155, 0, 39)  -- Original size
TextButton.Visible = false
TextButton.Font = Enum.Font.SourceSans
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 20.000
TextButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextStrokeTransparency = 0.000
TextButton.TextWrapped = true

if getgenv().Game[1] == "all" then
    
    TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderColor3 = Color3.fromRGB(255, 0, 255)
TextLabel.Position = UDim2.new(-0.00129664713, 0, -0.000140406293, 0)
TextLabel.Size = UDim2.new(0, 218, 0, 25)  -- Original size
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "MAJESTY's Tool Giver"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14.000

else

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderColor3 = Color3.fromRGB(255, 0, 255)
TextLabel.Position = UDim2.new(-0.00129664713, 0, -0.000140406293, 0)
TextLabel.Size = UDim2.new(0, 218, 0, 25)  -- Original size
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "MAJESTY's Tool Giver - ".. getgenv().Game[1]
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14.000

end

TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(177, 177, 177)
TextButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton_2.Position = UDim2.new(0.0825688094, 0, 0.804444432, 0)
TextButton_2.Size = UDim2.new(0, 180, 0, 30)  -- Original size
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.Text = "Update List"
TextButton_2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_2.TextSize = 14.000

CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red color
CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.Position = UDim2.new(CloseX, 0, CloseY, 0)  -- Use the CloseX and CloseY variables
CloseButton.Size = CloseSize  -- Use the CloseSize variable
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14.000

CloseButton.MouseButton1Click:Connect(function()
	ToolGiverGui:Destroy()  -- Destroy the GUI
end)

local function FNDR_fake_script()
	local script = Instance.new('LocalScript', Frame)

	local button = script.Parent.ScrollingFrame.TextButton
	button.Parent = nil
	button.Name = "slaves"
	local toolNames = {}

	local function cloneToBackpack(toolName)
		local clonedTool = toolName:Clone()
		clonedTool.Parent = game:GetService("Players").LocalPlayer:WaitForChild("Backpack")
	end

	local function updatelist()
		for i, v in script.Parent.ScrollingFrame:GetDescendants() do
			if v:IsA("TextButton") then
				v:Destroy()
			end
		end

		toolNames = {}
		local tools = {}
		for i, v in pairs(game:GetDescendants()) do
			if v:IsA("Tool") and v.Parent.Parent ~= game:GetService("Players").LocalPlayer then
				if not toolNames[v.Name] then
					table.insert(tools, v)
					toolNames[v.Name] = true
				end
			end
		end

		table.sort(tools, function(a, b)
			return a.Name < b.Name
		end)

		for _, tool in ipairs(tools) do
			local clonebutton = button:Clone()
			clonebutton.Parent = script.Parent.ScrollingFrame
			clonebutton.Visible = true
			clonebutton.Text = tool.Name
			clonebutton.MouseButton1Click:Connect(function()
				cloneToBackpack(tool)
			end)
		end
	end

	script.Parent.TextButton.MouseButton1Click:Connect(updatelist)
end
coroutine.wrap(FNDR_fake_script)()

local function SGRWUDK_fake_script()
	local script = Instance.new('LocalScript', Frame)

	local UIS = game:GetService('UserInputService')
	local frame = script.Parent
	local dragToggle = nil
	local dragSpeed = 0
	local dragStart = nil
	local startPos = nil
	
	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {
			Position = position
		}):Play()
	end
	
	frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
	
	UIS.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end)
end
coroutine.wrap(SGRWUDK_fake_script)()

else
    
    getgenv().Game = "all"

    local ToolGiverGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local CloseButton = Instance.new("TextButton")  -- Close Button
    local CenteredTextLabel = Instance.new("TextLabel")  -- Centered Text
    
    -- Variables for Close Button position and size
    local CloseX = 0.9  -- Change this for horizontal positioning
    local CloseY = 0.016  -- Change this for vertical positioning
    local CloseSize = UDim2.new(0, 18, 0, 18)  -- Close Button size
    
    ToolGiverGui.Parent = game:GetService("CoreGui")
    ToolGiverGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ToolGiverGui.ResetOnSpawn = false
    
    Frame.Parent = ToolGiverGui
    Frame.Active = true
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderColor3 = Color3.fromRGB(255, 0, 255)
    Frame.Position = UDim2.new(0.061, 0, 0.094, 0)
    Frame.Size = UDim2.new(0, 218, 0, 225)
    
    -- Add the centered text
    CenteredTextLabel.Parent = Frame
    CenteredTextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    CenteredTextLabel.BorderColor3 = Color3.fromRGB(255, 0, 255)
    CenteredTextLabel.Position = UDim2.new(0.1, 0, 0.4, 0)  -- Position in the center
    CenteredTextLabel.Size = UDim2.new(0.8, 0, 0.2, 0)  -- Adjust size if needed
    CenteredTextLabel.Font = Enum.Font.SourceSans
    CenteredTextLabel.Text = "Wrong GameId!"
    CenteredTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CenteredTextLabel.TextSize = 20
    CenteredTextLabel.TextWrapped = true
    CenteredTextLabel.TextXAlignment = Enum.TextXAlignment.Center
    CenteredTextLabel.TextYAlignment = Enum.TextYAlignment.Center
    
    -- Close button
    CloseButton.Parent = Frame
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red color
    CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton.Position = UDim2.new(CloseX, 0, CloseY, 0)  -- Use the CloseX and CloseY variables
    CloseButton.Size = CloseSize  -- Use the CloseSize variable
    CloseButton.Font = Enum.Font.SourceSans
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14
    
    CloseButton.MouseButton1Click:Connect(function()
        ToolGiverGui:Destroy()  -- Destroy the GUI
    end)
    
    -- Dragging functionality
    local function SGRWUDK_fake_script()
        local script = Instance.new('LocalScript', Frame)
    
        local UIS = game:GetService('UserInputService')
        local frame = script.Parent
        local dragToggle = nil
        local dragSpeed = 0
        local dragStart = nil
        local startPos = nil
        
        local function updateInput(input)
            local delta = input.Position - dragStart
            local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {
                Position = position
            }):Play()
        end
        
        frame.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
                dragToggle = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragToggle = false
                    end
                end)
            end
        end)
        
        UIS.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if dragToggle then
                    updateInput(input)
                end
            end
        end)
    end
    coroutine.wrap(SGRWUDK_fake_script)()

end
