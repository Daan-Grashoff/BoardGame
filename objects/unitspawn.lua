require 'objects.board'
unitspawn = {}

function unitspawn.load()
	unitspawn.active = false
	unitspawn.units = {}
	for i = 0, 4 do 
		unit = {}
		unit.n = i
		unit.x = 0
		unit.y = 0
		unit.width = 80
		unit.height = 80
		if i == 0 then
			unit.name = 'worker'
			unit.spawnpoint = {
				'base',
				'barak'
			}
		elseif i == 1 then
			unit.name = 'soldier'
			unit.spawnpoint = {
				'base',
				'barak'
			}
		elseif i == 2 then
			unit.name = 'tank'
			unit.spawnpoint = {
				'base',
				'barak'
			}
		elseif i == 3 then
			unit.name = 'robot'
			unit.spawnpoint = {
				'barak'
			}
		else
			unit.name = 'boot'
			unit.spawnpoint = {
				'barak'
			}
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
	-- tile.unit = clone(unit)
	tile.unit = unit
	tile.occupied = true
	unitspawn.show(tile)
end


function unitspawn.show(tile)

	board.getBases()
	for i,tile in pairs(board.tiles) do
		tile.spawning = false
		board.reset(tile)
	end


	if not unitspawn.active then
		unitspawn.active = true
		tile.spawning = true
		for i,unit in pairs(unitspawn.units) do 
			if tile.x > width/2 then 
				unit.x = tile.x - unit.width * (i-1) - 40
			else
				unit.x = tile.x + unit.width * (i-1) 
			end

			if tile.y > height/2 then 
				unit.y = tile.y - 80
			else
				unit.y = tile.y + 40
			end

		end
	else
		unitspawn.active = false
		tile.spawning = false
	end

end

function unitspawn.disable()
	if unitspawn.active then
		unitspawn.active = false
	end
end

function unitspawn.draw()
	if unitspawn.active then
		for k,unit in pairs(unitspawn.units) do 
			love.graphics.setColor(255,255,255)
			baseType = ''
			bases = board.getBases()
			for _,base in pairs(bases) do 
				if base.spawning then 
					baseType = base.type
				end
			end
			if k == 2 then
				love.graphics.rectangle("fill", unit.x, unit.y, unit.width,unit.height)
				love.graphics.draw(sprites[baseType]['soldaat'], unit.x, unit.y, 0, 1.5)
			else
				love.graphics.rectangle("fill", unit.x, unit.y, unit.width,unit.height)
			end
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line", unit.x, unit.y, unit.width,unit.height)
			love.graphics.print(unit.name, unit.x + 5, unit.y)
		end
	end

	for _,t in pairs(board.tiles) do
		-- if boat is next to ground, and can load
		-- draw spawn buttons to let the units out
		if t.unloadboatspawning then
			for i,unit in pairs(t.unit.passengers) do 
				-- set color white
				love.graphics.setColor(255,255,255)
				love.graphics.rectangle("fill", t.x + (80 * (i-1)), t.y + tile.size, 80, 80)
				-- set color black
				love.graphics.setColor(0,0,0)
				love.graphics.rectangle("line", t.x + (80 * (i-1)), t.y + tile.size, 80,80)
				-- draw unit type name
				love.graphics.print(unit.type, t.x + (80 * (i-1)) + 5, t.y + tile.size)
			end
		end
	end

end