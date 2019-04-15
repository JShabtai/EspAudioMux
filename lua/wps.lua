wpsConnecting = false
function connectWps ()
    if (wpsConnecting) then
        print('WPS connection already in progress')
        return
    end

    wpsConnecting = true
    print('Beginning WPS push button connection')

    wifi.setmode(wifi.STATION)
    wps.enable()

    wps.start(function(status)
        if status == wps.SUCCESS then
            wps.disable()

            print("WPS: Success, connecting to AP...")

            wifi.sta.connect(function()
                -- TODO Check and handle status
                wpsConnecting = false
                print ("Done (possibly unsuccessfully)")
            end)
            return
        end

        wps.disable()
        wpsConnecting = false
    end)
end

-- GPIO0 (used for flashing) is IO pin 3
gpio.mode(3, gpio.INPUT)
gpio.trig(3, 'up', connectWps)

-- Try connecting normally. If this fails, automatically start WPS
print('Trying to connect to Wi-Fi')
wifi.sta.connect(function()
    status = wifi.sta.status()
    if (status == wifi.STA_GOTIP) then
        print ("Connected to Wi-Fi")
        return
    elseif (status == wifi.STA_CONNECTING) then
        print ("Wi-Fi is connecting")
        return
    elseif (status == wifi.STA_IDLE) then
        print ("Wi-Fi is idle")
    elseif (status == wifi.STA_WRONGPWD) then
        print ("Wi-Fi password is wrong")
    elseif (status == wifi.STA_APNOTFOUND) then
        print ("Cannot find a known AP")
    elseif (status == wifi.STA_FAIL) then
        print ("Wi-Fi connection failed")
    else
        print ("Connection status unknown")
    end

    connectWps()
end)
