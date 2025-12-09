game.ReplicatedStorage.remoteEvents.spawnPiece.OnServerEvent:Connect(function(plr, piece, cframe)
	local clone = piece:Clone()
	local pasta
	local qnt = 1
	for _, pastas in ipairs(game.Workspace.pastaDeArmazenarCoisas.pieces:GetChildren()) do
		if clone.Name == pastas.Name then
			pasta = pastas.Name
			break
		end
	end
	clone.Parent = game.Workspace.pastaDeArmazenarCoisas.pieces:WaitForChild(pasta)

	local yRotation = math.rad(plr.Character.HumanoidRootPart.Orientation.Y + 90)

	clone:SetPrimaryPartCFrame(cframe * CFrame.Angles(0, yRotation, 0))

	clone.Name = plr.Name

	local piecesPlayer = plr:WaitForChild("pieces")
	if piecesPlayer.Value > game.Workspace.valores.regras.limitarpieces.Value - 1 then
		clone:Destroy()
		print("Limite de peças atingido.")
		return
	else
		print("Criado peça: "..piece.Name)
	end
end)
