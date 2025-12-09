local CollectionService = game:GetService("CollectionService")

local estilos = {
	-- SAKURA
	{
		tronco = BrickColor.new("Burgundy"),
		folha = BrickColor.new("Carnation pink")
	},
	-- BÉTULA
	{
		tronco = BrickColor.new("Wheat"),
		folha = BrickColor.new("Earth green")
	},
	-- CARVALHO
	{
		tronco = BrickColor.new("Dark orange"),
		folha = BrickColor.new("Camo")
	},
	-- ABETO
	{
		tronco = BrickColor.new("Medium brown"),
		folha = BrickColor.new("Earth green")
	},
	-- YPÊ
	{
		tronco = BrickColor.new("Dark orange"),
		folha = BrickColor.new("Gold")
	}
}

local function aplicarEstiloArvore(model)
	local ypeChance = math.random(1, 100) == 1

	local decidido = false
	local estiloIndex = math.random(1, #estilos)
	local estilo = estilos[estiloIndex]

	repeat
		if ypeChance and estiloIndex == 5 then
			decidido = true
		elseif not ypeChance and estiloIndex == 5 then
			estiloIndex = math.random(1, #estilos)
			estilo = estilos[estiloIndex]
		elseif estiloIndex ~= 5 then
			decidido = true
		end
	until decidido

	local tronco, folhaum, folhadois
	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			if part.Name == "Tronco" then
				tronco = part
			elseif part.Name == "Folhaum" then
				folhaum = part
			elseif part.Name == "Folhadois" then
				folhadois = part
			end
		end
	end

	if tronco and folhaum and folhadois then
		tronco.BrickColor = estilo.tronco
		folhaum.BrickColor = estilo.folha
		folhadois.BrickColor = estilo.folha
	end
end


for _, arvore in pairs(CollectionService:GetTagged("arvore")) do
	aplicarEstiloArvore(arvore)
end

CollectionService:GetInstanceAddedSignal("arvore"):Connect(function(arvore)
	aplicarEstiloArvore(arvore)
end)
