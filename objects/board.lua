board = {}
function board.load()

	-- endturn button
	board.endTurn = {}
	board.endTurn.width = 100
	board.endTurn.height = 50
	board.endTurn.x = width - board.endTurn.width
	board.endTurn.y = height/2 - board.endTurn.height

	board.size = 16 -- 8 mobile / 16 tablet / 24 computer
	board.newTileX = love.graphics.getWidth( ) / (board.size + 1)
  	board.newTileY = love.graphics.getHeight( ) / (board.size + 1)
	board.tilePadding = 0
  	board.newTileSize = math.min(board.newTileX - board.tilePadding, board.newTileY - board.tilePadding)

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
			tile.unit = {}
			tile.occupied = false
			tile.f = false
			tile.walking = false
			tile.spawning = false
			tile.originalOwner = 0
			tile.owner = 0
			tile.attackable = false
			tile.attacking = false
			tile.loading = false
			tile.loadable = false
			tile.barak = true
			tile.income = 0

			if (i == 0 and j == 0) or 
			   (i == board.size and j ==  0) or 
			   (i == 0 and j ==  board.size) or 
			   (i == board.size and j == board.size) then
				tile.base = true
			else
				tile.base = false
			end

			if i < (board.size / 3) and j < (board.size / 3) then
				tile.originalOwner = players:getPlayerByBase('bos')
				if tile.base == true then 
					tile.owner = players:getPlayerByBase('bos')
				end
				tile.type = 'bos'
				tile.color = {52, 82, 40}
			elseif i > (math.ceil(board.size / 3) + math.floor(board.size / 18)) and j > (math.ceil(board.size / 3) + math.floor(board.size / 18)) and i < (math.floor(board.size / 3 * 2) - math.floor(board.size / 18)) and j < (math.floor(board.size / 3 * 2) - math.floor(board.size / 18)) then
				tile.type = 'goldmine'
				tile.color = {207, 181, 59}
			elseif  i > (board.size / 3 * 2) and j < (board.size / 3) then
				tile.originalOwner = players:getPlayerByBase('moeras')
				if tile.base == true then 
					tile.owner = players:getPlayerByBase('moeras')
				end
				tile.type = 'moeras'
				tile.color = {197, 179, 153}
			elseif i < (board.size / 3) and j > (board.size / 3 * 2) then
				tile.originalOwner = players:getPlayerByBase('ijs')
				if tile.base == true then 
					tile.owner = players:getPlayerByBase('ijs')
				end
				tile.type = 'ijs'
				tile.color = {175, 175, 175}
			elseif i > (board.size / 3 * 2) and j > (board.size / 3 * 2) then
				tile.originalOwner = players:getPlayerByBase('woestijn')
				if tile.base == true then 
					tile.owner = players:getPlayerByBase('woestijn')
				end
				tile.type = 'woestijn'
				tile.color = {21, 34, 20}
			else
				tile.type = 'water'
				tile.color = {45, 127, 180}
			end
			table.insert(board.tiles, tile)
		end
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
			if (walk.type ~= 'water' and t.unit.type ~= 'boot') or 
				-- base must be walkable!
			   (t.unit.type == 'boot' and walk.type == 'water' or walk.base) then
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
			and tile.occupied == true
			and tile.owner ~= t.owner then
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

function board.reset(tile)
	tile.attackable = false
	tile.attacking = false
	tile.walkable = false
	tile.walking = false
	tile.loading = false
	tile.loadable = false
end

function board.walkToggle(x, y, t, unit)
	if not t.walking then
		for i,walking in pairs(board.tiles) do
			-- clear board
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
				if (walk.type ~= 'water' and t.unit.type ~= 'boot') or 
				   (t.unit.type == 'boot' and walk.type == 'water') then
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
					if not tile.base then
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
			table.insert(t.unit.passengers, t.unit)
			tile.unit = {}
		end
		board.reset(tile)		
	end
	t.occupied = true
end


