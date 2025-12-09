local remote = game.ReplicatedStorage.remoteEvents.spawnPiece
local lastCframe = nil
script.Parent.Activated:Connect(function()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()

	local piece = nil
	for _, p in ipairs(game.ReplicatedStorage["peças"]:GetChildren()) do
		if p.Name == script.Parent.Name then
			piece = p
			break
		end
	end

	if piece then
		local mod = require(game.ReplicatedStorage.mainModule)
		local finalCFrame = mod.getCFramePiece(piece, character)
		if lastCframe ~= finalCFrame then
			remote:FireServer(piece, finalCFrame)
		end
		lastCframe = finalCFrame
	end
end)
