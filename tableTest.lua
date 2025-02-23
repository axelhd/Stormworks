m = math

abs,cos,sin,acos,asin,tan,atan = m.abs, m.cos, m.sin, m.acos, m.asin, m.tan, m.atan
pi = m.pi
pi2 = pi*2


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

function getHeadingToPoint(o, w, --[[optional]]distOnly)
    local a = w.y - o.y
    local b = w.x - o.x

    local dist = m.sqrt((a * a) + (b * b))
    local dir = m.atan(a / b)
    if distOnly == true then
        return dist
    end

    return dist, dir
end

for i=10,19 do
  local x = i
  local y = i
  --table.insert(route, {x, y, type, num})
  local spt = {x = x, y = y}
  table.insert(route, spt)
end

for i, v in pairs(route) do
  --print(route[i].x .. " " .. i)
  print(v.x .. " " .. i)
end

if getHeadingToPoint(own, route[currentStpt], true) < 20 then
  if route[currentStpt] then
    currentStpt = currentStpt + 1
  end
end
