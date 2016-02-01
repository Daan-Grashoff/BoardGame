settingsTheme = require 'assets.themes.settingsTheme'
UI = require 'lib.thranduil'

settingsScreen = {}

--scale = love.window.getPixelScale( )

scale = 1

function settingsScreen:load()
	settings:load()
	UI.registerEvents()
	musicOn = UI.Button(50, 100 * scale, 128 * scale, 128 * scale, {extensions = {settingsTheme.musicOn}, draggable = false})
	musicOff = UI.Button(200, 100 * scale, 128 * scale, 128 * scale, {extensions = {settingsTheme.musicOff}, draggable = false})
end

function settingsScreen:draw()
  	love.graphics.print("Settings", 500, 50, 0, 1.5, 1.5)
	if settings:getConfigByKey('game_sound') then
		love.graphics.rectangle("fill", 50, 100 * scale, 128 * scale, 128 * scale)
	else
		love.graphics.rectangle("fill", 200, 100 * scale, 128 * scale, 128 * scale)
	end
	musicOn:draw()
	musicOff:draw()
end

function settingsScreen:keypressed(key, gameState)
	if key == 'escape' then
		gameState:set("menu")
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
