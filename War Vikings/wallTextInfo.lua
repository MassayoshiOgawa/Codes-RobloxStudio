local mainFrame = script.Parent.playerFrame
local mainFrame2 = game.Workspace.trocasUI.SurfaceGui.Frame.playerFrame
local frames = {}
local frames2 = {} 
local portador = script.Parent.Parent.Parent
local icone = game.Workspace.trocasUI

local liberados = {}

local baseSize = portador.Size
local basePos = portador.Position
local baseSizeIc = icone.Size
local basePosIc = icone.Position

local cores = {
	Alemanha = "rgb(255,255,0)", 
	Dinamarca = "rgb(255,105,180)", 
	Islandia = "rgb(255,165,0)", 
	Suecia = "rgb(255,0,0)", 
	["Ilhas Britanicas"] = "rgb(0,255,0)", 
	Noruega = "rgb(0,0,255)" 
}

local function colorirTexto(texto)
	for pais, cor in pairs(cores) do
		texto = string.gsub(texto, pais, '<font color="'..cor..'">'..pais..'</font>')
	end
	return texto
end

local function atualizarPortador()
	local qtd = 0
	for _, v in pairs(frames) do
		if v then qtd += 1 end
	end
	local valorrr = 4.5
	if qtd == 1 then
		valorrr -= 0.8
	end
	portador.Size = Vector3.new(baseSize.X, baseSize.Y + valorrr * qtd, baseSize.Z)
	portador.Position = Vector3.new(basePos.X, basePos.Y + (valorrr/2) * qtd, basePos.Z)
end

local function atualizarIcone()
	local qtd = 0
	for _, v in pairs(frames) do
		if v then qtd += 1 end
	end
	local valorrr = 4.46
	if qtd == 1 then
		valorrr -= 0.8
	end
	icone.Size = Vector3.new(baseSizeIc.X, baseSizeIc.Y + valorrr * qtd, baseSizeIc.Z)
	icone.Position = Vector3.new(basePosIc.X, basePosIc.Y + (valorrr/2) * qtd, basePosIc.Z)
end

local function atualizarClone(plr)
	if not liberados[plr] then return end

	local territorio = plr:WaitForChild("territorio")
	local objetivo = plr:WaitForChild("pieces")
	local clone = frames[plr]
	local clone2 = frames2[plr]

	if territorio.Value ~= "Nenhum" and not clone then
		clone = mainFrame:Clone()
		clone.Parent = script.Parent
		clone.Visible = true
		clone.Name = plr.Name

		local nome = clone.player:FindFirstChild("nomeDoJogador")
		if nome then nome.Text = plr.Name end

		local label = clone:FindFirstChild("Territórios") or clone:FindFirstChild("Territorios")
		if label then
			label.RichText = true
			label.Text = colorirTexto(territorio.Value)
		end

		local objetivoLabel = clone:FindFirstChild("TemObjetivo")
		if objetivoLabel then
			objetivoLabel.Text = "Peças Posicionadas: " .. objetivo.Value
		end

		frames[plr] = clone

	elseif territorio.Value == "Nenhum" and clone then
		clone:Destroy()
		frames[plr] = nil

	elseif clone then
		local label = clone:FindFirstChild("Territórios") or clone:FindFirstChild("Territorios")
		if label then
			label.RichText = true
			label.Text = colorirTexto(territorio.Value)
		end
	end

	if territorio.Value ~= "Nenhum" and not clone2 then
		clone2 = mainFrame2:Clone()
		clone2.Parent = game.Workspace.trocasUI.SurfaceGui.Frame
		clone2.Visible = true
		clone2.Name = plr.Name

		local nome = clone2:FindFirstChild("nomeDoJogador")
		if nome then nome.Text = plr.Name end

		frames2[plr] = clone2

	elseif territorio.Value == "Nenhum" and clone2 then
		clone2:Destroy()
		frames2[plr] = nil

	elseif clone2 then
		local nome = clone2:FindFirstChild("nomeDoJogador")
		if nome then nome.Text = plr.Name end
	end

	atualizarPortador()
	atualizarIcone()
end

game.Players.PlayerAdded:Connect(function(plr)
	local territorio = plr:WaitForChild("territorio")
	local objetivo = plr:WaitForChild("pieces")

	territorio.Changed:Connect(function()
		atualizarClone(plr)
	end)

	objetivo.Changed:Connect(function()
		local clone = frames[plr]
		if clone then
			local objetivoLabel = clone:FindFirstChild("TemObjetivo")
			if objetivoLabel then
				objetivoLabel.Text = "Peças Posicionadas: " .. objetivo.Value
			end
		end
	end)
end)

local prompt = game.Workspace.objetivos.ProximityPrompt
prompt.Triggered:Connect(function(plr)
	liberados[plr] = true
	atualizarClone(plr)
	task.wait(0.1)
	atualizarPortador()
end)

game.Workspace.resetObjetivos.resetButton.ProximityPrompt.Triggered:Connect(function()
	frames = {} 
	frames2 = {} 
	atualizarPortador()
	atualizarIcone()
end)