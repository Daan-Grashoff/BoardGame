require 'objects.multiplayer'
require 'objects.settings'
require 'buildings.base'
require 'tiles.desertTile'
require 'tiles.grassTile'
require 'tiles.mountainTile'
require 'tiles.snowTile'
require 'tiles.swampTile'

board = {}
function board.load()
	multiplayer.load()

	GrassTile:load()
	SnowTile:load()
	DesertTile:load()
	SwampTile:load()
	MountainTile:load()

	settings:load()
	boardConfig = settings.getConfig()

	-- endturn button
	board.endTurn = {}
	board.endTurn.width = 100
	board.endTurn.height = 50
	board.endTurn.x = width - board.endTurn.width
	board.endTurn.y = height/2 - board.endTurn.height

	board.size = boardConfig['boardsize'] -- 8 mobile / 16 tablet / 24 computer
	board.newTileX = love.graphics.getWidth() / (board.size + 1)
	board.newTileY = love.graphics.getHeight() / (board.size + 1)
	board.tilePadding = 0
	board.newTileSize = math.floor(math.min(board.newTileX - board.tilePadding, board.newTileY - board.tilePadding))

	-- board.height = 18
	-- board.width = 18
	board.tiles = {}
	for i = 0 , board.size do
		for j = 0, board.size do
			tile = {}
			tile.size = math.floor(board.newTileSize)
			if board.newTileX > board.newTileY then
				tile.x = tile.size * i + 150
				tile.y = tile.size * j + 2
			else
				tile.x = tile.size * i
				tile.y = tile.size * j + 150
			end

			tile.corY = i
			tile.corX = j+1

			tile.unit = {}
			-- Tile is occupied if there is a unit on tile
			tile.occupied = false
			-- tile is walking if there is a unit on it and is walking
			tile.walking = false
			-- tile is spawning if base is spawning a unit
			tile.spawning = false--spawning
			-- tile original owner, each player gets a continent and this belongs to him
			tile.originalowner = 0--originalowner
			-- tile owner is set if there is a unit on it
			tile.owner = 0
			-- tile is attackable if there is a unit in range of your unit
			tile.attackable = false--attackable
			-- tile is attacking if there is a unit in range
			tile.attacking = false--attacking
			-- tile is loading if there is a boat in range
			tile.loading = false--loading
			-- tile is lb if there is a boat in range
			tile.loadable = false--loadable
			-- tile is ulb if the boat is next to ground
			tile.unloadable = false--un-loadable
			-- tile is uln if the boat is uln
			tile.unloading = false--un-ld
			--
			tile.unloadboatspawn = false--unloadboatspawn
			tile.unloadboatspawning = false--unloadboatspawning

			-- unit on tile is buidling
			tile.buidling = false
			tile.buildable = false

			tile.income = 0

			if (i == 0 and j == 0) or
			(i == board.size and j ==  0) or
			(i == 0 and j ==  board.size) or
			(i == board.size and j == board.size) then
				tile.base = true
				tile.health = 25
			else
				tile.base = false
				tile.health = 0
			end

			--	around land
			if (i < (board.size / 3) + 1
			and j < (board.size / 3) + 1
			and i > (board.size / 3))
			or (j < (board.size / 3) + 1
			and i < (board.size / 3) + 1
			and j > (board.size / 3)) then
				tile.coast = true
				tile.originalOwner = players:getPlayerByBase('bos')
			end

			--	around land
			if (i > (board.size / 3*2-1)
			and i < (board.size / 3*2)
			and j < (board.size / 3+1)
			or (j > (board.size / 3))
			and i > (board.size / 3*2)
			and j < (board.size / 3 + 1)) then
				tile.originalOwner = players:getPlayerByBase('ijs')
				tile.coast = true
			end

			--	around land
			if (i < (board.size / 3+1)
			and i > (board.size / 3)
			and j > (board.size / 3*2-1))
			or (i < (board.size / 3)
			and (j < (board.size / 3 * 2))
			and (j > board.size / 3 * 2 -1)) then
				tile.coast = true
				tile.originalOwner = players:getPlayerByBase('moeras')
			end

			--	around land
			if (i > (board.size / 3*2) - 1
			and j > (board.size / 3*2) - 1
			and i < (board.size / 3*2))
			or (j > (board.size / 3*2) - 1
			and i > (board.size / 3*2) - 1
			and j < (board.size / 3*2)) then
				tile.coast = true
				tile.originalOwner = players:getPlayerByBase('woestijn')
			end



			if i < (board.size / 3) and j < (board.size / 3) then
				tile.originalowner = players:getPlayerByBase('bos')
				if tile.base == true then
					tile.owner = players:getPlayerByBase('bos')
				end
				tile.type = 1
			elseif i > (math.ceil(board.size / 3) + math.floor(board.size / 18)) and j > (math.ceil(board.size / 3) + math.floor(board.size / 18)) and i < (math.floor(board.size / 3 * 2) - math.floor(board.size / 18)) and j < (math.floor(board.size / 3 * 2) - math.floor(board.size / 18)) then
				tile.type = 2
			elseif  i > (board.size / 3 * 2) and j < (board.size / 3) then
				tile.originalowner = players:getPlayerByBase('moeras')
				if tile.base == true then
					tile.owner = players:getPlayerByBase('moeras')
				end
				tile.type = 0
			elseif i < (board.size / 3) and j > (board.size / 3 * 2) then
				tile.originalowner = players:getPlayerByBase('ijs')
				if tile.base == true then
					tile.owner = players:getPlayerByBase('ijs')
				end
				tile.type = 3
			elseif i > (board.size / 3 * 2) and j > (board.size / 3 * 2) then
				tile.originalowner = players:getPlayerByBase('woestijn')
				if tile.base == true then
					tile.owner = players:getPlayerByBase('woestijn')
				end
				tile.type = 5
			else
				tile.type = 4
			end
			table.insert(board.tiles, tile)
		end
	end

	Board = { size = 16, tiles = {} }

	tile = {}

	tile.prefWidth = love.graphics.getWidth( ) / (Board.size + 1)
	tile.prefHeight = love.graphics.getHeight( ) / (Board.size + 1)
	tile.padding = 0
	tile.size = math.floor(math.min(tile.prefWidth - tile.padding, tile.prefHeight - tile.padding))

