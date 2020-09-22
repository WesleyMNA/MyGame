require("src.player.AircraftsData")

AircraftsManager = {}
AircraftsManager.__index = AircraftsManager

function AircraftsManager:new()
    this = {}

    setmetatable(this, self)
    return this
end

function AircraftsManager:getAircraft(id)
    for _, aircraft in pairs(AIRCRAFTS_DATA) do
        if aircraft.id == id then
            return aircraft
        end
    end
end

function AircraftsManager:getNumberOfAircrafts()
    local lenght = 0
    for _ in pairs(AIRCRAFTS_DATA) do
        lenght = lenght + 1
    end
    return lenght
end
