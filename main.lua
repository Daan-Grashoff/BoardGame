require 'screens.screensManager'
require 'lib.functions'


function love.load()

	width = 1080
	height = 763

  amountPlayers = 4

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
  elseif (screens:on("settings")) then
    settingsScreen:keypressed(key, screens)
  end

  -- exit game
  if key == 'escape' then
    love.event.quit()
  end  
end

function love.mousereleased(x, y, button)
  if (screens:on("game")) then
    for i,object in pairs(objects.items) do
      if object.dragging.active then
        object.dragging.active = false
        if not objects.collision(object.x + object.size/2, object.y + object.size/2, i) then
          object.x = object.prefx
          object.y = object.prefy
        end
      end
    end
  end
end

function love.mousepressed(x, y, button)
  if (screens:on("game")) then
    if x > board.endTurn.x
      and x < board.endTurn.x + board.endTurn.width
      and y > board.endTurn.y
      and y < board.endTurn.y + board.endTurn.height then
        players:update(players:getActivePlayer())
        for _,tiles in pairs(board.tiles) do
          board.reset(tiles)
          unitspawn.disable()
        end
    end

    for _,t in pairs(board.tiles) do
      if t.unloadboatspawning then
        for i,unit in pairs(t.unit.passengers) do       
          if x > t.x + (80 * (i-1))
          and x < t.x + (80 * (i-1)) + 80
          and y > t.y + tile.size
          and y < t.y + tile.size + 80 then
              board.spawn(t, unit, i, t.owner)
              return
          end
        end
      end

      -- select tile 
      if x > t.x
      and x < t.x + t.size
      and y > t.y 
      and y < t.y + t.size then

        if t.originalOwner ~= 0 then 
          -- printTable(players:getPlayerByID(t.originalOwner))
          -- printTable(players:getPlayerByID(t.originalOwner).tiles)
        end


        if t.owner > 0 then
          -- print(t.owner)
        end

        if t.unit.type == 'boot'
        and #t.unit.passengers ~= 0 then

        end

        -- check if tile is occupied
        -- check if owner of tile is active player
        if t.occupied 
        and t.owner == players:getActivePlayerId() 
        and players:getActivePlayerEnergy() ~= 0 then
          board.attackToggle(x, y, t)
        end


        -- check if tile is attackable
        if t.attackable and players:attack() then
          board.attack(x, y, t)
        end

        -- check if tile is attackable
        if t.unloadable then
          board.unloadBoatSpawn(t)
        end


        -- check if tile is occupied
        -- check if owner of tile is active player
        if t.occupied 
        and t.owner == players:getActivePlayerId()
        and players:getActivePlayerEnergy() ~= 0 then
          board.walkToggle(x, y, t)
        end


        -- check if tile is occupied
        -- check if owner of tile is active player
        if t.occupied 
        and t.owner == players:getActivePlayerId()
        and players:getActivePlayerEnergy() ~= 0
        and t.unit.type == 'boot'
        and not t.base
        and #t.unit.passengers ~= 0 then
          board.unloadToggle(x, y, t)
        end


        -- check if tile is walkable
        -- check if tile contains boat
        -- check if boat is not full
        -- check if boat is urs
        if t.loadable
        and t.owner == players:getActivePlayerId() 
        and t.unit.type == 'boot'
        and not t.base
        and #t.unit.passengers < 3 then 
          board.loadBoat(x, y, t)
        end

        -- check if tile is walkable
        -- check if tile is not occupied
        -- check if its no base tile
        if t.walkable 
        and not t.occupied
        and not t.base 
        and players:walk() then
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
            -- check if enough money and buy's item
            if t.spawning == true 
            and not t.occupied 
            and players:buyItem(prices[t.type][unit.name]) then
              -- spawn unit on tile
              unitspawn.spawn(t, objects.items[unit.n + 1])
              -- toggle all walkables on board
              board.walkFromBaseToggle(t, unit)
              -- set basewalk
              -- board.baseWalk(t, unit)
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
