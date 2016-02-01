settingsTheme = require 'assets.themes.settingsTheme'
UI = require 'lib.thranduil'

settingsScreen = {}

--scale = love.window.getPixelScale( )

scale = 1
btnWidth = 112
btnHeight = 81

function settingsScreen:load()
	settings:load()
	UI.registerEvents()
	musicOn = UI.Button(150, 200 * scale, btnWidth * scale, btnHeight * scale, {extensions = {settingsTheme.musicOn}, draggable = false})
	musicOff = UI.Button(250, 200 * scale, btnWidth * scale, btnHeight * scale, {extensions = {settingsTheme.musicOff}, draggable = false})
end

function settingsScreen:draw()
	settingsScreen:musicDraw()
end

function settingsScreen:keypressed(key, gameState)
	if key == 'escape' then
		gameState:set("menu")
	end
end

function settingsScreen:musicDraw()
	love.graphics.print("Settings", 500, 50, 0, 1.5, 1.5)
	-- love.graphics.rectangle("fill", 200, 100 * scale, btnWidth * scale, btnHeight * scale)
	love.graphics.setColor(255, 255, 255)
	if settings:getConfigByKey('game_sound') then
		musicOff:draw()
	else
		musicOn:draw()
	end
end

function settingsScreen:update(dt)
	musicOn:update(dt)
	musicOff:update(dt)

	if musicOn.released then
	    if not settings:getConfigByKey('game_sound') then
	        settings:setConfig('game_sound', true)
	    end
	elseif musicOff.released then
		if settings:getConfigByKey('game_sound') == true then
		    settings:setConfig('game_sound', false)
		end
	end
end
