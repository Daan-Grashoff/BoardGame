require 'screens'

function love.load()

	width = 1080
	height = 763

	love.window.setMode(width, height)

	love.graphics.setBackgroundColor(45, 127, 180)

	screens.load()
end

function love:keypressed(key)
  if (screens:on("game")) then
    game:keypressed(key, screens)
  elseif (screens:on("help")) then
    help:keypressed(key, screens)
  elseif (screens:on("credits")) then
    credits:keypressed(key, screens)
  end
end

function love.mousepressed(x, y, button)
  if (screens:on("game")) then
    for _,t in pairs(board.tiles) do
      if x > t.x
      and x < t.x + t.width
      and y > t.y 
      and y < t.y + t.height then
        if t.atributes.tank then
          board.walkToggle(x, y, t)
        end
        if t.atributes.walk and not t.atributes.tank then
          board.walk(x, y, t, lastTile)
        end
      end
    end

    -- Moving objects (soldiers)
    for _,object in pairs(objects.items) do
      objects.move(x, y, object)
    end
  end
end

function love:update(dt)
  dt = math.min(1/60, love.timer.getDelta())
  --print(love.timer.getDelta())
  --screens:update(dt)
  UPDATE_SCREENS(dt)
end

function love.draw()
	DRAW_SCREENS()
end