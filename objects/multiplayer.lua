require 'enet'
require 'lib.functions'
require 'lib.tserial.tserial'

multiplayer = {}

multiplayer.clientIP = nil
multiplayer.turn = false

function multiplayer.load()
	multiplayer.host = enet.host_create()
	multiplayer.server = multiplayer.host:connect("localhost:6789")
	multiplayer.service(multiplayer.host, multiplayer.server)
end

function multiplayer.service(host, server)
	multiplayer.event = multiplayer.host:service(100)
	if multiplayer.event and multiplayer.event.type == "connect" then
		multiplayer.connect(multiplayer.host, multiplayer.server, multiplayer.event)
	elseif multiplayer.event and multiplayer.event.type == "receive" then
		if string.match(multiplayer.event.data, 'input="mousereleased"') then
		    unpackTable = Tserial.unpack(multiplayer.event.data, true)
		    love.mousepressed(unpackTable.x, unpackTable.y, unpackTable.button)
		elseif string.match(multiplayer.event.data, 'input="getClientIP"') then
			unpackTable = Tserial.unpack(multiplayer.event.data, true)
			multiplayer.clientIP = unpackTable.clientIP
		elseif string.match(multiplayer.event.data, 'input="setCurrentPlayer"') then
			multiplayer.turn = true
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
	event.peer:send(event.data)
	host:flush()
end

return multiplayer