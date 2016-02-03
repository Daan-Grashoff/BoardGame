require 'objects.settings'

card = {}
cards = {
	[4] = {
		'ijs',
		'moeras',
		'woestijn',
		'bos'
	},
	[2] = {
		'bos',
		'woestijn'
	}
}

function card.shuffleCards()
	cards = cards[amountPlayers]

	for i = #cards, 2, -1 do
		local rand = math.random(i)
		cards[i], cards[rand] = cards[rand], cards[i]
	end

	return cards
end
