local objetivosIniciais = {
	"Conquistar 15 territórios à sua escolha com pelo menos 2 unidades em cada",
	"Conquistar Ilhas Britânicas, Alemanha e mais 3 territórios à sua escolha",
	"Conquistar Islândia, Dinamarca e mais 3 territórios à sua escolha",
	"Conquistar Islândia, Noruega e mais 1 território à sua escolha",
	"Conquistar Islândia, Dinamarca e Alemanha",
	"Conquistar Suécia, Dinamarca e mais 2 territórios à sua escolha",
	"Conquistar Noruega, Dinamarca e mais 2 territórios à sua escolha",
	"Eliminar todos os exércitos do jogador amarelo (ou conquistar 15 territórios se amarelo não existir)",
	"Eliminar todos os exércitos do jogador preto (ou conquistar 15 territórios se preto não existir)",
	"Eliminar todos os exércitos do jogador vermelho (ou conquistar 15 territórios se vermelho não existir)",
	"Eliminar todos os exércitos do jogador azul (ou conquistar 15 territórios se azul não existir)",
	"Eliminar todos os exércitos do jogador verde (ou conquistar 15 territórios se verde não existir)",
	"Eliminar todos os exércitos do jogador branco (ou conquistar 15 territórios se branco não existir)",
}

local objetivosIniciaisSemExercito = {
	"Conquistar 15 territórios à sua escolha com pelo menos 2 unidades em cada",
	"Conquistar Ilhas Britânicas, Alemanha e mais 3 territórios à sua escolha",
	"Conquistar Islândia, Dinamarca e mais 3 territórios à sua escolha",
	"Conquistar Islândia, Noruega e mais 1 território à sua escolha",
	"Conquistar Islândia, Dinamarca e Alemanha",
	"Conquistar Suécia, Dinamarca e mais 2 territórios à sua escolha",
	"Conquistar Noruega, Dinamarca e mais 2 territórios à sua escolha"
}

local objetivosDisponiveis = {}

local podePegar = {}

local function resetObjetivos()
	local regraDosEliminarExercito = game.Workspace.valores.regras.objetivosEliminarExercitos.Value
	objetivosDisponiveis = {}
	if regraDosEliminarExercito then	
		for _, obj in ipairs(objetivosIniciais) do
			table.insert(objetivosDisponiveis, obj)
		end
	else
		for _, obj in ipairs(objetivosIniciaisSemExercito) do
			table.insert(objetivosDisponiveis, obj)
		end
	end

	for i = #objetivosDisponiveis, 2, -1 do
		local j = math.random(1, i)
		objetivosDisponiveis[i], objetivosDisponiveis[j] = objetivosDisponiveis[j], objetivosDisponiveis[i]
	end

	print("Objetivos resetados e embaralhados!")

	for _, plr in ipairs(game.Players:GetPlayers()) do
		podePegar[plr] = true
	end
end

local prompt = script.Parent
local resetValue = script.Parent.Parent:WaitForChild("reset")
local frameContainer = game.Workspace.portador.SurfaceGui.Frame

prompt.Triggered:Connect(function(plr)
	if frameContainer:FindFirstChild(plr.Name) then
		warn(plr.Name .. " já tem um frame, não pode pegar objetivo")
		return
	end

	if not podePegar[plr] then
		warn(plr.Name .. " tentou pegar objetivo antes do reset.")
		return
	end

	if #objetivosDisponiveis == 0 then
		warn("Sem objetivos disponíveis!")
		return
	end

	local index = math.random(1, #objetivosDisponiveis)
	local escolhido = objetivosDisponiveis[index]

	local objetivoValue = plr:FindFirstChild("objetivo")
	if not objetivoValue then
		objetivoValue = Instance.new("StringValue")
		objetivoValue.Name = "objetivo"
		objetivoValue.Parent = plr
	end

	objetivoValue.Value = escolhido
	print("Objetivo sorteado para " .. plr.Name .. ": " .. escolhido)

	table.remove(objetivosDisponiveis, index)

	podePegar[plr] = false
end)

resetValue.Changed:Connect(function()
	if resetValue.Value then
		resetObjetivos()

		for _, plr in ipairs(game.Players:GetPlayers()) do
			local obj = plr:FindFirstChild("objetivo")
			if obj then
				obj.Value = "Nenhum"
			end
		end
	end
end)