end




function board.getTile(corX, corY)
	if board.tiles[(corY * (board.size+1)) + corX] then
		return board.tiles[(corY * (board.size+1)) + corX]
	else
		return false
	end
end


-- when u spawned a unit, this toggle to walk
function board.walkFromBaseToggle(t, unit)
	for i,walking in pairs(board.tiles) do
		if not walking.base then
			walking.walkable = false
		end
		walking.walking = false

	end
	for i,walk in pairs(board.tiles) do
		if  walk.x <= t.x + t.size*t.unit.walkRange
		and walk.x >= t.x - t.size*t.unit.walkRange
		and walk.y <= t.y + t.size*t.unit.walkRange
		and walk.y >= t.y - t.size*t.unit.walkRange then
			if (walk.type ~= 4 and t.unit.type ~= 'boot') or
			-- base must be walkable!
			(t.unit.type == 'boot' and walk.type == 4 or walk.harbor) then
				walk.walkable = true
			end
		end
		if  walk.x <= t.x
		and walk.x >= t.x
		and walk.y <= t.y
		and walk.y >= t.y then
			walk.walking = true
		end
	end
end

function board.attackToggle(x, y, t, unit)
	if not t.attacking then
		for i,tile in pairs(board.tiles) do
			if  tile.x <= t.x + t.size*t.unit.attackRange
			and tile.x >= t.x - t.size*t.unit.attackRange
			and tile.y <= t.y + t.size*t.unit.attackRange
			and tile.y >= t.y - t.size*t.unit.attackRange
			and (tile.occupied == true or tile.health > 0)
			and tile.owner ~= t.owner
			and not t.unit.attacked then
				tile.attackable = true
				t.attacking = true
			end
		end
	else
		for i,tile in pairs(board.tiles) do
			tile.attackable = false
			tile.attacking = false
		end
	end
end

function board.buildToggle(x, y, t, unit)
	if not t.building then
		for i,tile in pairs(board.tiles) do
			if  tile.x <= t.x + t.size*1
			and tile.x >= t.x - t.size*1
			and tile.y <= t.y + t.size*1
			and tile.y >= t.y - t.size*1
			and not tile.occupied
			and currentPlayer.currentEnergy > 1
			and tile.coast then
				tile.buildable = true
				t.building = true
			end
		end
	else
		for i,tile in pairs(board.tiles) do
			tile.buildable = false
			tile.building = false
		end
	end
