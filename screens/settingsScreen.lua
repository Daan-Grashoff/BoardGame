settingsTheme = require 'assets.themes.settingsTheme'
UI = require 'lib.thranduil'

settingsScreen = {}

--scale = love.window.getPixelScale( )

scale = 1
btnWidth = 112
btnHeight = 81
text = ""

function settingsScreen:load()
	settings:load()
	UI.registerEvents()
	musicOn = UI.Button(120, 150 * scale, btnWidth * scale, btnHeight * scale, {extensions = {settingsTheme.btnmusicOn}, draggable = false})
	musicOff = UI.Button(120 + btnWidth, 150 * scale, btnWidth * scale, btnHeight * scale, {extensions = {settingsTheme.btnmusicOff}, draggable = false})
	fullscreenOn = UI.Button(120, 350 * scale, btnWidth * scale, btnHeight * scale, {extensions = {settingsTheme.btnScreenOn}, draggable = false})
	fullscreenOff = UI.Button(120 + btnWidth, 350 * scale, btnWidth * scale, btnHeight * scale, {extensions = {settingsTheme.btnScreenOff}, draggable = false})
	boardsizeSmall = UI.Button(120, 550 * scale, btnWidth * scale, btnHeight * scale, {extensions = {settingsTheme.btnSmall}, draggable = false})
	boardsizeMedium = UI.Button(120 + btnWidth, 550 * scale, btnWidth * scale, btnHeight * scale, {extensions = {settingsTheme.btnMedium}, draggable = false})
	boardsizeLarge = UI.Button(120 + (btnWidth * 2), 550 * scale, btnWidth * scale, btnHeight * scale, {extensions = {settingsTheme.btnLarge}, draggable = false})
end

function settingsScreen:keypressed(key, gameState)
	if key == 'escape' then
		gameState:set("menu")
	end
end

function settingsScreen:updateMusic()
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

function settingsScreen:updateFullscreen(dt)
	fullscreenOn:update(dt)
	fullscreenOff:update(dt)

	if fullscreenOn.released then
	    if not settings:getConfigByKey('fullscreen') then
	        settings:setConfig('fullscreen', true)
	    end
	elseif fullscreenOff.released then
		if settings:getConfigByKey('fullscreen') == true then
		    settings:setConfig('fullscreen', false)
		end
	end
	if fullscreenOn.released or fullscreenOff.released then
		love.window.setFullscreen(settings:getConfigByKey("fullscreen"), "desktop")
	end
end

function settingsScreen:updateBoardsize()
	boardsizeSmall:update(dt)
	boardsizeMedium:update(dt)
	boardsizeLarge:update(dt)

	if boardsizeSmall.released then
	    if settings:getConfigByKey('boardsize') ~= 8 then
	        settings:setConfig('boardsize', 8)
	        text = "Next game will be started in small mode."
	    end
	elseif boardsizeMedium.released then
		if settings:getConfigByKey('boardsize') ~= 16 then
		    settings:setConfig('boardsize', 16)
	        text = "Next game will be started in medium mode."
		end
	elseif boardsizeLarge.released then
		if settings:getConfigByKey('boardsize') ~= 24 then
		    settings:setConfig('boardsize', 24)
	        text = "Next game will be started in large mode."
		end
	end
end

function settingsScreen:update(dt)
	settingsScreen:updateMusic()
	settingsScreen:updateFullscreen(dt)
	settingsScreen:updateBoardsize()
end

function settingsScreen:drawMusic()
	-- love.graphics.rectangle("fill", 200, 100 * scale, btnWidth * scale, btnHeight * scale)
	love.graphics.print("Ingame music", 190, 130, 0, 1, 1)
	-- love.graphics.rectangle("fill", 120, 200 * scale, (btnWidth * 2) * scale, btnHeight * scale)
	-- love.graphics.setColor(love.graphics.getBackgroundColor())
	musicOff:draw()
	musicOn:draw()
end

function settingsScreen:drawFullscreen()
	love.graphics.print("Fullscreen mode", 190, 330, 0, 1, 1)
	fullscreenOff:draw()
	fullscreenOn:draw()
end

function settingsScreen:drawBoardsize()
	love.graphics.print("Boardsize", 255, 530, 0, 1, 1)
	boardsizeSmall:draw()
	boardsizeMedium:draw()
	boardsizeLarge:draw()
	if text ~= "" then
		love.graphics.print(text, 125, 635, 0, 1, 1)
	end
end

function settingsScreen:draw()
	love.graphics.print("Settings", 500, 50, 0, 2, 2)
	settingsScreen:drawMusic()
	settingsScreen:drawFullscreen()
	settingsScreen:drawBoardsize()
end