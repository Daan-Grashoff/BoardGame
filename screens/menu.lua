Menu = require 'assets.themes.menuTheme'
UI = require 'lib.thranduil'

menu = {}

--scale = love.window.getPixelScale( )
width, height = love.window.getMode()

scale = 1

function menu:load()
	UI.registerEvents()
	resumeButton = UI.Button(250, 125 * scale, 500 * scale, 50 * scale, {extensions = {Menu.ResumeButton}, draggable = false})
	startLocalButton = UI.Button(250, 125 * scale, 240 * scale, 50 * scale, {extensions = {Menu.startLocalButton}, draggable = false})
	startMultiButton = UI.Button(510, 125 * scale, 240 * scale, 50 * scale, {extensions = {Menu.startMultiButton}, draggable = false})
	settingsButton = UI.Button(900, 600, 128, 128 * scale, {extensions = {Menu.SettingsButton}, draggable = false})
	creditsButton = UI.Button(250, 200 * scale, 500 * scale, 50 * scale, {extensions = {Menu.CreditsButton}, draggable = false})
	helpButton = UI.Button(250, 275 * scale, 500 * scale, 50 * scale, {extensions = {Menu.HelpButton}, draggable = false})
	quitButton = UI.Button(250, 350 * scale, 500 * scale, 50 * scale, {extensions = {Menu.QuitButton}, draggable = false})
end

function menu:draw()
	if GAME_LAUNCHED == false then
		startLocalButton:draw()
		startMultiButton:draw()
	else
		resumeButton:draw()
	end
	settingsButton:draw()
	creditsButton:draw()
	helpButton:draw()
	quitButton:draw()
	-- love.graphics.setColor(255, 255, 255)
end

function menu:update(dt)
	startLocalButton:update(dt)
	startMultiButton:update(dt)
	resumeButton:update(dt)
	settingsButton:update(dt)
	creditsButton:update(dt)
	helpButton:update(dt)
	quitButton:update(dt)
	if startLocalButton.released then
		if GAME_LAUNCHED == false then
			screens:set("selection")
	    else
	      	screens:set("game")
		end
	elseif resumeButton.released then
	    screens:set("game")
	elseif startMultiButton.released then
		print("Have to implement multiplayer here!")
	elseif creditsButton.released then
		screens:set("credits")
	elseif helpButton.released then
		screens:set("help")
	elseif settingsButton.released then
		screens:set("settings")
	elseif quitButton.released then
		if GAME_LAUNCHED == false then
			love.event.quit()
		else
			-- game.restart()
			-- game = {}
			print('Have to remove old game data after press!')
		end
	end
end
