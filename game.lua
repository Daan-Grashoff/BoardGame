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


function game:draw()
	love.graphics.print("GAME", 200, 100)
  board.draw()
	objects.draw()
end
