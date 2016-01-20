require 'constructor'

local Theme = {}

Theme.twoPersons = {}
Theme.twoPersons.draw = function(self)
    --love.graphics.setColor(64, 64, 64)
    if self.hot then love.graphics.setColor(96, 96, 96) end
    if self.down then love.graphics.setColor(32, 32, 32) end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    if self.selected then end
	love.graphics.draw(TWO_PERSON, self.x, self.y)
end

Theme.Checkbox = {}
Theme.Checkbox.draw = function(self)
    love.graphics.setColor(64, 64, 64)
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    if self.hot then 
        love.graphics.setColor(96, 96, 96) 
        love.graphics.rectangle('fill', self.x + self.w/6, self.y + self.h/6, 4*self.w/6, 4*self.h/6)
    end
    if self.checked then
        love.graphics.setColor(128, 128, 128) 
        love.graphics.rectangle('fill', self.x + self.w/6, self.y + self.h/6, 4*self.w/6, 4*self.h/6)
    end
    if self.selected then 
        love.graphics.setColor(128, 32, 32) 
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
end

local major, minor, rev = love.getVersion()
local love_version = major .. '.' .. minor .. '.' .. rev

Theme.Textarea = {}
Theme.Textarea.draw = function(self)
    love.graphics.setLineStyle('rough')

    -- Draw textinput background
    love.graphics.setColor(24, 24, 24)
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)

    -- Draw selected text with inverted color and blue selection background
    if self.selection_index and self.index ~= self.selection_index then
        love.graphics.setColor(128, 128, 128)
        self.text:draw()

        if self.selected then
            love.graphics.setColor(51, 153, 255)
            for i, _ in ipairs(self.selection_positions) do
                love.graphics.rectangle('fill', self.selection_positions[i].x, self.selection_positions[i].y, self.selection_sizes[i].w, self.selection_sizes[i].h)
            end

            love.graphics.setColor(222, 222, 222)
            if love_version == '0.9.1' or love_version == '0.9.2' then
                for i, _ in ipairs(self.selection_positions) do
                    -- love.graphics.setStencil(function() 
                    --     love.graphics.rectangle('fill', self.selection_positions[i].x, self.selection_positions[i].y, self.selection_sizes[i].w, self.selection_sizes[i].h)
                    -- end)
                    self.text:draw()
                    --love.graphics.setStencil()
                end
            else
                for i, _ in ipairs(self.selection_positions) do
                    -- love.graphics.stencil(function() 
                    --     love.graphics.rectangle('fill', self.selection_positions[i].x, self.selection_positions[i].y, self.selection_sizes[i].w, self.selection_sizes[i].h)
                    -- end)
                    -- love.graphics.setStencilTest(true)
                    self.text:draw()
                    -- love.graphics.setStencilTest(false)
                end
            end
        end

    -- Draw text normally + cursor
    else
        love.graphics.setColor(128, 128, 128)
        self.text:draw()

        if self.selected and self.cursor_visible then 
            love.graphics.setColor(128, 128, 128)
            for i, _ in ipairs(self.selection_positions) do
                love.graphics.line(self.selection_positions[i].x, self.selection_positions[i].y, 
                self.selection_positions[i].x, self.selection_positions[i].y + self.selection_sizes[i].h)
            end
        end
    end

    love.graphics.setLineStyle('smooth')
    if self.selected then 
        love.graphics.setColor(128, 32, 32) 
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    end
    love.graphics.setColor(255, 255, 255, 255)
end

Theme.Frame = {}
Theme.Frame.draw = function(self)
    -- Draw frame
    love.graphics.setColor(45, 127, 180)
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)

    -- Draw resize borders
    if self.resizable then
        love.graphics.setColor(16, 16, 16)
        if self.resize_hot then love.graphics.setColor(48, 48, 48) end
        if self.resizing then love.graphics.setColor(40, 40, 40) end
        if not self.resize_corner then
            love.graphics.rectangle('fill', self.x, self.y, self.w, self.resize_margin_top)
            love.graphics.rectangle('fill', self.x, self.y + self.h - self.resize_margin_bottom, self.w, self.resize_margin_bottom)
            love.graphics.rectangle('fill', self.x, self.y, self.resize_margin_left, self.h)
            love.graphics.rectangle('fill', self.x + self.w - self.resize_margin_right, self.y, self.resize_margin_right, self.h)
        else
            if self.resize_corner == 'top-left' then
                love.graphics.rectangle('fill', self.x, self.y, self.resize_corner_width, self.resize_corner_height)
            elseif self.resize_corner == 'top-right' then
                love.graphics.rectangle('fill', self.x + self.w - self.resize_corner_width, self.y, self.resize_corner_width, self.resize_corner_height)
            elseif self.resize_corner == 'bottom-left' then
                love.graphics.rectangle('fill', self.x, self.y + self.h - self.resize_corner_height, self.resize_corner_width, self.resize_corner_height)
            elseif self.resize_corner == 'bottom-right' then
                love.graphics.rectangle('fill', self.x + self.w - self.resize_corner_width, self.y + self.h - self.resize_corner_height, 
                                        self.resize_corner_width, self.resize_corner_height)
            end
        end
    end

    -- Draw drag bar
    if self.draggable then
        love.graphics.setColor(16, 16, 16)
        if self.drag_hot then love.graphics.setColor(48, 48, 48) end
        if self.dragging then love.graphics.setColor(40, 40, 40) end
        love.graphics.rectangle('fill', self.x + (self.resize_margin_left or 0), self.y + (self.resize_margin_top or 0),
                                self.w - ((self.resize_margin_left or 0) + (self.resize_margin_right or 0)), self.drag_margin)
    end

    if self.selected then end
end

return Theme