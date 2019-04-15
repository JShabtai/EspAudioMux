enablePin = 5
s0Pin = 6
s1Pin = 7

muxEnabled = false
muxCurrentChannel = 0

function muxEnable(enable)
    muxEnabled = enable
    if (enable) then
        gpio.write(enablePin, gpio.LOW)
    else
        gpio.write(enablePin, gpio.HIGH)
    end
end

function muxSetChannel (channel)
    if (channel == 0) then
        gpio.write(s0Pin, gpio.LOW)
        gpio.write(s1Pin, gpio.LOW)
    elseif (channel == 1) then
        gpio.write(s0Pin, gpio.HIGH)
        gpio.write(s1Pin, gpio.LOW)
    elseif (channel == 2) then
        gpio.write(s0Pin, gpio.LOW)
        gpio.write(s1Pin, gpio.HIGH)
    elseif (channel == 3) then
        gpio.write(s0Pin, gpio.HIGH)
        gpio.write(s1Pin, gpio.HIGH)
    else
        return
    end

    muxCurrentChannel = channel
end

gpio.mode(enablePin, gpio.OUTPUT)
gpio.mode(s0Pin, gpio.OUTPUT)
gpio.mode(s1Pin, gpio.OUTPUT)

muxEnable(false)
muxSetChannel(0)
