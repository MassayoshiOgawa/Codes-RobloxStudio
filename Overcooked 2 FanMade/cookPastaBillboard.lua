local module = {}

module.CozinharMacarrao = function(plr, tempo, frame, agua)
	local currTempo = tempo
	local verde = frame
	local branco = frame:WaitForChild("green")
	while currTempo > 1 do
		currTempo -= 1
		branco.Size = UDim2.new(currTempo/tempo, 0, 1, 0)
		wait(1)
	end
	currTempo = 10
	tempo = currTempo
	branco.BackgroundColor3 = verde.BackgroundColor3
	verde.BackgroundColor3 = Color3.new(1, 0, 0)
	while currTempo > 0 do
		currTempo -= 1
		branco.Size = UDim2.new(currTempo/tempo, 0, 1, 0)
		wait(1)
	end
	for _, part in pairs(agua:GetChildren()) do
		if part:IsA("Part") then
			part.BrickColor = BrickColor.new("Black")
		end
	end
end

return module
