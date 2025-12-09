-- Scripts contained in this game are old.
-- If i could do it all over i would make it better with the new skills i know now.
-- But, atleast appreciate all the hardwork.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local debounce = true
local checkdebounce = true
local startdecreasingRemoteEvent = game.ReplicatedStorage.RemoteEvents.sobrevivencia.iniciar
local vocemorreuframe = script.Parent.VoceMorreu
vocemorreuframe.Visible = false

local moedaBefore
local diamanteBefore
local tempoBefore

local veri

if debounce == true then
	debounce = false
	player = game.Players.LocalPlayer
	if player.Character then
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local start = leaderstats:FindFirstChild("StartSobrevivencia")
			local vida = leaderstats:FindFirstChild("Vida")
			local fome = leaderstats:FindFirstChild("Fome")
			local sede = leaderstats:FindFirstChild("Sede")
			if checkdebounce == true then
				checkdebounce = false
				if start.Value == 0 or start.Value == nil then
					wait(0.1)
					veri = "Sim"
					startdecreasingRemoteEvent:FireServer(veri)
				else
					veri = "Nao"
					startdecreasingRemoteEvent:FireServer(veri)
				end
			end
		else
			print("Leaderstats não encontrado!")
		end
	else
		print("O bloco foi tocado, mas não pelo jogador local.")
	end
end