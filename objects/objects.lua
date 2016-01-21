objects = {}

function objects.load()
	objects.items = {}
	for j = 0, 10 do 
		item = {}
		item.x = 10 
		item.size = 50
		item.y = item.size * j * 2
		item.prefx = item.x
		item.prefy = item.size * j * 2
		item.centerx = item.x + item.size/2
		item.centery = item.y + item.size/2
		item.dragging = { active = false, diffX = 0, diffY = 0 }
		if j == 0 then
			item.type = 'worker'
			item.walkRange = 1
			item.attackRange = 0
		elseif j == 1 then
			item.type = 'soldaat'
			item.walkRange = 1
			item.attackRange = 1
		elseif j == 2 then
			item.type = 'tank'
			item.walkRange = 1
			item.attackRange = 2
		elseif j == 3 then
			item.type = 'robot'
			item.walkRange = 1
			item.attackRange = 1
		else
			item.type = 'boot'
			item.walkRange = 1
			item.attackRange = 0
		end

		-- item.type = 'soldaat'
		-- item.type = 'robot'
		-- item.type = 'tank'
		-- item.type = 'boot'


		-- item.type = 'barak'
		-- item.type = 'haven'

		table.insert(objects.items, item)
	end -- life
end -- life

function love.mousepressed(x, y, button)
	for _,object in pairs(objects.items) do
		if x > object.x and x < object.x + object.size
		and y > object.y and y < object.y + object.size
		then
			object.dragging.active = true
			object.dragging.diffX = x - object.x
			object.dragging.diffY = y - object.y
		end
	end
end

function love.mousereleased(x, y, button)
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

function objects.update(dt)
	for _,object in pairs(objects.items) do
		if object.dragging.active then
			object.x = love.mouse.getX() - object.dragging.diffX
			object.y = love.mouse.getY() - object.dragging.diffY
		end
	end
end

function objects.collision(x, y, i)
	for _,b in pairs(board.tiles) do 
		if x >= b.x and x <= b.x + b.size
		and y >= b.y and y <= b.y + b.size then
			if  b.type ~= 'water' or (objects.items[i].type == 'boot' and b.type == 'water') then
				b.unit = objects.items[i]
				b.occupied = true
				return false
			else
				return false
			end
		end
	end
end

function objects.move(x, y, object)
	if x > object.x and x < object.x + object.size
	and y > object.y and y < object.y + object.size then
		object.dragging.active = true
		object.dragging.diffX = x - object.x
		object.dragging.diffY = y - object.y
	end
end


function objects.draw(self)
	for _,i in pairs(objects.items) do
		love.graphics.setColor(255, 0, 0)
		love.graphics.rectangle('fill', i.x, i.y, i.size, i.size)
		love.graphics.setColor(0,0,0)
		love.graphics.print(i.type, i.x+5, i.y + 20)
	end
end


function OBJECTS_UPDATE(dt)
	objects.update(dt)
	objects.collision()
end