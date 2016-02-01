require 'objects.settings'
require 'buildings.base'
require 'tiles.desertTile'
require 'tiles.grassTile'
require 'tiles.mountainTile'
require 'tiles.snowTile'
require 'tiles.swampTile'

board = {}
function board.load()

	GrassTile:load()
	SnowTile:load()
	DesertTile:load()
	SwampTile:load()
	MountainTile:load()

	settings:load()
	boardConfig = settings.getConfig()

	-- endturn button
	board.endTurn = {}
	board.endTurn.width = 100
	board.endTurn.height = 50
	board.endTurn.x = width - board.endTurn.width
	board.endTurn.y = height/2 - board.endTurn.height

	board.size = boardConfig['boardsize'] -- 8 mobile / 16 tablet / 24 computer
	board.newTileX = love.graphics.getWidth() / (board.size + 1)
	board.newTileY = love.graphics.getHeight() / (board.size + 1)
	board.tilePadding = 0
	board.newTileSize = math.floor(math.min(board.newTileX - board.tilePadding, board.newTileY - board.tilePadding))

	-- board.height = 18
	-- board.width = 18
	board.tiles = {}
	for i = 0 , board.size do
		for j = 0, board.size do
			tile = {}
			tile.size = math.floor(board.newTileSize)
			if board.newTileX > board.newTileY then
				tile.x = tile.size * i + 150
				tile.y = tile.size * j + 2
			else
				tile.x = tile.size * i
				tile.y = tile.size * j + 150
			end


			tile.unit = {}
			-- Tile is occupied if there is a unit on tile
			tile.occupied = false
			-- ???
			tile.f = false
			-- tile is walking if there is a unit on it and is walking
			tile.walking = false
			-- tile is spawning if base is spawning a unit
			tile.spw = false--spawning
			-- tile original owner, each player gets a continent and this belongs to him
			tile.orgown = 0--originalowner
			-- tile owner is set if there is a unit on it
			tile.owner = 0
			-- tile is attackable if there is a unit in range of your unit
			tile.attb= false--attackable
			-- tile is attacking if there is a unit in range
			tile.attacking = false--attacking
			-- tile is loading if there is a boat in range
			tile.ld = false--loading
			-- tile is lb if there is a boat in range
			tile.lb = false--loadable
			-- tile is ulb if the boat is next to ground
			tile.ulb = false--un-loadable
			-- tile is uln if the boat is uln
			tile.uln = false--un-ld
			--
			tile.unbs = false--unloadboatspawn
			tile.unbsn = false--unloadboatspawning

			tile.barak = true
			tile.income = 0

			if (i == 0 and j == 0) or
			(i == board.size and j ==  0) or
			(i == 0 and j ==  board.size) or
			(i == board.size and j == board.size) then
				tile.base = true
			else
				tile.base = false
			end

			-- --	around land
			-- if (i < (board.size / 3) + 1
			-- and j < (board.size / 3) + 1
			-- and i > (board.size / 3))
			-- or (j < (board.size / 3) + 1
			-- and i < (board.size / 3) + 1
			-- and j > (board.size / 3)) then
			-- 	tile.coast = true
			-- end

			if i < (board.size / 3) and j < (board.size / 3) then
				tile.orgown = players:getPlayerByBase('bos')
				if tile.base == true then
					tile.owner = players:getPlayerByBase('bos')
				end
				tile.type = 1
			elseif i > (math.ceil(board.size / 3) + math.floor(board.size / 18)) and j > (math.ceil(board.size / 3) + math.floor(board.size / 18)) and i < (math.floor(board.size / 3 * 2) - math.floor(board.size / 18)) and j < (math.floor(board.size / 3 * 2) - math.floor(board.size / 18)) then
				tile.type = 2
			elseif  i > (board.size / 3 * 2) and j < (board.size / 3) then
				tile.orgown = players:getPlayerByBase('moeras')
				if tile.base == true then
					tile.owner = players:getPlayerByBase('moeras')
				end
				tile.type = 0
			elseif i < (board.size / 3) and j > (board.size / 3 * 2) then
				tile.orgown = players:getPlayerByBase('ijs')
				if tile.base == true then
					tile.owner = players:getPlayerByBase('ijs')
				end
				tile.type = 3
			elseif i > (board.size / 3 * 2) and j > (board.size / 3 * 2) then
				tile.orgown = players:getPlayerByBase('woestijn')
				if tile.base == true then
					tile.owner = players:getPlayerByBase('woestijn')
				end
				tile.type = 5
			else
				tile.type = 4
			end
			table.insert(board.tiles, tile)
		end
	end

	Board = { size = 16, tiles = {} }

	tile = {}

	tile.prefWidth = love.graphics.getWidth( ) / (Board.size + 1)
	tile.prefHeight = love.graphics.getHeight( ) / (Board.size + 1)
	tile.padding = 0
	tile.size = math.floor(math.min(tile.prefWidth - tile.padding, tile.prefHeight - tile.padding))

	-- Generating Board
	for i=0, Board.size do
		for j=0, Board.size do

			if i < (Board.size / 3) and j < (Board.size / 3) then
				if (i == 0 and j == 0) then
					Board.tiles[i * (Board.size + 1) + j] = Base:new(i * (Board.size + 1) + j, {255, 0, 0}, Board.size, 'bos', 25)
				elseif (i == math.ceil(Board.size / 3) - 1) and (j == math.ceil(Board.size / 3) - 1) then
					Board.tiles[i * (Board.size + 1) + j] = GrassTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'bos', 'rc')
				elseif (i == math.ceil(Board.size / 3) - 1) then
					Board.tiles[i * (Board.size + 1) + j] = GrassTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'bos', 'b')
				elseif (j == math.ceil(Board.size / 3) - 1) then
					Board.tiles[i * (Board.size + 1) + j] = GrassTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'bos', 'r')
				else
					--Board.tiles[i * (Board.size + 1) + j] = Tile:new(i * (Board.size + 1) + j, {52, 82, 40}, bosImage, 'bos')
					Board.tiles[i * (Board.size + 1) + j] = GrassTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'bos', 'c')
				end
			elseif i > (math.ceil(Board.size / 3) + math.floor(Board.size / 18)) and j > (math.ceil(Board.size / 3) + math.floor(Board.size / 18)) and i < (math.floor(Board.size / 3 * 2) - math.floor(Board.size / 18)) and j < (math.floor(Board.size / 3 * 2) - math.floor(Board.size / 18)) then
				if i == (math.ceil(Board.size / 3) + math.floor(Board.size / 18)) + 1 and j == (math.ceil(Board.size / 3) + math.floor(Board.size / 18)) + 1 then
					Board.tiles[i * (Board.size + 1) + j] = MountainTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'goldmine', 'lt')
				elseif i == (math.floor(Board.size / 3 * 2) - math.floor(Board.size / 18)) - 1 and j == (math.floor(Board.size / 3 * 2) - math.floor(Board.size / 18)) - 1 then
					Board.tiles[i * (Board.size + 1) + j] = MountainTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'goldmine', 'rc')
				elseif i == (math.ceil(Board.size / 3) + math.floor(Board.size / 18)) + 1 and j == (math.floor(Board.size / 3 * 2) - math.floor(Board.size / 18)) - 1 then
					Board.tiles[i * (Board.size + 1) + j] = MountainTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'goldmine', 'rt')
				elseif j == (math.floor(Board.size / 3 * 2) - math.floor(Board.size / 18)) - 1 then
					Board.tiles[i * (Board.size + 1) + j] = MountainTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'goldmine', 'r')
				elseif i == ((math.floor(Board.size / 3 * 2) - math.floor(Board.size / 18))) - 1 and j == (math.ceil(Board.size / 3) + math.floor(Board.size / 18)) + 1 then
					Board.tiles[i * (Board.size + 1) + j] = MountainTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'goldmine', 'lc')
				elseif j == (math.ceil(Board.size / 3) + math.floor(Board.size / 18)) + 1 then
					Board.tiles[i * (Board.size + 1) + j] = MountainTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'goldmine', 'l')
				elseif i == ((math.floor(Board.size / 3 * 2) - math.floor(Board.size / 18))) - 1 then
					Board.tiles[i * (Board.size + 1) + j] = MountainTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'goldmine', 'b')
				elseif i == (math.ceil(Board.size / 3) + math.floor(Board.size / 18)) + 1 then
					Board.tiles[i * (Board.size + 1) + j] = MountainTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'goldmine', 't')
				else
					Board.tiles[i * (Board.size + 1) + j] = MountainTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'goldmine', 'c')
				end

				--Board.tiles[i * (Board.size + 1) + j] = Tile:new(i * (Board.size + 1) + j, {207, 181, 59}, mountainImage, 'goldmine')
			elseif i > (Board.size / 3 * 2) and j < (Board.size / 3) then
				if (i == Board.size and j == 0) then
					Board.tiles[i * (Board.size + 1) + j] = Base:new(i * (Board.size + 1) + j, {255, 0, 0}, 'moeras', 25)
				elseif i == math.ceil(Board.size / 3 * 2) and j == math.floor(Board.size / 3) then
					Board.tiles[i * (Board.size + 1) + j] = SwampTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'moeras', 'rt')
				elseif i == math.ceil(Board.size / 3 * 2) then
					Board.tiles[i * (Board.size + 1) + j] = SwampTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'moeras', 't')
				elseif j == math.floor(Board.size / 3) then
					Board.tiles[i * (Board.size + 1) + j] = SwampTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'moeras', 'r')
				else
					Board.tiles[i * (Board.size + 1) + j] = SwampTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'moeras', 'c')
					--Board.tiles[i * (Board.size + 1) + j] = Tile:new(i * (Board.size + 1) + j, {197, 179, 153}, snowImage, 'moeras')
				end
			elseif i < (Board.size / 3) and j > (Board.size / 3 * 2) then
				if (i == 0 and j == Board.size) then
					Board.tiles[i * (Board.size + 1) + j] = Base:new(i * (Board.size + 1) + j, {255, 0, 0}, 'ijs', 25)
				elseif (i == math.ceil(Board.size / 3) - 1) and j == math.ceil(Board.size / 3 * 2) then
					Board.tiles[i * (Board.size + 1) + j] = SnowTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'ijs', 'lc')
				elseif j == math.ceil(Board.size / 3 * 2) then
					Board.tiles[i * (Board.size + 1) + j] = SnowTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'ijs', 'l')
				elseif (i == math.ceil(Board.size / 3) - 1) then
					Board.tiles[i * (Board.size + 1) + j] = SnowTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'ijs', 'b')
				else
					Board.tiles[i * (Board.size + 1) + j] = SnowTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'ijs', 'c')
					--Board.tiles[i * (Board.size + 1) + j] = Tile:new(i * (Board.size + 1) + j, {175, 175, 175}, snowImage, 'ijs')
				end
			elseif i > (Board.size / 3 * 2) and j > (Board.size / 3 * 2) then
				if (i == Board.size and j == Board.size) then
					Board.tiles[i * (Board.size + 1) + j] = Base:new(i * (Board.size + 1) + j, {255, 0, 0}, 'woestijn', 25)
				elseif i == math.ceil(Board.size / 3 * 2) and j == math.ceil(Board.size / 3 * 2) then
					Board.tiles[i * (Board.size + 1) + j] = DesertTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'woestijn', 'lt')
				elseif i == math.ceil(Board.size / 3 * 2) then
					Board.tiles[i * (Board.size + 1) + j] = DesertTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'woestijn', 't')
				elseif j == math.ceil(Board.size / 3 * 2) then
					Board.tiles[i * (Board.size + 1) + j] = DesertTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'woestijn', 'l')
				else
					Board.tiles[i * (Board.size + 1) + j] = DesertTile:new(i * (Board.size + 1) + j, {45, 127, 180}, Board.size, nil, (tile.size / 2), 'woestijn', 'c')
					--Board.tiles[i * (Board.size + 1) + j] = Tile:new(i * (Board.size + 1) + j, {21, 34, 20}, desertImage, 'woestijn')
				end
			else
				Board.tiles[i * (Board.size + 1) + j] = SnowTile:new(i * (Board.size + 1) + j, {15, 85, 150}, Board.size, nil, (tile.size / 2), 'water', nil)
			end
		end
	end


