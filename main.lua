require 'screens.screensManager'

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
  elseif (screens:on("selection")) then
    selection:keypressed(key, screens)
  end
end

function love.mousepressed(x, y, button)
  if (screens:on("game")) then

    for _,t in pairs(board.tiles) do
      if x > t.x
      and x < t.x + t.size
      and y > t.y 
      and y < t.y + t.size then


        -- check click on unit and not spawntoggle
        if t.occupied then
          board.walkToggle(x, y, t)
        end

        -- check click on walkspot and not spawntoggle
        if t.walkable and not t.occupied and not t.base then
          -- walk function
          board.walk(x, y, t, lastTile)
        end

        -- check click on base
        if (t.base or t.barak) and not t.occupied then
            unitspawn.show(t)
        end
      end
    end
    for i,unit in pairs(unitspawn.units) do       
      if unitspawn.active then
        if x > unit.x
        and x < unit.x + unit.width
        and y > unit.y 
        and y < unit.y + unit.height then
          for _,t in pairs(board.tiles) do
            if t.spawning == true and not t.occupied then
              unitspawn.spawn(t, objects.items[unit.n + 1])
              board.walkFromBaseToggle(t, unit)
              board.baseWalk(t, unit)
            end
          end
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
