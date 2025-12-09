local textBox = script.Parent.quantidadeTextBox
local storeButton = script.Parent.store
local item = script.Parent.item.Value
local plr = game.Players.LocalPlayer
local mod = require(game.ReplicatedStorage.moduleScripts.itens)

local function setPlaceholder(text, color)
	textBox.Text = ""
	local oldText, oldColor = textBox.PlaceholderText, textBox.PlaceholderColor3
	textBox.PlaceholderText = text
	textBox.PlaceholderColor3 = color
	task.wait(2)
	textBox.PlaceholderText = oldText
	textBox.PlaceholderColor3 = oldColor
end

local function erroLess(input)
	setPlaceholder("You have less than "..tostring(input)..".", Color3.fromRGB(255, 0, 0))
end

local function erroLessThanZero()
	setPlaceholder("Do not use negative numbers.", Color3.fromRGB(255, 0, 0))
end

local function erroNotNum()
	setPlaceholder("Do not type any characters.", Color3.fromRGB(255, 0, 0))
end

local function sucesso(input)
	local engName = mod.getEngName(item)
	setPlaceholder("Successfully stored "..input.." "..engName, Color3.fromRGB(0, 255, 0))
end

storeButton.MouseButton1Click:Connect(function()
	local qunt = tonumber(textBox.Text)
	item = script.Parent.item.Value
	if qunt then
		qunt = math.floor(qunt)
		local quantidadeDisponivel = plr:GetAttribute(item)
		if quantidadeDisponivel and qunt > 0 and qunt <= quantidadeDisponivel then
			sucesso(qunt)
			game.ReplicatedStorage.RemoteEvents.stash.retirar:FireServer(item, qunt)
		else
			if qunt < 0 then
				erroLessThanZero()
			else
				erroLess(qunt)
			end
		end
	elseif textBox.Text ~= "" then
		erroNotNum()
	end
end)
