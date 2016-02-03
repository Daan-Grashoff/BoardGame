Menu = require 'assets.themes.menuTheme'
UI = require 'lib.thranduil'

menu = {}

--scale = love.window.getPixelScale( )
--width, height = love.window.getMode()


-- [] [] [] 								[]
-- [] [Local] [Multiplayer]	[]
-- [] [Credits]							[]
-- [] [Help]								[]
-- [] [Exit] 								[]

maxCellWidth = love.graphics.getWidth() / 4
maxCellHeight = love.graphics.getHeight() / 12


function menu:load()
	UI.registerEvents()
	buttonSize = maxCellWidth * 2
	startLocalButton = UI.Button((love.graphics.getWidth() / 2) - (buttonSize / 2), maxCellHeight * 1.50, (buttonSize / 2) - 10, maxCellHeight, {extensions = {Menu.startLocalButton}, draggable = false})
	startMultiButton = UI.Button((love.graphics.getWidth() / 2), maxCellHeight * 1.50, (buttonSize / 2), maxCellHeight, {extensions = {Menu.startMultiButton}, draggable = false})
	resumeButton = UI.Button((love.graphics.getWidth() / 2) - (buttonSize / 2), maxCellHeight * 1.50, buttonSize, maxCellHeight, {extensions = {Menu.ResumeButton}, draggable = false})
	creditsButton = UI.Button((love.graphics.getWidth() / 2) - (buttonSize / 2), maxCellHeight * 2.75, buttonSize, maxCellHeight, {extensions = {Menu.CreditsButton}, draggable = false})
	helpButton = UI.Button((love.graphics.getWidth() / 2) - (buttonSize / 2), maxCellHeight * 4, buttonSize, maxCellHeight, {extensions = {Menu.HelpButton}, draggable = false})
	quitButton = UI.Button((love.graphics.getWidth() / 2) - (buttonSize / 2), maxCellHeight * 5.25, buttonSize, maxCellHeight, {extensions = {Menu.QuitButton}, draggable = false})

	settingsButton = UI.Button((love.graphics.getWidth() / 2), 0, maxCellHeight, maxCellHeight, {extensions = {Menu.SettingsButton}, draggable = false})

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
