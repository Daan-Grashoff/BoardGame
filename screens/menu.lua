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
	startLocalButton = UI.Button((love.graphics.getWidth() / 2) - (buttonSize / 2), maxCellHeight * 3.50, (buttonSize / 2) - 10, maxCellHeight, {extensions = {Menu.startLocalButton}, draggable = false})
	startMultiButton = UI.Button((love.graphics.getWidth() / 2), maxCellHeight * 3.50, (buttonSize / 2), maxCellHeight, {extensions = {Menu.startMultiButton}, draggable = false})
	resumeButton = UI.Button((love.graphics.getWidth() / 2) - (buttonSize / 2), maxCellHeight * 3.50, buttonSize, maxCellHeight, {extensions = {Menu.ResumeButton}, draggable = false})
	creditsButton = UI.Button((love.graphics.getWidth() / 2) - (buttonSize / 2), maxCellHeight * 4.75, buttonSize, maxCellHeight, {extensions = {Menu.CreditsButton}, draggable = false})
	helpButton = UI.Button((love.graphics.getWidth() / 2) - (buttonSize / 2), maxCellHeight * 6, buttonSize, maxCellHeight, {extensions = {Menu.HelpButton}, draggable = false})
	quitButton = UI.Button((love.graphics.getWidth() / 2) - (buttonSize / 2), maxCellHeight * 8.50, buttonSize, maxCellHeight, {extensions = {Menu.QuitButton}, draggable = false})
	tutorialButton = UI.Button((love.graphics.getWidth() / 2) - (buttonSize / 2), maxCellHeight * 7.25, buttonSize, maxCellHeight, {extensions = {Menu.TutorialButton}, draggable = false})
	settingsButton = UI.Button((love.graphics.getWidth() / 2) - 10, maxCellHeight * 9.75, maxCellHeight, maxCellHeight, {extensions = {Menu.SettingsButton}, draggable = false})
end

function menu:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(love.graphics.newFont(32))
    local text = 'Frequency'
    love.graphics.print(text, (love.graphics.getWidth() / 2) - (love.graphics.getFont():getWidth(text) / 2), maxCellHeight * 2.20)
	if GAME_LAUNCHED == false then
		startLocalButton:draw()
		startMultiButton:draw()
	else
		resumeButton:draw()
	end
	settingsButton:draw()
	creditsButton:draw()
	helpButton:draw()
	tutorialButton:draw()
	quitButton:draw()
	-- love.graphics.setColor(255, 255, 255)
end

function menu:update(dt)

	if GAME_LAUNCHED == false then
		startLocalButton:update(dt)
		startMultiButton:update(dt)
	else
		startLocalButton:update(dt)
		startMultiButton:update(dt)
		resumeButton:update()
	end

	settingsButton:update(dt)
	creditsButton:update(dt)
	helpButton:update(dt)
	tutorialButton:update(dt)
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
		IS_MULTIPLAYER = true
		screens:set("selection")
	elseif creditsButton.released then
		screens:set("credits")
	elseif helpButton.released then
		screens:set("help")
	elseif settingsButton.released then
		screens:set("settings")
	elseif tutorialButton.released then
		print('Here comes the turorial!')
		-- screens:set("tutorial")
	elseif quitButton.released then
		if GAME_LAUNCHED == false then
			love.event.quit()
		else
			-- game.restart()
			-- game = {}
			print('Have to remove old game data after press!')
			love.event.quit()
		end
	end
end