function board.unloadToggle(x,y,t)
	for i,walk in pairs(board.tiles) do
		-- get all walkable spots around unit
		if  walk.x <= t.x + t.size*t.unit.walkRange
		and walk.x >= t.x - t.size*t.unit.walkRange
		and walk.y <= t.y + t.size*t.unit.walkRange
		and walk.y >= t.y - t.size*t.unit.walkRange then

			-- make sure type is not water if ground unit
			-- make sure type is water if water unit
			if (walk.type ~= 'water' and t.unit.type ~= 'boot') or 
			   (t.unit.type == 'boot' and walk.type == 'water') then
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
end

function board.unload(x,y,t)

end

function board.attack(x, y, t)
	for i,tile in pairs(board.tiles) do
		if tile.attacking then
			-- do damage to unit 
			t.unit.health = t.unit.health - tile.unit.health
			-- do damage to unit 
			tile.unit.health = tile.unit.health - t.unit.damage
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
		board.reset(tile)		
	end
end

function board.clear(t)
	t.occupied = false
	t.unit = {}
	t.owner = 0
	t.attackable = false
	t.attacking = false
	t.walkable = false
	t.walking = false
	t.loading = false
	t.loadable = false
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

function board.draw()
	for _,t in pairs(board.tiles) do

		love.graphics.setColor(t.color)
		love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)

		-- color the tiles with unit on it
		if t.occupied then
			love.graphics.setColor(240,230,140)
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
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
			love.graphics.setColor(181, 90,60)
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
		end

		-- Owner ID on tile
		if t.owner then
			love.graphics.print(t.owner, t.x + 1, t.y + 30)
		end

		-- original owner ID on tile
		if t.originalOwner then
			love.graphics.print(t.originalOwner, t.x + 1, t.y + 20)
		end

		-- Unit damage on tile
		if t.unit.damage then
			love.graphics.print('D ' .. t.unit.damage, t.x + 20, t.y + 30)
		end

		-- Unit health on tile
		if t.unit.health then
			love.graphics.print('H ' .. t.unit.health, t.x + 20, t.y + 20)
		end

		-- Unit type on tile
		if t.unit.type then
			love.graphics.setColor(0,0,0)
			love.graphics.print(t.unit.type, t.x, t.y+2)
		end

		-- Print tile income worth
		if t.income ~= 0 then
			love.graphics.setColor(0,0,0)
			love.graphics.print(t.income, t.x, t.y+2)
		end



		if t.walking then
			love.graphics.print('walking!!!!', t.x+5, t.y + 20)
		elseif t.attackable then 
			love.graphics.setColor(255, 0, 0, 100)
			love.graphics.rectangle('fill', t.x, t.y, t.size, t.size)
		-- show tile is loadable (able to load a unit in boat)
		elseif t.loadable then
			love.graphics.setColor(0, 0,255)
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
			love.graphics.setColor(0,0,0)
		end

		if t.owner == players:getActivePlayerId() then
			love.graphics.setColor(0, 255, 0, 100)
			love.graphics.rectangle('fill', t.x, t.y, t.size, t.size)
		end


		if players:getPlayerEnergy() then
			love.graphics.setColor(0,0,0)
		else
			love.graphics.setColor(0,255, 0)
		end
		love.graphics.rectangle('fill', board.endTurn.x, board.endTurn.y, board.endTurn.width, board.endTurn.height)


		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("line", t.x, t.y, t.size, t.size)

		if t.base then
			playerStats = players:getPlayerByID(t.owner)
			if playerStats then
				if t.x < width/2 then
					xpos = t.x - 75
				else
					xpos = t.x + 75
				end

				love.graphics.print('Energy ' .. playerStats.currentEnergy .. '/' .. playerStats.energy, xpos, t.y)
				love.graphics.print('Freq ' .. playerStats.freq, xpos, t.y + 15)
				love.graphics.print('Income ' .. playerStats.income, xpos, t.y + 30)
			end
		end

		-- if t.walking then
		-- 	love.graphics.setColor(240,230,140)
		-- 	love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
		-- 	love.graphics.setColor(0, 0,0)
		-- end

	end
end