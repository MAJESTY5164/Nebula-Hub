if getgenv().AutoFarmLoaded == nil then

	getgenv().AutoFarmLoaded = true
	local Players = game:GetService("Players")
	local Workspace = game:GetService("Workspace")
	local Lighting = game:GetService("Lighting")
	
	local LocalPlayer = Players.LocalPlayer
	
	local autoFarm = function(currentRun)
		local Character = LocalPlayer.Character
		local NormalStages = Workspace.BoatStages.NormalStages
	
		for i = 1, 10 do
			local Stage = NormalStages["CaveStage" .. i]
			local DarknessPart = Stage:FindFirstChild("DarknessPart")
	
			if (DarknessPart) then
				Character.HumanoidRootPart.CFrame = DarknessPart.CFrame
	
				local Part = Instance.new("Part", LocalPlayer.Character)
				Part.Anchored = true
				Part.Position = LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 6, 0)
	
				wait(2)
				Part:Destroy()
			end
		end
	
		repeat wait()
			Character.HumanoidRootPart.CFrame = NormalStages.TheEnd.GoldenChest.Trigger.CFrame
		until Lighting.ClockTime ~= 14
	
		local Respawned = false
		local Connection
		Connection = LocalPlayer.CharacterAdded:Connect(function()
			Respawned = true
			Connection:Disconnect()
		end)
	
		repeat wait() until Respawned
		wait(1)
	end
	
	local autoFarmRun = 1
	while wait() do
		if (getgenv().AutoFarm) then
			autoFarm(autoFarmRun)
			autoFarmRun = autoFarmRun + 1
		end
	end
	end
