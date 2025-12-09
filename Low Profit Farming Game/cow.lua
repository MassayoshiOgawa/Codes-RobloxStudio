-- Scripts contained in this game are old.
-- If i could do it all over i would make it better with the new skills i know now.
-- But, atleast appreciate all the hardwork.

local players = game:GetService("Players")
local collectionservice = game:GetService("CollectionService")
local popupModule = require(game.ServerScriptService.PopUpService.popupmessage)

local function HPregeneration(hpbar, billboard, timemax, hitbox)
	local hp = timemax
	billboard.Enabled = true
	hitbox.CanCollide = false
	hitbox.Transparency = 1

	repeat
		hpbar.Text = tostring(hp)
		hp -= 1
		wait(1)
	until hp <= 0

	hpbar.Text = ""
	billboard.Enabled = false
	hitbox.CanCollide = true
	hitbox.Transparency = 1
end

for _, Part in pairs(collectionservice:GetTagged("vaca")) do
	local click = Part:FindFirstChild("ClickDetector")
	local hpbar = Part:FindFirstChild("BillboardGui") and Part.BillboardGui:FindFirstChild("TextLabel")
	local billboard = Part:FindFirstChild("BillboardGui")
	local hitbox = Part
	hitbox.Transparency = 1

	if click and hpbar and billboard then
		click.MouseClick:Connect(function(player)
			local character = player.Character
			local leaderstats = player:FindFirstChild("leaderstats")
			if not leaderstats then
				warn("Leaderstats não encontrado para o jogador:", player.Name)
				return
			end

			local garrafa = leaderstats:FindFirstChild("Garrafa")
			local leite = leaderstats:FindFirstChild("Leite")

			if not garrafa or not leite then
				warn("Garrafa ou Leite não encontrados em leaderstats:", player.Name)
				return
			end

			if garrafa.Value >= 1 and not billboard.Enabled then
				garrafa.Value = garrafa.Value - 1
				leite.Value = leite.Value + 1
				task.spawn(function()
					HPregeneration(hpbar, billboard, 200, hitbox)
				end)
			else
				print("Ta faltando coisa")
				popupModule.PopUpMessageFrame(player, "Para pegar leite, é necessário ter no mínimo uma garrafa no inventário.", 1)
			end
		end)
	else
		warn("Configuração incompleta na parte:", Part.Name)
	end
end
