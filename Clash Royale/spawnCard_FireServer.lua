local debounce = true
local card = "knight"
local mod = require(game.ServerScriptService.cardSelectionModule)
local players = game:GetService("Players")

script.Parent.Touched:Connect(function(plr)
	if debounce == true then
		debounce = false
		plr = plr.Parent
		if plr then
			mod.spawnCard(plr, card)
			wait(1)
			debounce = true
		else
			wait(1)
			debounce = true
		end
	end
end)