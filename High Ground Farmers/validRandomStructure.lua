local module = {}

module.validarEspaco = function(strucObj, spawner)
	local function HaAlgoDentro(bloco)
		local cframe = bloco.CFrame
		local originalSize = bloco.Size

		local reductionFactor = 0.9
		local innerSize = Vector3.new(
			originalSize.X * reductionFactor,
			originalSize.Y * reductionFactor,
			originalSize.Z * reductionFactor
		)

		local parts = workspace:GetPartBoundsInBox(cframe, innerSize)

		for _, part in ipairs(parts) do
			if part ~= bloco 
				and not bloco:IsAncestorOf(part) 
				and part:IsA("Part") 
				and string.lower(part.Name) ~= "hitbox" 
				and string.lower(part.Name) ~= "smallstrucspawn" 
				and string.lower(part.Name) ~= "center"
			then
				print("O CULPADO É: ".. part.Name)
				print("Logo bloqueou o: "..strucObj.Name)
				part.BrickColor = BrickColor.new("Really red")
				return false
			end
		end
		print("Ta liberado o modelo: "..strucObj.Name)
		return true
	end
	
	local cloneStruc = strucObj:Clone()
	cloneStruc.Parent = game.Workspace
	local altura = cloneStruc:GetExtentsSize().Y / 2
	cloneStruc:SetPrimaryPartCFrame(cloneStruc.PrimaryPart.CFrame + Vector3.new(0, altura, 0))
	for _, part in pairs(strucObj:GetChildren()) do
		if part:IsA("Part") then
			if HaAlgoDentro(part) then
				cloneStruc:Destroy()
				return false
			end
		end
	end
	cloneStruc:Destroy()
	return true
end

return module
