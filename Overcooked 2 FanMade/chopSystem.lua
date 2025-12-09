local collectionservice = game:GetService("CollectionService")
local Debounce = false
local ModuleGetIngredient = require(game.ServerScriptService.module.get_ingredient)
local tools = 0

local function FacaDisappear(faca)
	for i, part in pairs(faca) do
		if part:IsA("Part") then
			if part.Transparency == 1 then
				part.Transparency = 0
			else
				part.Transparency = 1
			end
		end
	end
end

for i, Part in pairs(collectionservice:GetTagged("chop")) do
	local proximityPrompt = Part.ProximityPrompt
	local chopPlate = proximityPrompt.Parent.Parent.ChopPlate
	proximityPrompt.Triggered:Connect(function(plr)
		local backpack = plr:FindFirstChild("Backpack")
		local character = plr.Character
		if character then
			for _, tool in pairs(character:GetChildren()) do
				local toolname
				if tool:IsA("Tool") then
					for i, CheckedTool in pairs(game.ReplicatedStorage.tools.ingredientes:GetChildren()) do
						if CheckedTool.Name == tool.Name then
							toolname = tool.Name
							Debounce = true
							tool:Destroy()
						end
					end
					if Debounce == true then
						Debounce = false
						for i, ingredient in pairs(game.ReplicatedStorage.tools.ingredientes:GetChildren()) do
							if ingredient.Name == toolname then
								local clone = ingredient:Clone()
								clone.Parent = chopPlate.Parent
								if clone:IsA("Model") and clone.PrimaryPart then
									clone:SetPrimaryPartCFrame(chopPlate.CFrame)
									clone.PrimaryPart.Anchored = true
									local faca = proximityPrompt.Parent.Parent.Faca:GetChildren()
									FacaDisappear(faca)
									local chopActionButton = Instance.new("ProximityPrompt")
									chopActionButton.Parent = ingredient
									local ProximiChop = Instance.new("ProximityPrompt")
									ProximiChop.Parent = Part
									ProximiChop.RequiresLineOfSight = false
									ProximiChop.HoldDuration = 4

									ProximiChop.Triggered:Connect(function()
										clone:Destroy()
										for i, ChoppedIngredient in pairs(game.ReplicatedStorage.tools.ingredientes.Stages.Chopped:GetChildren()) do
											if ChoppedIngredient.Name == ingredient.Name.."Chopped" then
												local ChoppedClone = ChoppedIngredient:Clone()
												ChoppedClone.Parent = chopPlate.Parent
												ChoppedClone:SetPrimaryPartCFrame(chopPlate.CFrame)
												ChoppedClone.PrimaryPart.Anchored = true
												local proximiCollectChop = Instance.new("ProximityPrompt")
												proximiCollectChop.Parent = Part
												proximiCollectChop.RequiresLineOfSight = false
												ProximiChop:Destroy()
												proximityPrompt.Enabled = false

												proximiCollectChop.Triggered:Connect(function(plr)
													tools = 0
													local character = plr.Character
													if character then
														for _, tool in pairs(character:GetChildren()) do
															if tool:IsA("Tool") then
																tools += 1
															end
															if tools > 1 then
																tool:Destroy() 
															end
														end
													end
													for _, tool in pairs(backpack:GetChildren()) do
														if tool:IsA("Tool") then
															tools += 1
														end
													end
													if tools == 0 then
														ModuleGetIngredient.GetIngredient(plr, ingredient.Name, "Chopped")
														proximityPrompt.Enabled = true
														Debounce = true
														FacaDisappear(faca)
														ChoppedClone:Destroy()
														proximiCollectChop:Destroy()
													end
												end)												
											end
										end
									end)
								end
							end
						end
					end
				end
			end
		end
	end)
end