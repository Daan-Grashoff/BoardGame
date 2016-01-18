menu = {}

function menu:load()
	menu.options = {'Start game', 'Help', 'Credits', 'Quit'}

	--menu.bgImage = love.graphics.newImage('assets/images/background.png')
	menu.selectedOption = 1
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
  end
end


function menu:draw()

	love.graphics.setColor(255, 255, 255)
	--love.graphics.draw(menu.bgImage, 0, 0)

	--love.graphics.setFont(fonts.bigFont)
	--love.graphics.setColor(255, 0, 0)

	--love.graphics.setFont(fonts.smallFont)

	for i, option in ipairs(menu.options) do

		if i == menu.selectedOption then
			love.graphics.setColor(255, 255, 0)
		else
			love.graphics.setColor(0, 255, 0)
		end

		love.graphics.print(option, 50, 50 + i * 100)
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

function menu:update(dt)
end
