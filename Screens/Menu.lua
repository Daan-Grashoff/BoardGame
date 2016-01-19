Menu = require 'Assets.Themes.Menu'
UI = require 'Extensions.thranduil.UI'

menu = {}

function menu:load()
	UI.registerEvents()

	startButton = UI.Button(200, 100, 100, 50, {extensions = {Menu.StartButton}, draggable = false})
	creditsButton = UI.Button(400, 100, 100, 50, {extensions = {Menu.CreditsButton}, draggable = false})
	helpButton = UI.Button(200, 200, 100, 50, {extensions = {Menu.HelpButton}, draggable = false})
	quitButton = UI.Button(400, 200, 100, 50, {extensions = {Menu.QuitButton}, draggable = false})
end

function menu:draw()
	startButton:draw()
	creditsButton:draw()
	helpButton:draw()
	quitButton:draw()
	love.graphics.setColor(255, 255, 255)
end

function menu:update(dt)
	startButton:update(dt)
	creditsButton:update(dt)
	helpButton:update(dt)
	quitButton:update(dt)
	if startButton.pressed then
	    currentScreen = "game"
	elseif creditsButton.pressed then
		currentScreen = "credits"
	elseif helpButton.pressed then
		currentScreen = "help"
	elseif quitButton.pressed then
		love.event.quit()
	end
end