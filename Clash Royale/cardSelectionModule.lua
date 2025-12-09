local cards = {
	["knight"] = {
		elixir = 3,
		hp = 3464,
		walkspeed = 12,
		walkanim = "rbxassetid://137178784455771",
		idleanim = "rbxassetid://77718556544425",
		trophiesNeeded = 0,
		usesToTurnEvo = 0,
		tool = {"ClassicSword"}
	},
	["firecracker"] = {
		elixir = 3,
		hp = 442,
		walkspeed = 14,
		walkanim = "rbxassetid://130724698946985",
		idleanim = "rbxassetid://120742328312914",
		trophiesNeeded = 0,
		usesToTurnEvo = 2,
		tool = {"RocketLauncher"}
	},
	["guards"] =  {
		elixir = 3,
		hp = 1979,
		walkspeed = 12,
		trophiesNeeded = 0,
		usesToTurnEvo = 0,
		tool = nil -- this card isnt done yet
	},
	["minipekka"] =  {
		elixir = 4,
		hp = 1979,
		walkspeed = 12,
		walkanim = "rbxassetid://99788604623912",
		idleanim = "rbxassetid://109305377498306",
		trophiesNeeded = 0,
		usesToTurnEvo = 0,
		tool = {"MiniPekka"}
	},
	["infernotower"] =  {
		elixir = 5,
		hp = 3464,
		walkspeed = 12,
		trophiesNeeded = 0,
		usesToTurnEvo = 0,
		tool = nil -- this card isnt done yet
	},
	["gigaskelet"] =  {
		elixir = 6,
		hp = 3464,
		walkspeed = 10,
		trophiesNeeded = 0,
		idleanim = "rbxassetid://74019457031979",
		walkanim = "rbxassetid://123417918535408",
		usesToTurnEvo = 0,
		tool = {"GigaSkelet"}
	},
	["pekka"] =  {
		elixir = 7,
		hp = 3464,
		walkspeed = 5,
		trophiesNeeded = 0,
		usesToTurnEvo = 1,
		tool = {"PEKKA"}
	},
	["megaknight"] =  {
		elixir = 7,
		hp = 3464,
		walkspeed = 7,
		trophiesNeeded = 0,
		usesToTurnEvo = 1,
		tool = {"Combat", "MegaJump"}
	},
	["golem"] =  {
		elixir = 8,
		hp = 8464,
		walkspeed = 4,
		trophiesNeeded = 0,
		usesToTurnEvo = 1,
		tool = {"Golem"}
	}
}

local module = {}

module.spawnCard = function(plr, cardName)
	local plrCharacter = plr
	plr = game:GetService("Players"):GetPlayerFromCharacter(plr)
	local leaderstats = plr:FindFirstChild("leaderstats")
	if not cards[cardName] then return end
	local plrteam = plr.Team.Name
	if plrteam ~= "Blue" and plrteam ~= "Red" then return end
	local elixir
	local teamID
	local spawnBlock
	if plrteam == "Blue" then
		elixir = game.Workspace.gameValues.elixir_blue
		spawnBlock = game.Workspace.ArenaFolder.ArenaModel.TeamArenaSpawn_Blue
		teamID = "BL"
	else
		elixir = game.Workspace.gameValues.elixir_red
		spawnBlock = game.Workspace.ArenaFolder.ArenaModel.TeamArenaSpawn_Red
		teamID = "RD"
	end
	local card = cards[cardName]
	if leaderstats:FindFirstChild("Trophies").Value < card["trophiesNeeded"] then return end
	if elixir.Value < card.elixir then return end
	elixir.Value -= card.elixir
	local morphFolder = game.ServerStorage.morphs.not_evo
	local toolFolder = game.ServerStorage.Weapons.not_evo
	if not plr:GetAttribute("evo_" .. cardName) and card["usesToTurnEvo"] > 0 then
		plr:SetAttribute("evo_" .. cardName, 1)
	else
		if plr:GetAttribute("evo_" .. cardName) then
			if plr:GetAttribute("evo_" .. cardName) >= card["usesToTurnEvo"] then
				plr:SetAttribute("evo_" .. cardName, 0)
				morphFolder = game.ServerStorage.morphs.evo
				toolFolder = game.ServerStorage.Weapons.evo
			else
				plr:SetAttribute("evo_" .. cardName, plr:GetAttribute("evo_" .. cardName) + 1)
			end
		end
	end
	if morphFolder:FindFirstChild(cardName .. teamID) then	
		local charClone = morphFolder:FindFirstChild(cardName .. teamID):Clone()
		charClone.Name = plr.Name
		plr.Character = charClone
		charClone.Parent = workspace
		local rootPart = charClone:FindFirstChild("HumanoidRootPart") or charClone:FindFirstChild("Torso")
		local plrRoot = plrCharacter:FindFirstChild("HumanoidRootPart") or plrCharacter:FindFirstChild("Torso")
		if rootPart and plrRoot then
			rootPart.CFrame = plrRoot.CFrame
		end
	end
	if card.tool ~= nil then
		for _, toolName in ipairs(card.tool) do
			local tool = toolFolder:FindFirstChild(toolName .. teamID)
			if tool then
				local toolClone = tool:Clone()
				toolClone.Parent = plr.Backpack
			end
		end
	end
	if spawnBlock then
		local character = plr.Character
		if character then
			character:PivotTo(spawnBlock.CFrame + Vector3.new(0, 3, 0))
		end
	end
	local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local Animate = humanoid.Parent.Animate 
		if Animate then
			if card["walkanim"] then
				local walk = Animate.walk.WalkAnim 
				walk.AnimationId = card["walkanim"]
			end
			if card["idleanim"] then
				local idle = Animate.idle.Animation1
				idle.AnimationId = card["idleanim"]
			end
			local toolnone = Animate.toolnone.ToolNoneAnim
			toolnone.AnimationId = "rbxassetid://96539026852508" 
		end
		humanoid.MaxHealth = card["hp"]
		humanoid.Health = card["hp"]
		humanoid.WalkSpeed = card["walkspeed"]
	end
end

return module
