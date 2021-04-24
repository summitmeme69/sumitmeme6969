local degHealth = {
	["breaks"] = 0,-- has neg effect
	["axle"] = 0,	-- has neg effect
	["radiator"] = 0, -- has neg effect 
	["clutch"] = 0,	-- has neg effect
	["transmission"] = 0, -- has neg effect
	["electronics"] = 0, -- has neg effect
	["fuel_injector"] = 0, -- has neg effect
	["fuel_tank"] = 0 -- has neg effect
}

RegisterNetEvent("mech:tools")
AddEventHandler("mech:tools", function(args)
    local shop = exports["isPed"]:isPed("myjob")
    if exports["srp-inventory"]:hasEnoughOfItem(args[1],tonumber(args[2]),false) then
        TriggerServerEvent("mech:add:materials", args[1], tonumber(args[2]), shop)
    else
        TriggerEvent("DoLongHudText", "You don't have the materials")
    end
end)


RegisterNetEvent("mech:tools:cl")
AddEventHandler("mech:tools:cl", function(materials, amount, deg, plate)
    local shop = exports["isPed"]:isPed("myjob")
    TriggerServerEvent("mech:remove:materials", materials, amount, deg, plate, shop)
end)

function repairVeh(args)
    local job = exports["isPed"]:isPed("myjob")
    if job == 'tuner_shop' or job == 'auto_exotics' or job == 'paleto_mech' or job == 'auto_bodies' then 
        local degname = string.lower(args[1])
        local amount = tonumber(args[2])
        local removepart = tonumber(args[2])
        local itemname = ""
        local current = 100

        if not amount then
            TriggerEvent("DoLongHudText", "Error: You need to do /repair [part] [amount]", 2)
            return
        end

        if degname == "body" or degname == "Body" then
            TriggerEvent('DoLongHudText', 'This part is not degrading please repair it through the menu')
        end

        if degname == "Engine" or degname == "engine" then
            TriggerEvent('DoLongHudText', 'This part is not degrading please repair it through the menu')
        end

        if degname == "brakes" or degname == "Brakes" then
            itemname = "rubber"
            degname = "breaks"
            current = degHealth["breaks"]
        end

        if degname == "Axle" or degname == "axle" then
            degname = "axle"
            itemname = "scrapmetal"
            current = degHealth["axle"]
        end

        if degname == "Radiator" or degname == "radiator" then
            degname = "radiator"
            itemname = "scrapmetal"
            current = degHealth["radiator"]
        end

        if degname == "Clutch" or degname == "clutch" then
            degname = "clutch"
            itemname = "scrapmetal"
            current = degHealth["clutch"]
        end

        if degname == "electronics" or degname == "Electronics" then
            degname = "electronics"
            itemname = "plastic"
            current = degHealth["electronics"]
        end

        if degname == "fuel" or degname == "Fuel" then
            itemname = "steel"
            degname = "fuel_tank"
            current = degHealth["fuel_tank"]
        end

        if degname == "transmission" or degname == "Transmission" then
            itemname = "aluminium"
            degname = "transmission"
            current = degHealth["transmission"]
        end

        if degname == "Injector" or degname == "injector" then
            itemname = "copper"
            degname = "fuel_injector"
            current = degHealth["fuel_injector"]
        end

        if amount < 10 then
            RequestAnimDict("mp_car_bomb")
            TaskPlayAnim(PlayerPedId(),"mp_car_bomb","car_bomb_mechanic",8.0, -8, -1, 49, 0, 0, 0, 0)
            Wait(100)
            TaskPlayAnim(PlayerPedId(),"mp_car_bomb","car_bomb_mechanic",8.0, -8, -1, 49, 0, 0, 0, 0)
            FreezeEntityPosition(PlayerPedId(), true)
            local finished = exports["srp-taskbar"]:taskBar(amount*1000,"Repairing")
            local coordA = GetEntityCoords(PlayerPedId(), 1)
            local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
            local targetVehicle = getVehicleInDirection(coordA, coordB)
            local plate = GetVehicleNumberPlateText(targetVehicle)
            if finished == 100 then
                FreezeEntityPosition(PlayerPedId(), false)
                if targetVehicle ~= 0 then
                    TriggerServerEvent('scrap:towTake',degname,itemname, plate, amount, removepart)
                else
                    TriggerEvent("DoLongHudText","No Vehicle")
                end
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        else
            TriggerEvent("DoLongHudText","You cant repair anything higher then 10", 2)
        end
       
    end
end

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        offset = offset - 1
        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end

RegisterCommand("repair", function(source, args)
    local job = exports["isPed"]:isPed("myjob")
    if job == 'tuner_shop' or job == 'auto_exotics' or job == 'paleto_mech' or job == 'auto_bodies' then 
        if Tuner or auto_exotics or paleto_mech or auto_bodies then
            if args[1] and args[2] then
                repairVeh(args)
            end
        end
    end
end)


RegisterCommand("mechadd", function(source, args)
    local job = exports["isPed"]:isPed("myjob")
    if job == 'tuner_shop' or job == 'auto_exotics' or job == 'paleto_mech' or job == 'auto_bodies' then 
        if Tuner or auto_exotics or paleto_mech or auto_bodies then
            if args[1] and args[2] then
                TriggerEvent("mech:tools", args)
            end
        end
    end
end)

RegisterNetEvent("mech:check:internal:storage")
AddEventHandler("mech:check:internal:storage", function(shop)
    TriggerServerEvent("mech:check:materials", shop)
end)

RegisterNetEvent("clean:cleanvehicle")
AddEventHandler("clean:cleanvehicle", function()
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local vehicle = nil
        if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
        else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
        if DoesEntityExist(vehicle) then
            TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
            Citizen.Wait(10000)
            SetVehicleDirtLevel(vehicle, 0)
            ClearPedTasksImmediately(playerPed)
            TriggerEvent('DoLongHudText', 'Vehicle Cleaned')
        end
    end
end)


RegisterCommand("transfer", function(source, args)
    TriggerEvent("transfer:attempt")
end)

RegisterNetEvent("transfer:attempt")
AddEventHandler("transfer:attempt", function()
    local coords = GetEntityCoords(PlayerPedId())
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        if DoesEntityExist(vehicle) then
            t, distance = GetClosestPlayer()
	        if(distance ~= -1 and distance < 2) then
                local plate = GetVehicleNumberPlateText(vehicle)
                TriggerServerEvent("transfer:attempt:send", plate, GetPlayerServerId(t))
            else
                TriggerEvent("DoLongHudText", "You are not near anyone to transfer the vehicle too", 2)
            end
        end
    end
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local closestPed = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)
	if not IsPedInAnyVehicle(PlayerPedId(), false) then

		for index,value in ipairs(players) do
			local target = GetPlayerPed(value)
			if(target ~= ply) then
				local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
				local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
				if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
					closestPlayer = value
					closestPed = target
					closestDistance = distance
				end
			end
		end
		
		return closestPlayer, closestDistance, closestPed

	else
		TriggerEvent("DoShortHudText","Inside Vehicle.",2)
	end

end