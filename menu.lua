Menu = require 'Assets.Themes.Menu'
UI = require 'Libraries.thranduil.UI'

menu = {}

function menu:load()
	--menu.bgImage = love.graphics.newImage('assets/images/background.png')
	menu.options = {'Start game', 'Help', 'Credits', 'Quit'}
	menu.selectedOption = 1
	UI.registerEvents()

	startButton = UI.Button(200, 100, 100, 50, {extensions = {Menu.StartButton}, draggable = false})
	creditsButton = UI.Button(400, 100, 100, 50, {extensions = {Menu.CreditsButton}, draggable = false})
	helpButton = UI.Button(200, 200, 100, 50, {extensions = {Menu.HelpButton}, draggable = false})
	quitButton = UI.Button(400, 200, 100, 50, {extensions = {Menu.QuitButton}, draggable = false})
end

function menu:navigateTo(gameState)
	if menu.selectedOption == 1 then
		gameState:set("game")
  elseif menu.selectedOption == 2 then
		gameState:set("help")
  elseif menu.selectedOption == 3 then
		gameState:set("credits")
	elseif menu.selectedOption == 4 then
		love.event.quit()
	end
end


function menu:keypressed(key, gameState)
  if key == 'up' then
  	menu:previous()
  elseif key == 'down' then
  	menu:next()
  elseif key == 'return' then
  	menu:navigateTo(gameState)
  elseif key == 'escape' then
  	love.event.quit()
  end
end

function menu:next()
	menu.selectedOption = menu.selectedOption + 1
	if menu.selectedOption > #menu.options then
		menu.selectedOption = 1
	end
end

function menu:previous()
	menu.selectedOption = menu.selectedOption - 1
	if menu.selectedOption < 1 then
		menu.selectedOption = #menu.options
	end
end

function menu:draw()
	startButton:draw()
	creditsButton:draw()
	helpButton:draw()
	quitButton:draw()
	love.graphics.setColor(255, 255, 255)
	--love.graphics.draw(menu.bgImage, 0, 0)

	--love.graphics.setFont(fonts.bigFont)
	--love.graphics.setColor(255, 0, 0)

	--love.graphics.setFont(fonts.smallFont)
	--Will be removed because it will not be used
	for i, option in ipairs(menu.options) do

		if i == menu.selectedOption then
			love.graphics.setColor(255, 255, 0)
		else
			love.graphics.setColor(0, 255, 0)
		end

		--love.graphics.print(option, 50, 50 + i * 100)
	end
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