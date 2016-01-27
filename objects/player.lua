require 'lib.functions'

players = {}
startAmoundFreq = 10000
startAmoundEnergy = 100
startingCard = "bos"

function players:generate(names)
	playerCount = amountPlayers
	cards = card.shuffleCards()
	for i=1,playerCount do
		players[i] = {
			id = i,
			name = names[i],
			base = cards[i],
			freq = startAmoundFreq,
			energy = startAmoundEnergy,
			currentEnergy = startAmoundEnergy,
			income = 0,
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
  			currentPlayer = players[i]
		end
	end
	return players
end

function players:update(activePlayer)
	for k,player in ipairs(players) do
		if player['active'] == true then
			player.income = 0
		    for _,tile in pairs(board.tiles) do
		    	if tile.owner == player.id
	    		and tile.unit.type ~= 'worker'
		    	and not tile.base then
		    		if tile.originalOwner == player.id then
						player['freq'] = player['freq'] + 50
						player.income = player.income + 50
						tile.income = 50
					elseif tile.type == 'goldmine' then
						player['freq'] = player['freq'] + 150
						player.income = player.income + 150
						tile.income = 150
					else
						player['freq'] = player['freq'] + 100
						player.income = player.income + 100
						tile.income = 100
					end
				else
					tile.income = 0
		    	end

		    end
		    if player.energy < 10 then
				player.energy = player.energy + 1
			end
			player.currentEnergy = player.energy
			player.active = false
			if k == #players then
				k = 0
			end
			players[k+1].active = true
			currentPlayer = players[k+1]
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

function players:getBaseByPlayer(id)
	return players[id].base
end

function players:getPlayerByBase(base)
	for i,player in ipairs(players) do
		if player.base == base then
			return player.id
		end
	end
	return 0
end

function players:walk()
	energy = players:getActivePlayer().currentEnergy
	if energy > 0 then
		players:getActivePlayer().currentEnergy = energy - 1
		return true
	else
		print('not enough energy to walk')
		return false
	end
end

function players:attack()
	energy = players:getActivePlayer().currentEnergy
	if energy > 0 then
		players:getActivePlayer().currentEnergy = energy - 1
		return true
	else
		print('not enough energy to attack')
		return false
	end
end

function players:getPlayerEnergy()
	if currentPlayer.currentEnergy > 0 then
		return true
	else
		return false
	end
	print(currentPlayer.currentEnergy)
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


function players:getActivePlayerEnergy()
	for k,player in ipairs(players) do
		if player['active'] == true then
			return player.currentEnergy
		end
	end
end