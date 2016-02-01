require 'enet'
require 'lib.tserial.tserial'
require 'lib.functions'

host = enet.host_create "*:6789"
currentPlayer = nil

while true do
	event = host:service(100)
	if event and event.type == "connect" then
		print("New player is trying to connect!")
		if currentPlayer == nil then
		    currentPlayer = event.peer
		    print("Assigned host: " .. tostring(currentPlayer) ..".")
		end
	elseif event and event.type == "receive" and event.peer == currentPlayer then
		host:broadcast(event.data)
		host:flush()
	elseif event and event.type == "disconnect" then
		print("Player ".. tostring(event.peer) .." has left the game!")
	end
end