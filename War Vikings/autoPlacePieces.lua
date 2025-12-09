local workspace = game.Workspace
local localizacoesFolder = workspace:WaitForChild("paises")
local storageFolder = workspace:WaitForChild("pastaDeArmazenarCoisas"):WaitForChild("pieces"):WaitForChild("Soldado")
local pieceTemplate = game.ReplicatedStorage:WaitForChild("peças"):WaitForChild("Soldado")

local function trim(s) return (s and s:gsub("^%s+", ""):gsub("%s+$", "")) or "" end
local function sanitizeName(s) return (s or ""):gsub("%s+", "_"):gsub("[^%w_]", "") end

local function findChildInsensitive(parent, name)
	name = trim(name):lower()
	for _, c in ipairs(parent:GetChildren()) do
		if tostring(c.Name):lower() == name then
			return c
		end
	end
	return nil
end

local function parseTerritorios(valor)
	local territorios = {}
	if not valor or valor == "" or valor == "Nenhum" then return territorios end

	for bloco in string.gmatch(valor, "([^|]+)") do
		bloco = trim(bloco)
		local pais, cidades = string.match(bloco, "^(.-):%s*(.+)$")
		if pais and cidades then
			pais = trim(pais)
			for cidade in string.gmatch(cidades, "([^,]+)") do
				cidade = trim(cidade)
				if cidade ~= "" then
					table.insert(territorios, { pais = pais, cidade = cidade })
				end
			end
		end
	end
	return territorios
end

local colorMap = {
	black  = BrickColor.new("Really black"),
	yellow = BrickColor.new("New Yeller"),
	blue   = BrickColor.new("Really blue"),
	red    = BrickColor.new("Really red"),
	green  = BrickColor.new("Lime green"),
	white  = BrickColor.new("White"),
}

local function limparPecasDoPlayer(plr)
	for _, obj in ipairs(storageFolder:GetChildren()) do
		if type(obj.Name) == "string" and obj.Name == plr.Name then
			obj:Destroy()
		end
	end
end

local function posicionarPecasDoPlayer(plr)
	local valor = plr:FindFirstChild("territorio") and plr.territorio.Value
	if not valor or valor == "" or valor == "Nenhum" then
		return
	end

	limparPecasDoPlayer(plr)

	local territorios = parseTerritorios(valor)
	if #territorios == 0 then return end

	local cortime = plr:FindFirstChild("colorTeam") and plr.colorTeam.Value or "white"
	local brick = colorMap[cortime] or BrickColor.new("White")

	for _, info in ipairs(territorios) do
		local paisFolder = findChildInsensitive(localizacoesFolder, info.pais)
		if not paisFolder then
			warn(("posicionarPecas: país não encontrado '%s' (player %s)"):format(info.pais, plr.Name))
		else
			local territorioPart = findChildInsensitive(paisFolder, info.cidade)
			if not territorioPart then
				warn(("posicionarPecas: cidade não encontrada '%s' no país '%s' (player %s)"):format(info.cidade, paisFolder.Name, plr.Name))
			else
				local clone = pieceTemplate:Clone()
				clone.Name = plr.Name
				clone.Parent = storageFolder

				if not clone.PrimaryPart then
					local pp = clone:FindFirstChildWhichIsA("BasePart", true)
					if pp then clone.PrimaryPart = pp end
				end

				if clone.PrimaryPart then
					local rot = math.random(-45, 45)
					local randomRotation = CFrame.Angles(0, math.rad(rot), 0)

					clone:SetPrimaryPartCFrame(territorioPart.CFrame * randomRotation)

				else
					warn("Template não tem PrimaryPart: peça não posicionada para", clone.Name)
				end

				for _, desc in ipairs(clone:GetDescendants()) do
					if desc:IsA("BasePart") then
						desc.BrickColor = brick
					end
				end
			end
		end
	end
end

game.Players.PlayerAdded:Connect(function(plr)
	local debounce = true
	if not plr:FindFirstChild("territorio") then
		local sv = Instance.new("StringValue")
		sv.Name = "territorio"
		sv.Value = "Nenhum"
		sv.Parent = plr
	end
	if not plr:FindFirstChild("colorTeam") then
		local cv = Instance.new("StringValue")
		cv.Name = "colorTeam"
		cv.Value = "white"
		cv.Parent = plr
	end

	local last = nil
	local function onChanged()
		local regra = game.Workspace.valores.regras.colocarAutomatico		
		if debounce then debounce = false return end
		if regra.Value == true then
			local cur = plr.territorio.Value
			if cur == last then return end
			last = cur
			posicionarPecasDoPlayer(plr)
		end
	end

	plr:WaitForChild("territorio").Changed:Connect(onChanged)

end)

for _, plr in ipairs(game.Players:GetPlayers()) do
	task.spawn(function() game.Players.PlayerAdded:Wait() end) 
end

print("Script de posicionamento de peças carregado.")
