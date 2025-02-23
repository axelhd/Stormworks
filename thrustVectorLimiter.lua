function onTick()
    local limit = input.getNumber(1)
    local attempt = input.getNumber(2)
    local invert = 1
    if attempt < 0 then
        --attempt = attempt * -1
        invert = -1
    end
    if attempt * invert < limit then
        out = attempt * invert
    else
        out = limit * invert
    end

    output.setNumber(3, out)
end
