local module = {}

module.getutensilio = function(plr, utensilio, model)

		for i, utensiliosTool in pairs(game.ReplicatedStorage.tools.utensilios:GetChildren()) do
			if utensilio ==  utensiliosTool.Name then
				local clone = utensiliosTool:Clone()
				local character = plr.Character

				if character then
					clone.Parent = character
					model:Destroy()
				else
					clone.Parent = plr:FindFirstChild("Backpack")
					model:Destroy()
				end
			end
		end
	
end


return module
