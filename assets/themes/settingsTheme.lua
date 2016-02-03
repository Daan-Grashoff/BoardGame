local Settings = {}

ON = love.graphics.newImage('assets/images/on.PNG')
OFF = love.graphics.newImage('assets/images/off.PNG')
SMALL = love.graphics.newImage('assets/images/small.PNG')
MEDIUM = love.graphics.newImage('assets/images/medium.PNG')
LARGE = love.graphics.newImage('assets/images/large.PNG')

ONACTIVE = love.graphics.newImage('assets/images/on_active.PNG')
OFFACTIVE = love.graphics.newImage('assets/images/off_active.PNG')
SMALLACTIVE = love.graphics.newImage('assets/images/small_active.PNG')
MEDIUMACTIVE = love.graphics.newImage('assets/images/medium_active.PNG')
LARGEACTIVE = love.graphics.newImage('assets/images/large_active.PNG')
-- scale = love.window.getPixelScale( )

Settings.btnmusicOn = {}
Settings.btnmusicOn.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(255, 255, 255)
	if settings:getConfigByKey('game_sound') then
		love.graphics.draw(ONACTIVE, self.x, self.y)
	else
		love.graphics.draw(ON, self.x, self.y)
	end
end

Settings.btnmusicOff = {}
Settings.btnmusicOff.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(255, 255, 255)
	if settings:getConfigByKey('game_sound') then
		love.graphics.draw(OFF, self.x, self.y)
	else
		love.graphics.draw(OFFACTIVE, self.x, self.y)
	end
end

Settings.btnScreenOn = {}
Settings.btnScreenOn.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(255, 255, 255)
    if settings:getConfigByKey('fullscreen') then
		love.graphics.draw(ONACTIVE, self.x, self.y)
	else
		love.graphics.draw(ON, self.x, self.y)
	end
end

Settings.btnScreenOff = {}
Settings.btnScreenOff.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(255, 255, 255)    
    if settings:getConfigByKey('fullscreen') then
		love.graphics.draw(OFF, self.x, self.y)
	else
		love.graphics.draw(OFFACTIVE, self.x, self.y)
	end
end

Settings.btnSmall = {}
Settings.btnSmall.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(255, 255, 255)
	love.graphics.draw(SMALL, self.x, self.y)
	if settings:getConfigByKey('boardsize') == 8 then
		love.graphics.draw(SMALLACTIVE, self.x, self.y)
	else
		love.graphics.draw(SMALL, self.x, self.y)
	end
end

Settings.btnMedium = {}
Settings.btnMedium.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(255, 255, 255)
	if settings:getConfigByKey('boardsize') == 16 then
		love.graphics.draw(MEDIUMACTIVE, self.x, self.y)
	else
		love.graphics.draw(MEDIUM, self.x, self.y)
	end
end

Settings.btnLarge = {}
Settings.btnLarge.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(255, 255, 255)
    if settings:getConfigByKey('boardsize') == 24 then
		love.graphics.draw(LARGEACTIVE, self.x, self.y)
	else
		love.graphics.draw(LARGE, self.x, self.y)
	end
end

return Settings
