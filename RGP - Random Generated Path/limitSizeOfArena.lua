-- This game is a script testing, so expect to see some wierd things

local r = game.ReplicatedStorage.ChangePlatLimitSize

local fb = r.fb
local bb = r.bb
local lb = r.lb
local rb = r.rb

fb.OnServerEvent:Connect(function(plr, x)
	local chang = 20 * x
	print(x)
	local frb = game.Workspace.Blockers.FrontBlock
	frb.Position = Vector3.new(frb.Position.X, frb.Position.Y, frb.Position.Z + chang)
end)

bb.OnServerEvent:Connect(function(plr, x)
	local chang = 20 * x * -1
	local frb = game.Workspace.Blockers.BackBlock
	frb.Position = Vector3.new(frb.Position.X, frb.Position.Y, frb.Position.Z + chang)
end)

lb.OnServerEvent:Connect(function(plr, x)
	local chang = 20 * x
	local frb = game.Workspace.Blockers.LeftBlock
	frb.Position = Vector3.new(frb.Position.X + chang, frb.Position.Y, frb.Position.Z)
end)

rb.OnServerEvent:Connect(function(plr, x)
	local chang = 20 * x * -1
	local frb = game.Workspace.Blockers.RightBlock
	frb.Position = Vector3.new(frb.Position.X + chang, frb.Position.Y, frb.Position.Z)
end)