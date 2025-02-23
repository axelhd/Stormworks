local numIn = {
  ["heading"]     = 1,
  ["modify"]      = 2,
  ["Pp"]          = 3,
  ["Pi"]          = 4,
  ["Pd"]          = 5,
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
  ["rudder"]    = 1,
  ["distance"]  = 2
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

local pin = {
  ["num"]   = num,
  ["bool"]  = bool
  }
print(num["in"]["heading"])

local pidData = {}
id = "test"

if not pidData[id] then
  pidData = {
  [id] = {
    error_prior = 0,
    integral_prior = 0
  }
}
end
id = "test2"
if not pidData[id] then
  pidData[id] = {error_prior = 0, integral_prior = 0}
end

print(pidData[id]["error_prior"])
pidData[id]["error_prior"] = 10
print(pidData[id]["error_prior"])