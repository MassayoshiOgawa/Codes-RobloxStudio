local module = {}

module.GetIngredient = function(plr, ingredient, stage)
	
	local itens = 0

	local character = plr.Character
	if character then
		for _, tool in pairs(character:GetChildren()) do
			if tool:IsA("Tool") then
				itens += 1
			end
		end
	end
	
	for _, tool in pairs(plr:FindFirstChild("Backpack"):GetChildren()) do
		if tool:IsA("Tool") then
			itens += 1
			if itens > 1 then
				tool:Destroy()
			end
		end
	end


	if itens == 0 then
		local tool
		if stage == nil then
			tool = game.ReplicatedStorage.tools.ingredientes:FindFirstChild(ingredient)
		elseif stage == "Chopped" then
			tool = game.ReplicatedStorage.tools.ingredientes.Stages.Chopped:FindFirstChild(ingredient.."Chopped")
		elseif stage == "Cooked" then
			tool = game.ReplicatedStorage.tools.ingredientes.Stages.Cooked:FindFirstChild(ingredient.."Cooked")
		end
		if tool then
			local clone = tool:Clone()
			local character = plr.Character

			if character then
				clone.Parent = character
			else
				clone.Parent = plr:FindFirstChild("Backpack")
			end
		end
	end

	
end

return module
