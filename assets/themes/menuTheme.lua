require 'constructor'

local Menu = {}

local oldFont = love.graphics.getFont()


Menu.startLocalButton = {}
Menu.startLocalButton.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    love.graphics.setColor(255, 255, 255)
    local text = 'Start local'
    love.graphics.print(text, self.x + (self.w / 2) - (love.graphics.getFont():getWidth(text) / 2), self.y + 15)
    if self.selected then
        love.graphics.setColor(128, 32, 32)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(64, 64, 64)
    love.graphics.setFont(oldFont)
end

Menu.startMultiButton = {}
Menu.startMultiButton.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    love.graphics.setColor(255, 255, 255)
    local text = 'Start multiplayer'
    love.graphics.print(text, self.x + (self.w / 2) - (love.graphics.getFont():getWidth(text) / 2), self.y + 15)
    if self.selected then
        love.graphics.setColor(128, 32, 32)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(64, 64, 64)
    love.graphics.setFont(oldFont)
end

Menu.ResumeButton = {}
Menu.ResumeButton.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    love.graphics.setColor(255, 255, 255)
    local text = 'Resume Game'
    love.graphics.print(text, self.x + (self.w / 2) - (love.graphics.getFont():getWidth(text) / 2), self.y + 15)
    if self.selected then
        love.graphics.setColor(128, 32, 32)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(64, 64, 64)
    love.graphics.setFont(oldFont)
end

Menu.CreditsButton = {}
Menu.CreditsButton.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    love.graphics.setColor(255, 255, 255)
    local text = 'Credits'
    love.graphics.print(text, self.x + (self.w / 2) - (love.graphics.getFont():getWidth(text) / 2), self.y + 15)
    if self.selected then
        love.graphics.setColor(128, 32, 32)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(64, 64, 64)
    love.graphics.setFont(oldFont)
end

Menu.HelpButton = {}
Menu.HelpButton.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    love.graphics.setColor(255, 255, 255)
    local text = 'Help'
    love.graphics.print(text, self.x + (self.w / 2) - (love.graphics.getFont():getWidth(text) / 2), self.y + 15)
    if self.selected then
        love.graphics.setColor(128, 32, 32)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(64, 64, 64)
    love.graphics.setFont(oldFont)
end

Menu.QuitButton = {}
Menu.QuitButton.draw = function(self)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    love.graphics.setColor(255, 255, 255)
    local text = 'Quit'
    love.graphics.print(text, self.x + (self.w / 2) - (love.graphics.getFont():getWidth(text) / 2), self.y + 15)
    if self.selected then
        love.graphics.setColor(128, 32, 32)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(64, 64, 64)
    love.graphics.setFont(oldFont)
end

Menu.SettingsButton = {}
Menu.SettingsButton.draw = function(self)
    love.graphics.setColor(64, 64, 64)
    love.graphics.draw(GEAR, self.x, self.y, self.w / 128, self.h / 128)
end

return Menu
