settings = require 'objects.settings'

local Selection = UI.Object:extend('Chatbox')

function Selection:new(x, y, w, h)
	settings.load()

	UI.DefaultTheme = Theme
    self.main_frame = UI.Frame(x, y, w, h, {draggable = false, drag_margin = 20, disable_directional_selection = true, disable_tab_selection = true})

    -- self.textinput = UI.Textarea(5, 25 + h - 70 + 5, w - 50, h, {single_line = true, text_margin = 4})
    -- self.main_frame:addElement(self.textinput)

    self.twoPersons = UI.Button(((love.graphics.getWidth() / 4) - (love.graphics.getWidth() / 6)) , 200, (love.graphics.getWidth() / 6), (love.graphics.getWidth() / 6), {extensions = {Theme.twoPersons}})
    self.main_frame:addElement(self.twoPersons)

    self.fourPersons = UI.Button(((love.graphics.getWidth() / 4) - (love.graphics.getWidth() / 6)) + (love.graphics.getWidth() / 5), 200, (love.graphics.getWidth() / 6), (love.graphics.getWidth() / 6), {extensions = {Theme.fourPersons}})
    self.main_frame:addElement(self.fourPersons)

	-- self.backButton = UI.Button(500 + (btnWidth * 2), 550 * scale, btnWidth * scale, btnHeight * scale, {extensions = {settingsTheme.btnBack}, draggable = false})
	-- self.main_frame:addElement(self.backButton)
end

function Selection:update(dt)
	--text = self.textinput.text.str_text
	if self.twoPersons.released then
		GAME_LAUNCHED = true
		amountPlayers = 2
		game:load()
	  screens:set("game")
	elseif self.fourPersons.released then
		GAME_LAUNCHED = true
		amountPlayers = 4
		game:load()
		screens:set("game")
	end
    self.main_frame:update(dt)
end

function Selection:draw()
	self.main_frame:draw()
end

return Selection
