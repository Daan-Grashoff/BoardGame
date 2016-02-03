local Settings = {}

ON = love.graphics.newImage('assets/images/on.png')
OFF = love.graphics.newImage('assets/images/off.png')
SMALL = love.graphics.newImage('assets/images/small.png')
MEDIUM = love.graphics.newImage('assets/images/medium.png')
LARGE = love.graphics.newImage('assets/images/large.png')

ONACTIVE = love.graphics.newImage('assets/images/on_active.png')
OFFACTIVE = love.graphics.newImage('assets/images/off_active.png')
SMALLACTIVE = love.graphics.newImage('assets/images/small_active.png')
MEDIUMACTIVE = love.graphics.newImage('assets/images/medium_active.png')
LARGEACTIVE = love.graphics.newImage('assets/images/large_active.png')
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

Settings.btnBack = {}
Settings.btnBack.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(255, 255, 255)
	love.graphics.print("< Back", self.x, self.y, 0, 1, 1)

end

return Settings
