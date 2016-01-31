-- Meta Class
Base = { id, color, type, health }
Base.__index = Base

-- constructor
function Base:new(id, color, type, health )
  self = setmetatable( {}, Base )
  self.m_id = id
  self.m_color = color
  self.m_type = type
  self.m_health = health

  self.selected = false

  return self
end

function Base:recruitUnits()
  self.selected = true
end

function Base:onPress()
  print("hi")
  self.selected = true
end

function Base:draw()
  if self.selected == true then
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill", 250, 100, 45, 45)
  end
end

return Base
