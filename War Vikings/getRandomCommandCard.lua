local label = game.Workspace.comandoLabel.SurfaceGui.TextLabel
local lastdeci = 5

script.Parent.Triggered:Connect(function()
	for i = 0, math.random(4, 10) do
		task.wait(0.05)
		local deci
		repeat
			deci = math.random(1, 4)
		until deci ~= lastdeci
		if deci == 1 then
			label.Text = "Águas Sagradas — Se o comandante estiver em um território com porto, o navio daquele local pode rolar novamente um dado de ataque ou defesa durante combates marítimos."
		end
		if deci == 2 then
			label.Text = "Parede de Escudos — A cada combate, você pode rerrolar um dado de defesa."
		end
		if deci == 3 then
			label.Text = "Prece da Guerra — Quando usar o poder de um deus, você pode ignorar o efeito da carta comprada, embaralhar de volta no baralho e comprar outra."
		end
		if deci == 4 then
			label.Text = "Grito de Batalha — Em cada combate, você pode rerrolar um dado de ataque."
		end
		lastdeci = deci
	end
end)