end

-- when u spawned a unit, this toggle to walk
function board.walkFromBaseToggle(t, unit)
	for i,walking in pairs(board.tiles) do
		if not walking.base then
			walking.walkable = false
		end
		walking.walking = false

	end
	for i,walk in pairs(board.tiles) do
		if  walk.x <= t.x + t.size*t.unit.walkRange
		and walk.x >= t.x - t.size*t.unit.walkRange
		and walk.y <= t.y + t.size*t.unit.walkRange
		and walk.y >= t.y - t.size*t.unit.walkRange then
			if (walk.type ~= 4 and t.unit.type ~= 'boot') or
			-- base must be walkable!
			(t.unit.type == 'boot' and walk.type == 4 or walk.base) then
				walk.walkable = true
			end
		end
		if  walk.x <= t.x
		and walk.x >= t.x
		and walk.y <= t.y
		and walk.y >= t.y then
			walk.walking = true
		end
	end
end

function board.attackToggle(x, y, t, unit)
	if not t.attacking then
		for i,tile in pairs(board.tiles) do
			if  tile.x <= t.x + t.size*t.unit.attackRange
			and tile.x >= t.x - t.size*t.unit.attackRange
			and tile.y <= t.y + t.size*t.unit.attackRange
			and tile.y >= t.y - t.size*t.unit.attackRange
			and tile.occupied == true
			and tile.owner ~= t.owner then
				tile.attb = true
				t.attacking = true
			end
		end
	else
		for i,tile in pairs(board.tiles) do
			tile.attb = false
			tile.attacking = false
		end
	end
