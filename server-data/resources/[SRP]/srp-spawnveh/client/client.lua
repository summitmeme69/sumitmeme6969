--------------------
------ LOCALS ------
--------------------

local policeStations = {
    {423.0098, -998.5323, 30.70965},
    {598.319, -43.34404, 77.84077},
    {394.8801, -1615.537, 29.29195},
    {838.4712, -1324.668, 26.14592},
    {-569.8502, -147.8663, 37.97765},
    {-1140.76, -852.4924, 13.80752},
    {1857.284, 3676.704, 33.68986},
    {-465.8285, 6023.557, 31.34055},
}

local showPD = true
local hospitals = {
    {289.153, -589.7777, 42.72568},
    {-238.2745, 6332.053, 32.42596},
    {1835.68, 3664.355, 33.72331},
    {301.1462, -1438.589, 29.79921},
    {-470.3907, -343.2873, 34.37463},
    {1150.98, -1506.603, 34.69252},
    {-658.088, 298.153, 81.6488},
}

local showHospitals = true

----------------------
------ COMMANDS ------
----------------------

RegisterCommand("extra", function(source, args, rawCommand)
	if exports["isPed"]:isPed("myjob") == "police" then
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped, false)
		local extraID = tonumber(args[1])
		local extra = args[1]
		local toggle = tostring(args[2])
		for k,v in pairs(Config.PoliceGarage) do 
			if IsPedInAnyVehicle(ped, true) then
				local veh = GetVehiclePedIsIn(ped, false)
				if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
					if toggle == "true" then
						toggle = 0
					end
					if veh ~= nil and veh ~= 0 and veh ~= 1 then
						TriggerEvent('DoLongHudText', 'Extra Toggled', 1)
				
						if extra == "all" then
							SetVehicleExtra(veh, 1, toggle)
							SetVehicleExtra(veh, 2, toggle)
							SetVehicleExtra(veh, 3, toggle)
							SetVehicleExtra(veh, 4, toggle)
							SetVehicleExtra(veh, 5, toggle)       
							SetVehicleExtra(veh, 6, toggle)
							SetVehicleExtra(veh, 7, toggle)
							SetVehicleExtra(veh, 8, toggle)
							SetVehicleExtra(veh, 9, toggle)               
							SetVehicleExtra(veh, 10, toggle)
							SetVehicleExtra(veh, 11, toggle)
							SetVehicleExtra(veh, 12, toggle)
							SetVehicleExtra(veh, 13, toggle)
							SetVehicleExtra(veh, 14, toggle)
							SetVehicleExtra(veh, 15, toggle)
							SetVehicleExtra(veh, 16, toggle)
							SetVehicleExtra(veh, 17, toggle)
							SetVehicleExtra(veh, 18, toggle)
							SetVehicleExtra(veh, 19, toggle)
							SetVehicleExtra(veh, 20, toggle)
						TriggerEvent('DoLongHudText', 'Extra All Toggled', 1)
						elseif extraID == extraID then
							SetVehicleExtra(veh, extraID, toggle)
						end
					end
				end
			end
		end
	elseif exports["isPed"]:isPed("myjob") == "ems" then
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped, false)
		local extraID = tonumber(args[1])
		local extra = args[1]
		local toggle = tostring(args[2])
		for k,v in pairs(Config.EMSGarage) do 
			if IsPedInAnyVehicle(ped, true) then
				local veh = GetVehiclePedIsIn(ped, false)
				if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
					if toggle == "true" then
						toggle = 0
					end
				end
				if veh ~= nil and veh ~= 0 and veh ~= 1 then
					TriggerEvent('DoLongHudText', 'Extra Toggled', 1)
					
					if extra == "all" then
						SetVehicleExtra(veh, 1, toggle)
						SetVehicleExtra(veh, 2, toggle)
						SetVehicleExtra(veh, 3, toggle)
						SetVehicleExtra(veh, 4, toggle)
						SetVehicleExtra(veh, 5, toggle)       
						SetVehicleExtra(veh, 6, toggle)
						SetVehicleExtra(veh, 7, toggle)
						SetVehicleExtra(veh, 8, toggle)
						SetVehicleExtra(veh, 9, toggle)               
						SetVehicleExtra(veh, 10, toggle)
						SetVehicleExtra(veh, 11, toggle)
						SetVehicleExtra(veh, 12, toggle)
						SetVehicleExtra(veh, 13, toggle)
						SetVehicleExtra(veh, 14, toggle)
						SetVehicleExtra(veh, 15, toggle)
						SetVehicleExtra(veh, 16, toggle)
						SetVehicleExtra(veh, 17, toggle)
						SetVehicleExtra(veh, 18, toggle)
						SetVehicleExtra(veh, 19, toggle)
						SetVehicleExtra(veh, 20, toggle)
						TriggerEvent('DoLongHudText', 'Extra All Toggled', 1)
					elseif extraID == extraID then
						SetVehicleExtra(veh, extraID, toggle)
					end
					
				end
			end
		end
	end
