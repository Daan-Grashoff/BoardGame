board = {}

scale = love.window.getPixelScale( )

function board.load()
	board.height = 18
	board.width = 18
	board.tiles = {}
	for i = 0 , board.width do
		for j = 0, board.height do
			tile = {}
			tile.height = 40 * scale
			tile.width = 40 * scale
			tile.x = tile.height * i + 150
			tile.y = tile.width * j + 2
			tile.atributes = {}
			tile.atributes.object = {}
			tile.atributes.tank = false
			tile.atributes.walk = false
			tile.atributes.walking = false
			if i  < 7 and j < 7 then
				tile.type = 'bos'
			elseif  i > 11 and j < 7 then
				tile.type = 'moeras'
			elseif i < 7 and j > 11 then
				tile.type = 'ijs'
			elseif i > 11 and j > 11 then
				tile.type = 'woestijn'
			else
				tile.type = 'water'
			end
			table.insert(board.tiles, tile)
		end
	end
end

function love.mousepressed(x, y, button)
	for _,t in pairs(board.tiles) do
		if x > t.x and x < t.x + t.width
		and y > t.y and y < t.y + t.height
		then
			t.atributes.tank = true
		end
	end

end

function board.walkToggle(x, y, t, object)
	if not t.atributes.walking then
		for i,walking in pairs(board.tiles) do
			walking.atributes.walk = false
			walking.atributes.walking = false
		end

		for i,walk in pairs(board.tiles) do
			if  walk.x <= t.x + t.width*t.atributes.object.range
			and walk.x >= t.x - t.width*t.atributes.object.range
			and walk.y <= t.y + t.height*t.atributes.object.range
			and walk.y >= t.y - t.height*t.atributes.object.range then
				if (walk.type ~= 'water' and t.atributes.object.type ~= 'boot') or (t.atributes.object.type == 'boot' and walk.type == 'water') then
					walk.atributes.walk = true
				end
			end

			if  walk.x <= t.x
			and walk.x >= t.x
			and walk.y <= t.y
			and walk.y >= t.y then
				walk.atributes.walking = true
			end
		end
	else
		if t.atributes.object then
			for _,walk in pairs(board.tiles) do
				-- if  walk.x <= t.x + 40*1
				-- and walk.x >= t.x - 40*1
				-- and walk.y <= t.y + 40*1
				-- and walk.y >= t.y - 40*1 then
				-- 	walk.atributes.walk = false
				-- end

				if walk.atributes.walking then
					walk.atributes.walking = false
				end
				walk.atributes.walk = false


				-- if  walk.x <= t.x
				-- and walk.x >= t.x
				-- and walk.y <= t.y
				-- and walk.y >= t.y then
				-- 	walk.atributes.walking = false
				-- end
			end
		end
	end
end

function board.walk(x, y, t, lastTile)
	--print('ayy')
	if t.atributes.walk then
		for _,walk in pairs(board.tiles) do
			if walk.atributes.walk then
				if walk.atributes.tank and walk.atributes.walking then
					walk.atributes.tank = false
					--print('test')
					t.atributes.object = walk.atributes.object
					walk.atributes.object = {}
				end
				walk.atributes.walk = false
			end
		end
		t.atributes.tank = true
		--print(t.atributes.object.type)
	end

end

function board.draw()

	tileSize = 40 * scale

	love.graphics.setColor(52,82,40)
	love.graphics.rectangle("fill", 150, 0+1, 7*tileSize, 7*tileSize)

	love.graphics.setColor(175,175,175)
	love.graphics.rectangle("fill", 150 + 12*40, 0+1, 7*tileSize, 7*tileSize)

	love.graphics.setColor(197,179,153)
	love.graphics.rectangle("fill", 150, height - 7*tileSize, 7*tileSize, 7*tileSize)

	love.graphics.setColor(21,34,20)
	love.graphics.rectangle("fill", 150 + 12*tileSize, height - 7*tileSize, 7*tileSize, 7*tileSize)

	love.graphics.setColor(207,181,59)
	love.graphics.rectangle("fill", 150 + 8*tileSize, height - 11*tileSize, 3*tileSize, 3*tileSize)



	for _,t in pairs(board.tiles) do
		if t.atributes.object.type then
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("fill", t.x, t.y, t.width, t.height)
			love.graphics.setColor(0,0,0)
			love.graphics.print(t.atributes.object.type, t.x+5, t.y + 20)
		end


		if t.atributes.tank then
			-- love.graphics.setColor(255, 0,0)
			-- love.graphics.rectangle("fill", t.x, t.y, t.width, t.height)
		elseif t.atributes.walk then
			love.graphics.setColor(0, 255,0, 100)
			love.graphics.rectangle("fill", t.x, t.y, t.width, t.height)
			love.graphics.setColor(0,0,0)
			love.graphics.print('walk', t.x + 5, t.y + 20)
		end
		love.graphics.print(t.type, t.x + 5, t.y)
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("line", t.x, t.y, t.width, t.height)
	end
end
