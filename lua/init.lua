-- Set baud rate to 4800 since higher speeds don't seem to work for some reason :(
uart.setup(0,4800,8,0,1,1)

-- 500ms delay in case of panic loop
print("Pausing in case of panic loop");
tmr.delay(500000)
print("Done pausing");

print("MAC is: " .. wifi.sta.getmac())

wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function (T)
    print("Connected to WIFI with IP: " .. wifi.sta.getip())
end)


wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, function (T)
    print("Disconnected from wifi; reasonCode=" .. T.reason)
end)

dofile('wps.lua')
dofile('server.lua')