end, false)
  
RegisterCommand('fix', function(source)
	if exports["isPed"]:isPed("myjob") == "police" then
		policeFix()
	elseif exports["isPed"]:isPed("myjob") == "ems" then
		EMSFix()
	end
end,false)


RegisterCommand('boat', function(source, args)
	if exports["isPed"]:isPed("myjob") == "police" then
      TriggerEvent('srp:spawnVehicle', 'predator')
	else
		TriggerEvent('DoLongHudText', 'You are not Police!', 1)
  end
end)

RegisterCommand('livery', function(source, args, raw)
	local coords = GetEntityCoords(GetPlayerPed(-1))
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' and GetVehicleLiveryCount(vehicle) - 1 >= tonumber(args[1]) then
		SetVehicleLivery(vehicle, tonumber(args[1]))
		TriggerEvent('DoLongHudText', 'Livery Set', 1)
	else
		TriggerEvent('DoLongHudText', 'You are not a police officer!', 2)
	end
  end)

RegisterCommand("svlistuc", function(source, args, rawCommand)
	if exports["isPed"]:isPed("myjob") == "police" then
		TriggerEvent('chatMessagess', 'Undercover Vehicles:', 2, " \n [14] Galivanter Baller (UC) \n [15] Bravado Banshee (UC) \n [16] Bravado Buffalo (UC) \n [17] Pfister Comet (UC) \n [18] Invetero Coquette (UC) \n [19] Albany Primo (UC) \n [20] Declasse Rancher (UC) \n [21] Albany Washington (UC) ")
	end
end)


RegisterCommand("door", function(source, args, raw)
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	local Driver = GetPedInVehicleSeat(veh, -1)
	
	if args[1] ~= nil then
		door = tonumber(args[1]) - 1
	else
		door = nil
	end

	if door ~= nil then
		if DoesEntityExist(Driver) and IsPedInAnyVehicle(ped, false) then
			if GetVehicleDoorAngleRatio(veh, door) > 0 then
				SetVehicleDoorShut(veh, door, false)
			else	
				SetVehicleDoorOpen(veh, door, false, false)
			end
		end
	end
end)

RegisterCommand('seat', function(source, args)
	if args[1] ~= nil and tonumber(args[1]) >= 1 and tonumber(args[1]) <= 4 then
	  TriggerEvent('car:swapseat', tonumber(args[1]) - 2)
	end
end)


-----------------------
------ NETEVENTS ------
-----------------------

RegisterNetEvent('animation:impound')
AddEventHandler('animation:impound', function()
		inanimation = true
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("amb@code_human_police_investigate@idle_a")
		while not HasAnimDictLoaded("amb@code_human_police_investigate@idle_a") do
			Citizen.Wait(0)
		end
		
		if IsEntityPlayingAnim(lPed, "amb@code_human_police_investigate@idle_a", "idle_b", 3) then
			ClearPedSecondaryTask(lPed)
		else
			TaskPlayAnim(lPed, "amb@code_human_police_investigate@idle_a", "idle_b", 8.0, -8, -1, 49, 0, 0, 0, 0)
			seccount = 4
			while seccount > 0 do
				Citizen.Wait(1000)
				seccount = seccount - 1
			end
			ClearPedSecondaryTask(lPed)
		end		
		inanimation = false
end)

