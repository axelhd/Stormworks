local num0 = 0
local num1 = 0
local num2 = 0
function onTick()
    num0 = input.getNumber(0)
    num1 = input.getNumber(1)
    num2 = input.getNumber(2)
end

function onDraw()
    screen.drawText(0, 0, num0)
    screen.drawText(0, 9, num1)
    screen.drawText(0, 19, num2)
end
