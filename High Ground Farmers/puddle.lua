local collectionservice = game:GetService("CollectionService")
local players = game:GetService("Players")
local mod = require(game.ServerScriptService.ModuleScripts.atributoFolder.atributo)

for i, part in pairs(collectionservice:GetTagged("poço")) do
	if part.Name == "aguadopoço" or part.Name == "lagoaguadopoço" then
		part.Touched:Connect(function(hit)
			local character = hit.Parent
			local player = players:GetPlayerFromCharacter(character)

			if player then
				local Agua = mod.getserver(player, "Agua")
				local regadormaxcap = mod.getserver(player, "StatusRegadorCapacity")

				if Agua and regadormaxcap then
					local tool = character:FindFirstChildOfClass("Tool")
					local maxcap = 100 + regadormaxcap * 2

					if tool and tool.Name == "Regador" and Agua < maxcap then
						local novoValor = math.min(Agua + 26, maxcap)
						mod.chngserver(player, "Agua", novoValor)
						print("Adicionado água, novo valor:", novoValor)
					end
				end
			end
		end)
	end
end