end


function board.resetAll()
	for _,tile in pairs(board.tiles) do
		tile.attackable = false
		tile.attacking = false
		tile.walkable = false
		tile.walking = false
		tile.loading = false
		tile.loadable = false
		tile.unloading = false
		tile.unloadable = false
		tile.unloadboatspawning = false
		tile.unloadboatspawn = false

		--
		tile.building = false
		tile.buildable = false
	end
end


function board.reset(tile)
	tile.attackable = false
	tile.attacking = false
	tile.walkable = false
	tile.walking = false
	tile.loading = false
	tile.loadable = false
	tile.unloading = false
	tile.unloadable = false
	tile.unloadboatspawning = false
	tile.unloadboatspawn = false

	unitspawn.active = false

	tile.building = false
	tile.buildable = false
end


function board.unloadBoatSpawn(t)
	if not t.unloadboatspawn then
		for i,tile in pairs(board.tiles) do
			if tile.unloading then
				tile.unloadboatspawning = true
			end
		end
		t.unloadboatspawn = true
	else
		t.unloadboatspawn = false
		for i,tile in pairs(board.tiles) do
			tile.unloadboatspawning = false
		end

	end
end


function board.spawn(t, unit, count, owner)
	for i,tile in pairs(board.tiles) do
		if tile.unloadable then
			tile.unit = unit
			tile.occupied = true
			tile.owner = owner
		end
		board.reset(tile)
	end
	table.remove(t.unit.passengers, count)
end

function board.walkToggle(x, y, t, unit)
	if not t.walking then
		for i,walking in pairs(board.tiles) do
			-- clear board
			unitspawn.active = false
			walking.walkable = false
			walking.walking = false
		end

		for i,walk in pairs(board.tiles) do
			-- get all walkable spots around unit
			if  walk.x <= t.x + t.size*t.unit.walkRange
			and walk.x >= t.x - t.size*t.unit.walkRange
			and walk.y <= t.y + t.size*t.unit.walkRange
			and walk.y >= t.y - t.size*t.unit.walkRange then

				-- make sure type is not water if ground unit
				-- make sure type is water if water unit
				if (walk.type ~= 4
				and t.unit.type ~= 'boot' and not walk.harbor)
				or  (t.unit.type == 'boot'
				and (walk.type == 4 or walk.harbor))
				then
					walk.walkable = true
				end

				-- make sure ground soldiers can access boat
				-- check if unit type isnt of boat
				-- check if boat is of urs
				if t.unit.type ~= 'boot'
				and walk.unit.type == 'boot'
				and walk.owner == players:getActivePlayerId() then
					walk.loadable = true
					t.loading = true
				end
			end

			if  walk.x <= t.x
			and walk.x >= t.x
			and walk.y <= t.y
			and walk.y >= t.y then
				-- make current tile walking
				walk.walking = true
			end
		end
	else
		-- set walktoggle false
		-- set all walking false
		-- set all walkables false
		if t.unit then
			for _,walk in pairs(board.tiles) do
				if walk.walking then
					walk.walking = false
				end
				walk.walkable = false
			end
		end
	end
end


function board.walk(x, y, t, lastTile, playerid)
	if t.walkable then
		for _,tile in pairs(board.tiles) do
			if tile.walkable then
				-- check if tile is occupied
				-- check if tile is walking
				if tile.occupied and tile.walking then
					tile.occupied = false
					-- not removing owner of a base
					if not tile.base and not tile.harbor then
						tile.owner = 0
					end
					-- set tile owner to current player ID
					t.owner = playerid
					-- transfer unit to selected tiles
					t.unit = tile.unit
					-- remove prev tile unit
					tile.unit = {}
				end
			end
			board.reset(tile)
		end
		-- set selecterd tile to occupied
		t.occupied = true
	end
end

