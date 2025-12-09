local CollectionService = game:GetService("CollectionService")
local coresNeutras = {
	"Black", "Really black", "Dark stone grey", "Medium stone grey", "Smoky grey",
	"Brown", "Reddish brown", "Dirt brown", "Brick yellow", "Taupe", "Cork", "Grey", "Dark taupe"
}

local function ehCorNeutra(cor)
	for _, nome in ipairs(coresNeutras) do
		if cor.Name == nome then
			return true
		end
	end
	return false
end

local function corAleatoriaViva()
	local cor
	repeat
		cor = BrickColor.random()
	until not ehCorNeutra(cor)
	return cor
end

local function aplicarCorAleatoria(flor)
	local cor = corAleatoriaViva()
	for _, part in pairs(flor:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
			if part.Name == "flor1" or part.Name == "flor2" or part.BrickColor.Name == "Deep orange" then
				part.BrickColor = cor
			end
		end
	end
end

for _, flor in ipairs(CollectionService:GetTagged("flor")) do
	aplicarCorAleatoria(flor)
end

CollectionService:GetInstanceAddedSignal("flor"):Connect(function(flor)
	aplicarCorAleatoria(flor)
end)
