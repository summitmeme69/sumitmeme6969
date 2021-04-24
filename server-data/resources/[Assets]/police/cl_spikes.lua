local spikes = {}
local spikemodel = "P_ld_stinger_s"
local nearSpikes = false

function CreateSpikes()
    local spawnCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
        local spike = CreateObject(GetHashKey(spikemodel), spawnCoords.x, spawnCoords.y, spawnCoords.z, 1, 1, 1)
        SetEntityHeading(spike, GetEntityHeading(PlayerPedId()))
        PlaceObjectOnGroundProperly(spike)
		TriggerEvent("animation:PlayAnimation","layspike")
        table.insert(spikes, spike)
		TriggerEvent("DoLongHudText","Spikes Placed!",1)
end

RegisterNetEvent('placespikes')
AddEventHandler('placespikes', function()
    CreateSpikes()
end)

RegisterNetEvent('removespikes')
AddEventHandler('removespikes', function()
    local src = source
    local plypos = GetEntityCoords(PlayerPedId())
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
		TriggerEvent("animation:PlayAnimation","layspike")
        local spike = GetClosestObjectOfType(plypos.x, plypos.y, plypos.z, 20.0, GetHashKey(spikemodel), 1, 1, 1)
        Delete(spike)
		TriggerEvent("DoLongHudText","Spike strip picked up!",1)
    end
end)

RegisterCommand("spikes", function(source, args, raw)
    local job = exports["isPed"]:isPed("myjob")
    local src = source
    if job == 'police' and not IsPedInAnyVehicle(PlayerPedId(), false) then
        CreateSpikes()
        TriggerEvent("DoLongHudText","Spikes Placed!",1)
    end
end)

function Delete(object)
	SetEntityAsMissionEntity(object, false, true)
	DeleteEntity(object)
end

RegisterCommand("removespikes", function(source, args, raw)
    local job = exports["isPed"]:isPed("myjob")
    local src = source
    local plypos = GetEntityCoords(PlayerPedId())
    if job == 'police' and not IsPedInAnyVehicle(PlayerPedId(), false) then
        local spike = GetClosestObjectOfType(plypos.x, plypos.y, plypos.z, 20.0, GetHashKey(spikemodel), 1, 1, 1)
        Delete(spike)
        TriggerEvent("DoLongHudText","Spike strip picked up!",1)
    end
end)
local hit = false
Citizen.CreateThread(function()
    local wait2 = 100
    while true do
        Citizen.Wait(wait2)
        if nearSpikes then
            local tires = {
                {bone = "wheel_lf", index = 0},
                {bone = "wheel_rf", index = 1},
                {bone = "wheel_lm", index = 2},
                {bone = "wheel_rm", index = 3},
                {bone = "wheel_lr", index = 4},
                {bone = "wheel_rr", index = 5}
            }

            for a = 1, #tires do
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                local vehpos = GetEntityCoords(vehicle)
                local tirePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tires[a].bone))
                local spike = GetClosestObjectOfType(tirePos.x, tirePos.y, tirePos.z, 20.0, GetHashKey(spikemodel), 1, 1, 1)
                local spikePos = GetEntityCoords(spike, false)
                local distance = Vdist(tirePos.x, tirePos.y, tirePos.z, spikePos.x, spikePos.y, spikePos.z)
                local distance2 = Vdist(vehpos, spikePos)
                    wait2 = 0
                if distance < 1.8 and distance > 0 then
                    if not IsVehicleTyreBurst(vehicle, tires[a].index, true) or IsVehicleTyreBurst(vehicle, tires[a].index, false) then
                        SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
                        hit = true
                    end
                else
                    if distance > 10 and hit then
                        Delete(spike)
                        hit = false
                        wait2 = 100
                    end
                end
            end
        else
            wait2 = 100
        end
    end
end)

Citizen.CreateThread(function()
    local waittime = 100
    while true do
        Citizen.Wait(waittime)
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                local vehiclePos = GetEntityCoords(vehicle, false)
                if GetClosestObjectOfType(vehiclePos.x, vehiclePos.y, vehiclePos.z, 30.0, GetHashKey(spikemodel), 1, 1, 1) ~= 0 then
                    waittime = 0
                    nearSpikes = true
                else
                    waittime = 100
                    nearSpikes = false
                end
            else
                waittime = 100
                nearSpikes = false
            end
        end
    end
end)
