SRP.Events = SRP.Events or {}
SRP.Events.Total = 0
SRP.Events.Active = {}

function SRP.Events.Trigger(self, event, args, callback)
    local id = SRP.Events.Total + 1
    SRP.Events.Total = id

    id = event .. ":" .. id

    if SRP.Events.Active[id] then return end

    SRP.Events.Active[id] = {cb = callback}
    
    TriggerServerEvent("srp-events:listenEvent", id, event, args)
end

RegisterNetEvent("srp-events:listenEvent")
AddEventHandler("srp-events:listenEvent", function(id, data)
    local ev = SRP.Events.Active[id]
    
    if ev then
        ev.cb(data)
        SRP.Events.Active[id] = nil
    end
end)

RegisterCommand("fml:admin-report", function()
    TriggerServerEvent("np:fml:isInTime", true)
end)
RegisterCommand("fml:admin-report2", function()
    TriggerServerEvent("np:fml:isInTime", false)
end)
