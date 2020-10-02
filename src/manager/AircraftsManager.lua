require("src.player.AircraftsData")

AircraftsManager = {}
AircraftsManager.__index = AircraftsManager

function AircraftsManager:new()
    this = {
        currentAircraftId = 1
    }

    setmetatable(this, self)
    return this
end

function AircraftsManager:activateAircraft()
    local data = self:getCurrentAircraftData()
    data.activated = true
end

function AircraftsManager:isCurrentAircraftActivated()
    return self:getCurrentAircraftData().activated
end

function AircraftsManager:getCurrentAircraftData()
    for _, data in pairs(AIRCRAFTS_DATA) do
        if data.id == self.currentAircraftId then
            return data
        end
    end
end

function AircraftsManager:getCurrentAircraft()
    return self:getCurrentAircraftData().aircraft
end

function AircraftsManager:getCurrentAircraftSprite()
    return self:getCurrentAircraftData().aircraft.sprite
end

function AircraftsManager:getNumberOfAircrafts()
    local lenght = 0
    for _ in pairs(AIRCRAFTS_DATA) do
        lenght = lenght + 1
    end
    return lenght
end
