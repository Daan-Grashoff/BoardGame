player = {}


function player.load()
	player.x = 5
	player.y = 5

	player.xvel = 0
	player.yvel = 0

	player.friction = 7
	player.speed = 2000

	player.width = 50
	player.height = 50
end

function player.update()

end

function player.physics(dt)
	player.x = player.x + player.xvel * dt
	player.yvel = player.yvel + gravity * dt
	player.y = player.y + player.yvel * dt
	player.xvel = player.xvel * (1 - math.min(dt*player.friction, 1))
end 

function player.move(dt)
	if love.keyboard.isDown('right') and 
	player.xvel < player.speed then 
		player.xvel = player.xvel + player.speed * dt
	end
	if love.keyboard.isDown('left') and
	player.xvel > -player.speed then
		player.xvel = player.xvel - player.speed * dt
	end

	if love.keyboard.isDown('up') then
		player.yvel = player.yvel - 3000 * dt
	end
end

function player.boundary()
	if player.x < 0 then
		player.x = 0
		player.xvel = 0
	end

	if player.y + player.height > groundLevel then
		player.y = groundLevel + player.height
		player.yvel = 0
	end
end

function player.draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
end




function UPDATE_PLAYER(dt)
	player.boundary()
	player.move(dt)
	player.physics(dt)
end

function DRAW_PLAYER()
	player.draw()
end



