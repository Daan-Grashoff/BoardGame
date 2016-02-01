require "enet"

function love.startServer()
	address = "localhost:"..math.random(7070,8080)
	print(address)
	serverHost = enet.host_create(address, nil, 10)
	return address

	-- local done = false
	-- while not done do
	-- 	local event = host:service(100)
	-- 	if event then
	-- 		if event.type == "connect" then
	-- 			server:send("wally world", 0)
	-- 			server:send("nut house", 1)
	-- 		elseif event.type == "receive" then
	-- 			print(event.type, event.data)
	-- 			done = true
	-- 		end
	-- 	end
	-- end

	-- server:disconnect()
	-- host:flush()

	-- print "done"
end


function love.connectToServer(address)
	-- local channel_responders = {
	-- 	[0] = function(event)
	-- 		print("doing nothing")
	-- 	end,
	-- 	[1] = function(event)
	-- 		print("sending back...")
	-- 		event.peer:send(event.data, event.channel)
	-- 	end
	-- }

	host = enet.host_create()
	server = host:connect(address, 1)
	return host

	-- while true do
	-- 	local event = host:service(100)
	-- 	if event then
	-- 		if event.type == "receive" then
	-- 			print("receive, channel:", event.channel)
	-- 			channel_responders[event.channel](event)
	-- 		else
	-- 			print(event.type, event.peer)
	-- 		end
	-- 	end
	-- end
end

function love.updateServerData()
	event = host:service(100)
	-- if event then
	--     if event.type == "receive" then
	--     	message = "Got message: "..event.data
	--     	event.peer:send( "pong" )
	--     elseif event.type == "connect" then
	--    		message =  " connected." ..event.data
	--     elseif event.type == "disconnect" then
	--    		message = " disconnected."
	--     end
	--     event = host:service()
	-- end
	-- if message then
	-- 	print(message)
	-- end
	local done = false
	if event then
		-- event.peer:send("hello SERVER") --LINE 12
	    -- if event.type == "connect" then
	    -- 		print("Connected to", event.peer)
	    --   	event.peer:send("hello SERVE, IM CONNECTED")
	    if event.type == "receive" then
	      	print("Got message from server: ", event.data, event.peer)
	      	done = true
	    end
	end
end

function love.sendData(data)
	-- local event = host:service(100)
	-- print(host:total_sent_data())
	print(host)
	event = serverHost:service(100)
	print(event)
	if event then
		event.peer:send(data)
	end
end