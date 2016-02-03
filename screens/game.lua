require "objects.settings"
require "objects.board"
require "objects.objects"
require "objects.cards"
require "objects.player"
require "objects.unitspawn"
require "lib.TEsound"
require "ai"

math.randomseed(os.time())
game = {}

function game:load()
	currentPlayer = 0
	settings:load()

	timer = 0

	if settings:getConfigByKey("game_sound") then
		-- TEsound.playLooping("assets/music/track1.mp3", 'Background', 0)
	end

	-- players:update({freq = 500, energy = 2})

	-- generate player
	players:generate(names)


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

    -- timer = timer + dt

 	if timer >= 0.1 then
     	_base = board.getBaseById(currentPlayer.id)
      	ai(players:getActivePlayer(), _base)
        timer = 0
    end

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
