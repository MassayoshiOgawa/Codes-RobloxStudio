-- Scripts contained in this game are old.
-- If i could do it all over i would make it better with the new skills i know now.
-- But, atleast appreciate all the hardwork.

local players = game:GetService("Players")
local collectionservice = game:GetService("CollectionService")
local popupModule = require(game.ServerScriptService.PopUpService.popupmessage)

local function HPregeneration(hpbar, billboard, hitbox, hp)
	repeat
		hpbar.Text = tostring(hp)
		hp -= 1
		wait(1)
	until hp <= 0

	hpbar.Text = ""
	billboard.Enabled = false
	hitbox.Transparency = 1
	hitbox.CanCollide = false
end

for _, Part in pairs(collectionservice:GetTagged("galinha")) do
	local click = Part:FindFirstChild("ClickDetector")
	local hpbar = Part:FindFirstChild("BillboardGui") and Part.BillboardGui:FindFirstChild("TextLabel")
	local billboard = Part:FindFirstChild("BillboardGui")
	local hitbox = Part
	local hp = 0
	local timemax = 200
	local eggdebounce = true

	if click and hpbar and billboard then
		hitbox.Transparency = 1
		hitbox.CanCollide = false
		billboard.Enabled = false

		click.MouseClick:Connect(function(player)
			local leaderstats = player:FindFirstChild("leaderstats")
			if leaderstats then
				local ovo = leaderstats:FindFirstChild("Ovo")
				if ovo and eggdebounce and hp == 0 then
					eggdebounce = false
					ovo.Value += 1
					hp = timemax
					billboard.Enabled = true
					hitbox.CanCollide = true
					local teibou = 124020434399705
					popupModule.PopUpMessageFrame(player, teibou, 2)

					task.spawn(function()
						HPregeneration(hpbar, billboard, hitbox, hp)
						eggdebounce = true
					end)
				end
			else
				warn("Leaderstats não encontrado para o jogador:", player.Name)
			end
		end)
	else
		warn("Configuração incompleta na parte:", Part.Name)
	end
end
