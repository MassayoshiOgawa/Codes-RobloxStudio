local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		while true do
				
			local backpack = player:FindFirstChild("Backpack")
			if not backpack then
				repeat wait() until player:FindFirstChild("Backpack")
				backpack = player:FindFirstChild("Backpack")
			end

			local tools = 0
			
			local character = player.Character
			if character then
				for _, tool in pairs(character:GetChildren()) do
					if tool:IsA("Tool") then
						tools += 1
					end
					if tools > 1 then
						tool:Destroy() 
					end
				end
			end
			
			for _, tool in pairs(backpack:GetChildren()) do
				if tool:IsA("Tool") then
					tools += 1
					if tools > 1 then
						tool:Destroy() 
					end
				end
			end
			wait(0.1)
		end
	end)
end)
