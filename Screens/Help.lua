help = {}

function help:load()

end

function help:update(dt)

end

function help:keypressed(key, gameState)
  if key == 'escape' then
  	gameState:set("menu")
  end
end

function help:draw()
	love.graphics.print("MEEPE", 200, 100)
end
