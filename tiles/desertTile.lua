-- Meta Class
DesertTile = { id, color, boardSize, image, size, type, f}
DesertTile.__index = DesertTile

-- constructor
function DesertTile:new(id, color, boardSize, image, size, type, f)
  self = setmetatable( {}, DesertTile )
  self.m_id = id
  self.m_boardSize = boardSize
  self.m_color = color
  self.m_image = image
  self.m_type = type
  self.m_size = size
  self.f = {}

  self.selected = false

  offsetX = (self.m_id % (self.m_boardSize + 1)) * (self.m_size * 2) + 150
  offsetY = math.floor((self.m_id / (self.m_boardSize + 1))) * (self.m_size * 2) + 1

  if f == 'c' then
    self.f = {
      {Image = self.m2, X = offsetX, Y = offsetY, Scale = (self.m_size / 32)},
      {Image = self.m2, X = (offsetX + self.m_size), Y = offsetY, Scale = (self.m_size / 32)},
      {Image = self.m2, X = (offsetX + self.m_size), Y = (offsetY + self.m_size), Scale = (self.m_size / 32)},
      {Image = self.m2, X = offsetX, Y = (offsetY + self.m_size), Scale = (self.m_size / 32)}
    }
  elseif f == 'r' then
    self.f = {
      {Image = self.m2, X = offsetX, Y = offsetY, Scale = (self.m_size / 32)},
      {Image = self.r2, X = (-5 + offsetX + self.m_size), Y = offsetY, Scale = (self.m_size / 32)},
      {Image = self.r2, X = (-5 + offsetX + self.m_size), Y = (offsetY + self.m_size), Scale = (self.m_size / 32)},
      {Image = self.m2, X = offsetX, Y = (offsetY + self.m_size), Scale = (self.m_size / 32)}
    }
  elseif f == 't' then
    self.f = {
      {Image = self.m1, X = (offsetX), Y = (5 + offsetY), Scale = (self.m_size / 32)},
      {Image = self.m1, X = (offsetX + self.m_size), Y = (5 + offsetY), Scale = (self.m_size / 32)},
      {Image = self.m2, X = (offsetX + self.m_size), Y = (offsetY + self.m_size), Scale = (self.m_size / 32)},
      {Image = self.m2, X = (offsetX), Y = (offsetY + self.m_size), Scale = (self.m_size / 32)}
    }
  elseif f == 'rc' then
    self.f = {
      {Image = self.m2, X = offsetX, Y = offsetY, Scale = (self.m_size / 32)},
      {Image = self.r2, X = (-5 + offsetX + self.m_size), Y = offsetY, Scale = (self.m_size / 32)},
      {Image = self.r3, X = (-5 + offsetX + self.m_size), Y = (-5 + offsetY + self.m_size), Scale = (self.m_size / 32)},
      {Image = self.m3, X = (-5 + offsetX), Y = (-5 + offsetY + self.m_size), Scale = (self.m_size / 32)}
    }
  elseif f == 'rt' then
    self.f = {
      {Image = self.m1, X = (offsetX), Y = (5 + offsetY), Scale = (self.m_size / 32)},
      {Image = self.r1, X = (-5 + offsetX + self.m_size), Y = (5 + offsetY), Scale = (self.m_size / 32)},
      {Image = self.r2, X = (-5 + offsetX + self.m_size), Y = (offsetY + self.m_size), Scale = (self.m_size / 32)},
      {Image = self.m2, X = (offsetX), Y = (offsetY + self.m_size), Scale = (self.m_size / 32)}
    }
  elseif f == 'l' then
    self.f = {
      {Image = self.l2, X = (5 + offsetX), Y = offsetY, Scale = (self.m_size / 32)},
      {Image = self.m2, X = (5 + offsetX + self.m_size), Y = offsetY, Scale = (self.m_size / 32)},
      {Image = self.m2, X = (5 + offsetX + self.m_size), Y = (offsetY + self.m_size), Scale = (self.m_size / 32)},
      {Image = self.l2, X = (5 + offsetX), Y = (offsetY + self.m_size), Scale = (self.m_size / 32)}
    }
  elseif f == 'lt' then
    self.f = {
      {Image = self.l1, X = (5 + offsetX), Y = (5 + offsetY), Scale = (self.m_size / 32)},
      {Image = self.m1, X = (5 + offsetX + self.m_size), Y = (5 + offsetY), Scale = (self.m_size / 32)},
      {Image = self.m2, X = (5 + offsetX + self.m_size), Y = (offsetY + self.m_size), Scale = (self.m_size / 32)},
      {Image = self.l2, X = (5 + offsetX), Y = (offsetY + self.m_size), Scale = (self.m_size / 32)}
    }
  elseif f == 'lc' then
    self.f = {
      {Image = self.l2, X = (5 + offsetX), Y = offsetY, Scale = (self.m_size / 32)},
      {Image = self.r2, X = (5 + offsetX + self.m_size), Y = offsetY, Scale = (self.m_size / 32)},
      {Image = self.m3, X = (5 + offsetX + self.m_size), Y = (-5 + offsetY + self.m_size), Scale = (self.m_size / 32)},
      {Image = self.l3, X = (5 + offsetX), Y = (-5 + offsetY + self.m_size), Scale = (self.m_size / 32)}
    }
  elseif f == 'b' then
    self.f = {
      {Image = self.m2, X = offsetX, Y = offsetY, Scale = (self.m_size / 32)},
      {Image = self.m2, X = (offsetX + self.m_size), Y = offsetY, Scale = (self.m_size / 32)},
      {Image = self.m3, X = (offsetX + self.m_size), Y = (-5 + offsetY + self.m_size), Scale = (self.m_size / 32)},
      {Image = self.m3, X = (offsetX), Y = (-5 + offsetY + self.m_size), Scale = (self.m_size / 32)}
    }
  end


  return self
end

function DesertTile:load()
  self.l1 = love.graphics.newImage('assets/images/desert/l1.png')
  self.l2 = love.graphics.newImage('assets/images/desert/l2.png')
  self.l3 = love.graphics.newImage('assets/images/desert/l3.png')
  self.m1 = love.graphics.newImage('assets/images/desert/m1.png')
  self.m2 = love.graphics.newImage('assets/images/desert/m2.png')
  self.m3 = love.graphics.newImage('assets/images/desert/m3.png')
  self.r1 = love.graphics.newImage('assets/images/desert/r1.png')
  self.r2 = love.graphics.newImage('assets/images/desert/r2.png')
  self.r3 = love.graphics.newImage('assets/images/desert/r3.png')
end

function DesertTile:onPress()
  self.selected = true
  -- print(self.m_type)
end

function DesertTile:draw()
  --(i % (Board.size + 1)) * tile.size, math.floor((i / (Board.size + 1))) * tile.size
  love.graphics.setColor(255,255,255)
  for _, t in pairs(self.f) do
    love.graphics.draw(t.Image, t.X, t.Y, 0, t.Scale)
  end
end

return DesertTile
