require 'enet'
require 'lib.functions'
require 'lib.tserial.tserial'

multiplayer = {}

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
		if string.match(multiplayer.event.data, "{") then
		    unpackTable = Tserial.unpack(multiplayer.event.data, true)
		    love.mousepressed(unpackTable.x, unpackTable.y, unpackTable.button)
		end
	end
end

function multiplayer.connect(host, server, event)
	event.peer:send("Connected")
	host:flush()
	print("Connected to server: " .. tostring(event.peer) .. ".")
end

function multiplayer.send(host, server, event)
	event.peer:send(event.data)
	host:flush()
end

return multiplayer