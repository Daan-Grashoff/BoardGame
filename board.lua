board = {}

function board.load()
	board.height = 18
	board.width = 18
	board.tiles = {}
	for i = 0 , board.width do 
		for j = 0, board.height do
			tile = {}
			tile.n = j
			tile.height = 40
			tile.width = 40
			tile.x = tile.height * i + 150
			tile.y = tile.width * j + 2
			tile.atributes = {}
			tile.atributes.tank = false
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

function board.draw()
	for _,t in pairs(board.tiles) do
		if t.atributes.tank then
			love.graphics.setColor(255, 0,0)
			love.graphics.rectangle("fill", t.x, t.y, t.width, t.height)
		end
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("line", t.x, t.y, t.width, t.height)

	end
end