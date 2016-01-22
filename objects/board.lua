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
			tile.barak = true

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

-- not legit code
-- function love.mousepressed(x, y, button)
-- 	for _,t in pairs(board.tiles) do
-- 		if x > t.x and x < t.x + t.width
-- 		and y > t.y and y < t.y + t.height
-- 		then
-- 			t.atributes.occupied = true
-- 		end
-- 	end
-- end


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
			   (t.unit.type == 'boot' and walk.type == 'water') then
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

function board.walkToggle(x, y, t, unit)
	if not t.walking then
		for i,walking in pairs(board.tiles) do
			walking.walkable = false
			walking.walking = false
		end

		for i,walk in pairs(board.tiles) do
			if  walk.x <= t.x + t.size*t.unit.walkRange
			and walk.x >= t.x - t.size*t.unit.walkRange
			and walk.y <= t.y + t.size*t.unit.walkRange
			and walk.y >= t.y - t.size*t.unit.walkRange then
				if (walk.type ~= 'water' and t.unit.type ~= 'boot') or 
				   (t.unit.type == 'boot' and walk.type == 'water') then
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
	else
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
				if tile.occupied and tile.walking then
					tile.occupied = false
					if not tile.base then
						tile.owner = 0
					end
					t.owner = playerid
					t.unit = tile.unit
					tile.unit = {}
				end
				tile.walkable = false
				tile.attackable = false
			end
			tile.walking = false
		end
		t.occupied = true
	end
end

function board.attack(x, y, t)
	t.occupied = false
	t.unit = {}
	for i,tile in pairs(board.tiles) do
		tile.attackable = false
		tile.attacking = false
		t.owner = 0
		tile.walkable = false
		tile.walking = false
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

function board.draw()
	for _,t in pairs(board.tiles) do

		love.graphics.setColor(t.color)
		love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)

		if t.unit.type then
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
			love.graphics.setColor(0,0,0)
			love.graphics.print(t.unit.type, t.x+5, t.y + 20)
		end

		if t.occupied then
			love.graphics.setColor(240,230,140)
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
			love.graphics.setColor(0, 0,0)
		elseif t.walkable then
			love.graphics.setColor(0, 255,0, 100)
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
			love.graphics.setColor(0,0,0)
		end

		love.graphics.setColor(0, 0,0)

		if t.base then
			love.graphics.setColor(181, 90,60)
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
		else
			-- love.graphics.print(t.type, t.x + 5, t.y)
		end

		if t.owner then
			love.graphics.print(t.owner, t.x + 5, t.y + 30)
		end
		
		if t.originalOwner then
			love.graphics.print(t.originalOwner, t.x + 5, t.y + 20)
		end

		if t.walking then
			love.graphics.print('walking!!!!', t.x+5, t.y + 20)
		elseif t.attackable then 
			love.graphics.setColor(255, 0, 0, 100)
			love.graphics.rectangle('fill', t.x, t.y, t.size, t.size)
		end

		if t.owner == players:getActivePlayerId() then
			love.graphics.setColor(0, 255, 0, 100)
			love.graphics.rectangle('fill', t.x, t.y, t.size, t.size)
		end

		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle('fill', board.endTurn.x, board.endTurn.y, board.endTurn.width, board.endTurn.height)


		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("line", t.x, t.y, t.size, t.size)
	end
end