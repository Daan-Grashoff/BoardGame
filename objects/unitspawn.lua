require 'objects.board'
unitspawn = {}

function unitspawn.load()
	unitspawn.active = false
	unitspawn.units = {}
	units = {}
	for i = 0, 4 do
		unit = {}
		unit.n = i
		unit.x = 0
		unit.y = 0
		unit.width = 80
		unit.height = 80
		if i == 0 then
			unit.name = 'worker'
			unit.spawnBase = true
			unit.spawnHarbor = false
		elseif i == 1 then
			unit.name = 'soldier'
			unit.spawnBase = true
			unit.spawnHarbor = false
		elseif i == 2 then
			unit.name = 'tank'
			unit.spawnBase = true
			unit.spawnHarbor = false
		elseif i == 3 then
			unit.name = 'robot'
			unit.spawnBase = true
			unit.spawnHarbor = false
		else
			unit.name = 'boot'
			unit.spawnBase = false
			unit.spawnHarbor = true
		end
		table.insert(unitspawn.units, unit)
	end
end

function unitspawn.update()

end


function clone(t) -- deep-copy a table
    local target = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            target[k] = clone(v)
        else
            target[k] = v
        end
    end
    return target
end

function unitspawn.spawn(tile, unit)
	tile.unit = clone(unit)
	tile.occupied = true
	unitspawn.show(tile)
end


function unitspawn.show(tile)
	if not unitspawn.active then
		board.resetAll()
		for i,tile in pairs(board.tiles) do
			-- clear board
			tile.spawning = false
		end
		unitspawn.active = true
		tile.spawning = true

		units = spawnableUnits(tile)

		for i,unit in pairs(units) do 
			if tile.x > width/2 then 
				unit.x = tile.x - unit.width * (i-1) - 36
			else
				unit.x = tile.x + unit.width * (i-1)
			end


			if tile.y > height/2 then 
				unit.y = tile.y - 82
			else
				unit.y = tile.y + 44
			end

		end
	else
		unitspawn.active = false
		tile.spawning = false
	end
end

function spawnableUnits(tile)
	_spawnableUnits = {}
	if tile.base then
		for i, unit in pairs(unitspawn.units) do
			if unit.spawnBase then
				table.insert(_spawnableUnits, unit)
			end
		end
	elseif tile.harbor then
		for i, unit in pairs(unitspawn.units) do
			if unit.spawnHarbor then

				table.insert(_spawnableUnits, unit)
			end
		end
	end
	return _spawnableUnits
end

function containsValue(table, key)
    for _,item in pairs(table) do
    	if item == key then
    		return table
    	end
    end
    return false
end

function unitspawn.disable()
	if unitspawn.active then
		unitspawn.active = false
	end
end

function unitspawn.draw()
	if unitspawn.active and multiplayer.turn then
		for k,unit in pairs(units) do 
			baseType = ''
			bases = board.getBases()
			for _,base in pairs(bases) do
				if base.spawning then
					if base.type == 0 then
						baseType = 'moeras'
					elseif base.type == 1 then
						baseType = 'bos'
					elseif base.type == 2 then
						baseType = 'goldmine'
					elseif base.type == 3 then
						baseType = 'ijs'
					elseif base.type == 4 then
						baseType = 'water'
					else
						baseType = 'woestijn'
					end
				end
			end

			base = board.getBaseById(currentPlayer.id)

			if base.type == 0 then
				baseType = 'moeras'
			elseif base.type == 1 then
				baseType = 'bos'
			elseif base.type == 2 then
				baseType = 'goldmine'
			elseif base.type == 3 then
				baseType = 'ijs'
			elseif base.type == 4 then
				baseType = 'water'
			else
				baseType = 'woestijn'
			end


			love.graphics.setColor(122,122,122, 200)
			love.graphics.rectangle("fill", unit.x, unit.y, unit.width, unit.height)
			love.graphics.setColor(255,255,255)
			if k == 2 then
				_width = sprites[baseType]['soldier']:getWidth()/2
				_height = sprites[baseType]['soldier']:getHeight()
				love.graphics.draw(sprites[baseType]['soldier'], unit.x + _width, unit.y + _height, 0, 1.5)
			else
				_width = sprites[baseType][unit.name]:getWidth()/2
				if unit.name == 'tank' then
					_height = sprites[baseType][unit.name]:getHeight()-15
				elseif unit.name == 'robot' then
					_height = sprites[baseType][unit.name]:getHeight()-10
				else
					_height = sprites[baseType][unit.name]:getHeight()
				end
				love.graphics.draw(sprites[baseType][unit.name], unit.x + _width, unit.y + _height, 0, 1.5)
			end

			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line", unit.x, unit.y, unit.width,unit.height)
			love.graphics.setColor(255,255,255)

			love.graphics.printf(unit.name, unit.x, unit.y, 80, 'center')
			love.graphics.printf(prices[baseType][unit.name], unit.x, unit.y+15, 80, 'center')
		end
	end

	for k,t in pairs(board.tiles) do
		-- if boat is next to ground, and can load
		-- draw spawn buttons to let the units out
		if t.unloadboatspawning then
			for i,unit in pairs(t.unit.passengers) do 			
				if t.owner == 0 then
				    image = sprites['bos'][t.unit.type]
				else
				    image = sprites[players:getBaseByPlayer(t.owner)][unit.type]
				end
				-- set color white
				love.graphics.setColor(122,122,122, 200)
				love.graphics.rectangle("fill", t.x + (80 * (i-1)), t.y + tile.size, 80, 80)

				-- set sprite to block
				love.graphics.setColor(255,255,255)
				_width = image:getWidth()/2
				_height = image:getHeight()
				love.graphics.draw(image, t.x + (80 * (i-1)) + _width, t.y + tile.size + _height, 0, 1.5)

				-- set color black
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle("line", t.x + (80 * (i-1)), t.y + tile.size, 80,80)

				-- draw unit type name
				love.graphics.setColor(255,255,255)
				love.graphics.print(unit.type, t.x + (80 * (i-1)) + 5, t.y + tile.size)
			end
		end
	end

end
