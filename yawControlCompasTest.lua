m = math
ign, igb, osn, osb = input.getNumber, input.getBool, output.setNumber, output.setBool 
heading = 0

function onTick()
    heading = ign(1)
    osn(1, theta)
end
function onDraw()
    local h = screen.getHeight()
    local w = screen.getWidth() 
    s = 0
    if h < w then
        s = h
    else
        s = w
    end
    screen.drawCircle(w/2, h/2, s/2-2)
    
    theta = 2 * heading * m.pi
    
    hy = s/2-2
    o = h / 2 + math.sin(theta) * hy
    a = w / 2 + math.cos(theta) * hy

    screen.setColor(255, 0, 0)
    screen.drawLine(w/2, h/2, a, o)
    screen.setColor(255, 255, 255)
end

