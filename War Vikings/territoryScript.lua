local territoriosIniciais = {
	Alemanha          = {"Fulda", "Frankfurt", "Colditz"},
	Dinamarca         = {"Fyrkat", "Trelleborg", "Hedeby", "Nonnebakken", "Ilhas Fareyjar"},
	Islandia          = {"Borg", "Reykjavik", "Hlidarendi", "Haukadalur", "Papey", "Akureyri"},
	Suecia            = {"Lund", "Helgo", "Stockholm", "Sigtuna", "Gamla Upsala", "Valsgarde", "Umeá"},
	["Ilhas Britanicas"] = {"Cork", "Wexford", "Sligo", "Londres", "Leicester", "York", "Lindisfarne", "Dublin"},
	Noruega           = {"Kaupang", "Oslo", "Stavanger", "Bergen", "Trondheim", "Ornes", "Trondenes"}
}

local territoriosDisponiveis = {}
local podePegar = false
local registrados = {} 

local function trim(s)
	return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function agruparListaParaString(lista)
	if not lista or #lista == 0 then return "Nenhum" end
	local porPais, ordem, visto = {}, {}, {}
	for _, item in ipairs(lista) do
		local pais, cidade = string.match(item, "^(.-):%s*(.+)$")
		if pais and cidade then
			pais, cidade = trim(pais), trim(cidade)
			if not porPais[pais] then
				porPais[pais], visto[pais] = {}, {}
				table.insert(ordem, pais)
			end
			if not visto[pais][cidade] then
				table.insert(porPais[pais], cidade)
				visto[pais][cidade] = true
			end
		end
	end
	local parts = {}
	for _, pais in ipairs(ordem) do
		table.insert(parts, pais .. ": " .. table.concat(porPais[pais], ", "))
	end
	return table.concat(parts, " | ")
end