RegisterNetEvent('PDSpawnVeh')
AddEventHandler('PDSpawnVeh', function()
	TriggerEvent('srp-context:sendMenu', {
        {
            id = 1,
            header = "Police Garage",
            txt = ""
        },
        {
            id = 2,
            header = "2011 Crown Victoria",
			txt = "Old Rust Bucket!",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "polvic"
				}
            }
        },
		{
            id = 3,
            header = "2014 Ford Taurus",
			txt = "Everyone's Favourite Car!",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "poltaurus"
				}
            }
        },
		{
            id = 4,
            header = "2014 Dodge Charger",
			txt = "Flex Your Rank Playa!",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "polchar"
				}
            }
        },
		{
            id = 5,
            header = "2015 Chevy Tahoe",
			txt = "Noone Drives This Shit!",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "poltah"
				}
            }
        },
		{
            id = 6,
            header = "2015 Ford Mustang",
			txt = "H.E.A.T Have No Good Drivers!",
			params = {
                event = "spawn:veh:pd",
				args = {
					vehicle = "2015polstang"
				}
            }
        },
		{
            id = 7,
            header = "S.W.A.T Bearcat",
			txt = "Not BP For Travis To Reverse!",
			params = {
                event = "spawn:large:riot",
            }
        },
		{
            id = 8,
            header = "Prison Bus",
			txt = "The Driver Is Dying!",
			params = {
                event = "spawn:large:pbus",
            }
        },
    })
end)

RegisterNetEvent('EMSSpawnVeh')
AddEventHandler('EMSSpawnVeh', function()
	TriggerEvent('srp-context:sendMenu', {
        {
            id = 1,
            header = "EMS Garage",
            txt = ""
        },
        {
            id = 2,
            header = "2018 Vapid Speedo",
			txt = "Get in me van!",
			params = {
                event = "spawn:veh:ems",
				args = {
					vehicle = "emsnspeedo"
				}
            }
        },
		{
            id = 3,
            header = "2014 Dodge Charger",
			txt = "Everyone's Favorite Car!",
			params = {
                event = "spawn:veh:ems",
				args = {
					vehicle = "emsc"
				}
            }
        },
		{
            id = 4,
            header = "Coroner Van",
			txt = "Is it dead?",
			params = {
                event = "spawn:veh:ems",
				args = {
					vehicle = "emsv"
				}
            }
        },
    })
end)

RegisterNetEvent('spawn:veh:pd')
AddEventHandler('spawn:veh:pd', function(type)
	SpawnVehPD(type.vehicle)	
end)

RegisterNetEvent('spawn:veh:ems')
AddEventHandler('spawn:veh:ems', function(type)
	SpawnVehEMS(type.vehicle)	
end)

RegisterNetEvent("spawn:hei:pd")
AddEventHandler("spawn:hei:pd", function()
	Citizen.CreateThread(function()

        local hash = GetHashKey("polmav")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 449.45401000977, -981.42340087891, 43.691394805908, true, false)

		if name ~= "polmav" then
			SetVehicleModKit(vehicle, 0)
			SetVehicleMod(vehicle, 16, 4, false)
		end

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end
        LastVehicle = vehicle
    end)
end)

RegisterNetEvent("spawn:hei:ems")
AddEventHandler("spawn:hei:ems", function()
	Citizen.CreateThread(function()

        local hash = GetHashKey("polmav")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 351.67828369141, -588.35443115234, 74.161727905273, true, false)
		SetEntityHeading(vehicle, 251.18246459961)

		if name ~= "polmav" then
			SetVehicleModKit(vehicle, 0)
			SetVehicleMod(vehicle, 16, 4, false)
		end

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        
        SetVehicleDirtLevel(vehicle, 0)
		SetVehicleLivery(vehicle, 1)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end
        LastVehicle = vehicle
    end)
end)

RegisterNetEvent("spawn:large:riot")
AddEventHandler("spawn:large:riot", function()
	Citizen.CreateThread(function()

        local hash = GetHashKey("riot")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 450.12786865234, -1020.5704345703, 28.423704147339, true, false)
		SetEntityHeading(vehicle, 91.702270507812)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end
        LastVehicle = vehicle
    end)
end)

RegisterNetEvent("spawn:large:pbus")
AddEventHandler("spawn:large:pbus", function()
	Citizen.CreateThread(function()

        local hash = GetHashKey("pbus")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 450.12786865234, -1020.5704345703, 28.423704147339, true, false)
		SetEntityHeading(vehicle, 91.702270507812)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end
        LastVehicle = vehicle
    end)
end)

