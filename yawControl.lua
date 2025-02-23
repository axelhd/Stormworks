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
m,i,o,p = math,input,output,property
ign,osn,igb,osb = i.getNumber, o.setNumber, i.getBool, o.setBool
pgn,pgb = p.getNumber, p.getBool
abs,cos,sin,acos,asin,tan,atan = m.abs, m.cos, m.sin, m.acos, m.asin, m.tan, m.atan
pi = m.pi
pi2 = pi*2
s = screen
text,line,rect,rectF,circl,clear,setcolor = s.drawText,s.drawLine,s.drawRect,s.drawRectF,s.drawCircle,s.drawClear,s.setColor

log = debug.log

local targetHeading = 0
local error_prior = 0
local integral_prior = 0
local targetHeadingInit = false

local point = 0
local yaw_error = 0

local getHeadingToPointMode = false

local own = {
	x = 0,
	y = 0
}
local wpt = {
	x = 0,
	y = 0
}

local route = {}
local currentStpt = 1

local Pc = false
local Ic = false
local Dc = false

local PnPrev = 0
local InPrev = 0
local DnPrev = 0

local numIn = {
  ["heading"]     = 1,
  ["modify"]      = 2,
  ["Pp"]          = 3,
  ["Ip"]          = 4,
  ["Dp"]          = 5,
  ["P"]           = 6,
  ["I"]           = 7,
  ["D"]           = 8,
  ["ownX"]        = 9,
  ["ownY"]        = 10,
  ["wptX"]        = 11,
  ["wptY"]        = 12,
  ["steerpoint"]  = 13
}

local numOut = {
  ["rudder"]      = 1,
  ["distance"]    = 2,
  ["steerpoint"]  = 3
}

local num = {
  ["in"]  = numIn,
  ["out"] = numOut
}

local boolIn = {
  ["Route"] = 1,
  ["Point"] = 2,
  ["Set"]   = 3,
  ["Enter"] = 4,
  ["Clear"] = 5
}

local boolOut = {
  
}

local bool = {
  ["in"]  = boolIn,
  ["out"] = boolOut
}

local pidData = {}

function getHeadingToPoint(o, w, --[[optional]]distOnly)
    if w then
        local a = w.y - o.y
        local b = w.x - o.x

        local dist = m.sqrt((a * a) + (b * b))
        local dir = m.atan(a / b)
        if distOnly == true then
            return dist
        end

        return dist, dir
    end
    log("w is nil")
    return 0, 0
end

function PID(ProportionalV, IntegralV, DerivativeV, set, current, id)
    if not pidData[id] then
        pidData[id] = {
        error_prior = 0,
        integral_prior = 0
        }
    error_prior = pidData[id]["error_prior"]
    integral_prior = pidData[id]["integral_prior"]
    end
    yaw_error = set - current
    if yaw_error > 0.5 then
         yaw_error = yaw_error - 1
    elseif yaw_error < -0.5 then
        yaw_error = yaw_error + 1
    end
    debugStr =  string.format("error: %f, set: %f, current: %f", yaw_error, set, current)
    --log(debugStr)
    local integral = integral_prior + yaw_error 
    local derivative = yaw_error - error_prior

    local value_out = ProportionalV*yaw_error + IntegralV*integral + DerivativeV*derivative 

    pidData[id]["error_prior"] = error_prior
    pidData[id]["integral_prior"] = integral_prior
    if value_out > 1 then value_out = 1 end
    if value_out < -1 then value_out = -1 end
    return value_out
end

    --route.insert(x, y, wptType, wptNumber)
    

function onTick()
    local presentHeading = ign(num["in"]["heading"])
    local modifyHeading = ign(num["in"]["modify"])
    modifyHeading = modifyHeading * -1
    if targetHeadingInit == false then
        targetHeading = presentHeading
        targetHeadingInit = true
    end

    if modifyHeading > 0  or modifyHeading < 0 then
         targetHeading = targetHeading + modifyHeading * 0.005
    end


    -- ENTER POINT
    if igb(bool["in"]["Enter"]) == true then
        local x = ign(num["in"]["wptX"])
        local y = ign(num["in"]["wptY"])
        local spt = {x = x, y = y}
        table.insert(route, spt)
    end

    if igb(bool["in"]["Clear"]) == true then
        route = {}
    end

    if igb(bool["in"]["Enter"]) == true then
        currentStpt = igb(num["in"]["steerpoint"])
    end

    routeMode = igb(bool["in"]["Route"])
    pointMode = igb(bool["in"]["Point"])
    if routeMode == true then
        own.x = ign(num["in"]["ownX"])
        own.y = ign(num["in"]["ownY"])
        if pointMode == true then
            wpt.x = ign(num["in"]["wptX"])
            wpt.y = ign(num["in"]["wptY"])
            --log("POINT")
        else
            if route[currentStpt] then
                --log("NO POINT")
                --log(currentStpt)
                if getHeadingToPoint(own, route[currentStpt], true) < 20 then
                    if route[currentStpt+1] then
                        currentStpt = currentStpt + 1
                    end
                end
                --log("FOR WORKING")                        
                wpt.x = route[currentStpt].x
                wpt.y = route[currentStpt].y
            end
        end
        distance, direction = getHeadingToPoint(own, wpt)
        if wpt.x > own.x then
            targetHeading = ((direction / pi) / 2) - 0.25
        else
            targetHeading = ((direction / pi) / 2) + 0.25
        end
    end

    if targetHeading > 0.5 then
        targetHeading = -0.5
    elseif targetHeading < -0.5 then
        targetHeading = 0.5
    end
    
    local Pp = ign(num["in"]["Pp"])
    local Ip = ign(num["in"]["Ip"])
    local Dp = ign(num["in"]["Dp"])

    local Pn = ign(num["in"]["P"])
    local In = ign(num["in"]["I"])
    local Dn = ign(num["in"]["D"])

    local P = 0
    local I = 0
    local D = 0
    
    if Pn ~= PnPrev then
        Pc = true
    end
    if In ~= InPrev then
        Ic = true
    end
    if Dn ~= DnPrev then
        Dc = true
    end
    
    if Pc == true then
        P = Pn
    else 
        P = Pp
    end
    if Ic == true then
        I = In
    else
        I = Ip
    end
    if Dc == true then
        D = Dn
    else
        D = Dp
    end

    PnPrev = Pn
    InPrev = In
    DnPrev = Dn

    rudder = PID(P, I, D, targetHeading, presentHeading, "rudder")
    rudder = rudder * -1
   
    --log(rudder)
    --log(num["out"]["rudder"])
    osn(num["out"]["rudder"], rudder)
    osn(num["out"]["distance"], distance)
    osn(num["out"]["steerpoint"], currentStpt)
    
    --for i, v in ipairs(route) do 
        --osn(i+10, getHeadingToPoint(own, route[i], true))
        --debug.log(route[i])
    --end 
    for i, v in pairs(route) do
        log(string.format("i: %d, stpt: %d", i, currentStpt))
        if i >= currentStpt then
            osn(10+i, getHeadingToPoint(own, v, true))
        end
    end
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

    local theta = 2 * ((yaw_error - 0.25) * -1) * m.pi

    local hy = s/2-2
    local o = h / 2 + math.sin(theta) * hy
    local a = w / 2 + math.cos(theta) * hy

    screen.setColor(255, 0, 0)
    screen.drawLine(w/2, h/2, a, o)
    screen.setColor(255, 255, 255)
end
