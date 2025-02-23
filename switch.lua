function onTick()
    val_in = input.getNumber(2)
    switch = input.getBool(1)
    if switch == true then
        output.setNumber(3, val_in)
    else
        output.setNumber(4, val_in)
    end
end
