require "objects.board"
require "objects.objects"
require "objects.cards"

game = {}

function game:load()
	board.load()

	card.load()

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