RegisterNetEvent('srp-spawnveh:showPD')
AddEventHandler('srp-spawnveh:showPD', function()
    showPD = not showPD
   for _, item in pairs(policeStations) do
        if not showPD then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[3])
            SetBlipSprite(item.blip, 60)
            SetBlipScale(item.blip, 0.7)
			SetBlipColour(item.blip, 38)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Police Department")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)
RegisterNetEvent('srp-spawnveh:EMS')
AddEventHandler('srp-spawnveh:EMS', function()
    showHospitals = not showHospitals
   for _, item in pairs(hospitals) do
        if not showHospitals then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[3])
            SetBlipSprite(item.blip, 61)
            SetBlipScale(item.blip, 0.7)
			SetBlipColour(item.blip, 2)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Hospital")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)


-----------------------
------ FUNCTIONS ------
-----------------------


function SpawnVehPD(name)
	Citizen.CreateThread(function()

        local hash = GetHashKey(name)

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 451.25408935547, -975.93743896484, 25.69979095459, 85.700180053711, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        applyMaxUpgrades(vehicle)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end
        LastVehicle = vehicle
    end)
end

function SpawnVehEMS(name)
	Citizen.CreateThread(function()

        local hash = GetHashKey(name)

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointEMS(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 333.15982055664, -576.3837890625, 28.796867370605, 338.55960083008, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end
        LastVehicle = vehicle
    end)
end

function applyMaxUpgrades(veh)
	SetVehicleModKit(veh, 0)
    SetVehicleMod(veh, 16, 4, false)
end

function findClosestSpawnPointPD(pCurrentPosition)
	local coords = vector3(451.25408935547, -975.93743896484, 25.69979095459)
	local closestDistance = -1
	local closestCoord = pCurrentPosition
	local distance = #(coords - pCurrentPosition)
	if closestDistance == -1 or closestDistance > distance then
	  closestDistance = distance
	  closestCoord = coords
	end
	return closestCoord
end

function findClosestSpawnPointEMS(pCurrentPosition)
	local coords = vector3(333.15982055664, -576.3837890625, 28.796867370605)
	local closestDistance = -1
	local closestCoord = pCurrentPosition
	local distance = #(coords - pCurrentPosition)
	if closestDistance == -1 or closestDistance > distance then
	  closestDistance = distance
	  closestCoord = coords
	end
	return closestCoord
end

function policeFix()
	local ped = GetPlayerPed(-1)
	for k,v in pairs(Config.PoliceGarage) do 
		if IsPedInAnyVehicle(ped, true) then
			local veh = GetVehiclePedIsIn(ped, false)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
				FreezeEntityPosition(veh, true)
				TriggerEvent('DoLongHudText', 'Your vehicle is being repaired please wait', 1)
				local finished = exports["srp-taskbar"]:taskBar(5000, "Completing Task")
				if finished == 100 then
					TriggerEvent('DoLongHudText', 'Your vehicle has been repaired', 1)
					SetVehicleFixed(veh)
					SetVehicleDirtLevel(veh, 0.0)
					exports["srp-oGasStations"]:SetFuel(veh, 100)
					FreezeEntityPosition(veh, false)
				else
					FreezeEntityPosition(veh, false)
				end
			end
		end
	end
end

function EMSFix()
	local ped = GetPlayerPed(-1)
	for k,v in pairs(Config.EMSGarage) do 
		if IsPedInAnyVehicle(ped, true) then
			local veh = GetVehiclePedIsIn(ped, false)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), v[1], v[2], v[3], true) <= Config.Distance then
				FreezeEntityPosition(veh, true)
				TriggerEvent('DoLongHudText', 'Your vehicle is being repaired please wait', 1)
				local finished = exports["srp-taskbar"]:taskBar(5000, "Completing Task")
				if finished == 100 then
					TriggerEvent('DoLongHudText', 'Your vehicle has been repaired', 1)
					SetVehicleFixed(veh)
					SetVehicleDirtLevel(veh, 0.0)
					exports["srp-oGasStations"]:SetFuel(veh, 100)
					FreezeEntityPosition(veh, false)
				else
					FreezeEntityPosition(veh, false)
				end
			end
		end
	end
end

Citizen.CreateThread(function()
    showPD = false
    TriggerEvent('srp-spawnveh:showPD')
end)

Citizen.CreateThread(function()
    showHospitals = false
    TriggerEvent('srp-spawnveh:EMS')
end)