local itemFrameSeed = game.ReplicatedStorage.frames.stash.itemFrameSeed
local itemFrameNormal = game.ReplicatedStorage.frames.stash.itemFrame
local mod = require(game.ReplicatedStorage.moduleScripts.itens)
local frameDebounce = {}

local function attFrames()
	local player = game.Players.LocalPlayer
	local atributos = player:GetAttributes()

	for nome, valor in pairs(atributos) do
		if string.sub(nome, 1, 4) ~= "Bau_" then
			local nomeFinal = nome

			if valor == 0 and frameDebounce[nomeFinal] then
				frameDebounce[nomeFinal]:Destroy()
				frameDebounce[nomeFinal] = nil
			end

			if valor > 0 and not frameDebounce[nomeFinal] then
				local frameParaUsar = itemFrameNormal
				if string.sub(nomeFinal, 1, 7) == "Semente" then
					frameParaUsar = itemFrameSeed
				end

				local clone = frameParaUsar:Clone()
				clone.Name = nome
				clone.Parent = script.Parent

				local id = mod.getIcon(nomeFinal)
				clone.icone.Image = "rbxassetid://" .. id

				if clone:FindFirstChild("quantidade") then
					clone.quantidade.Text = tostring(valor)
				end

				frameDebounce[nomeFinal] = clone
				if id == 73613792471508 then
					frameDebounce[nomeFinal]:Destroy()
					frameDebounce[nomeFinal] = nil
				end
			end
			
		end
	end
end

while true do
	task.wait(1)
	attFrames()
end