end

function board.reset(tile)
	tile.attb = false
	tile.attacking = false
	tile.walkable = false
	tile.walking = false
	tile.ld = false
	tile.lb = false
	tile.uln = false
	tile.ulb = false
	tile.unbsn = false
	tile.unbs = false
end


function board.unloadBoatSpawn(t)
	if not t.unbs then
		for i,tile in pairs(board.tiles) do
			if tile.uln then
				tile.unbsn = true
			end
		end
		t.unbs = true
	else
		t.unbs = false
		for i,tile in pairs(board.tiles) do
			tile.unbsn = false
		end

	end
end


function board.spawn(t, unit, count, owner)
	for i,tile in pairs(board.tiles) do
		if tile.ulb then
			tile.unit = unit
			tile.occupied = true
			tile.owner = owner
		end
		board.reset(tile)
	end
	table.remove(t.unit.passengers, count)
end

function board.walkToggle(x, y, t, unit)
	if not t.walking then
		for i,walking in pairs(board.tiles) do
			-- clear board
			walking.walkable = false
			walking.walking = false
		end

		for i,walk in pairs(board.tiles) do
			-- get all walkable spots around unit
			if  walk.x <= t.x + t.size*t.unit.walkRange
			and walk.x >= t.x - t.size*t.unit.walkRange
			and walk.y <= t.y + t.size*t.unit.walkRange
			and walk.y >= t.y - t.size*t.unit.walkRange then

				-- make sure type is not water if ground unit
				-- make sure type is water if water unit
				if (walk.type ~= 4 and t.unit.type ~= 'boot') or
				(t.unit.type == 'boot' and walk.type == 4) then
					walk.walkable = true
				end

				-- make sure ground soldiers can access boat
				-- check if unit type isnt of boat
				-- check if boat is of urs
				if t.unit.type ~= 'boot'
				and walk.unit.type == 'boot'
				and walk.owner == players:getActivePlayerId() then
					walk.lb = true
					t.ld = true
				end
			end

			if  walk.x <= t.x
			and walk.x >= t.x
			and walk.y <= t.y
			and walk.y >= t.y then
				-- make current tile walking
				walk.walking = true
			end
		end
	else
		-- set walktoggle false
		-- set all walking false
		-- set all walkables false
		if t.unit then
			for _,walk in pairs(board.tiles) do
				if walk.walking then
					walk.walking = false
				end
				walk.walkable = false
			end
		end
	end
