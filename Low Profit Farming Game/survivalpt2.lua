-- Scripts contained in this game are old.
-- If i could do it all over i would make it better with the new skills i know now.
-- But, atleast appreciate all the hardwork.

wait(2)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local sedeRandom = 0
local fomeRandom = 0

-- %%%%%%%%%%%%%%%
local descerRapido = false
local aceleratorDebounce = false
local cdPrincipal = 17
local cdAlternativo = 3
if descerRapido == true then
	local cdPrincipal = 0.1
	local cdAlternativo = 0.1
end
-- %%%%%%%%%%%%%%%

local activePlayers = {}

local enviarValoresPerdidos = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("sobrevivencia"):WaitForChild("enviarvaloresperdidos")

ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("sobrevivencia"):WaitForChild("iniciar").OnServerEvent:Connect(function(player, veri)
	if activePlayers[player] then return end

	activePlayers[player] = true 

	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then
		return
	end

	local sede = leaderstats:FindFirstChild("Sede")
	local fome = leaderstats:FindFirstChild("Fome")
	local vida = leaderstats:FindFirstChild("Vida")
	local start = leaderstats.StartSobrevivencia
	
	if veri == "Sim" then
		start.Value = 1
		sede.Value = 100
		fome.Value = 100
		vida.Value = 100
	end
	
	local moeda = leaderstats.Moedas
	local dima = leaderstats.Diamantes
	
	local pao = leaderstats.Pao
	local garrafadagua = leaderstats.GarrafaDaAgua

	if aceleratorDebounce == true then
		sede.Value = 20
		fome.Value = 20
		vida.Value = 100
	end

	local gui = player:WaitForChild("PlayerGui"):WaitForChild("Inventario"):WaitForChild("FomeSedeVida"):WaitForChild("VoceMorreu")
	if not gui then
		warn("GUI 'VoceMorreu' não encontrado para o jogador: " .. player.Name)
		return
	end

	local dimaP = gui.DimasPerdidos
	local moedaP = gui.MoedasPerdidos

	if not (sede and fome and vida) then
		return
	end

	local function restart()
		player:LoadCharacter()
		local oldDima = dima.Value
		local oldMoeda = moeda.Value
		wait(0.2)
		sede.Value = 100
		fome.Value = 100
		vida.Value = 100
		moeda.Value = math.floor(moeda.Value / 10)
		dima.Value = math.floor(dima.Value / 3)

		if gui.Visible == false then
			gui.Visible = true
		end

		enviarValoresPerdidos:FireClient(player, oldDima - dima.Value, oldMoeda - moeda.Value)

		print("GUI atualizado. Dimas perdidos:", (oldDima - dima.Value), "Moedas perdidas:", (oldMoeda - moeda.Value))
	end

	local function decsede()
		while sede.Value > 0 and fome.Value > 0 and activePlayers[player] do
			sedeRandom = math.random(1, 3)
			if sedeRandom > 1 then
				sede.Value -= 1
			else
				if sede.Value > 1 then
				sede.Value -= 2
				else
					sede.Value -= 1
				end
			end
			fomeRandom = math.random(1, 2)
			wait(fomeRandom)
			fome.Value -= 1
			if pao.Value > 5 and garrafadagua.Value > 5 then
				wait(cdPrincipal - 6)
			else
				wait(cdPrincipal)
			end
		end
	end

	while activePlayers[player] do
		if fome.Value > 0 and sede.Value > 0 then
			decsede()
		else
			while (fome.Value <= 0 or sede.Value <= 0) and vida.Value > 0 and activePlayers[player] do
				if fome.Value <= 0 then
					vida.Value -= 2
					if sede.Value > 0 then
						sede.Value -= 1
					end
				end
				if sede.Value <= 0 then
					vida.Value -= 1
					if fome.Value > 0 then
						fome.Value -= 1
					end
				end
				wait(cdAlternativo)
			end
		end

		if vida.Value <= 0 and activePlayers[player] then
			restart()
		end
		wait(0.1)
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	activePlayers[player] = nil
end)
