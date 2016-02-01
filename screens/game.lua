require "objects.settings"
require "objects.board"
require "objects.objects"
require "objects.player"
require "objects.unitspawn"
require "lib.TEsound"

math.randomseed(os.time())
game = {}

function game:load()
	currentPlayer = 0
	settings:load()

	if settings:getConfigByKey("game_sound") then
		--TEsound.playLooping("assets/music/track1.mp3", 'Background', 0)
	end

	-- players:update({freq = 500, energy = 2})
	board.load()
	objects.load()
	unitspawn.load()
end

function game:update(dt)
	-- if love.window.isVisible() == false then
	-- 	TEsound.pause(1)
	-- else
	-- 	TEsound.resume(1)
	-- end
	objects.update()
end

function game:keypressed(key, gameState)
  	if key == 'escape' then
  		if settings:getConfigByKey("game_sound") then
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
