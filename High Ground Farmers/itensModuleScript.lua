local module = {}

local itens = {
	SementeTrigo = {
		icon = 131241769375207,
		desc = "As a seed, you can plant it on the right surface.",
		engName = "Wheat Seed",
		tipo = {"Semente"}
	},
	SementeTomate = {
		icon = 97741041964699,
		desc = "As a seed, you can plant it on the right surface.",
		engName = "Tomato Seed",
		tipo = {"Semente"}
	},
	SementeAbobora = {
		icon = 136064123747777,
		desc = "As a seed, you can plant it on the right surface.",
		engName = "Pumpkin Seed",
		tipo = {"Semente"}
	},
	SementeMorango = {
		icon = 91997980225248,
		desc = "As a seed, you can plant it on the right surface.",
		engName = "Strawberry Seed",
		tipo = {"Semente"}
	},
	Trigo = {
		icon = 131241769375207,
		desc = "Wheat looks nice.",
		engName = "Wheat",
		tipo = {""}
	},
	Tomate = {
		icon = 97741041964699,
		desc = "Red tomato.",
		engName = "Tomato",
		tipo = {""}
	},
	Abobora = {
		icon = 136064123747777,
		desc = "They were supposed to be bigger.",
		engName = "Pumpkin",
		tipo = {""}
	},
	Morango = {
		icon = 91997980225248,
		desc = "Strawberry tastes good, we all love it.",
		engName = "Strawberry",
		tipo = {""}
	},
	Pao = {
		icon = 131003848184997,
		desc = "You can eat it in case you're hungry.",
		engName = "Bread",
		tipo = {"Alimento"}
	},
	GarrafaDeAgua = {
		icon = 115156458506276,
		desc = "A nice way to kill thirst.",
		engName = "Bottle Of Water",
		tipo = {"Alimento"}
	},
	Agua = {
		icon = 75229443359000,
		desc = "Use it to water the soil.",
		engName = "Water",
		tipo = {""}
	},
	Queijo = {
		icon = 113435690746656,
		desc = "Nice and yellow.",
		engName = "Cheese",
		tipo = {""}
	},
	Ovo = {
		icon = 124020434399705,
		desc = "I'm so sorry Ms Chicken.",
		engName = "Egg",
		tipo = {""}
	},
	Pizza = {
		icon = 87685467858768,
		desc = "Why can I not eat it?",
		engName = "Pizza",
		tipo = {""}
	},
	Massa = {
		icon = 126082263590256,
		desc = "Soft and shiny.",
		engName = "Dough",
		tipo = {""}
	},
	Leite = {
		icon = 75826786577121,
		desc = "I did nothing wrong Ms Cow.",
		engName = "Milk",
		tipo = {""}
	},
	Garrafa = {
		icon = 72125495297457,
		desc = "You can store liquids inside of it.",
		engName = "Bottle",
		tipo = {""}
	},

	Moeda = {
		icon = 101230497260421,
		desc = "The current currency of the game.",
		engName = "Coin",
		tipo = {""}
	},
	Diamante = {
		icon = 77707387347815,
		desc = "The most expensive currency of the game.",
		engName = "Diamond",
		tipo = {""}
	},
}

local defaultIcon = 73613792471508
local defaultDesc = "This item does not have a description yet."
local defaultName = "This item does not have an English name."

function module.getIcon(nome)
	if string.sub(nome, 1, 4) == "Bau_" then
		nome = string.sub(nome, 5)
	end
	local data = itens[nome]
	if not data then
		for key, value in pairs(itens) do
			if string.lower(key) == string.lower(nome) then
				return value.icon or defaultIcon
			end
		end
		return defaultIcon
	end
	return data.icon or defaultIcon
end

function module.getDesc(nome)
	if string.sub(nome, 1, 4) == "Bau_" then
		nome = string.sub(nome, 5)
	end
	local data = itens[nome]
	if not data then
		for key, value in pairs(itens) do
			if string.lower(key) == string.lower(nome) then
				return value.desc or defaultDesc
			end
		end
		return defaultDesc
	end
	return data.desc or defaultDesc
end

function module.getEngName(nome)
	if string.sub(nome, 1, 4) == "Bau_" then
		nome = string.sub(nome, 5)
	end
	local data = itens[nome]
	if not data then
		for key, value in pairs(itens) do
			if string.lower(key) == string.lower(nome) then
				return value.engName or defaultName
			end
		end
		return defaultName
	end
	return data.engName or defaultName
end

return module