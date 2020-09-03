-- Desktop
WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

-- Android
-- WINDOW_WIDTH = love.graphics.getHeight()
-- WINDOW_HEIGHT = love.graphics.getWidth()

TILE_SIZE = 16

function renderLoop(objectList)
    for _, object in pairs(objectList) do
        object:render()
    end
end

function updateLoop(dt, objectList)
    for _, object in pairs(objectList) do
        object:update(dt)
    end
end

function copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
    return res
end

function table.indexOf(t, object)
    if type(t) ~= "table" then error("table expected, got " .. type(t), 2) end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end

function math.sign(v)
	return (v >= 0 and 1) or -1
end

function math.round(v, bracket)
	bracket = bracket or 1
	return math.floor(v/bracket + math.sign(v) * 0.5) * bracket
end
