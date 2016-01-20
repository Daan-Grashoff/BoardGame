require 'objects.board'
unitspawn = {}

function unitspawn.load()
	unitspawn.active = false
	unitspawn.units = {}
	for i = 0, 1 do 
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
				'barak'
			}
		else
			unit.name = 'robot'
			unit.spawnpoint = {
				'barak'
			}
		end
		table.insert(unitspawn.units, unit)
	end

end

function unitspawn.update()

end

function unitspawn.spawn(tile, unit)
	tile.unit = unit
	tile.occupied = true
	unitspawn.show(tile)
end


function unitspawn.show(tile)
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

function unitspawn.draw()
	if unitspawn.active then
		for _,unit in pairs(unitspawn.units) do 
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("fill", unit.x, unit.y, unit.width,unit.height)
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line", unit.x, unit.y, unit.width,unit.height)
			love.graphics.print(unit.name, unit.x + 5, unit.y)
		end
	end


end