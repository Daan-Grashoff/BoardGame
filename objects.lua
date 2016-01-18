objects = {}

function objects.load()
	objects.items = {}
	for j = 0, 10 do 
		item = {}
		item.x = 10 
		item.y = 25 * j * 2
 		item.height = 25
		item.width = 25
		item.centerx = item.x + item.width/2
		item.centery = item.y + item.height/2
		item.dragging = { active = false, diffX = 0, diffY = 0 }
		table.insert(objects.items, item)
	end
end

function love.mousepressed(x, y, button)
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

function love.mousereleased(x, y, button)
	for i,object in pairs(objects.items) do
		if object.dragging.active then
			object.dragging.active = false
			objects.collision(object.x + object.width/2, object.y + object.height/2, i)
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
		if x >= b.x and x <= b.x + b.width
		and y >= b.y and y <= b.y + b.height then
			b.atributes.tank = true
			table.remove(objects.items, i)
		end
	end
end


function objects.draw(self)
	for _,i in pairs(objects.items) do
		love.graphics.setColor(255, 0, 0)
		love.graphics.rectangle('fill', i.x, i.y, i.width, i.height)
	end
end


function OBJECTS_UPDATE(dt)
	objects.update(dt)
	objects.collision()
end