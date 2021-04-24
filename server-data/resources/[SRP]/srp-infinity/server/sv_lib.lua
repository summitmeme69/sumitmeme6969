

RegisterServerEvent('srp:infinity:player:ready')
AddEventHandler('srp:infinity:player:ready', function()
    local ting = GetEntityCoords(GetPlayerPed(source))
    
    TriggerClientEvent('srp:infinity:player:coords', -1, ting)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        local ting = GetEntityCoords(source)

        TriggerClientEvent('srp:infinity:player:coords', -1, ting)
        TriggerEvent("srp-base:updatecoords", ting.x, ting.y, ting.z)
       -- print("[^2srp-infinity^0]^3 Sync Successful.^0")
    end
end)