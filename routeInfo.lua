m,i,o,p = math,input,output,property
ign,osn,igb,osb = i.getNumber, o.setNumber, i.getBool, o.setBool
pgn,pgb = p.getNumber, p.getBool
abs,cos,sin,acos,asin,tan,atan = m.abs, m.cos, m.sin, m.acos, m.asin, m.tan, m.atan
pi = m.pi
pi2 = pi*2
s = screen
text,line,rect,rectF,circl,clear,setcolor = s.drawText,s.drawLine,s.drawRect,s.drawRectF,s.drawCircle,s.drawClear,s.setColor

local distance1 = 0
local distance2 = 0
local distance3 = 0
local distance4 = 0
local currentStpt = 0

function onTick()
    distance1 = ign(10)
    distance2 = ign(12)
    distance3 = ign(13)
    distance4 = ign(14)
    currentStpt = ign(3)
end

function onDraw()
    text(0, 0, "STPT")
    local str = tostring(currentStpt)
    text(s.getWidth() - string.len(str), 0, str)
    text(0, 5, distance1)
    text(0, 10, distance2)
    text(0, 15, distance3)
    text(0, 20, distance4)
end
