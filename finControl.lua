-- local altitude0 = input.getNumber(1)
-- local altitude1 = input.getNumber(2)
-- local altitude2 = input.getNumber(3)
-- local altitude3 = input.getNumber(4)
-- 
-- local P = input.getNumber(9)
-- local I = input.getNumber(10)
-- local D = input.getNumber(11)
-- 
-- local setAF = input.getNumber(12)
-- local setAB = input.getNumber(13)

--local error_prior = 0
--local integral_prior = 0

local pidData = {}
function PID(ProportionalV, IntegralV, DerivativeV, set, current, id)
    if not pidData[id] then
        pidData[id] = {
        error_prior = 0,
        integral_prior = 0
        }
    error_prior = pidData[id]["error_prior"]
    integral_prior = pidData[id]["integral_prior"]
    end


    local error = set - current
    local integral = integral_prior + error 
    local derivative = error - error_prior

    local value_out = ProportionalV*error + IntegralV*integral + DerivativeV*derivative 

    pidData[id]["error_prior"] = error_prior
    pidData[id]["integral_prior"] = integral_prior

    return value_out
end

function onTick()
    local altitude0 = input.getNumber(1)
    local altitude1 = input.getNumber(2)
    local altitude2 = input.getNumber(3)
    local altitude3 = input.getNumber(4)
    
    local P = input.getNumber(9)
    local I = input.getNumber(10)
    local D = input.getNumber(11)
    
    local setAF = input.getNumber(12)
    local setAB = input.getNumber(13)


    front0 = PID(P, I, D, setAF, altitude0, "front0") * -1
    front1 = PID(P, I, D, setAF, altitude1, "front1") * -1
    back0 = PID(P, I, D, setAB, altitude2, "back0") * -1
    back1 = PID(P, I, D, setAB, altitude3, "back1") * -1

    output.setNumber(5, front0)
    output.setNumber(6, front1)
    output.setNumber(7, back0)
    output.setNumber(8, back1)
end

