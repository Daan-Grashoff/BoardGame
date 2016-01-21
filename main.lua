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

  if key == 'space' then
    players:update(players:getActivePlayer())
  end
end

function love.mousepressed(x, y, button)
  if (screens:on("game")) then
    for _,t in pairs(board.tiles) do
      -- select tile 
      if x > t.x
      and x < t.x + t.size
      and y > t.y 
      and y < t.y + t.size then



        if t.originalOwner ~= 0 then 
          -- printTable(players:getPlayerByID(t.originalOwner))
          -- printTable(players:getPlayerByID(t.originalOwner).tiles)
        end


        -- check if tile is occupied
        -- check if owner of tile is active player
        if t.occupied and t.owner == players:getActivePlayerId() then
          board.attackToggle(x, y, t)
        end


        -- check if tile is attackable
        if t.attackable then
          print('keke?')
          board.attack(x, y, t)
        end



        -- check if tile is occupied
        -- check if owner of tile is active player
        if t.occupied and t.owner == players:getActivePlayerId() then
          board.walkToggle(x, y, t)
        end

        -- check if tile is walkable
        -- check if tile is not occupied
        -- check if its no base tile
        if t.walkable 
        and not t.occupied 
        and not t.base then
          -- walk function
          board.walk(x, y, t, lastTile, players:getActivePlayerId())
        end

        -- check click on base or barak
        -- check if no units on tile
        -- check if owner of tile is active player
        -- check if owner has energy
        if (t.base or t.barak) 
        and not t.occupied 
        and t.owner == players:getActivePlayerId()
        and players:getActivePlayerEnergy() ~= 0 then
          print('keke')
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
            -- check if tile is spawning
            -- check if tile is not occupied
            if t.spawning == true and not t.occupied then
              -- spawn unit on tile
              unitspawn.spawn(t, objects.items[unit.n + 1])
              board.walkFromBaseToggle(t, unit)
              board.baseWalk(t, unit)        
              players.buyItem(prices[t.type][unit.name])
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
