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
	--love.graphics.print("MEEPE", 200, 100)
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10, 0, 5)
  	love.graphics.print("Pixel Ratio: "..tostring(love.window.getPixelScale( )), 10, 80, 0, 5)
end
