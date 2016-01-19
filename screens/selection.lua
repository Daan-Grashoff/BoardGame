require 'constructor'

Selection = require 'assets.themes.selectionTheme'
UI = require 'lib.thranduil'

selection = {}

function selection:load()
	UI.registerEvents()

	twoPersons = UI.Button(300, 300, 128, 128, {extensions = {Selection.TwoPersons}, draggable = false})
	fourPersons = UI.Button(500, 300, 128, 128, {extensions = {Selection.FourPersons}, draggable = false})
end

function selection:keypressed(key, gameState)
	if key == 'escape' then
		gameState:set('menu')
	end
end

function selection:update(dt)
	twoPersons:update(dt)
	fourPersons:update(dt)
end

function selection:draw()
	twoPersons:draw()
	fourPersons:draw()
	if twoPersons.pressed then
	    print("2 spelers")
	elseif fourPersons.pressed then
		print("4 spelers")
	end
end