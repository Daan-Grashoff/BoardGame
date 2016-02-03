function AiLoad()
	harbor = false
	soldierCnt = 0
end


function ai(player, _base)
	if player.currentEnergy ~= 0 then
		print('-------------------- AI TURN --------------------')

			if not _units then 
				_units = players:getUnits()
			end

			soldierCnt = 0

			-- if units = 0 spawn a worker
			if #_units == 0 then
				-- spawn a worker
				aiSpawnByID(player, _base, 1, true)
			end


			-- if not firstBoat then 
			_units = players:getUnits()
			-- end

			-- check if boat is full
			for _,units in pairs(_units) do
				if units.unit.type == 'boot'
				and #units.unit.passengers == 3 then
					_boat = true
				end
			end

			if not coast_tile then
				coast_tile = findCoast()
			end

			if not harbor then
				for _,units in pairs(_units) do
					if units.unit.type == 'worker' then
						if aiWalkToCordinates(units, coast_tile.corX, coast_tile.corY) then 
							if buildHarbor(units, coast_tile) then
								harbor = coast_tile
							end
						end
					end
				end
				if #_units < 4 then
					aiSpawnByID(player, _base, 2, true)
				end
			end

			if harbor and not firstBoat then 
				aiSpawnByID(player, coast_tile, 1, false)

				firstBoat = true
			end

			if firstBoat then

				for _,units in pairs(_units) do
					if units.unit.type == 'worker' then
						mousepressTile(units)
						getInBoat()
					end
				end


				if aiWalkToCordinates(_units[1], coast_tile.corX, coast_tile.corY, soldier) then 
					mousepressTile(_units[1])

					if getInBoat() then
						-- aiSpawnByID(player, _base, 2, true)
					end
				end
			end


			-- if harbor then
				-- aiSpawn(player, _base, 2)
			-- end

			-- if #units > 0 and not _boat then
			-- 	-- aiWalkForwards(player, units[1])
			-- 	if #units < 2 then
			-- 		aiSpawn(player, _base, 2)
			-- 	end
			-- 	units = players:getUnits()

			-- 	-- for _,i in pairs(units) do
			-- 	-- 	if i.unit.type == 'boot' then
			-- 	-- 	end 
			-- 	-- end

			-- 	if units[1].unit.type == 'boot' then
			-- 		aiWalkTo(player, units[1], units[2])
			-- 	else
			-- 		aiWalkTo(player, units[2], units[1])
			-- 	end
			-- 	-- aiWalkSidewards(player, units[1])
			-- else
			-- 	aiWalkToCordinates(units[1], -200, -200)
			-- end



		    -- _walkable = findWalkables()
			-- _unit = getRandomUnit()

		 --    if _walkable then
			-- 	love.mousepressed(_walkable.x+40, _walkable.y + 40, 2)
			-- elseif _unit then
			-- 	love.mousepressed(_unit.x + 40, _unit.y + 40, 2)
		 --    	_walkable = findWalkables()
	  --   	    if _walkable then
			-- 		love.mousepressed(_walkable.x+40, _walkable.y + 40, 2)
			-- 	end
			-- end	

			-- delay_s(player, _base,1)	
	end
end    

function aiSpawn(player, _base, id)  
	-- click on the base
	love.mousepressed(_base.x + 40, _base.y + 40, 2)

	-- loop through spawnable units
	for i,unit in pairs(unitspawn.units) do
		-- get "random unit"
		if i == 2 then
			-- click on unit you want to spawn
			love.mousepressed(unit.x + 40, unit.y + 40, 2)
			-- get all the walkables
			_walkable = findWalkables()
		    if _walkable then
		    	-- if there is a walkable click on it
				love.mousepressed(_walkable.x+40, _walkable.y + 40, 2)
			end
		end
	end
end

function aiWalkRight(unit)
	mousepressTile(unit)
	_newTileRight = board.getTile(unit.corX, unit.corY+1)
	if not _newTileRight then
		return false
	end
	if (_newTileRight and not _newTileRight.occupied and unit.unit.type ~= 'boot' and _newTileRight.type ~= 4) or (unit.unit.type == 'boot' and _newTileRight.type == 4) then
		mousepressTile(_newTileRight)
		return true
	else
		mousepressTile(unit)
		return false
	end
end

function aiWalkLeft(unit)
	mousepressTile(unit)
	_newTileLeft = board.getTile(unit.corX, unit.corY-1)
	if ((_newTileLeft and not _newTileLeft.occupied and unit.unit.typet ~= 'boot' and _newTileLeft.type ~= 4) or (unit.unit.type == 'boot' and _newTileLeft.type == 4)) then
		mousepressTile(_newTileLeft)
		return _newTileLeft
	else
		mousepressTile(unit)
		return false
	end
end

function aiWalkUp(unit)
	mousepressTile(unit)
	_newTileUp = board.getTile(unit.corX-1, unit.corY)
	if (_newTileUp and not _newTileUp.occupied and unit.unit.type ~= 'boot' and _newTileUp.type ~= 4) or (unit.unit.type == 'boot' and _newTileUp.type == 4) then
		mousepressTile(_newTileUp)
		return true
	else
		mousepressTile(unit)
		return false
	end
end