function board.loadBoat(x,y,t)
	for _,tile in pairs(board.tiles) do
		if tile.occupied and tile.loading then
			tile.occupied = false
			if not tile.base then
				tile.owner = 0
			end
			currentPlayer.currentEnergy = currentPlayer.currentEnergy - 1
			table.insert(t.unit.passengers, tile.unit)
			tile.unit = {}
		end
		board.reset(tile)
	end
	t.occupied = true
end


function board.unloadToggle(x,y,t)
	if not t.unloading then
		for i,tile in pairs(board.tiles) do
			-- clear board
			unitspawn.active = false
			tile.unloading = false
			tile.unloadable = false
		end
		for i,walk in pairs(board.tiles) do
			-- get all walkable spots around unit
			-- check if tile is left or right
			if  walk.x <= t.x + t.size*1
			and walk.x >= t.x - t.size*1
			and walk.y <= t.y
			and walk.y >= t.y
			then
				if t.unit.type == 'boot'
				and walk.type ~= 4
				and not walk.harbor
				and not walk.occupied then
					walk.unloadable = true
					t.unloading = true
				end
				-- check if tile is top or bottom=
			elseif walk.x <= t.x
				and walk.x >= t.x
				and walk.y <= t.y + t.size*1
				and walk.y >= t.y - t.size*1
				then
					if t.unit.type == 'boot'
					and walk.type ~= 4
					and not walk.harbor
					and not walk.occupied then
						walk.unloadable = true
						t.unloading = true
					end
				end
			end
		else
			for i,tile in pairs(board.tiles) do
				board.reset(tile)
			end
		end
	end

function board.unload(t)
	for _,tile in pairs(board.tiles) do
		if tile.unloadable then
			if tile.occupied and tile.tileing then
				tile.occupied = false
				t.unit = tile.unit

				-- currentPlayer.currentEnergy = currentPlayer.currentEnergy - 1
				tile.unit = {}
			end
		end
		t.occupied = true
	end
end

function board.attack(x, y, t)
	for i,tile in pairs(board.tiles) do
		if tile.attacking then
			if t.unit.health then

				-- do damage to unit
				tile.unit.attacked = true
				t.unit.health = t.unit.health - tile.unit.damage

				-- do damage to unit
				tile.unit.health = tile.unit.health - t.unit.damage / 2

				-- if unit's health is below 1
				if t.unit.health <= 0 then
					-- clear tile
					board.clear(t)
				end

				-- if unit's health is below 1
				if tile.unit.health <= 0 then
					-- clear tile
					board.clear(tile)
				end
			end
			if t.health ~= 0 then
				t.health = t.health - tile.unit.damage
				if t.health <= 0 then
					if t.harbor then
						t.type = 4
						t.owner = 0
						t.originalOwner = 0
						print('make harbor water again')
					end
					board.clear(t)
				end
			end
			board.reset(tile)
		end
	end
end

function board.clear(t)
	t.occupied = false
	t.unit = {}

	if not t.base then
		t.owner = 0
	end

	t.harbor = false
	t.base = false
	t.attackable = false
	t.attacking = false

	t.walkable = false
	t.walking = false
	t.loading = false
	t.loadable = false
	t.unloading = false
	t.unloadable = false
	t.unloadboatspawning = false
	t.unloadboatspawn = false
end

function board.build(x, y, t)
	for _,tile in pairs(board.tiles) do
		if tile.building then
			t.harbor = true
			t.health = 6
			currentPlayer.freq = currentPlayer.freq - prices['bos']['harbor']
			currentPlayer.currentEnergy = currentPlayer.currentEnergy - 2
			t.owner = tile.owner
			t.type = tile.type
		end
		board.reset(tile)
	end
end


function board.baseWalk(t, unit)
	if t.walk then
		for _,walk in pairs(board.tiles) do
			if walk.walkable then
				if walk.occupied and walk.walking then
					walk.occupied = false
					t.unit = walk.unit
					walk.unit = {}
				end
				walk.walkable = false
			end
		end
		t.occupied = true
	end
end

function board.getBases()
	bases = {}
	bases[0] = board.tiles[1]
	bases[1] = board.tiles[board.size+1]
	bases[2] = board.tiles[(board.size+1)*(board.size+1)]
	bases[3] = board.tiles[(board.size+1)*(board.size+1)-board.size]
	return bases
end

