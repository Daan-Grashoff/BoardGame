TWO_PERSON = love.graphics.newImage('assets/images/people-1-128.png')
FOUR_PERSON = love.graphics.newImage('assets/images/four-people.png')
GEAR = love.graphics.newImage('assets/images/gear.png')
ON = love.graphics.newImage('assets/images/on.PNG')
OFF = love.graphics.newImage('assets/images/off.PNG')
GAME_LAUNCHED = false

prices = {
	ijs = {
		worker = 100,
		soldier = 150,
		robot = 500,
		tank = 1000,
		boot = 200,
		attackboot = 500,
		harbor = 1000
	},
	moeras = {
		worker = 100,
		soldier = 150,
		robot = 500,
		tank = 1000,
		boot = 200,
		attackboot = 500,
		harbor = 1000
	},
	woestijn = {
		worker = 100,
		soldier = 150,
		robot = 500,
		tank = 1000,
		boot = 200,
		attackboot = 500,
		harbor = 1000
	},
	bos = {
		worker = 100,
		soldier = 150,
		robot = 500,
		tank = 1000,
		boot = 200,
		attackboot = 500,
		harbor = 1000
	}
}

sprites = {
	ijs = {
		base = love.graphics.newImage("assets/images/base-left.png"),
		barak = love.graphics.newImage("assets/images/barak-left.png"),
		harbor = love.graphics.newImage("assets/images/harbor.png"),
		worker = love.graphics.newImage("assets/images/worker-white.png"),
		soldier = love.graphics.newImage("assets/images/soldier-white.png"),
		robot = love.graphics.newImage("assets/images/robot-white.png"),
		tank = love.graphics.newImage("assets/images/tank-white.png"),
		boot = love.graphics.newImage("assets/images/boat-white.png"),
		attackboot = love.graphics.newImage("assets/images/attack-boat-white.png")
	},
	moeras = {
		base = love.graphics.newImage("assets/images/base-right.png"),
		barak = love.graphics.newImage("assets/images/barak-right.png"),
		harbor = love.graphics.newImage("assets/images/harbor.png"),
		worker = love.graphics.newImage("assets/images/worker-red.png"),
		soldier = love.graphics.newImage("assets/images/soldier-red.png"),
		robot = love.graphics.newImage("assets/images/robot-red.png"),
		tank = love.graphics.newImage("assets/images/tank-red.png"),
		boot = love.graphics.newImage("assets/images/boat-red.png"),
		attackboot = love.graphics.newImage("assets/images/attack-boat-red.png")
	},
	woestijn = {
		base = love.graphics.newImage("assets/images/base-right.png"),
		barak = love.graphics.newImage("assets/images/barak-right.png"),
		harbor = love.graphics.newImage("assets/images/harbor.png"),
		worker = love.graphics.newImage("assets/images/worker-yellow.png"),
		soldier = love.graphics.newImage("assets/images/soldier-yellow.png"),
		robot = love.graphics.newImage("assets/images/robot-yellow.png"),
		tank = love.graphics.newImage("assets/images/tank-yellow.png"),
		boot = love.graphics.newImage("assets/images/boat-yellow.png"),
		attackboot = love.graphics.newImage("assets/images/attack-boat-yellow.png")
	},
	bos = {
		base = love.graphics.newImage("assets/images/base-left.png"),
		barak = love.graphics.newImage("assets/images/barak-left.png"),
		harbor = love.graphics.newImage("assets/images/harbor.png"),
		worker = love.graphics.newImage("assets/images/worker-green.png"),
		soldier = love.graphics.newImage("assets/images/soldier-green.png"),
		robot = love.graphics.newImage("assets/images/robot-green.png"),
		tank = love.graphics.newImage("assets/images/tank-green.png"),
		boot = love.graphics.newImage("assets/images/boat-green.png"),
		attackboot = love.graphics.newImage("assets/images/attack-boat-green.png")
	}
}