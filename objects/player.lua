require 'lib.functions'

players = {}
startAmoundFreq = 1000
startAmoundEnergy = 1
startingCard = "bos"
playerCount = 4

function players:generate(names)
	cards = card.shuffleCards()
	for i=1,playerCount do
		players[i] = {
			id = i,
			name = names[i],
			base = cards[i],
			freq = startAmoundFreq,
			energy = startAmoundEnergy,
			tiles = {
				Ijs = 0,
				Moeras = 0,
				Woestijn = 0,
				Bos = 0,
				Goud = 0
			},
			active = false
		}
		players[i]['tiles'][players[i]['base']] = 1
		if players[i]['base'] == startingCard then
			players[i]['active'] = true
		end
	end
	return players
end

function players:textDraw()
	for k,player in ipairs(players) do
		love.graphics.print(player.freq, k*200, k*50)
		love.graphics.print(player.energy, k*200, k*55)
	end
	return true
end

function players:update(activePlayer)
	for k,player in ipairs(players) do
		if player['active'] == true then
			player['freq'] = activePlayer['freq']
			player['energy'] = player['energy'] + 1
			player['active'] = false
			if k == #players then
				k = 0
			end
			players[k+1]['active'] = true
			break
		end
	end
	return players
end


function players:getActivePlayerId()
	for k,player in ipairs(players) do
		if player['active'] == true then
			return player.id
		end
	end
end

function players:getPlayerByID(id)
	return players[id]
end

function players:getPlayerByBase(base)
	for i,player in ipairs(players) do
		if player.base == base then
			return player.id
		end
	end
end

function players:buyItem(itemPrice)
	freq = players:getActivePlayer().freq
	if not itemPrice then
		print('No price found!')
		return false
	end
	if itemPrice > freq then
		print('Your frequency is to damn low!')
		return false
	end
	players:getActivePlayer().freq = freq - itemPrice
	-- activePlayer = players.getActivePlayer()
	-- if activePlayer.freq > itemPrice then
	-- 	activePlayer.freq = activePlayer.freq - itemPrice
	-- end
	return true
end

function players:getActivePlayer()
	for k,player in ipairs(players) do
		if player['active'] == true then
			return player
		end
	end
end

function players:getActivePlayerEnergy()
	for k,player in ipairs(players) do
		if player['active'] == true then
			return player.energy
		end
	end
end