function aiWalkDown(unit)
	mousepressTile(unit)
	_newTileDown = board.getTile(unit.corX+1, unit.corY)
	if (_newTileDown and not _newTileDown.occupied and unit.unit.type ~= 'boot' and _newTileDown.type ~= 4) or (_newTileDown and unit.unit.type == 'boot' and _newTileDown.type == 4) then
		mousepressTile(_newTileDown)
		return true
	else
		mousepressTile(unit)
		return false
	end
end


function aiWalkToCordinates(unit, corX, corY, soldier)

	if (unit.corX-1 == corX
	or unit.corX+1 == corX 
	or unit.corX == corX)
	and (unit.corY-1 == corY
	or unit.corY+1 == corY 
	or unit.corY == corY) then
		return true
	end

	if unit.corY > corY and aiWalkLeft(unit) then
		-- print('walkleft -> ', aiWalkLeft(unit))
		print('walkleft -> ')
	elseif unit.corY < corY and aiWalkRight(unit) then
		-- print('walkright -> ', aiWalkRight(unit))
		print('walkright -> ')
	elseif unit.corX > corX and aiWalkUp(unit) then
		-- print('walkUp -> ', aiWalkUp(unit))
		print('walkUp -> ')
	elseif unit.corX < corX and aiWalkDown(unit) then
		print('walkDown -> ')
		-- print('walkDown -> ', aiWalkDown(unit))
	else
		aiWalkDown(aiWalkLeft(unit))

	end

end

function aiWalkTo(player, boot, unit)
	hor = boot.corX - unit.corX
	vert = boot.corY - unit.corY

	-- go to vertical
	if vert > 0 then
		aiWalkRight(unit)
	elseif vert < 0 then
		aiWalkLeft(unit)
	end
	-- got to bottom
	if hor > 0 then
		aiWalkDown(unit)
	elseif hor < 0 then
		aiWalkUp(unit)
	end

	getInBoat()
end


function getInBoat()
    for i,tile in pairs(board.tiles) do
    	if tile.loadable 
		and not tile.base then
			mousepressTile(tile)
			return true
    	end
    end
end

function buildHarbor(_unit, _tile)
	if not _tile.harbor then
		mousepressTile(_unit)
		mousepressTile(_tile)
	else
		return true
	end

end




function mousepressTile(tile)
	love.mousepressed(tile.x + 40, tile.y + 40, 2)
end

function aiSpawnByID(player, _base, id, move)  
	-- click on the base
	love.mousepressed(_base.x + 40, _base.y + 40, 2)

	-- loop through spawnable units
	for i,unit in pairs(units) do
		-- get "random unit"
		if i == id then
			-- click on unit you want to spawn
			love.mousepressed(unit.x + 40, unit.y + 40, 2)
			-- get all the walkables
			_walkable = findWalkables()
			-- if move is false dont spawn anywere
		    if _walkable 
		    and move then
		    	-- if there is a walkable click on it
				love.mousepressed(_walkable.x+40, _walkable.y + 40, 2)
			else
				
				love.mousepressed(_base.x+40, _base.y + 40, 2)
			end
		end
	end
end

function aiWalkForwards(player, unit)
	love.mousepressed(unit.x+40, unit.y + 40, 2)
	if unit.corX > 10 then
		_tile = board.getTile(unit.corX-1, unit.corY)
		if _tile.type ~= 4 then
			love.mousepressed(_tile.x+40, _tile.y + 40, 2)
		else
			love.mousepressed(unit.x+40, unit.y + 40, 2)
			return false
		end
	else 
		_tile = board.getTile(unit.corX+1, unit.corY)
		if _tile.type ~= 4 then
			love.mousepressed(_tile.x+40, _tile.y + 40, 2)
		else
			love.mousepressed(unit.x+40, unit.y + 40, 2)
			return false

		end
	end
	return aiWalkForwards(player, _tile)
end


function aiWalkSidewards(player, unit)
	if unit.type ~= 4 then
		love.mousepressed(unit.x+40, unit.y + 40, 2)
		if unit.corY > 10 then
			_tile = board.getTile(unit.corX, unit.corY-1)
			love.mousepressed(_tile.x+40, _tile.y + 40, 2)
		else 
			_tile = board.getTile(unit.corX, unit.corY+1)
			love.mousepressed(_tile.x+40, _tile.y + 40, 2)
		end
		return aiWalkSidewards(player, _tile)
	else
		return false
	end
end






function getRandomUnit()
	_units = {}
	for i,tile in pairs(board.tiles) do
		if tile.occupied 
		and not tile.base
		and tile.unit
        and tile.owner == players:getActivePlayerId() then
    		table.insert(_units, tile)
    	end
	end

	if #_units == 0 then
		return false
	end

	return _units[math.random(#_units)]
end

function findWalkables()
	local _walkables = {}
    for i,tile in pairs(board.tiles) do
    	if tile.walkable 
		and not tile.occupied
		and not tile.base then
    		table.insert(_walkables, tile)
    	end
    end
    -- _walkables[math.random(#_walkables)]
    if #_walkables == 0 then 
    	return false
    end

    return _walkables[math.random(#_walkables)]
end

function findCoast()
	local _walkables = {}
    for i,tile in pairs(board.tiles) do
		if tile.coast
		and tile.originalOwner == players:getActivePlayerId()
		and not tile.harbor
		and not tile.occupied then
    		table.insert(_walkables, tile)
    	end
    end
    -- _walkables[math.random(#_walkables)]
    if #_walkables == 0 then 
    	return false
    end

    return _walkables[math.random(#_walkables)]
end






