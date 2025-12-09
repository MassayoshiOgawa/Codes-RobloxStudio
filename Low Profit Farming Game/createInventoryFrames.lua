-- Scripts contained in this game are old.
-- If i could do it all over i would make it better with the new skills i know now.
-- But, atleast appreciate all the hardwork.

local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")

local Stomato = leaderstats:WaitForChild("SementeTomato")
local Strigo = leaderstats:WaitForChild("SementeTrigo")
local Sabobora = leaderstats:WaitForChild("SementeAbobora")
local Smorango = leaderstats:WaitForChild("SementeMorango")

local tomatos = leaderstats:WaitForChild("Tomatos")
local trigos = leaderstats:WaitForChild("Trigos")
local aboboras = leaderstats:WaitForChild("Aboboras")
local morangos = leaderstats:WaitForChild("Morangos")

local massa = leaderstats.Massa
local garrafa = leaderstats.Garrafa
local ovo = leaderstats.Ovo
local leite = leaderstats.Leite
local pizza = leaderstats.Pizza
local queijo = leaderstats.Queijo
local Pao = leaderstats.Pao
local GarrafaDaAgua = leaderstats.GarrafaDaAgua

local moedas = leaderstats:WaitForChild("Moedas")
local diamantes = leaderstats:WaitForChild("Diamantes")

local agua = leaderstats:WaitForChild("Agua")
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
local STomatoDebounce = true
local STrigoDebounce = true
local SaboboraDebounce = true
local SmorangoDebounce = true

local TomatoDebounce = true
local TrigoDebounce = true
local AboboraDebounce = true
local MorangoDebounce = true

local CoinDebounce = true
local DiamanteDebounce = true

local MassaDebounce = true
local GarrafaDebounce = true
local OvoDebounce = true
local LeiteDebounce = true
local PizzaDebounce = true
local QueijoDebounce = true
local PaoDebounce = true
local GarrafaDaAguaDebounce = true

local AguaDebounce = true
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
local SementeTrigoFrame
local SementeTomatoFrame
local SementeAboboraFrame
local SementeMorangoFrame

local tomatoFrame
local TrigoFrame
local AboboraFrame
local MorangoFrame

local coinFrame
local diamanteFrame

local MassaFrame
local GarrafaFrame
local OvoFrame
local LeiteFrame
local PizzaFrame
local QueijoFrame
local PaoFrame
local GarrafaDaAguaFrame

local AguaFrame
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

wait(0.2)

