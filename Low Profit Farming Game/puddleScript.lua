-- Scripts contained in this game are old.
-- If i could do it all over i would make it better with the new skills i know now.
-- But, atleast appreciate all the hardwork.

local collectionservice = game:GetService("CollectionService")
local players = game:GetService("Players")

for i, part in pairs(collectionservice:GetTagged("poço")) do
	if part.Name == "aguadopoço" or part.Name == "lagoaguadopoço" then
		part.Touched:Connect(function(hit)
			local character = hit.Parent
			local player = players:GetPlayerFromCharacter(character)

			if player then
				local leaderstats = player:FindFirstChild("leaderstats")
				if leaderstats then
					local Agua = leaderstats:FindFirstChild("Agua")
					local regadormaxcap = leaderstats:FindFirstChild("statusregadorcapacity")

					if Agua then
						local tool = character:FindFirstChildOfClass("Tool")
						local maxcap = 100 + regadormaxcap.Value * 2

						if tool and tool.Name == "Regador" and Agua.Value < maxcap then
							Agua.Value = Agua.Value + 26
							print("Adicionado agua, novo valor:", Agua.Value)
						end
						
						if Agua.Value > maxcap then
							Agua.Value = maxcap
						end
				
					end
				end
			end
		end)
	end
end
