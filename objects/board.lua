board = {}
function board.load()
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

			tile.owner = 0
			tile.barak = false

			if (i == 0 and j == 0) or 
			   (i == board.size and j ==  0) or 
			   (i == 0 and j ==  board.size) or 
			   (i == board.size and j == board.size) then
				tile.base = true
			else
				tile.base = false
			end

			if i < (board.size / 3) and j < (board.size / 3) then
				players:getPlayerByBase('bos')
				tile.type = 'bos'
				tile.color = {52, 82, 40}
			elseif i > (math.ceil(board.size / 3) + math.floor(board.size / 18)) and j > (math.ceil(board.size / 3) + math.floor(board.size / 18)) and i < (math.floor(board.size / 3 * 2) - math.floor(board.size / 18)) and j < (math.floor(board.size / 3 * 2) - math.floor(board.size / 18)) then
				tile.type = 'goldmine'
				tile.color = {207, 181, 59}
			elseif  i > (board.size / 3 * 2) and j < (board.size / 3) then
				tile.type = 'moeras'
				tile.color = {197, 179, 153}
			elseif i < (board.size / 3) and j > (board.size / 3 * 2) then
				tile.type = 'ijs'
				tile.color = {175, 175, 175}
			elseif i > (board.size / 3 * 2) and j > (board.size / 3 * 2) then
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

function board.walkFromBaseToggle(t, unit)
	for i,walking in pairs(board.tiles) do
		if not walking.base then
			walking.walkable = false
			walking.walking = false
		end
	end
	for i,walk in pairs(board.tiles) do
		if  walk.x <= t.x + t.size*t.unit.range
		and walk.x >= t.x - t.size*t.unit.range
		and walk.y <= t.y + t.size*t.unit.range
		and walk.y >= t.y - t.size*t.unit.range then
			if (walk.type ~= 'water' and t.unit.type ~= 'boot') or 
			   (t.unit.type == 'boot' and walk.type == 'water') then
					walk.walkable = true
					print(t.x)
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

function board.walkToggle(x, y, t, unit)
	if not t.walking then
		for i,walking in pairs(board.tiles) do
			walking.walkable = false
			walking.walking = false
		end

		for i,walk in pairs(board.tiles) do
			if  walk.x <= t.x + t.size*t.unit.range
			and walk.x >= t.x - t.size*t.unit.range
			and walk.y <= t.y + t.size*t.unit.range
			and walk.y >= t.y - t.size*t.unit.range then
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

function board.walk(x, y, t, lastTile)
	if t.walkable then
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

function board.draw()



	-- love.graphics.setColor(52,82,40)
	-- love.graphics.rectangle("fill", 150, 0+1, 7*40, 7*40)

	-- love.graphics.setColor(175,175,175)
	-- love.graphics.rectangle("fill", 150 + 12*40, 0+1, 7*40, 7*40)

	-- love.graphics.setColor(197,179,153)
	-- love.graphics.rectangle("fill", 150, height - 7*40, 7*40, 7*40)

	-- love.graphics.setColor(21,34,20)
	-- love.graphics.rectangle("fill", 150 + 12*40, height - 7*40, 7*40, 7*40)

	-- love.graphics.setColor(207,181,59)
	-- love.graphics.rectangle("fill", 150 + 8*40, height - 11*40, 3*40, 3*40)



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
			love.graphics.setColor(255, 0,0)
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
			love.graphics.setColor(0, 0,0)
		elseif t.walkable then
			love.graphics.setColor(0, 255,0, 100)
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
			love.graphics.setColor(0,0,0)
		end

		love.graphics.setColor(0, 0,0)

		if t.base then
			love.graphics.print('BASE', t.x + 5, t.y)
		else
			love.graphics.print(t.type, t.x + 5, t.y)
		end
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("line", t.x, t.y, t.size, t.size)
	end
end