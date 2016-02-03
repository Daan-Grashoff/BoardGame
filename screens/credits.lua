credits = {}

local about = {
      {"CREATED BY", ""},
      {"Damien", " \"Programmer\" \n- Scaling\n- Android Support\n- Map Generation\n- Tile Mapping "},
      {"Daan", " \"Programmer\" \n- AI\n- Game Logic "},
      {"Steefnerd", " \"Programmer\" \n- Multiplayer Support\n- Screen Design\n- Save Settings"},
      {"Rickert", " \"Programmer\" \n- Settings\n- Sounds "},
      {"Bob", " \"Brogrammer\" "}
    }

scrollerIndex = 450

function credits:load()

end

function credits:update(dt)
  if scrollerIndex > -600 then
    scrollerIndex = scrollerIndex - 35 * love.timer.getDelta()
  else
    scrollerIndex = 100
  end
end

function credits:keypressed(key, gameState)
  if key == 'escape' then
  	gameState:set("menu")
  end
end

function credits:draw()
  for i, option in ipairs(about) do
		love.graphics.setColor(0, 255, 0)
		love.graphics.print(option, 50, 50 + i * 100 + scrollerIndex)
	end
end
