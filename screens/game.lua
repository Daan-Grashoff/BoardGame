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

	TEsound.playLooping("assets/music/track1.mp3", 'Background', 0)

	if settings:getConfigByKey("game_sound") == false then
		TEsound.pause(1)
	end

	timer = 0

	-- generate player
	players:generate(names)

	board.load()
	objects.load()
	unitspawn.load()
	--multiplayer.load()
end

function game:update(dt)


    -- timer = timer + dt

 	if timer >= 0.1 then
     	_base = board.getBaseById(currentPlayer.id)
      	ai(players:getActivePlayer(), _base)
        timer = 0
    end

	if settings:getConfigByKey("game_sound") == true and TEsound.channels[1]['playing'] == false then
		TEsound.resume(1)
	elseif settings:getConfigByKey("game_sound") == false and TEsound.channels[1]['playing'] == true then
		TEsound.pause(1)
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
  	board.draw()
	objects.draw()
	unitspawn.draw()
end
