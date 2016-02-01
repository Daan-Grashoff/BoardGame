require 'constructor'

local Settings = {}

scale = love.window.getPixelScale( )

Settings.musicOn = {}
Settings.musicOn.draw = function(self)
    love.graphics.setColor(255, 255, 255)
	love.graphics.draw(ON, self.x, self.y)
end

Settings.musicOff = {}
Settings.musicOff.draw = function(self)
    love.graphics.setColor(255, 255, 255)
	love.graphics.draw(OFF, self.x, self.y)
end

return Settings
