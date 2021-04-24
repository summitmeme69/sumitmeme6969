local trackedVehicles = {}
local paused = false
local changingVar = ""

local checkPlayerOwnedVehicles = false

RegisterNetEvent('veh.checkOwner')
AddEventHandler('veh.checkOwner', function(status)
  checkPlayerOwnedVehicles = status
end)

RegisterNetEvent('veh.updateVehicleDegredation')
AddEventHandler('veh.updateVehicleDegredation', function(br,ax,rad,cl,tra,elec,fi,ft)
	local tempReturn = {}
	for k, v in pairs(trackedVehicles) do
		if not IsEntityDead(k) then
			tempReturn[#tempReturn+1] = v
		else
			trackedVehicles[k] = nil
		end
		if #tempReturn > 0 then
			TriggerServerEvent('veh.updateVehicleDegredationServer', v[1],br,ax,rad,cl,tra,elec,fi,ft)
		end		
	end
end)


RegisterNetEvent('veh.randomDegredation')
AddEventHandler('veh.randomDegredation', function(upperLimit,vehicle,spinAmount)
	degHealth = getDegredationArray()
	local plate = GetVehicleNumberPlateText(vehicle)
    if checkPlayerOwnedVehicles then
        local br = degHealth.breaks
        local ax = degHealth.axle
        local rad = degHealth.radiator
        local cl = degHealth.clutch
        local tra = degHealth.transmission
        local elec = degHealth.electronics
        local fi = degHealth.fuel_injector 
        local ft = degHealth.fuel_tank
        for i=1,spinAmount do
            local chance =  math.random(0,150)
             if chance <= 10 and chance >= 0 then
                  br = br - math.random(0,upperLimit)
            elseif chance <= 20 and chance >= 11 then
                 ax = ax - math.random(0,upperLimit)
            elseif chance <= 30 and chance >= 21 then
                 rad = rad - math.random(0,upperLimit)
            elseif chance <= 40 and chance >= 31 then
                 cl = cl - math.random(0,upperLimit)
            elseif chance <= 50 and chance >= 41 then
                 tra = tra - math.random(0,upperLimit)
            elseif chance <= 60 and chance >= 51 then
                 elec = elec - math.random(0,upperLimit)
            elseif chance <= 70 and chance >= 61 then
                 fi = fi - math.random(0,upperLimit)
            elseif chance <= 80 and chance >= 71 then
                 ft = ft - math.random(0,upperLimit)
            end
        end

        if br < 0 then 
            br = 0 
        end
        if ax < 0 then ax = 0 end
        if rad < 0 then rad = 0 end
        if cl < 0 then cl = 0 end
        if tra < 0 then tra = 0 end
        if elec < 0 then elec = 0 end
        if fi < 0 then fi = 0 end
        if ft < 0 then ft = 0 end
        TriggerServerEvent('veh.updateVehicleDegredationServer',plate,br,ax,rad,cl,tra,elec,fi,ft)
        TriggerServerEvent('veh.callDegredation', plate)
	end
end)

RegisterNetEvent('veh.updateVehicleBounce')
AddEventHandler('veh.updateVehicleBounce', function(br,ax,rad,cl,tra,elec,fi,ft,plate)
	if br == 0 then br = nil end
	TriggerServerEvent('veh.updateVehicleDegredationServer',plate,br,ax,rad,cl,tra,elec,fi,ft)
end)

RegisterNetEvent('veh.getSQL')
AddEventHandler('veh.getSQL', function(degredation)
	changingVar = degredation
end)

RegisterNetEvent('veh:requestUpdate')
AddEventHandler('veh:requestUpdate', function()
	local playerped = GetPlayerPed(-1)   
	local coordA = GetEntityCoords(playerped, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)
    local plate = GetVehicleNumberPlateText(targetVehicle)
	TriggerServerEvent('veh.examine',plate,targetVehicle)
end)

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




function getDegredationArray()
		local temp = changingVar:split(",")
		if(temp[1] ~= nil) then	
			local degHealth = {
			["breaks"] = 0,-- has neg effect
			["axle"] = 0,	-- has neg effect
			["radiator"] = 0, -- has neg effect
			["clutch"] = 0,	-- has neg effect
			["transmission"] = 0, -- has neg effect
			["electronics"] = 0, -- has neg effect
			["fuel_injector"] = 0, -- has neg effect
			["fuel_tank"] = 0 
			}

			for i,v in ipairs(temp) do
					if i == 1 then
						degHealth.breaks = tonumber(v)
						if degHealth.breaks == nil then
							degHealth.breaks = 0
						end
					elseif i == 2 then
						degHealth.axle = tonumber(v)
					elseif i == 3 then
						degHealth.radiator = tonumber(v)
					elseif i == 4 then
						degHealth.clutch = tonumber(v)
					elseif i == 5 then
						degHealth.transmission = tonumber(v)
					elseif i == 6 then
						degHealth.electronics = tonumber(v)
					elseif i == 7 then
						degHealth.fuel_injector = tonumber(v)
					elseif i == 8 then	
						degHealth.fuel_tank = tonumber(v)
					end
			end
		return degHealth
	end
end


RegisterNetEvent('veh.getVehicleDegredation')
AddEventHandler('veh.getVehicleDegredation', function(currentVehicle,tick)
		degHealth = getDegredationArray()
		if IsPedInVehicle(PlayerPedId(),currentVehicle,false) then
			if checkPlayerOwnedVehicles then
				if GetVehicleClass(currentVehicle) ~= 13 and GetVehicleClass(currentVehicle) ~= 21 and GetVehicleClass(currentVehicle) ~= 16 and GetVehicleClass(currentVehicle) ~= 15 and GetVehicleClass(currentVehicle) ~= 14 then
					if degHealth.fuel_injector <= 45 then
						local decayChance = math.random(10,100)
						if degHealth.fuel_injector <= 45 and degHealth.fuel_injector >= 25 then	
							if decayChance > 99 then
								fuelInjector(currentVehicle,50)
							end
						elseif degHealth.fuel_injector <= 24 and degHealth.fuel_injector >= 15 then	
							if decayChance > 98 then
								fuelInjector(currentVehicle,400)

							end
						elseif degHealth.fuel_injector <= 14 and degHealth.fuel_injector >= 9 then	
							if decayChance > 97 then
								fuelInjector(currentVehicle,600)

							end
						elseif  degHealth.fuel_injector <= 8 and degHealth.fuel_injector >= 0 then	
							if decayChance > 90 then
								fuelInjector(currentVehicle,1000)

							end
						end
					end

					if degHealth.radiator <= 35 and tick >= 15 then
						local engineHealth = GetVehicleEngineHealth(currentVehicle)
						if degHealth.radiator <= 35 and degHealth.radiator >= 20 then
							if engineHealth <= 1000 and engineHealth >= 700 then
								SetVehicleEngineHealth(currentVehicle, engineHealth-10)
							end
						elseif degHealth.radiator <= 19 and degHealth.radiator >= 10 then
							if engineHealth <= 1000 and engineHealth >= 500 then
								SetVehicleEngineHealth(currentVehicle, engineHealth-20)
							end
						elseif degHealth.radiator <= 9 and degHealth.radiator >= 0 then
							if engineHealth <= 1000 and engineHealth >= 200 then
								SetVehicleEngineHealth(currentVehicle, engineHealth-30)
							end
						end
					end

					if degHealth.axle <= 35 and tick >= 15 then
						local Chance = math.random(1,100)
						if degHealth.axle <= 35 and degHealth.axle >= 20 and Chance > 90 then
							for i=0,360 do					
								SetVehicleSteeringScale(currentVehicle,i)
								Citizen.Wait(5)
							end
						elseif degHealth.axle <= 19 and degHealth.axle >= 10 and Chance > 70 then
							for i=0,360 do	
								Citizen.Wait(10)
								SetVehicleSteeringScale(currentVehicle,i)
							end
						elseif degHealth.axle <= 9 and degHealth.axle >= 0 and Chance > 50 then
							for i=0,360 do
								Citizen.Wait(15)
								SetVehicleSteeringScale(currentVehicle,i)
							end
						end
					end

					if degHealth.transmission <= 35 and tick >= 15 then
						local speed = GetEntitySpeed(currentVehicle)
						local Chance = math.random(1,100)
						if degHealth.transmission <= 35 and degHealth.transmission >= 20 and Chance > 90 then
							for i=0,3 do
								if not IsPedInVehicle(PlayerPedId(),currentVehicle,false) then
									return
								end
								Citizen.Wait(5)
								SetVehicleHandbrake(currentVehicle,true)
								Citizen.Wait(math.random(1000))
								SetVehicleHandbrake(currentVehicle,false)
							end
						elseif degHealth.transmission <= 19 and degHealth.transmission >= 10 and Chance > 70 then
							for i=0,5 do
								if not IsPedInVehicle(PlayerPedId(),currentVehicle,false) then
									return
								end							
								Citizen.Wait(10)
								SetVehicleHandbrake(currentVehicle,true)
								Citizen.Wait(math.random(1000))
								SetVehicleHandbrake(currentVehicle,false)
							end
						elseif degHealth.transmission <= 9 and degHealth.transmission >= 0 and Chance > 50 then
							for i=0,11 do
								if not IsPedInVehicle(PlayerPedId(),currentVehicle,false) then
									return
								end							
								Citizen.Wait(20)
								SetVehicleHandbrake(currentVehicle,true)
								Citizen.Wait(math.random(1000))
								SetVehicleHandbrake(currentVehicle,false)
							end
						end
					end

					if degHealth.electronics <= 35 and tick >= 15 then
						local Chance = math.random(1,100)
						if degHealth.electronics <= 35 and degHealth.electronics >= 20 and Chance > 90 then
							for i=0,10 do
								Citizen.Wait(50)
								electronics(currentVehicle)
							end
						elseif degHealth.electronics <= 19 and degHealth.electronics >= 10 and Chance > 70 then
							for i=0,10 do
								Citizen.Wait(100)
								electronics(currentVehicle)
							end
						elseif degHealth.electronics <= 9 and degHealth.electronics >= 0 and Chance > 50 then
							for i=0,10 do
								Citizen.Wait(200)
								electronics(currentVehicle)
							end
						end
					end

					if degHealth.breaks <= 35 and tick >= 15 then
						local Chance = math.random(1,100)
						if degHealth.breaks <= 35 and degHealth.breaks >= 20 and Chance > 90 then
								SetVehicleHandbrake(currentVehicle,true)
								Citizen.Wait(1000)
								SetVehicleHandbrake(currentVehicle,false)
						elseif degHealth.breaks <= 19 and degHealth.breaks >= 10 and Chance > 70 then
								SetVehicleHandbrake(currentVehicle,true)
								Citizen.Wait(4500)
								SetVehicleHandbrake(currentVehicle,false)
						elseif degHealth.breaks <= 9 and degHealth.breaks >= 0 and Chance > 50 then
								SetVehicleHandbrake(currentVehicle,true)
								Citizen.Wait(7000)
								SetVehicleHandbrake(currentVehicle,false)
						end
					else
						SetVehicleHandbrake(currentVehicle,false)
					end

					if degHealth.clutch <= 35 and tick >= 15 then
						local Chance = math.random(1,100)
						if degHealth.clutch <= 35 and degHealth.clutch >= 20 and Chance > 90 then
								SetVehicleHandbrake(currentVehicle,true)
								fuelInjector(currentVehicle,50)
								for i=1,360 do
									SetVehicleSteeringScale(currentVehicle,i)
									Citizen.Wait(5)
								end
								Citizen.Wait(2000)
								SetVehicleHandbrake(currentVehicle,false)
						elseif degHealth.clutch <= 19 and degHealth.clutch >= 10 and Chance > 70 then
								SetVehicleHandbrake(currentVehicle,true)
								fuelInjector(currentVehicle,100)
								for i=1,360 do
									SetVehicleSteeringScale(currentVehicle,i)
									Citizen.Wait(5)
								end
								Citizen.Wait(5000)
								SetVehicleHandbrake(currentVehicle,false)
						elseif degHealth.clutch <= 9 and degHealth.clutch >= 0 and Chance > 50 then
								SetVehicleHandbrake(currentVehicle,true)
								fuelInjector(currentVehicle,200)
								for i=1,360 do
									SetVehicleSteeringScale(currentVehicle,i)
									Citizen.Wait(5)
								end
								Citizen.Wait(7000)
								SetVehicleHandbrake(currentVehicle,false)
						end
					end

					if degHealth.fuel_tank <= 35 and tick >= 15 then
						if degHealth.clutch <= 35 and degHealth.clutch >= 20 then
							TriggerEvent("carHud:FuelMulti",20)
						elseif degHealth.clutch <= 19 and degHealth.clutch >= 10 then
							TriggerEvent("carHud:FuelMulti",10)
						elseif degHealth.clutch <= 9 and degHealth.clutch >= 0 then
							TriggerEvent("carHud:FuelMulti",20)
						end
					else
						TriggerEvent("carHud:FuelMulti",1)
					end	
				end			
			end
		end
		-- add in actions for vechile when health is low 
end)
function fuelInjector(currentVehicle,wait)
	SetVehicleEngineOn(currentVehicle,0,0,1)
	SetVehicleUndriveable(currentVehicle,true)
	Citizen.Wait(wait)
	SetVehicleEngineOn(currentVehicle,1,0,1)
	SetVehicleUndriveable(currentVehicle,false)
end

function electronics(currentVehicle)
	SetVehicleLights(currentVehicle,1)
	Citizen.Wait(600)
	SetVehicleLights(currentVehicle,0)
end

function trackVehicleHealth()
	local tempReturn = {}
	for k, v in pairs(trackedVehicles) do
		if not IsEntityDead(k) then
			v[2] = math.ceil(GetVehicleEngineHealth(k))
			v[3] = math.ceil(GetVehicleBodyHealth(k))
			v[4] = DecorGetInt(k, "CurrentFuel")
			if v[4] == nil then
				v[4] = 50
			end
			tempReturn[#tempReturn+1] = v
		else
			trackedVehicles[k] = nil
		end
	end
	if #tempReturn > 0 then
		TriggerServerEvent('veh.updateVehicleHealth', tempReturn)
	end
end

RegisterNetEvent('veh.setVehicleHealth')
AddEventHandler('veh.setVehicleHealth', function(eh, bh, Fuel, veh)
	Citizen.CreateThread(function()
		setPlayerOwnedVehicle()
		paused = true
		smash = false
		damageOutside = false
		damageOutside2 = false 
		local engine = eh + 0.0
		local body = bh + 0.0

		if engine < 200.0 then
			engine = 200.0
		end

		if body < 900.0 then
			body = 900.0
		end
		if body < 950.0 then
			smash = true
		end

		if body < 920.0 then
			damageOutside = true
		end

		local currentVehicle = (veh and IsEntityAVehicle(veh)) and veh or GetVehiclePedIsIn(PlayerPedId(), false)

		SetVehicleEngineHealth(currentVehicle, engine)


		if smash then
			SmashVehicleWindow(currentVehicle, 0)
			SmashVehicleWindow(currentVehicle, 1)
			SmashVehicleWindow(currentVehicle, 2)
			SmashVehicleWindow(currentVehicle, 3)
			SmashVehicleWindow(currentVehicle, 4)
		end

		if damageOutside then
			SetVehicleDoorBroken(currentVehicle, 1, true)
			SetVehicleDoorBroken(currentVehicle, 6, true)
			SetVehicleDoorBroken(currentVehicle, 4, true)
		end


		SetVehicleBodyHealth(currentVehicle, body)

		DecorSetInt(currentVehicle, "CurrentFuel", Fuel)

		paused = false
	end)
end)


function string:split(delimiter)
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find( self, delimiter, from  )
  while delim_from do
    table.insert( result, string.sub( self, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( self, delimiter, from  )
  end
  table.insert( result, string.sub( self, from  ) )
  return result
end

enteredveh = false

RegisterNetEvent('deg:EnteredVehicle')
AddEventHandler('deg:EnteredVehicle', function()
	enteredveh = true
end)

local calledplate = nil
Citizen.CreateThread(function()
	Citizen.Wait(1000)
	local tick = 0
	local rTick = 0
	local vehicleNewBodyHealth = 0
	local vehicleNewEngineHealth = 0
	local exitveh = true
	local lastvehicle = 0
	while true do
		Citizen.Wait(1000)
        local playerPed = PlayerPedId()
        local currentVehicle = GetVehiclePedIsIn(playerPed, false)
		if IsPedInVehicle(PlayerPedId(),currentVehicle, false) then
			tick = tick + 1
			rTick = rTick + 1

			local driverPed = GetPedInVehicleSeat(currentVehicle, -1)
            if playerPed == driverPed then
                if calledplate ~= GetVehicleNumberPlateText(currentVehicle) then
                    TriggerServerEvent("enteredMyVehicle", GetVehicleNumberPlateText(currentVehicle))
                    TriggerServerEvent('veh.callDegredation', GetVehicleNumberPlateText(currentVehicle)) 
                    calledplate = GetVehicleNumberPlateText(currentVehicle) 
                else
                    TriggerServerEvent('veh.callDegredation', GetVehicleNumberPlateText(currentVehicle)) 
                end
				local plate = GetVehicleNumberPlateText(currentVehicle)
				local engineHealth = math.ceil(GetVehicleEngineHealth(currentVehicle))
				local bodyHealth = math.ceil(GetVehicleBodyHealth(currentVehicle))
				if checkPlayerOwnedVehicles then
					trackedVehicles[currentVehicle] = {plate, engineHealth, bodyHealth}
				end
			end

            if enteredveh and checkPlayerOwnedVehicles then
				currentVehicle = GetVehiclePedIsIn(playerPed, false)
				lastvehicle = currentVehicle
				enteredveh = false
				exitveh = false
				tick = 13
				rTick = 55
			end

			if tick >= 15 then
				TriggerEvent('veh.getVehicleDegredation',currentVehicle,tick)
                trackVehicleHealth()
         
				tick = 0
			end

			if rTick >= 60 then
                TriggerEvent('veh.randomDegredation',1,currentVehicle,3)
				rTick = 0
			end

		else
			if not exitveh then	
                TriggerEvent('veh.getVehicleDegredation',lastvehicle,15)
				tick = 0
				rTick = 0
				lastvehicle = 0
				currentVehicle = 0
				exitveh = true
			end
		end
	end
end)


RegisterNetEvent('veh.isPlayers')
AddEventHandler('veh.isPlayers', function(veh,cb)
	if checkPlayerOwnedVehicles then
		cb(true)
	else
		cb(false)
	end	
end)


RegisterNetEvent('veh.getDegredation')
AddEventHandler('veh.getDegredation', function(veh,cb)
	deghealth = getDegredationArray()
	local plate = GetVehicleNumberPlateText(veh)
	if checkPlayerOwnedVehicles then
        TriggerServerEvent('veh.callDegredation', plate)
        cb(deghealth)
	end
	if not checkPlayerOwnedVehicles  then
		TriggerServerEvent('veh.callDegredation', plate)
	end
	Citizen.Wait(100)
end)
local engineHealth = 0
local bodyHealth = 0

RegisterNetEvent('towgarage:triggermenu')
AddEventHandler('towgarage:triggermenu', function(degradation,eHealth,bHealth)
	local degHealth = {
		["breaks"] = 0,-- has neg effect
		["axle"] = 0,	-- has neg effect
		["radiator"] = 0, -- has neg effect
		["clutch"] = 0,	-- has neg effect
		["transmission"] = 0, -- has neg effect
		["electronics"] = 0, -- has neg effect
		["fuel_injector"] = 0, -- has neg effect
		["fuel_tank"] = 0 
	}
	local engineHealth = eHealth
	local bodyHealth = bHealth
	local temp = degradation:split(",")
	if(temp[1] ~= nil) then	
		for i,v in ipairs(temp) do
			if i == 1 then
				degHealth.breaks = tonumber(v)
				if degHealth.breaks == nil then
					degHealth.breaks = 0
				end
			elseif i == 2 then
				degHealth.axle = tonumber(v)
			elseif i == 3 then
				degHealth.radiator = tonumber(v)
			elseif i == 4 then
				degHealth.clutch = tonumber(v)
			elseif i == 5 then
				degHealth.transmission = tonumber(v)
			elseif i == 6 then
				degHealth.electronics = tonumber(v)
			elseif i == 7 then
				degHealth.fuel_injector = tonumber(v)
			elseif i == 8 then	
				degHealth.fuel_tank = tonumber(v)
			end
		end
	end

	local playerped = PlayerPedId()
	local coordA = GetEntityCoords(playerped, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)


	if targetVehicle ~= nil  and targetVehicle ~= 0 then
		engineHealth = GetVehicleEngineHealth(targetVehicle) 
		bodyHealth = GetVehicleBodyHealth(targetVehicle)
		currentVeh = targetVehicle
		local strng = "\n Brakes (Rubber) - " .. round(degHealth["breaks"] / 10,2) .. "/10.0" .. " \n Axle (Scrap) - " .. round(degHealth["axle"] / 10,2) .. "/10.0" .. " \n Radiator (Scrap) - " .. round(degHealth["radiator"] / 10,2) .. "/10.0" .. " \n Clutch (Scrap) - " .. round(degHealth["clutch"] / 10,2) .. "/10.0" .. " \n Transmission (Aluminium) - " .. round(degHealth["transmission"] / 10,2) .. "/10.0" .. " \n Electronics (Plastic) - " .. round(degHealth["electronics"] / 10,2) .. "/10.0" .. " \n Injector (Copper) - " .. round(degHealth["fuel_injector"] / 10,2) .. "/10.0" .. " \n Fuel (Steel) - " .. round(degHealth["fuel_tank"] / 10,2) .. "/10.0" .. " \n Body (Glass) - " .. round((bodyHealth / 10) / 10,2) .. "/10.0" .. " \n Engine (Scrap) - " .. round((engineHealth / 10) / 10,2) .. "/10.0"
		TriggerEvent("customNotification", strng)
	end
end)

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end