require 'constructor'

local Theme = {}

Theme.fourPersons = {}
Theme.fourPersons.draw = function(self)
    love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x - 10, self.y - 10, self.w + 20, self.h + 20)
    love.graphics.setColor(255, 255, 255)
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(FOUR_PERSON, self.x, self.y)
    if self.selected then
        love.graphics.setColor(128, 32, 32)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(64, 64, 64)
end

Theme.twoPersons = {}
Theme.twoPersons.draw = function(self)
    love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x - 10, self.y - 10, self.w + 20, self.h + 20)
    love.graphics.setColor(255, 255, 255)
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(TWO_PERSON, self.x, self.y)
    if self.selected then
        love.graphics.setColor(128, 32, 32)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(64, 64, 64)
end

-- local major, minor, rev = love.getVersion()
-- local love_version = major .. '.' .. minor .. '.' .. rev

-- Theme.Textarea = {}
-- Theme.Textarea.draw = function(self)
--     love.graphics.setLineStyle('rough')

--     -- Draw textinput background
--     love.graphics.setColor(24, 24, 24)
--     love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)

--     -- Draw selected text with inverted color and blue selection backgrou
--     love.graphics.setColor(128, 128, 128)
--     self.text:draw()

--     if self.selected and self.cursor_visible then 
--         love.graphics.setColor(128, 128, 128)
--         for i, _ in ipairs(self.selection_positions) do
--             love.graphics.line(self.selection_positions[i].x, self.selection_positions[i].y, 
--             self.selection_positions[i].x, self.selection_positions[i].y + self.selection_sizes[i].h)
--         end
--     end

--     if self.selected then end
--     love.graphics.setColor(255, 255, 255, 255)
-- end

-- Theme.Frame = {}
-- Theme.Frame.draw = function(self)
--     -- Draw frame
--     love.graphics.setColor(45, 127, 180)
--     love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)

--     -- Draw resize borders
--     if self.resizable then
--         love.graphics.setColor(16, 16, 16)
--         if self.resize_hot then love.graphics.setColor(48, 48, 48) end
--         if self.resizing then love.graphics.setColor(40, 40, 40) end
--         if not self.resize_corner then
--             love.graphics.rectangle('fill', self.x, self.y, self.w, self.resize_margin_top)
--             love.graphics.rectangle('fill', self.x, self.y + self.h - self.resize_margin_bottom, self.w, self.resize_margin_bottom)
--             love.graphics.rectangle('fill', self.x, self.y, self.resize_margin_left, self.h)
--             love.graphics.rectangle('fill', self.x + self.w - self.resize_margin_right, self.y, self.resize_margin_right, self.h)
--         else
--             if self.resize_corner == 'top-left' then
--                 love.graphics.rectangle('fill', self.x, self.y, self.resize_corner_width, self.resize_corner_height)
--             elseif self.resize_corner == 'top-right' then
--                 love.graphics.rectangle('fill', self.x + self.w - self.resize_corner_width, self.y, self.resize_corner_width, self.resize_corner_height)
--             elseif self.resize_corner == 'bottom-left' then
--                 love.graphics.rectangle('fill', self.x, self.y + self.h - self.resize_corner_height, self.resize_corner_width, self.resize_corner_height)
--             elseif self.resize_corner == 'bottom-right' then
--                 love.graphics.rectangle('fill', self.x + self.w - self.resize_corner_width, self.y + self.h - self.resize_corner_height, 
--                                         self.resize_corner_width, self.resize_corner_height)
--             end
--         end
--     end

--     -- Draw drag bar
--     if self.draggable then
--         love.graphics.setColor(16, 16, 16)
--         if self.drag_hot then love.graphics.setColor(48, 48, 48) end
--         if self.dragging then love.graphics.setColor(40, 40, 40) end
--         love.graphics.rectangle('fill', self.x + (self.resize_margin_left or 0), self.y + (self.resize_margin_top or 0),
--                                 self.w - ((self.resize_margin_left or 0) + (self.resize_margin_right or 0)), self.drag_margin)
--     end

--     if self.selected then end
-- end

return Theme