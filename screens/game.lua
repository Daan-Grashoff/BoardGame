require "objects.settings"
require "objects.board"
require "objects.objects"
require "objects.cards"
require "objects.player"
require "objects.unitspawn"
require "lib.TEsound"

math.randomseed(os.time())
game = {}

function game:load()
	currentPlayer = 0
	settings:load()

	TEsound.playLooping("assets/music/track1.mp3", 'Background', 0)

	if settings:getConfigByKey("game_sound") == false then
		TEsound.pause(1)
	end

	-- generate player
	players:generate(names)

	board.load()
	objects.load()
	unitspawn.load()
end

function game:update(dt)
	if settings:getConfigByKey("game_sound") == true and TEsound.channels[1]['playing'] == false then
		TEsound.resume(1)
	end
	objects.update()
end

function game:keypressed(key, gameState)
  	if key == 'escape' then
  		if settings:getConfigByKey("game_sound") == true then
  			TEsound.pause(1)
  		end
  		gameState:set("menu")
  	end
end

function game:draw()
	love.graphics.print("GAME", 200, 100)
  	board.draw()
	objects.draw()
	unitspawn.draw()
end