local function checkframe()
	if Strigo.Value >= 1 and STrigoDebounce then
		STrigoDebounce = false
		SementeTrigoFrame = game.ReplicatedStorage.inventoryFrames.SementeTrigoFrame:Clone()
		SementeTrigoFrame.Parent = script.Parent.ScrollingFrame
	end
		if Strigo.Value < 1 and SementeTrigoFrame then
			SementeTrigoFrame:Destroy()
			STrigoDebounce = true
		end

	if Stomato.Value >= 1 and STomatoDebounce then
		STomatoDebounce = false
		SementeTomatoFrame = game.ReplicatedStorage.inventoryFrames.SementeTomatoFrame:Clone()
		SementeTomatoFrame.Parent = script.Parent.ScrollingFrame
	end
		if Stomato.Value < 1 and SementeTomatoFrame then
			SementeTomatoFrame:Destroy()
			STomatoDebounce = true
		end

	if Sabobora.Value >= 1 and SaboboraDebounce then
		SaboboraDebounce = false
		SementeAboboraFrame = game.ReplicatedStorage.inventoryFrames.SementeAboboraFrame:Clone()
		SementeAboboraFrame.Parent = script.Parent.ScrollingFrame
	end
	if Sabobora.Value < 1 and SementeAboboraFrame then
		SementeAboboraFrame:Destroy()
		SaboboraDebounce = true
	end
	
	if Smorango.Value >= 1 and SmorangoDebounce then
		SmorangoDebounce = false
		SementeMorangoFrame = game.ReplicatedStorage.inventoryFrames.SementeMorangoFrame:Clone()
		SementeMorangoFrame.Parent = script.Parent.ScrollingFrame
	end
	if Smorango.Value < 1 and SementeMorangoFrame then
		SementeMorangoFrame:Destroy()
		SmorangoDebounce = true
	end

	if agua.Value >= 1 and AguaDebounce then
		AguaDebounce = false
		AguaFrame = game.ReplicatedStorage.inventoryFrames.AguaFrame:Clone()
		AguaFrame.Parent = script.Parent.ScrollingFrame
	end
		if agua.Value < 1 and AguaFrame then
			AguaFrame:Destroy()
			AguaDebounce = true
		end

	if tomatos.Value >= 1 and TomatoDebounce then
		TomatoDebounce = false
		tomatoFrame = game.ReplicatedStorage.inventoryFrames.TomatoFrame:Clone()
		tomatoFrame.Parent = script.Parent.ScrollingFrame
	end
		if tomatos.Value < 1 and tomatoFrame then
			tomatoFrame:Destroy()
			TomatoDebounce = true
		end

	if trigos.Value >= 1 and TrigoDebounce then
		TrigoDebounce = false
		TrigoFrame = game.ReplicatedStorage.inventoryFrames.TrigoFrame:Clone()
		TrigoFrame.Parent = script.Parent.ScrollingFrame
	end
		if trigos.Value < 1 and TrigoFrame then
			TrigoFrame:Destroy()
			TrigoDebounce = true
		end
		
	if aboboras.Value >= 1 and AboboraDebounce then
		AboboraDebounce = false
		AboboraFrame = game.ReplicatedStorage.inventoryFrames.AboboraFrame:Clone()
		AboboraFrame.Parent = script.Parent.ScrollingFrame
	end
	if aboboras.Value < 1 and AboboraFrame then
		AboboraFrame:Destroy()
		AboboraDebounce = true
	end
	
	if morangos.Value >= 1 and MorangoDebounce then
		MorangoDebounce = false
		MorangoFrame = game.ReplicatedStorage.inventoryFrames.MorangoFrame:Clone()
		MorangoFrame.Parent = script.Parent.ScrollingFrame
	end
	if morangos.Value < 1 and MorangoFrame then
		MorangoFrame:Destroy()
		MorangoDebounce = true
	end

	if Pao.Value >= 1 and PaoDebounce then
		PaoDebounce = false
		PaoFrame = game.ReplicatedStorage.inventoryFrames.PaoFrame:Clone()
		PaoFrame.Parent = script.Parent.ScrollingFrame
	end
	if Pao.Value < 1 and PaoFrame then
		PaoFrame:Destroy()
		PaoDebounce = true
	end
	
	if GarrafaDaAgua.Value >= 1 and GarrafaDaAguaDebounce then
		GarrafaDaAguaDebounce = false
		GarrafaDaAguaFrame = game.ReplicatedStorage.inventoryFrames.GarrafaDaAguaFrame:Clone()
		GarrafaDaAguaFrame.Parent = script.Parent.ScrollingFrame
	end
	if GarrafaDaAgua.Value < 1 and GarrafaDaAguaFrame then
		GarrafaDaAguaFrame:Destroy()
		GarrafaDaAguaDebounce = true
	end

	if ovo.Value >= 1 and OvoDebounce then
		OvoDebounce = false
		OvoFrame = game.ReplicatedStorage.inventoryFrames.OvoFrame:Clone()
		OvoFrame.Parent = script.Parent.ScrollingFrame
	end
	if ovo.Value < 1 and OvoFrame then
		OvoFrame:Destroy()
		OvoDebounce = true
	end
	
	if garrafa.Value >= 1 and GarrafaDebounce then
		GarrafaDebounce = false
		GarrafaFrame = game.ReplicatedStorage.inventoryFrames.GarrafaFrame:Clone()
		GarrafaFrame.Parent = script.Parent.ScrollingFrame
	end
	if garrafa.Value < 1 and GarrafaFrame then
		GarrafaFrame:Destroy()
		GarrafaDebounce = true
	end
	
	if massa.Value >= 1 and MassaDebounce then
		MassaDebounce = false
		MassaFrame = game.ReplicatedStorage.inventoryFrames.MassaFrame:Clone()
		MassaFrame.Parent = script.Parent.ScrollingFrame
	end
	if massa.Value < 1 and MassaFrame then
		MassaFrame:Destroy()
		MassaDebounce = true
	end
	
	if leite.Value >= 1 and LeiteDebounce then
		LeiteDebounce = false
		LeiteFrame = game.ReplicatedStorage.inventoryFrames.LeiteFrame:Clone()
		LeiteFrame.Parent = script.Parent.ScrollingFrame
	end
	if leite.Value < 1 and LeiteFrame then
		LeiteFrame:Destroy()
		LeiteDebounce = true
	end
	
	if pizza.Value >= 1 and PizzaDebounce then
		PizzaDebounce = false
		PizzaFrame = game.ReplicatedStorage.inventoryFrames.PizzaFrame:Clone()
		PizzaFrame.Parent = script.Parent.ScrollingFrame
	end
	if pizza.Value < 1 and PizzaFrame then
		PizzaFrame:Destroy()
		PizzaDebounce = true
	end
	
	if queijo.Value >= 1 and QueijoDebounce then
		QueijoDebounce = false
		QueijoFrame = game.ReplicatedStorage.inventoryFrames.QueijoFrame:Clone()
		QueijoFrame.Parent = script.Parent.ScrollingFrame
	end
	if queijo.Value < 1 and QueijoFrame then
		QueijoFrame:Destroy()
		QueijoDebounce = true
	end

	if moedas.Value >= 1 and CoinDebounce then
		CoinDebounce = false
		coinFrame = game.ReplicatedStorage.inventoryFrames.CoinFrame:Clone()
		coinFrame.Parent = script.Parent.ScrollingFrame
	end
		if moedas.Value < 1 and coinFrame then
			coinFrame:Destroy()
			CoinDebounce = true
		end

	if diamantes.Value >= 1 and DiamanteDebounce then
		DiamanteDebounce = false
		diamanteFrame = game.ReplicatedStorage.inventoryFrames.DiamanteFrame:Clone()
		diamanteFrame.Parent = script.Parent.ScrollingFrame
	end
		if diamantes.Value < 1 and diamanteFrame then
			diamanteFrame:Destroy()
			DiamanteDebounce = true
		end

end

while true do
	task.wait()
	checkframe()
end
