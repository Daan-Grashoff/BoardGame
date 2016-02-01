help = {}
local helpText = "Het spelbord is een vierkant bord. Elke hoek van het bord heeft zijn eigen basis met zijn eigen klimaat.\n In het midden van het bord bevindt zich de goudmijn. Tussen de gebieden bevindt zich water. Het bord is opgedeeld in vakjes.\n Per vakje in je eigen gebied krijg je f 50, per vakje dat je in vijandelijk gebied hebt krijg je f 100 en in de goudmijn f 150 per vakje. \nAan de randen van het spelbord staat een legenda die je ondersteunt tijdens het spelen van het spel.\n In het eerste vakje van je eigen gebied, voor het moeras dus in de linkerbovenhoek,\n bevindt zich een barak die dienst doet als basis waaruit het spel begint."

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

  love.graphics.setColor(255, 255, 255)
  love.graphics.print("Help", 500, 50, 0, 1.5, 1.5)
  love.graphics.print(helpText, 100, 200, 0)
end
