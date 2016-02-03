Theme = require('assets.themes.selectionTheme')
UI = require('lib.thranduil')
Chatbox = require("objects.selection")

selection = {}

function selection.load()
	UI.registerEvents()
	selectionFrame = Chatbox((love.graphics.getWidth() / 2) + 75, 50, 1080, 763)
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
    local text = 'Player selection'
    love.graphics.print(text, (love.graphics.getWidth() / 2) - (love.graphics.getFont():getWidth(text) / 2), maxCellHeight * 2.20)
    selectionFrame:draw()
end
