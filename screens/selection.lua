Theme = require('assets.themes.selectionTheme')
UI = require('lib.thranduil')
Chatbox = require("objects.selection")

selection = {}

function selection.load()
	UI.registerEvents()

	selectionFrame = Chatbox(0, 0, 1080, 763)

end

function selection.keypressed(key, gameState)
	if key == 'escape' then
		gameState:set('menu')
	end
end

function selection.update(dt)
	selectionFrame:update(dt)
end

function selection.draw()
	selectionFrame:draw()
end