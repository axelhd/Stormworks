function onTick()
    local Lever = input.getNumber(2)
    local In = input.getNumber(1)
    
    if In > Lever then
        output.setBool(3, true)
        output.setBool(4, false)
    elseif In < Lever then
        output.setBool(4, true)
        output.setBool(3, false)
    else
        output.setBool(3, false)
        output.setBool(4, false)
    end
        output.setNumber(1, In)
        output.setNumber(2, Lever)
end