function board.getBaseById(id)
	for a,base in pairs(board.getBases()) do
		if base.owner == id then
			return base
		end

	end
end

--printing = true
function board.draw()
	if printing == true then
		--print(Tserial.pack(board.tiles))
		--print(string.len(Tserial.pack(board.tiles)))
		--printing = false
	end

	for _,t in pairs(board.tiles) do

		-- draw diffrent continents colors
		if t.type == 0 then
			love.graphics.setColor({197, 179, 153})
		elseif t.type == 1 then
			love.graphics.setColor({52, 82, 40})
		elseif t.type == 2 then
			love.graphics.setColor({207, 181, 59})
		elseif t.type == 3 then
			love.graphics.setColor({175, 175, 175})
		elseif t.type == 4 then
			love.graphics.setColor({45, 127, 180})
		else
			love.graphics.setColor({21, 34, 20})
		end

		love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)




		if t.owner == players:getActivePlayerId()
		and t.harbor then
			love.graphics.setColor(0, 255, 255)
			love.graphics.rectangle('fill', t.x, t.y, t.size, t.size)
			love.graphics.setColor(0, 255, 0, 100)
			love.graphics.rectangle('fill', t.x, t.y, t.size, t.size)
		end



		-- color the tiles with unit on it
		if t.occupied then
			if t.unit.type then
				love.graphics.setColor(255, 255, 255)
				if t.owner == 0 then
					image = sprites['bos'][t.unit.type]
				else
					image = sprites[players:getBaseByPlayer(t.owner)][t.unit.type]
				end

				if board.size == 8 then
					love.graphics.draw(image, t.x+10, t.y+10, 0, 2, 2)
				elseif board.size == 24 then
					love.graphics.draw(image, t.x, t.y, 0, 0.75, 0.75)
				else
					love.graphics.draw(image, t.x, t.y, 0)
				end
			else
				love.graphics.setColor(240,230,140)
				love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
			end
			love.graphics.setColor(0, 0,0)
		end

		-- show tile is walkable (able to walk on this tile colored)
		if t.walkable then
			love.graphics.setColor(0, 255,0, 100)
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
			love.graphics.setColor(0,0,0)
		end

		-- set print color black
		love.graphics.setColor(0, 0,0)

		-- Base tile other color
		if t.base then
			love.graphics.setColor(255, 255, 255)
			if t.owner == 0 then
				image = sprites['bos']['base']
			else
				image = sprites[players:getBaseByPlayer(t.owner)]['base']
			end
			love.graphics.draw(image, t.x, t.y, 0, board.newTileSize / 44, board.newTileSize / 44)
			-- love.graphics.setColor(181, 90,60)
			-- love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
		end

		-- Owner ID on tile
		if t.owner then
			love.graphics.setColor(0,0,0)
			-- love.graphics.print(t.owner, t.x + 1, t.y + 30)
		end

		-- original owner ID on tile
		if t.originalowner then
			love.graphics.setColor(0,0,0)
			-- love.graphics.print(t.originalOwner, t.x + 1, t.y + 20)
		end

		-- Unit damage on tile
		if t.unit.damage then
			-- love.graphics.setColor(0,0,0)
			love.graphics.setColor(255,255,0)
			love.graphics.print('A ' .. t.unit.damage, t.x + 10, t.y + 20)
		end

		-- Unit health on tile
		if t.unit.health then
			-- love.graphics.setColor(0,0,0)
			love.graphics.setColor(255,0,0)
			love.graphics.print('H ' .. t.unit.health, t.x + 10, t.y + 30)
		end

		if t.health > 0 then
			love.graphics.setColor(255,0,0)
			love.graphics.print('H ' .. t.health, t.x, t.y + 30)
		end

		if t.unit.type == 'boot' then
			love.graphics.setColor(255,0,0)
			love.graphics.print("P " ..#t.unit.passengers .. '/' .. 3, t.x +5, t.y)
		end

		-- Unit type on tile
		if t.unit.type then
			-- love.graphics.setColor(0,0,0)
			-- love.graphics.print(t.unit.type, t.x, t.y+2)
		end

		-- Print tile income worth
		if t.income ~= 0 then
			love.graphics.setColor(0,0,0)
			love.graphics.print(t.income, t.x, t.y+2)
		end

		-- if
		-- if t.unloading then
		-- 	for i,unit in pairs(t.unit.passengers) do
		-- 		love.graphics.setColor(255,255,255)
		-- 		love.graphics.rectangle("fill", 100 + (80 * i), 0, 80, 80)
		-- 		love.graphics.setColor(0,0,0)
		-- 		love.graphics.rectangle("line", 100 + (80 * i), 0, 80,80)
		-- 		love.graphics.print(unit.type, 100 + (80 * i) + 5, unit.y)
		-- 	end
		-- end

		if multiplayer.turn then
			if t.walking then
				-- debug show tile is walking
				-- love.graphics.print('walking!!!!', t.x+5, t.y + 20)
			elseif t.attackable then
				-- show tile is attackable (able to attack a other unit)
				love.graphics.setColor(255, 0, 0, 100)
				love.graphics.rectangle('fill', t.x, t.y, t.size, t.size)
			elseif t.loadable and #t.unit.passengers < 3 then
				-- show tile is lb (able to load units in boat)
				love.graphics.setColor(0, 0,255, 100)
				love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
				love.graphics.setColor(0,0,0)
			elseif t.unloadable then
				-- show tile is ulb (able to unload units on the ground)
				love.graphics.setColor(255,255,0, 100)
				love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
				love.graphics.setColor(0,0,0)
			elseif t.buildable then
				love.graphics.setColor(0,0,100)
				love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
				love.graphics.setColor(0,0,0)
			end

			if t.owner == players:getActivePlayerId()
			and t.base then
				love.graphics.setColor(0, 255, 0, 55)
				love.graphics.rectangle('fill', t.x, t.y, t.size, t.size)
			end
		end




		-- end turn button
		love.graphics.rectangle('fill', board.endTurn.x, board.endTurn.y, board.endTurn.width, board.endTurn.height)

		-- around tiles black border

		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("line", t.x, t.y, t.size, t.size)


		-- print player stats
		-- print Amount of energy of each player
		-- print Amount of frequeny of each player
		-- print Amount of Income of each player
		if t.base then
			playerStats = players:getPlayerByID(t.owner)
			if playerStats then
				-- position left or right
				if t.x < width/2 then
					-- position left
					xpos = t.x - 75
				else
					-- position right
					xpos = t.x + 75
				end

				love.graphics.print('Energy ' .. playerStats.currentEnergy .. '/' .. playerStats.energy, xpos, t.y)
				love.graphics.print('Freq ' .. playerStats.freq, xpos, t.y + 15)
				love.graphics.print('Income ' .. playerStats.income, xpos, t.y + 30)
			end
		end


		if t.coast then
			love.graphics.setColor(0,0,0, 50)
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
		end

		if t.harbor then
			love.graphics.setColor(144, 144, 144, 50)
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
		end

	  	if coast_tile then
    		love.graphics.setColor(144, 144, 144, 100)
			love.graphics.rectangle("fill", coast_tile.x, coast_tile.y, coast_tile.size, coast_tile.size)
		end

		-- if t.coast then
		-- 	love.graphics.setColor(0,0,0, 100)
		-- 	love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
		-- end


		-- if t.walking then
		-- 	love.graphics.setColor(240,230,140)
		-- 	love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
		-- 	love.graphics.setColor(0, 0,0)
		-- end

	end

	for i,t in pairs(Board.tiles) do
		--love.graphics.setColor(t.m_color)

		if t.m_image then
			love.graphics.setColor(255,255,255)
			love.graphics.draw(t.m_image, (i % (Board.size + 1)) * tile.size, math.floor((i / (Board.size + 1))) * tile.size, 44 / tile.size, 44 / tile.size)
		else
			--love.graphics.setColor(t.m_color)
			--love.graphics.rectangle("fill", ((i % (Board.size + 1)) * tile.size) + 0, math.floor((i / (Board.size + 1))) * tile.size, tile.size, tile.size)
		end

	end

	for i,t in pairs(Board.tiles) do
		--t:draw()
		--love.graphics.setColor(0,0,0)
		--love.graphics.rectangle("line", ((i % (Board.size + 1)) * tile.size) + 0, math.floor((i / (Board.size + 1))) * tile.size, tile.size, tile.size)
	end


end