local function popRandomTerritorio()
	if #territoriosDisponiveis == 0 then return nil end
	local idx = math.random(1, #territoriosDisponiveis)
	return table.remove(territoriosDisponiveis, idx)
end

local function resetTerritorios()
	territoriosDisponiveis = {}
	for pais, lista in pairs(territoriosIniciais) do
		for _, cidade in ipairs(lista) do
			table.insert(territoriosDisponiveis, pais .. ": " .. cidade)
		end
	end
	for i = #territoriosDisponiveis, 2, -1 do
		local j = math.random(1, i)
		territoriosDisponiveis[i], territoriosDisponiveis[j] = territoriosDisponiveis[j], territoriosDisponiveis[i]
	end
	print("Territórios resetados! Total:", #territoriosDisponiveis)
	podePegar = true
end

local resetValue = script.Parent.Parent:WaitForChild("reset")
resetValue.Changed:Connect(function()
	if resetValue.Value then
		resetTerritorios()
		for _, plr in ipairs(game.Players:GetPlayers()) do
			local terr = plr:FindFirstChild("territorio")
			if terr then terr.Value = "Nenhum" end
		end
	end
end)

local function limparTerritoriosPlayer(plr)
	local terr = plr:FindFirstChild("territorio")
	if not terr then
		terr = Instance.new("StringValue")
		terr.Name = "territorio"
		terr.Parent = plr
	end
	terr.Value = "Nenhum"
end

local function redistribuir()
	if #registrados == 0 then return end
	if #territoriosDisponiveis == 0 then resetTerritorios() end

	for _, plr in ipairs(registrados) do
		limparTerritoriosPlayer(plr)
	end

	local repartirIgual = game.Workspace.valores.regras.repartirIgualmente.Value
	local quantidade    = game.Workspace.valores.territoriosPcada.Value
	local nPlayers     = #registrados
	local total        = #territoriosDisponiveis

	if repartirIgual then
		local perPlayer = math.floor(total / nPlayers)
		for _, plr in ipairs(registrados) do
			local lista = {}
			for i = 1, perPlayer do
				local t = popRandomTerritorio()
				if not t then break end
				table.insert(lista, t)
			end
			plr.territorio.Value = agruparListaParaString(lista)
		end
	else
		for _, plr in ipairs(registrados) do
			local lista = {}
			for i = 1, quantidade do
				if #territoriosDisponiveis == 0 then break end
				table.insert(lista, popRandomTerritorio())
			end
			plr.territorio.Value = agruparListaParaString(lista)
		end
	end
end

local prompt = script.Parent
prompt.Triggered:Connect(function(plr)
	local frameDoJogador = game.Workspace.portador.SurfaceGui.Frame:FindFirstChild(plr.Name)
	if not frameDoJogador then
		table.insert(registrados, plr)
		redistribuir()
	else
		warn(plr.Name.." já tem um frame no portador, não será registrado")
	end
end)

local resetPrompt = game.Workspace.resetObjetivos.resetButton.ProximityPrompt
resetPrompt.Triggered:Connect(function()
	registrados = {}
	for _, plr in ipairs(game.Players:GetPlayers()) do
		limparTerritoriosPlayer(plr)
	end
	resetTerritorios()
end)

local pegarUmTerritorio = game.Workspace.territorios.ProximityPrompt
local labelT = game.Workspace["territórioSorteado"].SurfaceGui.TextLabel

pegarUmTerritorio.Triggered:Connect(function(plr)
	local frameDoJogador = game.Workspace.portador.SurfaceGui.Frame:FindFirstChild(plr.Name)
	if not frameDoJogador then
		labelT.Text = plr.Name..", você ainda não pode pegar um território!"
		return
	end
	if #territoriosDisponiveis == 0 then
		labelT.Text = "Nenhum território disponível! Tente novamente."
		resetTerritorios()
		return
	end
	local framePlr = game.Workspace.trocasUI.SurfaceGui.Frame:WaitForChild(plr.Name)
	local iconesGerados = framePlr:WaitForChild("iconesGerados")
	if iconesGerados.Value >= 5 then
		labelT.Text = "Não foi possível dar a carta para "..plr.Name
		return
	end
	local escolhido = popRandomTerritorio()
	if not escolhido then
		labelT.Text = "Nenhum território disponível!"
		return
	end
	local pais, cidade = string.match(escolhido, "^(.-):%s*(.+)$")
	local simboloIndex = math.random(1, 3)
	local simbol = (simboloIndex == 1 and "Escudo") or (simboloIndex == 2 and "Corvo") or "Martelo"

	local function tentarAdicionar(iconName, prefab, simb)
		if iconesGerados.Value < 5 and game.Workspace.trocasUI.SurfaceGui.Frame[iconName].Value > 0 then
			local clone = prefab:Clone()
			clone.Parent = framePlr.iconesContainer
			game.Workspace.trocasUI.SurfaceGui.Frame[iconName].Value -= 1
			iconesGerados.Value += 1
			
			local timestamp = os.date("%H:%M:%S")
			local mainframe = game.Workspace.historic.SurfaceGui.main.playerFrame
			local clone = mainframe:Clone()
			clone.Name = plr.Name
			clone.Visible = true
			clone.Parent = mainframe.Parent
			clone:WaitForChild("nome").Text = plr.Name
			clone:WaitForChild("horario").Text = timestamp
			local simb
			if simbol == "Escudo" then
				simb = "🛡️"
			elseif simbol == "Corvo" then
				simb = "🦅"
			else
				simb = "🔨"
			end
			clone:WaitForChild("simbolo").Text = simb
			return true
		end
		return false
	end
	if simboloIndex == 1 then
		tentarAdicionar("escudo", game.ReplicatedStorage.icones.escudo)
	elseif simboloIndex == 2 then
		tentarAdicionar("corvo", game.ReplicatedStorage.icones.corvo)
	elseif simboloIndex == 3 then
		tentarAdicionar("martelo", game.ReplicatedStorage.icones.martelo)
	end
	local territorioValue = plr:FindFirstChild("territorio") or Instance.new("StringValue", plr)
	territorioValue.Name = "territorio"
	local listaAtual = {}
	if territorioValue.Value ~= "" and territorioValue.Value ~= "Nenhum" then
		for bloco in string.gmatch(territorioValue.Value, "([^|]+)") do
			local p, cs = string.match(bloco, "^(.-):%s*(.+)$")
			if p and cs then
				for c in string.gmatch(cs, "([^,]+)") do
					table.insert(listaAtual, trim(p) .. ": " .. trim(c))
				end
			end
		end
	end
	table.insert(listaAtual, escolhido)
	labelT.Text = ("Território: %s%s, Símbolo: %s"):format(pais and pais .. ": " or "", cidade or "", simbol)
end)
