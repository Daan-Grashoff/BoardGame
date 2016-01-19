credits = {}

local about = {
      {"CREATED BY", ""},
      {"Damien", " \"Programmer\" "},
      {"Daan", " \"Programmer\" "},
      {"Steefnerd", " \"Programmer\" "},
      {"Aanrickert", " \"Stofzuiger\" "},
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
