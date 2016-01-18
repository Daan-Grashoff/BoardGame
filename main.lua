require 'screens'

function love.load()

	width = 1080
	height = 763
	love.window.setTitle = 'Board Game'

	love.window.setMode(width, height)

	love.graphics.setBackgroundColor(45, 127, 180)

	screens.load()
end

function love:keypressed(key)
  if (screens:on("game")) then
    game:keypressed(key, screens)
  elseif (screens:on("help")) then
    help:keypressed(key, screens)
  elseif (screens:on("menu")) then
    menu:keypressed(key, screens)
  elseif (screens:on("credits")) then
    credits:keypressed(key, screens)
  end
end

function love:update(dt)
  dt = math.min(1/60, love.timer.getDelta())
  --print(love.timer.getDelta())
  -- screens:update(dt)
  UPDATE_SCREENS(dt)
end


function love.draw()
	DRAW_SCREENS()
end
