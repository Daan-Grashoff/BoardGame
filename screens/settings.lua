Theme = require('assets.themes.settingsTheme')
UI = require('lib.thranduil')
Chatbox = require('objects.settingsScreen')

settingsScreen = {}

function settingsScreen:load()
	UI.registerEvents()
	settingsFrame = Chatbox(0, 0, 1080, 763)
end
settingsScreen:load()

function settingsScreen:keypressed(key, gamestate)
	if key == 'escape' then
	    gamestate:set("menu")
	end
end

function settingsScreen:update(dt)
	settingsFrame:update(dt)
end

function settingsScreen:draw()
	settingsFrame:draw()
end