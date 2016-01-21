card = {}
cards = {
	'ijs',
	'moeras',
	'woestijn',
	'bos'
}

function card.shuffleCards()
	-- shuffledCards = {}
	-- for i=1, #cards do
	-- 	rand = math.random(1,#cards)
	-- 	print(#cards)
	-- 	table.remove(cards, rand)
	-- 	table.insert(shuffledCards, cards[rand])
	-- end

	for i = #cards, 2, -1 do
		local rand = math.random(i)
		cards[i], cards[rand] = cards[rand], cards[i]
	end

	return cards
end
