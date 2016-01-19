selection = {}

function selection:load()

end

function selection:keypressed(key, gameState)
	if key == 'escape' then
		gameState:set('menu')
	end
end

function selection:update(dt)

end

function selection:draw()
	
end