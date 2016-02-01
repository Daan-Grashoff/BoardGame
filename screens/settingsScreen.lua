Theme = require('assets.themes.settingsTheme')
--UI = require('lib.thranduil')
--objScreen = require('objects.settingsScreen')
require('objects.settings')

settingsScreen = {}

function settingsScreen:load()
	settings:load()
	--UI.registerEvents()
	--settingsFrame = objScreen(0, 0, 1080, 763)
end
settingsScreen:load()

function settingsScreen:keypressed(key, gamestate)
	if key == 'escape' then
	    gamestate:set("menu")
	end
end

function settingsScreen:update(dt)
	--settingsFrame:update(dt)
end

function settingsScreen:draw()
	if settings:getConfigByKey('game_sound') then
		love.graphics.rectangle("fill", 190, 220, 150, 135)
	else
		love.graphics.rectangle("fill", 340, 220, 150, 135)

	end
	--settingsFrame:draw()
end
