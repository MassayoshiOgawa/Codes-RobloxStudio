local towerFolder = game.ServerStorage.towerFolder
local arenaTowerFolder = game.Workspace.ArenaFolder.ArenaModel.towers
local players = game:GetService("Players")
local matchEnding = false

local function rewardPlayer(plr)
	plr:WaitForChild("leaderstats"):WaitForChild("Trophies").Value += math.random(28, 31)
	if plr:WaitForChild("leaderstats"):WaitForChild("Trophies").Value > game.Workspace:WaitForChild("gameValues"):WaitForChild("max_trophies").Value then
		plr:WaitForChild("leaderstats"):WaitForChild("Trophies").Value = 15000
	end
end

local function towerGotDestroyed(teamOfTheTower, tower)
	tower:Destroy()
	if tower.Name == "RedKingTower" or tower.Name == "BlueKingTower" then
		if teamOfTheTower:lower() == "red" then
			endMatch("Blue")
		else
			endMatch("Red")
		end
	end
end

function connectTowerEvents()
	for _, folder in pairs(arenaTowerFolder:GetChildren()) do
		if folder:IsA("Folder") then
			for _, tower in pairs(folder:GetChildren()) do
				if tower:IsA("Model") then
					local humanoid = tower:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.Died:Connect(function()
							towerGotDestroyed(folder.Name, tower)
						end)
					end
				end
			end
		end
	end
end

function startMatch()
	for _, folder in pairs(arenaTowerFolder:GetChildren()) do
		if folder:IsA("Folder") then
			for _, tower in pairs(folder:GetChildren()) do
				if tower:IsA("Model") then
					tower:Destroy()
				end
			end
		end
	end

	for _, folder in pairs(arenaTowerFolder:GetChildren()) do
		if folder:IsA("Folder") then
			for _, positionPart in pairs(folder:GetChildren()) do
				if positionPart:IsA("Part") then
					local teamFolder = towerFolder:FindFirstChild(folder.Name:sub(1,1):upper() .. folder.Name:sub(2))
					if teamFolder then
						for _, tower in pairs(teamFolder:GetChildren()) do
							if tower.Name == positionPart.Name then
								local clone = tower:Clone()
								clone:SetPrimaryPartCFrame(positionPart.CFrame)
								clone.Parent = folder
							end
						end
					end
				end
			end
		end
	end

	connectTowerEvents()
end

function endMatch(victoriousTeam)
	if matchEnding then return end
	matchEnding = true
	task.wait(5)
	for _, player in pairs(players:GetChildren()) do
		if player.Team.Name ~= "None" then
			if player.Team.Name == victoriousTeam then
				rewardPlayer(player)
			end
			game.Workspace:FindFirstChild("Lobby"):FindFirstChild("RoundSpawn").Enabled = true
			player.Team = nil
			player:LoadCharacter()
		end
	end
	startMatch()
	matchEnding = false
end

startMatch()
