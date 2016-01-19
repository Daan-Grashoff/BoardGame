local Selection = {}

-- Selection.twoPersons = love.graphics.newImage('assets/images/people-1-128.png')


	
Selection.TwoPersons = {}
Selection.TwoPersons.draw = function(self)
	love.graphics.draw(TWO_PERSON, self.x, self.y)
    if self.hot then
    end
    if self.down then
    end
    if self.selected then 
    end
end

Selection.FourPersons = {}
Selection.FourPersons.draw = function(self)
	love.graphics.draw(TWO_PERSON, self.x, self.y)
    if self.hot then
    end
    if self.down then
    end
    if self.selected then 
    end
end

return Selection