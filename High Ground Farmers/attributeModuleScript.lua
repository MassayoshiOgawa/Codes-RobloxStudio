local Players = game:GetService("Players")
local player = Players.LocalPlayer

local module = {}

module.chngserver = function(player, nomeAtt, value)
	player:SetAttribute(nomeAtt, (player:GetAttribute(nomeAtt) or 0) + value)
end

module.getserver = function(player, nomeAtt)
	if player:GetAttribute(nomeAtt) == nil then
		player:SetAttribute(nomeAtt, 0)
	end
	return player:GetAttribute(nomeAtt)
end

return module