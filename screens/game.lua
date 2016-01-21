require "objects.board"
require "objects.objects"
require "objects.cards"
require "objects.player"
require "objects.unitspawn"
require "lib.TEsound"

math.randomseed(os.time())
game = {}

function game:load()
	-- TEsound.playLooping("assets/music/track1.mp3", 'Background', 999)

	names = {
		'Rick',
		'Demian',
		'Bob',
		'Stefan'
	}

	-- generate player
	players:generate(names)
	-- players:update({freq = 500, energy = 2})
	
	board.load()
	objects.load()
	unitspawn.load()

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
	unitspawn.draw()
end
