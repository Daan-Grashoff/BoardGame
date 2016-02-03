Theme = require('assets.themes.selectionTheme')
UI = require('lib.thranduil')
Chatbox = require("objects.selection")

selection = {}

function selection.load()
	UI.registerEvents()
	selectionFrame = Chatbox(100, 50, 1080, 763)
end
selection.load()

function selection.keypressed(key, gameState)
	if key == 'escape' then
    	gameState:set("menu")
  	end
end

function selection.update(dt)
	selectionFrame:update(dt)
end

function selection.draw()
	love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(love.graphics.newFont(32))

	love.graphics.printf("Player Amount", (love.graphics.getWidth() / 6.5), 50, (love.graphics.getWidth() / 1.5), "center")
	selectionFrame:draw()
end
