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
	-- love.graphics.print("MEEPE", 200, 100)
	-- love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10, 0, 5)
  	-- love.graphics.print("Pixel Ratio: "..tostring(love.window.getPixelScale( )), 10, 10)
  	-- love.graphics.printf("Help\n\n", 5, 50, 1100, 'center')

    -- love.graphics.print("This is a pretty lame example.", 10, 200)
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.print("Help", 500, 50, 0, 1.5, 1.5)
    love.graphics.print("Dit is de help tekst!", 500, 200, 0)
end
