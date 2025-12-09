-- This game is a script testing, so expect to see some wierd things

if not _G.minigametype then
	_G.minigametype = 1
end
_G.waitTimeToGeneratePlat = 0.04
wait(2)
local Plat = script.Parent
local KeepRunningSys = true
local UpCooldown = 0
local L, R, F, B, U, D = 0, 0, 0, 0, 0, 0
local PlatCloneData = game.ReplicatedStorage.PlatCloned
local eventRestart = game.ReplicatedStorage.Restart
local eventSize = game.ReplicatedStorage.ChangeSize

local PlatPosX
local PlatPosZ

local lb = game.Workspace.Blockers.LeftBlock.Position.X
local rb = game.Workspace.Blockers.RightBlock.Position.X
local fb = game.Workspace.Blockers.FrontBlock.Position.Z
local bb = game.Workspace.Blockers.BackBlock.Position.Z

if not _G.Altura then
	_G.Altura = 0
end

if not _G.Qunt then
	_G.Qunt = 0
end

-- %%%%%% minigametype 2 variables %%%%%
_G.reporTempo = 0
local RemainingBlocksCalcTempo = 0
-- %%%%%%%%%% minigametype 4 and 5 %%%%%
local AvoidBreakingMiniGameFive = 1
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

local function ClonePlat(PlatClone, PlatPosition)
	local newClone = PlatClone:Clone()
	newClone.Parent = game.Workspace
	newClone.Position = PlatPosition
	
	if _G.minigametype == 3 or _G.minigametype == 5 then
		local decisao = math.random(1, 5)
		if decisao == 1 then
			if _G.minigametype == 3 then
				newClone.Transparency = 0.7
				newClone.CanCollide = false
			elseif _G.minigametype == 5 and AvoidBreakingMiniGameFive >= 1 then
				newClone.Transparency = 0.7
				newClone.CanCollide = false
				AvoidBreakingMiniGameFive = 2
			end
		end
	end

	if _G.minigametype == 4 or _G.minigametype == 5 then
		local decisao = math.random(1, 7)
		if decisao == 1 then
			if AvoidBreakingMiniGameFive >= 1 and _G.minigametype == 5 then
				AvoidBreakingMiniGameFive = 1
				newClone.Color = Color3.new(1, 0.192157, 0.117647)
				newClone.Touched:Connect(function(hit)
					local character = hit.Parent
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")

					if humanoid then
						humanoid.Health = 0
					end
				end)
			elseif _G.minigametype == 4 then
				newClone.Color = Color3.new(1, 0.192157, 0.117647)
				newClone.Touched:Connect(function(hit)
					local character = hit.Parent
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")

					if humanoid then
						humanoid.Health = 0
					end
				end)
			end
		end
	end
	
end

local function WhichSideAvaliable(PCframe, Pposition)
	local offsets = {
		Left = Vector3.new(-4, 0, 0),  
		Right = Vector3.new(4, 0, 0),  
		Front = Vector3.new(0, 0, -4), 
		Back = Vector3.new(0, 0, 4),
		Up = Vector3.new(0, 4, 0),
		Down = Vector3.new(0, -4, 0)
	}

	for side, offset in pairs(offsets) do
		local checkPosition = PCframe.Position + offset
		local found = false
		if checkPosition.Z < fb or checkPosition.Z > bb or checkPosition.X > rb or checkPosition.X < lb then
			found = true
		else
			for _, obj in pairs(workspace:GetDescendants()) do
				if obj:IsA("Part") and (obj.Position - checkPosition).Magnitude < 0.1 then
					found = true
					break
				end
			end
		end

		if found then
			if side == "Front" then
				F = 1
			elseif side == "Right" then
				R = 1
			elseif side == "Back" then
				B = 1
			elseif side == "Left" then
				L = 1
			elseif side == "Up" then
				U = 1
			elseif side == "Down" then
				D = 1
			end
		end
	end
end

local PlatCframe = Plat.CFrame
local PlatPosition = Plat.Position

local function GetOfFromBroke()
	print("Quebrou!")
	KeepRunningSys = false  -- Pausa o sistema

	while L+R+B+F+U+D == 6 do
		wait(0.2)
		WhichSideAvaliable(Plat, Plat.Position)
	end

	print("Liberado novamente!")
	KeepRunningSys = true  -- Volta a rodar o sistema
end

