settings = require 'objects.settings'

local objScreen = UI.Object:extend('Chatbox')

function objScreen:new(x, y, w, h)
	settings:load()

	UI.DefaultTheme = Theme
	self.main_frame = UI.Frame(x, y, w, h, {draggable = false, drag_margin = 20, disable_directional_selection = true, disable_tab_selection = true})

	self.onButton = UI.Button(200, 200, 128, 128, {extensions = {Theme.On}})
	self.main_frame:addElement(self.onButton)

	self.offButton = UI.Button(350, 230, 128, 128, {extensions = {Theme.Off}})
	self.main_frame:addElement(self.offButton)
end

function objScreen:update(dt)
	if self.onButton.released then
	    if not settings:getConfigByKey('game_sound') then
	        settings:setConfig('game_sound', true)
	    end
	elseif self.offButton.released then
		if settings:getConfigByKey('game_sound') == true then
		    settings:setConfig('game_sound', false)
		end
	end
	self.main_frame:update(dt)
end

function objScreen:draw()
	self.main_frame:draw()
end

return objScreen