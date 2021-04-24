SRP.Core.hasLoaded = false


function SRP.Core.Initialize(self)
    Citizen.CreateThread(function()
        while true do
            if NetworkIsSessionStarted() then
                TriggerEvent("srp-base:playerSessionStarted")
                TriggerServerEvent("srp-base:playerSessionStarted")
                break
            end
        end
    end)
end
SRP.Core:Initialize()

AddEventHandler("srp-base:playerSessionStarted", function()
    while not SRP.Core.hasLoaded do
        --print("waiting in loop")
        Wait(100)
    end
    ShutdownLoadingScreen()
    SRP.SpawnManager:Initialize()
end)

RegisterNetEvent("srp-base:waitForExports")
AddEventHandler("srp-base:waitForExports", function()
    if not SRP.Core.ExportsReady then return end

    while true do
        Citizen.Wait(0)
        if exports and exports["srp-base"] then
            TriggerEvent("srp-base:exportsReady")
            return
        end
    end
end)

RegisterNetEvent("customNotification")
AddEventHandler("customNotification", function(msg, length, type)

	TriggerEvent("chatMessage","SYSTEM",4,msg)
end)

RegisterNetEvent("base:disableLoading")
AddEventHandler("base:disableLoading", function()
    print("player has spawned ")
    if not SRP.Core.hasLoaded then
         SRP.Core.hasLoaded = true
    end
end)

Citizen.CreateThread( function()
    TriggerEvent("base:disableLoading")
end)


RegisterNetEvent("paycheck:client:call")
AddEventHandler("paycheck:client:call", function()
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("paycheck:server:send", cid)
end)