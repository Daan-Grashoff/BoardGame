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
			currentEnergy = 0,
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
		    for _,tile in pairs(board.tiles) do
		    	if tile.owner == player.id
	    		and tile.unit.type ~= 'worker'
		    	and not tile.base then
		    		if tile.originalOwner == player.id then
						player['freq'] = player['freq'] + 50
					elseif tile.type == 'goldmine' then
						player['freq'] = player['freq'] + 150
					else
						player['freq'] = player['freq'] + 100
					end
		    	end
		    end
		    if player.energy < 10 then
				player.energy = player.energy + 1
			end
			player.active = false
			if k == #players then
				k = 0
			end
			players[k+1].active = true
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

	return true
end

function players:getActivePlayer()
	for k,player in ipairs(players) do
		if player['active'] == true then
			return player
		end
	end
end

function players:getActivePlayerEnoughEnergy()
	for k,player in ipairs(players) do
		if player['active'] == true then
			return True
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