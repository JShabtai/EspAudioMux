dofile('httpServer.lua')
dofile('mux.lua')

httpServer:listen(80)

function currentState()
    return {
        enabled=muxEnabled,
        currentChannel=muxCurrentChannel
    }
end

httpServer:use('/enable', function(req, res)
        res:type('application/json')
        muxEnable(true)
        res:send(sjson.encode(currentState()))
end)

httpServer:use('/disable', function(req, res)
        res:type('application/json')
        muxEnable(false)
        res:send(sjson.encode(currentState()))
end)

httpServer:use('/channel/0', function(req, res)
        res:type('application/json')
        muxSetChannel(0)
        res:send(sjson.encode(currentState()))
end)

httpServer:use('/channel/1', function(req, res)
        res:type('application/json')
        muxSetChannel(1)
        res:send(sjson.encode(currentState()))
end)

httpServer:use('/channel/2', function(req, res)
        res:type('application/json')
        muxSetChannel(2)
        res:send(sjson.encode(currentState()))
end)

httpServer:use('/channel/3', function(req, res)
        res:type('application/json')
        muxSetChannel(3)
        res:send(sjson.encode(currentState()))
end)
