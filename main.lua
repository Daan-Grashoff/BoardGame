require 'enet'
require 'lib.tserial.tserial'
require 'lib.functions'

server = {}

server.host = enet.host_create "*:6789"
server.event = nil
server.currentPlayer = nil
server.clientList = {}

function setCurrentPlayer()
	packTable = {}
	packTable.input = "setCurrentPlayer"
	packTable.currentPlayer = tostring(server.currentPlayer)

	server.event.data = Tserial.pack(packTable)
	server.event.type = "receive"
	server.event.peer:send(server.event.data)
	server.host:flush()
end

function setTurnIP()
	packTable = {}
	packTable.input = "setTurnIP"
	packTable.TurnIP = tostring(server.currentPlayer)

	server.event.data = Tserial.pack(packTable)
	server.event.type = "receive"
	server.event.peer:send(server.event.data)
	server.host:flush()
end

function setClientIP()
	packTable = {}
	packTable.input = "getClientIP"
	packTable.clientIP = tostring(server.event.peer)

	server.event.data = Tserial.pack(packTable)
	server.event.type = "recieve"
	server.event.peer:send(server.event.data)
	server.host:flush()
end

while true do
	server.event = server.host:service(100)
	if server.event and server.event.type == "connect" then
		print("New player is trying to connect!")
		table.insert(server.clientList, server.event.peer)
		if server.currentPlayer == nil then
		    server.currentPlayer = server.event.peer
		    print("Assigned host: " .. tostring(server.currentPlayer) ..".")
		    setCurrentPlayer()
		else
			setTurnIP()
		end

		setTurnIP()
		setClientIP()
	elseif server.event and server.event.type == "receive" and server.event.peer == server.currentPlayer then
		if string.match(server.event.data, 'input="getClientIP"') then
			packTable = {}
			packTable.input = "getClientIP"
			packTable.clientIP = tostring(server.event.peer)

			print("###server getClientIP")
			server.event.data = Tserial.pack(packTable)
			server.event.peer:send(Tserial.pack(packTable))
			server.host:flush()
		else
			server.host:broadcast(server.event.data)
			server.host:flush()
		end
	elseif server.event and server.event.type == "disconnect" then
		print("Player ".. tostring(server.event.peer) .." has left the game!")
	end
end