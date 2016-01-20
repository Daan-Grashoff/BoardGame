local Selection = UI.Object:extend('Chatbox')

function Selection:new(x, y, w, h)
	UI.DefaultTheme = Theme
    self.main_frame = UI.Frame(x, y, w, h, {draggable = false, drag_margin = 20, disable_directional_selection = true, disable_tab_selection = true})

    self.textinput = UI.Textarea(5, 25 + h - 70 + 5, w - 50, h, {single_line = true, font = font, text_margin = 4})
    self.main_frame:addElement(self.textinput)

    self.twoPersons = UI.Button(200, 200, 128, 128, {extensions = {Theme.twoPersons}})
    self.main_frame:addElement(self.twoPersons)

end

function Selection:update(dt)
	text = self.textinput.text.str_text
	if self.twoPersons.pressed then
	    currentScreen = "game"
	end
    self.main_frame:update(dt)
end

function Selection:draw()
	self.main_frame:draw()
end

return Selection