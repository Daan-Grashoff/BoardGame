Menu = require 'assets.themes.menuTheme'
UI = require 'lib.thranduil'

menu = {}

--scale = love.window.getPixelScale( )

scale = 3

function menu:load()
	UI.registerEvents()

	startButton = UI.Button(25, 25 * scale, 500 * scale, 50 * scale, {extensions = {Menu.StartButton}, draggable = false})
	settingsButton = UI.Button(0, 0, 128, 128 * scale, {extensions = {Menu.SettingsButton}, draggable = false})
	creditsButton = UI.Button(25, 100 * scale, 500 * scale, 50 * scale, {extensions = {Menu.CreditsButton}, draggable = false})
	helpButton = UI.Button(25, 175 * scale, 500 * scale, 50 * scale, {extensions = {Menu.HelpButton}, draggable = false})
	quitButton = UI.Button(25, 250 * scale, 500 * scale, 50 * scale, {extensions = {Menu.QuitButton}, draggable = false})
end

function menu:draw()
	startButton:draw()
	settingsButton:draw()
	creditsButton:draw()
	helpButton:draw()
	quitButton:draw()
	love.graphics.setColor(255, 255, 255)
end

function menu:update(dt)
	startButton:update(dt)
	settingsButton:update(dt)
	creditsButton:update(dt)
	helpButton:update(dt)
	quitButton:update(dt)
	if startButton.released then
	    currentScreen = "selection"
	elseif creditsButton.released then
		currentScreen = "credits"
	elseif helpButton.released then
		currentScreen = "help"
	elseif settingsButton.released then
		currentScreen = "settings"
	elseif quitButton.released then
		love.event.quit()
	end
end
