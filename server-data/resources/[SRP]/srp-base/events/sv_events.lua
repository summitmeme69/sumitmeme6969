SRP.Events = SRP.Events or {}
SRP.Events.Registered = SRP.Events.Registered or {}

RegisterServerEvent("srp-events:listenEvent")
AddEventHandler("srp-events:listenEvent", function(id, name, args)
    local src = source

    if not SRP.Events.Registered[name] then return end

    SRP.Events.Registered[name].f(SRP.Events.Registered[name].mod, args, src, function(data)
        TriggerClientEvent("srp-events:listenEvent", src, id, data)
    end)
end)

function SRP.Events.AddEvent(self, module, func, name)
    SRP.Events.Registered[name] = {
        mod = module,
        f = func
    }
end