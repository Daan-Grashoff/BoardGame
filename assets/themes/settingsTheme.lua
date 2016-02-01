require 'constructor'

local Theme = {}

Theme.On = {}
Theme.On.draw = function(self)
	if self.hot then end
    if self.down then end
    if self.selected then end
    love.graphics.draw(ON, self.x, self.y+20)
    love.graphics.print("Game sound", self.x, self.y)
end

Theme.Off = {}
Theme.Off.draw = function(self)
	if self.hot then end
	if self.down then end
	if self.selected then end
	love.graphics.draw(OFF, self.x, self.y)
end

return Theme