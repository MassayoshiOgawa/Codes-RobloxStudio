while true do
	task.wait(1)

	local tablee = {}
	local parentFrame = script.Parent.Parent.Frame

	for _, frame in ipairs(parentFrame:GetChildren()) do
		if frame.Name ~= "dont" and frame.Name ~= "playerFrame" then
			table.insert(tablee, frame.Name)
		end
	end

	local seen = {}
	for _, frame in ipairs(parentFrame:GetChildren()) do
		if frame.Name ~= "dont" and frame.Name ~= "playerFrame" then
			if seen[frame.Name] then
				frame:Destroy() 
			else
				seen[frame.Name] = true 
			end
		end
	end
end
