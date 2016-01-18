require "board"
require "objects"

game = {}

function game:load()
  -- loading classes
	board.load()

	objects.load()
end

function game:update(dt)
	objects.update()
end

function game:keypressed(key, gameState)
  if key == 'escape' then
  	gameState:set("menu")
  end
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

function game:draw()
	love.graphics.print("GAME", 200, 100)
  board.draw()
	objects.draw()
end
