require 'constructor'

local Menu = {}

scale = love.window.getPixelScale( )

Menu.StartButton = {}
Menu.StartButton.draw = function(self)
    love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print('Start Game', self.x + 230, self.y + 15, 0, scale)
    if self.selected then
        love.graphics.setColor(128, 32, 32)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(64, 64, 64)
end

Menu.CreditsButton = {}
Menu.CreditsButton.draw = function(self)
    love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print('Credits', self.x + 240, self.y + 15, 0, scale)
    if self.selected then
        love.graphics.setColor(128, 32, 32)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(64, 64, 64)
end

Menu.HelpButton = {}
Menu.HelpButton.draw = function(self)
    love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print('Help', self.x + 250, self.y + 15, 0, scale)
    if self.selected then
        love.graphics.setColor(128, 32, 32)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(64, 64, 64)
end

Menu.QuitButton = {}
Menu.QuitButton.draw = function(self)
    love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print('Quit', self.x + 250, self.y + 15, 0, scale)
    if self.selected then
        love.graphics.setColor(128, 32, 32)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(64, 64, 64)
end

Menu.SettingsButton = {}
Menu.SettingsButton.draw = function(self)
    love.graphics.setColor(64, 64, 64)
    love.graphics.draw(GEAR, 900, 600)
end

return Menu
