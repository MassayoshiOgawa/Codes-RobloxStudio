local Players = game:GetService("Players")

local folder1 = game.Workspace.pastaDeArmazenarCoisas.pieces:WaitForChild("Barco")
local folder2 = game.Workspace.pastaDeArmazenarCoisas.pieces:WaitForChild("Comandante")
local folder3 = game.Workspace.pastaDeArmazenarCoisas.pieces:WaitForChild("Soldado")
local folder4 = game.Workspace.pastaDeArmazenarCoisas.pieces:WaitForChild("Escudo")

local folders = {folder1, folder2, folder3, folder4}

local function atualizarContagem()
	local contagem = {}

	for _, folder in pairs(folders) do
		for _, piece in pairs(folder:GetChildren()) do
			local qnt = 1
			if folder.Name == "Escudo" then
				qnt = 10
			end
			local dono = piece.Name
			contagem[dono] = (contagem[dono] or 0) + qnt
		end
	end

	for _, plr in pairs(Players:GetPlayers()) do
		local piecesValue = plr:FindFirstChild("pieces")
		if piecesValue and piecesValue:IsA("IntValue") then
			piecesValue.Value = contagem[plr.Name] or 0
		end
	end
end

for _, folder in pairs(folders) do
	folder.ChildAdded:Connect(atualizarContagem)
	folder.ChildRemoved:Connect(atualizarContagem)
end

Players.PlayerAdded:Connect(function(plr)
	local piecesValue = Instance.new("IntValue")
	piecesValue.Name = "pieces"
	piecesValue.Value = 0
	piecesValue.Parent = plr
	atualizarContagem()
end)

atualizarContagem()
