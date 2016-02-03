require 'enet'
require 'lib.functions'
require 'lib.tserial.tserial'

multiplayer = {}

multiplayer.clientIP = nil
multiplayer.turn = false
multiplayer.turnIP = nil
multiplayer.lastPacket = nil

function multiplayer.load()
	multiplayer.host = enet.host_create()
	multiplayer.server = multiplayer.host:connect("localhost:6789")
	multiplayer.service(multiplayer.host, multiplayer.server)
end

function multiplayer.triggermousereleased(x, y, button, currentPlayer)
	if currentPlayer == multiplayer.turnIP then
		love.mousepressed(x, y, button)
		love.mousereleased(x, y, button)
	end
end

function multiplayer.service(host, server)
	multiplayer.event = multiplayer.host:service(100)
	if multiplayer.event and multiplayer.event.type == "connect" then
		multiplayer.connect(multiplayer.host, multiplayer.server, multiplayer.event)
	elseif multiplayer.event and multiplayer.event.type == "receive" then
		if string.match(multiplayer.event.data, 'input="mousereleased"') then
		    unpackTable = Tserial.unpack(multiplayer.event.data, true)
		    multiplayer.lastPacket = unpackTable.turnIP
		    multiplayer.triggermousereleased(unpackTable.x, unpackTable.y, unpackTable.button, unpackTable.turnIP)
		elseif string.match(multiplayer.event.data, 'input="getClientIP"') then
			unpackTable = Tserial.unpack(multiplayer.event.data, true)
			multiplayer.clientIP = unpackTable.clientIP
		elseif string.match(multiplayer.event.data, 'input="setCurrentPlayer"') then
			unpackTable = Tserial.unpack(multiplayer.event.data, true)
			multiplayer.turn = true
			multiplayer.clientIP = unpackTable.currentPlayer
			multiplayer.turnIP = unpackTable.currentPlayer
			multiplayer.lastPacket = unpackTable.currentPlayer
		elseif string.match(multiplayer.event.data, 'input="setTurnIP"') then
			unpackTable = Tserial.unpack(multiplayer.event.data, true)
			multiplayer.turnIP = unpackTable.TurnIP
			print("###client setTurnIP")
		end
	end
end

function multiplayer.connect(host, server, event)
	event.peer:send("Connected")
	host:flush()
	print("Connected to server: " .. tostring(event.peer) .. ".")
end

function multiplayer.getClientIP()
	packTable = {}
	packTable.input = "getClientIP"

	multiplayer.event.data = Tserial.pack(packTable)
	multiplayer.event.type = "receive"

	multiplayer.send(multiplayer.host, multiplayer.server, multiplayer.event)
end

function multiplayer.send(host, server, event)
	if multiplayer.turnIP == multiplayer.clientIP then
		multiplayer.lastPacket = multiplayer.clientIP
	end
	multiplayer.event.peer:send(event.data)
	multiplayer.host:flush()
end

return multiplayer