end


function board.walk(x, y, t, lastTile, playerid)
	if t.walkable then
		for _,tile in pairs(board.tiles) do
			if tile.walkable then
				-- check if tile is occupied
				-- check if tile is walking
				if tile.occupied and tile.walking then
					tile.occupied = false
					-- not removing owner of a base
					if not tile.base then
						tile.owner = 0
					end
					-- set tile owner to current player ID
					t.owner = playerid
					-- transfer unit to selected tiles
					t.unit = tile.unit
					-- remove prev tile unit
					tile.unit = {}
				end
			end
			board.reset(tile)
		end
		-- set selecterd tile to occupied
		t.occupied = true
	end
end

function board.loadBoat(x,y,t)
	for _,tile in pairs(board.tiles) do
		if tile.occupied and tile.ld then
			tile.occupied = false
			if not tile.base then
				tile.owner = 0
			end
			table.insert(t.unit.passengers, tile.unit)
			tile.unit = {}
		end
		board.reset(tile)
	end
	t.occupied = true
end


function board.unloadToggle(x,y,t)
	if not t.uln then
		for i,walk in pairs(board.tiles) do
			-- get all walkable spots around unit
			-- check if tile is left or right
			if  walk.x <= t.x + t.size*1
			and walk.x >= t.x - t.size*1
			and walk.y <= t.y
			and walk.y >= t.y
			then
				if t.unit.type == 'boot'
				and walk.type ~= 4
				and not walk.occupied then
					walk.ulb = true
					t.uln = true
				end
				-- check if tile is top or bottom=
			elseif walk.x <= t.x
				and walk.x >= t.x
				and walk.y <= t.y + t.size*1
				and walk.y >= t.y - t.size*1
				then
					if t.unit.type == 'boot'
					and walk.type ~= 4
					and not walk.occupied then
						walk.ulb = true
						t.uln = true
					end
				end
			end
		else
			for i,tile in pairs(board.tiles) do
				board.reset(tile)
			end
		end
	end

	function board.unload(t)
		for _,tile in pairs(board.tiles) do
			if tile.ulb then
				if tile.occupied and tile.tileing then
					tile.occupied = false
					t.unit = tile.unit
					tile.unit = {}
				end
				tile.walkable = false
			end
		end
		t.occupied = true
	end

	function board.attack(x, y, t)
		for i,tile in pairs(board.tiles) do
			if tile.attacking then
				-- do damage to unit
				t.unit.health = t.unit.health - tile.unit.damage
				-- do damage to unit
				tile.unit.health = tile.unit.health - t.unit.damage
				-- if unit's health is below 1
				printTable(t)
				if t.unit.health <= 0 then
					-- clear tile
					board.clear(t)
				end
				-- if unit's health is below 1
				if tile.unit.health <= 0 then
					-- clear tile
					board.clear(tile)
				end
			end
			board.reset(tile)
		end
	end

	function board.clear(t)
		t.occupied = false
		t.unit = {}
		if not t.base then
			t.owner = 0
		end
		t.attb = false
		t.attacking = false
		t.walkable = false
		t.walking = false
		t.ld = false
		t.lb = false
		t.uln = false
		t.ulb = false
		t.unbsn = false
		t.unbs = false
	end


	function board.baseWalk(t, unit)
		if t.walk then
			for _,walk in pairs(board.tiles) do
				if walk.walkable then
					if walk.occupied and walk.walking then
						walk.occupied = false
						t.unit = walk.unit
						walk.unit = {}
					end
					walk.walkable = false
				end
			end
			t.occupied = true
		end
	end

	function board.getBases()
		bases = {}
		bases[0] = board.tiles[1]
		bases[1] = board.tiles[board.size+1]
		bases[2] = board.tiles[(board.size+1)*(board.size+1)]
		bases[3] = board.tiles[(board.size+1)*(board.size+1)-board.size]
		return bases
	end

	--printing = true
	function board.draw()
		if printing == true then
			--print(Tserial.pack(board.tiles))
			--print(string.len(Tserial.pack(board.tiles)))
			--printing = false
		end
		for _,t in pairs(board.tiles) do

			-- draw diffrent continents colors
			if t.type == 0 then
				love.graphics.setColor({197, 179, 153})
			elseif t.type == 1 then
				love.graphics.setColor({52, 82, 40})
			elseif t.type == 2 then
				love.graphics.setColor({207, 181, 59})
			elseif t.type == 3 then
				love.graphics.setColor({175, 175, 175})
			elseif t.type == 4 then
				love.graphics.setColor({45, 127, 180})
			else
				love.graphics.setColor({21, 34, 20})
			end
			love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)

			-- color the tiles with unit on it
			if t.occupied then
				if t.unit.type then
					love.graphics.setColor(255, 255, 255)
					if t.owner == 0 then
						image = sprites['bos'][t.unit.type]
					else
						image = sprites[players:getBaseByPlayer(t.owner)][t.unit.type]
					end

					if board.size == 8 then
						love.graphics.draw(image, t.x+10, t.y+10, 0, 2, 2)
					elseif board.size == 24 then
						love.graphics.draw(image, t.x, t.y, 0, 0.75, 0.75)
					else
						love.graphics.draw(image, t.x, t.y, 0)
					end
				else
					love.graphics.setColor(240,230,140)
					love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
				end
				love.graphics.setColor(0, 0,0)
			end

			-- show tile is walkable (able to walk on this tile colored)
			if t.walkable then
				love.graphics.setColor(0, 255,0, 100)
				love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
				love.graphics.setColor(0,0,0)
			end

			-- set print color black
			love.graphics.setColor(0, 0,0)

			-- Base tile other color
			if t.base then
				love.graphics.setColor(255, 255, 255)
				if t.owner == 0 then
					image = sprites['bos']['base']
				else
					image = sprites[players:getBaseByPlayer(t.owner)]['base']
				end
				love.graphics.draw(image, t.x, t.y, 0)
				-- love.graphics.setColor(181, 90,60)
				-- love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
			end

			-- Owner ID on tile
			if t.owner then
				love.graphics.setColor(0,0,0)
				-- love.graphics.print(t.owner, t.x + 1, t.y + 30)
			end

			-- original owner ID on tile
			if t.orgown then
				love.graphics.setColor(0,0,0)
				-- love.graphics.print(t.originalOwner, t.x + 1, t.y + 20)
			end

			-- Unit damage on tile
			if t.unit.damage then
				-- love.graphics.setColor(0,0,0)
				love.graphics.setColor(255,255,0)
				love.graphics.print('A ' .. t.unit.damage, t.x + 20, t.y + 20)
			end

			-- Unit health on tile
			if t.unit.health then
				-- love.graphics.setColor(0,0,0)
				love.graphics.setColor(255,0,0)
				love.graphics.print('H ' .. t.unit.health, t.x + 20, t.y + 30)
			end

			-- Unit type on tile
			if t.unit.type then
				-- love.graphics.setColor(0,0,0)
				-- love.graphics.print(t.unit.type, t.x, t.y+2)
			end

			-- Print tile income worth
			if t.income ~= 0 then
				love.graphics.setColor(0,0,0)
				love.graphics.print(t.income, t.x, t.y+2)
			end

			-- if
			-- if t.uln then
			-- 	for i,unit in pairs(t.unit.passengers) do
			-- 		love.graphics.setColor(255,255,255)
			-- 		love.graphics.rectangle("fill", 100 + (80 * i), 0, 80, 80)
			-- 		love.graphics.setColor(0,0,0)
			-- 		love.graphics.rectangle("line", 100 + (80 * i), 0, 80,80)
			-- 		love.graphics.print(unit.type, 100 + (80 * i) + 5, unit.y)
			-- 	end
			-- end

			if t.walking then
				-- debug show tile is walking
				-- love.graphics.print('walking!!!!', t.x+5, t.y + 20)
			elseif t.attb then
				-- show tile is attackable (able to attack a other unit)
				love.graphics.setColor(255, 0, 0, 100)
				love.graphics.rectangle('fill', t.x, t.y, t.size, t.size)
			elseif t.lb and #t.unit.passengers < 3 then
				-- show tile is lb (able to load units in boat)
				love.graphics.setColor(0, 0,255, 100)
				love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
				love.graphics.setColor(0,0,0)
			elseif t.ulb then
				-- show tile is ulb (able to unload units on the ground)
				love.graphics.setColor(255,255,0, 100)
				love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
				love.graphics.setColor(0,0,0)
			end

			if t.owner == players:getActivePlayerId()
			and t.base then
				love.graphics.setColor(0, 255, 0, 55)
				love.graphics.rectangle('fill', t.x, t.y, t.size, t.size)
			end


			-- end turn button
			love.graphics.rectangle('fill', board.endTurn.x, board.endTurn.y, board.endTurn.width, board.endTurn.height)

			-- around tiles black border

			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line", t.x, t.y, t.size, t.size)


			-- print player stats
			-- print Amount of energy of each player
			-- print Amount of frequeny of each player
			-- print Amount of Income of each player
			if t.base then
				playerStats = players:getPlayerByID(t.owner)
				if playerStats then
					-- position left or right
					if t.x < width/2 then
						-- position left
						xpos = t.x - 75
					else
						-- position right
						xpos = t.x + 75
					end

					love.graphics.print('Energy ' .. playerStats.currentEnergy .. '/' .. playerStats.energy, xpos, t.y)
					love.graphics.print('Freq ' .. playerStats.freq, xpos, t.y + 15)
					love.graphics.print('Income ' .. playerStats.income, xpos, t.y + 30)
				end
			end


			-- if t.coast then
			-- 	love.graphics.setColor(0,0,0, 100)
			-- 	love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
			-- end


			-- if t.walking then
			-- 	love.graphics.setColor(240,230,140)
			-- 	love.graphics.rectangle("fill", t.x, t.y, t.size, t.size)
			-- 	love.graphics.setColor(0, 0,0)
			-- end

		end

		for i,t in pairs(Board.tiles) do
			--love.graphics.setColor(t.m_color)

			if t.m_image then
				love.graphics.setColor(255,255,255)
				love.graphics.draw(t.m_image, (i % (Board.size + 1)) * tile.size, math.floor((i / (Board.size + 1))) * tile.size, 0, tile.size / 128)
			else
				--love.graphics.setColor(t.m_color)
				--love.graphics.rectangle("fill", ((i % (Board.size + 1)) * tile.size) + 0, math.floor((i / (Board.size + 1))) * tile.size, tile.size, tile.size)
			end

		end

		for i,t in pairs(Board.tiles) do
			--t:draw()
			--love.graphics.setColor(0,0,0)
			--love.graphics.rectangle("line", ((i % (Board.size + 1)) * tile.size) + 0, math.floor((i / (Board.size + 1))) * tile.size, tile.size, tile.size)
		end


	end
