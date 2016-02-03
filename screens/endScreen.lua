Menu = require 'assets.themes.menuTheme'
UI = require 'lib.thranduil'

endScreen = {}

maxCellWidth = love.graphics.getWidth() / 4
maxCellHeight = love.graphics.getHeight() / 12

function endScreen:load()
	UI.registerEvents()
	buttonSize = maxCellWidth * 2
	quitButton = UI.Button((love.graphics.getWidth() / 2) - (buttonSize / 2), maxCellHeight * 8.50, buttonSize, maxCellHeight, {extensions = {Menu.QuitButton}, draggable = false})
end

function endScreen:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(love.graphics.newFont(32))
    local text = 'End of game!'
    love.graphics.print(text, (love.graphics.getWidth() / 2) - (love.graphics.getFont():getWidth(text) / 2), maxCellHeight * 2.20)
	if winner then
		love.graphics.print(winner, (love.graphics.getWidth() / 2) - (love.graphics.getFont():getWidth(text) / 2), maxCellHeight * 4.75)
	end
	quitButton:draw()
	-- love.graphics.setColor(255, 255, 255)
end

function endScreen:update(dt)
	quitButton:update(dt)
	if quitButton.released then
		love.event.quit()
	end
end
