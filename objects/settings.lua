require 'lib.tserial.tserial'
require 'lib.functions'
require 'lib.save-tables'
settings = {}

function settings:load()
	if not love.filesystem.exists("settings.conf") then
	    settings:defaultConfig()
	end
	settings.config = Tserial.unpack(love.filesystem.read("settings.conf"), true)
end

function settings:getConfig()
	return settings.config
end

function settings:getConfigByKey(key)
	return settings.config[key]
end

function settings:setConfig(key, value)
	settings.config[key] = value
	settings:save()
end

function settings:save()
	love.filesystem.write("settings.conf", Tserial.pack(settings.config))
end

function settings:defaultConfig()
	configTable = {
		boardsize = 16,
		credits_sound = true,
		amount_players = 4,
		game_sound = true,
		fullscreen = false
	}
	love.filesystem.write("settings.conf", Tserial.pack(configTable))
end

return settings