local function PlaceWork()
	L, R, F, B, U, D = 0, 0, 0, 0, 0, 0
	PlatCframe = Plat.CFrame
	PlatPosition = Plat.Position
	WhichSideAvaliable(PlatCframe, PlatPosition)

	if L+R+B+F+U+D == 6 then
		GetOfFromBroke()
	end

	if not KeepRunningSys then return end -- Se estiver bloqueado, não continua

	local Decided = false
	local SidePicked = "Nil"
	local PassIfCantGoAnywhere = 0
	local WhichSideItPicked

	repeat
		WhichSideItPicked = math.random(1, 6)
		if WhichSideItPicked == 1 and L == 0 then
			Decided = true
			SidePicked = "Left"
			UpCooldown -= 1
		elseif WhichSideItPicked == 2 and R == 0 then
			Decided = true
			SidePicked = "Right"
			UpCooldown -= 1
		elseif WhichSideItPicked == 3 and F == 0 then
			Decided = true
			SidePicked = "Front"
			UpCooldown -= 1
		elseif WhichSideItPicked == 4 and B == 0 then
			Decided = true
			SidePicked = "Back"
			UpCooldown -= 1
		elseif WhichSideItPicked == 544 and U == 0 then
			if UpCooldown <= 0 then
				Decided = true
				SidePicked = "Up"
				UpCooldown = 3
			end
			UpCooldown -= 1
		elseif WhichSideItPicked == 644 and D == 0 and Plat.Position.Y > 50 then
			Decided = true
			SidePicked = "Down"
		end
		PassIfCantGoAnywhere += 1
	if L+R+F+B == 4 then
		Decided = true
		SidePicked = "Up"
	end
	until Decided or PassIfCantGoAnywhere >= 6 or L+R+F+B == 4
	
	
	
	if not KeepRunningSys then return end -- Se estiver bloqueado, não continua

	local PlatClone = PlatCloneData
	local PlatDecision = math.random(1, 100)
	if PlatDecision == 1 and _G.Qunt < 0 then
		_G.Qunt += 1
		PlatClone = game.ReplicatedStorage:WaitForChild("PlatScript")
	end

	local moveVector = {
		Left = Vector3.new(-4, 0, 0),
		Right = Vector3.new(4, 0, 0),
		Front = Vector3.new(0, 0, -4),
		Back = Vector3.new(0, 0, 4),
		Up = Vector3.new(0, 4, 0),
		Down = Vector3.new(0, -4, 0)
	}

	if moveVector[SidePicked] then
		ClonePlat(PlatClone, PlatPosition)
		Plat.Position = Plat.Position + moveVector[SidePicked]
		_G.Altura = Plat.Position.Y
		PlatPosition = Plat.Position -- Atualiza a posição antes de mover
		PlatPosX = PlatPosition.X
		PlatPosZ = PlatPosition.Z
		Plat.Position = Vector3.new(PlatPosX, _G.Altura, PlatPosZ)
	end
end

local MiniGameResetVariable = 1
local function StartLoop()
	while KeepRunningSys == true do
		if KeepRunningSys == true then
			if _G.minigametype == 1 then
				MiniGameResetVariable = 1
				wait(_G.waitTimeToGeneratePlat)
				lb = game.Workspace.Blockers.LeftBlock.Position.X
				rb = game.Workspace.Blockers.RightBlock.Position.X
				fb = game.Workspace.Blockers.FrontBlock.Position.Z
				bb = game.Workspace.Blockers.BackBlock.Position.Z
				PlaceWork()
			elseif _G.minigametype == 2 then
				if MiniGameResetVariable ~= 2 then
					MiniGameResetVariable = 2
					_G.Tempo = 14
					KeepRunningSys = false
					Plat.Position = Vector3.new(6, 1.5, 10)
					wait(6)
					KeepRunningSys = true
				end
				RemainingBlocksCalcTempo += 1
				if RemainingBlocksCalcTempo >= 35 then
					RemainingBlocksCalcTempo = 0
					if _G.Tempo > 5 then
						_G.Tempo -= 1
					end
				end
				if _G.reporTempo >= 13 then
					if _G.Tempo <= 9 then
						local decisao = math.random(1, 2)
						if decisao == 1 then
							_G.Tempo += 1
						else
							_G.Tempo += 2
						end
					end
					if _G.Tempo >= 15 then
						local decisao = math.random(1, 4)
						if decisao == 1 then
							_G.Tempo += 1
						else
							_G.Tempo -= 2
						end
					end
					print("Segundo aumentado!")
					_G.reporTempo = 0
				end
				wait(_G.waitTimeToGeneratePlat)
				lb = game.Workspace.Blockers.LeftBlock.Position.X
				rb = game.Workspace.Blockers.RightBlock.Position.X
				fb = game.Workspace.Blockers.FrontBlock.Position.Z
				bb = game.Workspace.Blockers.BackBlock.Position.Z
				PlaceWork()
			elseif _G.minigametype == 3 or _G.minigametype == 4 or _G.minigametype == 5 then
				wait(_G.waitTimeToGeneratePlat)
				_G.Altura = Plat.Position.Y
				lb = game.Workspace.Blockers.LeftBlock.Position.X
				rb = game.Workspace.Blockers.RightBlock.Position.X
				fb = game.Workspace.Blockers.FrontBlock.Position.Z
				bb = game.Workspace.Blockers.BackBlock.Position.Z
				PlaceWork()
			end
		else
			wait(_G.waitTimeToGeneratePlat)
		end
	end
	return
end

local sizetype = 1
eventSize.OnServerEvent:Connect(function()
	if sizetype == 1 then
		Plat.Size = Vector3.new(4,1,4)
		sizetype = 2
		PlatCloneData.Size = Vector3.new(4,1,4)
	else
		Plat.Size = Vector3.new(4,4,4)
		sizetype = 1
		PlatCloneData.Size = Vector3.new(4,4,4)
	end
end)

eventRestart.OnServerEvent:Connect(function()
	
	_G.ReviveModelCooldown = 0
	if _G.minigametype == 2 then
		_G.Tempo = 14
	end
	
	KeepRunningSys = false
	
	for _, Part in ipairs(game.Workspace:GetChildren()) do
		if Part.Name == "PlatCloned" then
			Part:Destroy()
		end
		if Part.Name == "ReviveModelPp" or Part.Name == "ReviveModelTp" then
			for _, model in ipairs(Part:GetChildren()) do
				model:Destroy()
			end
		end
	end
	
	local NewPlatGenerator = script.Parent:Clone()
	NewPlatGenerator.Parent = game.Workspace
	NewPlatGenerator.Position = Vector3.new(6, 1.5, 10)
	Plat:Destroy()
	
	KeepRunningSys = true
end)
StartLoop()

