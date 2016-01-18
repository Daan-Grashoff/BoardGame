objects = {}

function objects.load()
	objects.items = {}
	for j = 0, 10 do 
		item = {}
		item.x = 10
		item.y = 10
		item.height = 10
		item.width = 10
		table.insert(objects.items, item)
	end
end

function objects.draw(self)
	for _,i in pairs(objects.items) do
		love.graphics.setColor(255, 0, 0, 1)
		love.graphics.rectangle('fill', i.x, i.y, i.width, i.height)
	end
end