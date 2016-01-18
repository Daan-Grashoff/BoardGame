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
  elseif (screens:on("menu")) then
    menu:keypressed(key, screens)
  elseif (screens:on("credits")) then
    credits:keypressed(key, screens)
  end
end

function love.mousepressed(x, y, button)
  for _,t in pairs(board.tiles) do
    if x > t.x and x < t.x + t.width
    and y > t.y and y < t.y + t.height
    and t.atributes.tank
    then
      print('menu')
    end
  end
  for _,object in pairs(objects.items) do
    if x > object.x and x < object.x + object.width
    and y > object.y and y < object.y + object.height
    then
      object.dragging.active = true
      object.dragging.diffX = x - object.x
      object.dragging.diffY = y - object.y
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
