card = {}
cards = {
	'Woestijn',
	'Moeras',
	'Ijsvlakte',
	'Bos'
}

function card.load()
	return card.randomCard()
end

function card.randomCard()
	math.randomseed(os.time())
	rand = math.random(1,table.getn(cards))
	card = cards[rand]
	table.remove(cards, rand)

	return card
end