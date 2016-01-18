require "board"
require "objects"

function love.load()

	width = 1080
	height = 763
	love.window.setTitle = 'Board Game'

	love.window.setMode(width, height)

	love.graphics.getBackgroundColor(255, 255, 255)

	-- loading classes
	board.load()

	objects.load()

end

function love.update(dt)
	-- UPDATE PLAYER
	if love.keyboard.isDown('escape') then
		love.event.quit()
	end

	objects.update()
end

function love.mousepressed(x, y, button)
	for _,t in pairs(board.tiles) do
		if x > t.x and x < t.x + t.width
		and y > t.y and y < t.y + t.height
		and t.atributes.tank
		then
			print('menu')
		end
	end
	for _,object in pairs(objects.items) do
		if x > object.x and x < object.x + object.width
		and y > object.y and y < object.y + object.height
		then
			object.dragging.active = true
			object.dragging.diffX = x - object.x
			object.dragging.diffY = y - object.y
		end
	end

end


function love.draw()

	-- draw player
	board.draw()
	objects.draw()
end