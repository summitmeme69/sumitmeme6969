--------------------
------ LOCALS ------
--------------------


local tasking = false
local rnd = 0
local blip = 0
local deliveryPed = 0
local gangTaskArea = "local"
local mygang = "local"
local watching = "local"
local watchinglist = {}
local drugStorePed = 0
local cashPayment = 125
local vehspawn = false
local oxyVehicle = 0
local firstdeal = false
local lunchtime = false
local bandprice = 463
local rollcashprice = 263
-- local inkedmoneybagprice = 15000
-- local markedbillsprice = 3500
local dropoffpoints = {
	[1] =  { ['x'] = 483.17,['y'] = -1827.35,['z'] = 27.86,['h'] = 135.87, ['info'] = ' East Side 1' },
	[2] =  { ['x'] = 475.87,['y'] = -1798.45,['z'] = 28.49,['h'] = 229.85, ['info'] = ' East Side 2' },
	[3] =  { ['x'] = 503.54,['y'] = -1765.06,['z'] = 28.51,['h'] = 67.61, ['info'] = ' East Side 3' },
	[4] =  { ['x'] = 512.0,['y'] = -1842.13,['z'] = 27.9,['h'] = 138.1, ['info'] = ' East Side 4' },
	[5] =  { ['x'] = 466.89,['y'] = -1852.81,['z'] = 27.72,['h'] = 310.97, ['info'] = ' East Side 5' },
	[6] =  { ['x'] = 431.33,['y'] = -1882.85,['z'] = 26.85,['h'] = 39.7, ['info'] = ' East Side 6' },
	[7] =  { ['x'] = 410.64,['y'] = -1908.57,['z'] = 25.46,['h'] = 80.03, ['info'] = ' East Side 7' },
	[8] =  { ['x'] = 192.93,['y'] = -2027.95,['z'] = 18.29,['h'] = 251.25, ['info'] = ' East Side 8' },
	[9] =  { ['x'] = 184.05,['y'] = -2004.77,['z'] = 18.31,['h'] = 49.81, ['info'] = ' East Side 9' },
	[10] =  { ['x'] = 212.4,['y'] = -1971.66,['z'] = 20.31,['h'] = 63.83, ['info'] = ' East Side 10' },
	[11] =  { ['x'] = 266.85,['y'] = -1964.41,['z'] = 23.0,['h'] = 49.59, ['info'] = ' East Side 11' },
	[12] =  { ['x'] = 313.05,['y'] = -1918.57,['z'] = 25.65,['h'] = 315.88, ['info'] = ' East Side 12' },
	[13] =  { ['x'] = 282.63,['y'] = -1948.96,['z'] = 24.39,['h'] = 40.21, ['info'] = ' East Side 13' },
	[14] =  { ['x'] = 250.44,['y'] = -1995.9,['z'] = 20.32,['h'] = 324.5, ['info'] = ' East Side 14' },
	[15] =  { ['x'] = 270.54,['y'] = -1706.13,['z'] = 29.31,['h'] = 46.82, ['info'] = ' Central 1' },
	[16] =  { ['x'] = 167.78,['y'] = -1635.0,['z'] = 29.3,['h'] = 22.04, ['info'] = ' Central 2' },
	[17] =  { ['x'] = 175.98,['y'] = -1542.48,['z'] = 29.27,['h'] = 316.21, ['info'] = ' Central 3' },
	[18] =  { ['x'] = -99.69,['y'] = -1577.74,['z'] = 31.73,['h'] = 231.66, ['info'] = ' Central 4' },
	[19] =  { ['x'] = -171.68,['y'] = -1659.11,['z'] = 33.47,['h'] = 85.41, ['info'] = ' Central 5' },
	[20] =  { ['x'] = -209.75,['y'] = -1632.29,['z'] = 33.9,['h'] = 177.99, ['info'] = ' Central 6' },
	[21] =  { ['x'] = -262.65,['y'] = -1580.04,['z'] = 31.86,['h'] = 251.02, ['info'] = ' Central 7' },
	[22] =  { ['x'] = -182.0,['y'] = -1433.79,['z'] = 31.31,['h'] = 210.92, ['info'] = ' Central 8' },
	[23] =  { ['x'] = -83.37,['y'] = -1415.39,['z'] = 29.33,['h'] = 180.98, ['info'] = ' Central 9' },
	[24] =  { ['x'] = -39.13,['y'] = -1473.67,['z'] = 31.65,['h'] = 5.17, ['info'] = ' Central 10' },
	[25] =  { ['x'] = 45.16,['y'] = -1475.65,['z'] = 29.36,['h'] = 136.92, ['info'] = ' Central 11' },
	[26] =  { ['x'] = 158.52,['y'] = -1496.02,['z'] = 29.27,['h'] = 133.49, ['info'] = ' Central 12' },
	[27] =  { ['x'] = 43.58,['y'] = -1599.87,['z'] = 29.61,['h'] = 50.3, ['info'] = ' Central 13' },
	[28] =  { ['x'] = 7.97,['y'] = -1662.14,['z'] = 29.33,['h'] = 318.63, ['info'] = ' Central 14' },
	[29] =  { ['x'] = -726.92,['y'] = -854.64,['z'] = 22.8,['h'] = 2.0, ['info'] = ' West 1' },
	[30] =  { ['x'] = -713.09,['y'] = -886.66,['z'] = 23.81,['h'] = 357.65, ['info'] = ' West 2' },
	[31] =  { ['x'] = -591.45,['y'] = -891.2,['z'] = 25.95,['h'] = 91.53, ['info'] = ' West 3' },
	[32] =  { ['x'] = -683.59,['y'] = -945.62,['z'] = 20.85,['h'] = 180.74, ['info'] = ' West 4' },
	[33] =  { ['x'] = -765.92,['y'] = -920.94,['z'] = 18.94,['h'] = 180.44, ['info'] = ' West 5' },
	[34] =  { ['x'] = -807.45,['y'] = -957.09,['z'] = 15.29,['h'] = 340.4, ['info'] = ' West 6' },
	[35] =  { ['x'] = -822.88,['y'] = -973.96,['z'] = 14.72,['h'] = 126.28, ['info'] = ' West 7' },
	[36] =  { ['x'] = -657.53,['y'] = -729.91,['z'] = 27.84,['h'] = 309.58, ['info'] = ' West 8' },
	[37] =  { ['x'] = -618.39,['y'] = -750.71,['z'] = 26.66,['h'] = 85.6, ['info'] = ' West 9' },
	[38] =  { ['x'] = -548.36,['y'] = -854.53,['z'] = 28.82,['h'] = 352.84, ['info'] = ' West 10' },
	[39] =  { ['x'] = -518.18,['y'] = -804.65,['z'] = 30.8,['h'] = 267.32, ['info'] = ' West 11' },
	[40] =  { ['x'] = -509.05,['y'] = -737.77,['z'] = 32.6,['h'] = 174.97, ['info'] = ' West 12' },
	[41] =  { ['x'] = -567.5,['y'] = -717.77,['z'] = 33.43,['h'] = 268.02, ['info'] = ' West 13' },
	[42] =  { ['x'] = -654.89,['y'] = -732.13,['z'] = 27.56,['h'] = 309.15, ['info'] = ' West 14' },
}

local OxyDropOffs = {
	[1] =  { ['x'] = 74.5,['y'] = -762.17,['z'] = 31.68,['h'] = 160.98, ['info'] = ' 1' },
	[2] =  { ['x'] = 100.58,['y'] = -644.11,['z'] = 44.23,['h'] = 69.11, ['info'] = ' 2' },
	[3] =  { ['x'] = 175.45,['y'] = -445.95,['z'] = 41.1,['h'] = 92.72, ['info'] = ' 3' },
	[4] =  { ['x'] = 130.3,['y'] = -246.26,['z'] = 51.45,['h'] = 219.63, ['info'] = ' 4' },
	[5] =  { ['x'] = 198.1,['y'] = -162.11,['z'] = 56.35,['h'] = 340.09, ['info'] = ' 5' },
	[6] =  { ['x'] = 341.0,['y'] = -184.71,['z'] = 58.07,['h'] = 159.33, ['info'] = ' 6' },
	[7] =  { ['x'] = -26.96,['y'] = -368.45,['z'] = 39.69,['h'] = 251.12, ['info'] = ' 7' },
	[8] =  { ['x'] = -155.88,['y'] = -751.76,['z'] = 33.76,['h'] = 251.82, ['info'] = ' 8' },
	[9] =  { ['x'] = -305.02,['y'] = -226.17,['z'] = 36.29,['h'] = 306.04, ['info'] = ' penis1' },
	[10] =  { ['x'] = -347.19,['y'] = -791.04,['z'] = 33.97,['h'] = 3.06, ['info'] = ' penis2' },
	[11] =  { ['x'] = -703.75,['y'] = -932.93,['z'] = 19.22,['h'] = 87.86, ['info'] = ' penis3' },
	[12] =  { ['x'] = -659.35,['y'] = -256.83,['z'] = 36.23,['h'] = 118.92, ['info'] = ' penis4' },
	[13] =  { ['x'] = -934.18,['y'] = -124.28,['z'] = 37.77,['h'] = 205.79, ['info'] = ' penis5' },
	[14] =  { ['x'] = -1214.3,['y'] = -317.57,['z'] = 37.75,['h'] = 18.39, ['info'] = ' penis6' },
	[15] =  { ['x'] = -822.83,['y'] = -636.97,['z'] = 27.9,['h'] = 160.23, ['info'] = ' penis7' },
	[16] =  { ['x'] = 308.04,['y'] = -1386.09,['z'] = 31.79,['h'] = 47.23, ['info'] = ' penis8' },
}



local pillWorker = { ['x'] = -1487.1783447266,['y'] = -909.90631103516,['z'] = 10.02357673645,['h'] = 144.23208618164, ['info'] = 'boop bap' }

local carpick = {
    [1] = "felon",
    [2] = "kuruma",
    [3] = "sultan",
    [4] = "granger",
    [5] = "tailgater",
}

local carspawns = {
	[1] =  { ['x'] = 548.98718261719,['y'] = -1930.4293212891,['z'] = 24.817556381226,['h'] = 300.880859375, ['info'] = ' car 8' },
	[2] =  { ['x'] = 546.31506347656,['y'] = -1927.0748291016,['z'] = 24.817556381226,['h'] = 300.880859375, ['info'] = ' car 1' },
	[3] =  { ['x'] = 543.97424316406,['y'] = -1923.6086425781,['z'] = 24.817556381226,['h'] = 300.880859375, ['info'] = ' car 2' },
}


-----------------------
------ NETEVENTS ------
-----------------------

RegisterNetEvent('lunchtime')
AddEventHandler('lunchtime', function(pass)
	lunchtime = pass
end)

RegisterNetEvent("oxydelivery:client")
AddEventHandler("oxydelivery:client", function()

	if tasking then
		return
	end
	
	rnd = math.random(1,#OxyDropOffs)

	CreateBlip()

	local pedCreated = false

	tasking = true
	local toolong = 600000
	while tasking do

		Citizen.Wait(1)
		local plycoords = GetEntityCoords(PlayerPedId())
		local dstcheck = #(plycoords - vector3(OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"])) 
		local oxyVehCoords = GetEntityCoords(oxyVehicle)
		local dstcheck2 = #(plycoords - oxyVehCoords) 

		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		if dstcheck < 40.0 and not pedCreated and (oxyVehicle == veh or dstcheck2 < 15.0) then
			pedCreated = true
			DeleteCreatedPed()
			CreateOxyPed()
			TriggerEvent("DoLongHudText","You are close to the drop off.")
		end
		toolong = toolong - 1
		if toolong < 0 then

		    SetVehicleHasBeenOwnedByPlayer(oxyVehicle,false)
			SetEntityAsNoLongerNeeded(oxyVehicle)
			tasking = false
			OxyRun = false
			TriggerEvent("DoLongHudText","You are no longer selling Oxy due to taking too long to drop off.")
		end
		if dstcheck < 2.0 and pedCreated then

			local crds = GetEntityCoords(deliveryPed)
			DrawText3Ds(crds["x"],crds["y"],crds["z"], "[E]")  

			if IsControlJustReleased(0,38) then
				TaskTurnPedToFaceEntity(deliveryPed, PlayerPedId(), 1.0)
				Citizen.Wait(1500)
				PlayAmbientSpeech1(deliveryPed, "Generic_Hi", "Speech_Params_Force")
				DoDropOff()
				tasking = false
			end
		end
	end
	
	DeleteCreatedPed()
	DeleteBlip()

end)

RegisterNetEvent("oxydelivery:startDealing")
AddEventHandler("oxydelivery:startDealing", function()
	local NearNPC = exports["isPed"]:GetClosestNPC()
	PlayAmbientSpeech1(NearNPC, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
	TriggerEvent("DoLongHudText","Your pager will be updated with locations soon.")
	salecount = 0	
	firstdeal = true
	OxyRun = true
	vehspawn = false
	CreateOxyVehicle()
	vehspawn = true
end)
-----------------------
------ FUNCTIONS ------
-----------------------

function CleanUpArea()
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(plycoords - pos)
        if distance < 10.0 and ObjectFound ~= playerped then
        	if IsEntityAPed(ObjectFound) then
        		if IsPedAPlayer(ObjectFound) then
        		else
        			DeleteObject(ObjectFound)
        		end
        	else
        		if not IsEntityAVehicle(ObjectFound) and not IsEntityAttached(ObjectFound) then
	        		DeleteObject(ObjectFound)
	        	end
        	end            
        end
        success, ObjectFound = FindNextObject(handle)
    until not success
    SetEntityAsNoLongerNeeded(drugStorePed)
    DeleteEntity(drugStorePed)
    EndFindObject(handle)
end





OxySpot = false

Citizen.CreateThread(function()
	exports["srp-polyzone"]:AddBoxZone("oxy_run_start", vector3(510.71, -1951.51, 24.99), 1.8, 1, {
		name="oxy_run_start",
		heading=35,
		--debugPoly=true,
		minZ=23.99,
		maxZ=26.59
	})
end)

RegisterNetEvent('srp-polyzone:enter')
AddEventHandler('srp-polyzone:enter', function(name)
    if name == "oxy_run_start" then
        OxySpot = true     
        LuckyDrawPlace()
		if not OxyRun then
			TriggerEvent('srp-ui:ShowUI', 'show', ("[E] %s"):format("Start Run ($750)")) 
		else
			TriggerEvent('srp-ui:ShowUI', 'show', ("%s"):format("Finish Your Run")) 
		end
    end
end)

RegisterNetEvent('srp-polyzone:exit')
AddEventHandler('srp-polyzone:exit', function(name)
    if name == "oxy_run_start" then
        OxySpot = false  
		TriggerEvent('srp-ui:HideUI')   
    end
end)

function LuckyDrawPlace()
	Citizen.CreateThread(function()
        while OxySpot do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
				if not OxyRun then
					TriggerServerEvent("oxydelivery:server", 750)
				end          
			end
		end
	end)
end

Citizen.CreateThread(function()
    while true do
        if drugdealer then
	        Citizen.Wait(1000)
	        if firstdeal then
	        	Citizen.Wait(10000)
	        end
	        TriggerEvent("drugdelivery:client")  
		    salecount = salecount + 1
		    if salecount == 7 then
		    	Citizen.Wait(1200000)
		    	drugdealer = false
		    end
		    Citizen.Wait(150000)
		    firstdeal = false
		elseif OxyRun then
			if (not DoesEntityExist(oxyVehicle) or GetVehicleEngineHealth(oxyVehicle) < 100.0) and vehspawn then
				OxyRun = false
				tasking = false
				TriggerEvent("chatMessage", "EMAIL - Drug Deliveries", 8, "Dude! You fucked the car up, I canceled your run, asshole! ")
			else
				if tasking then
			        Citizen.Wait(30000)
			    else
			        TriggerEvent("oxydelivery:client")  
				    salecount = salecount + 1
				    if salecount == 6 then
				    	Citizen.Wait(1200000)
				    	OxyRun = false
				    end
				end
			end
	    else
			Citizen.Wait(2000)
	    end
    end
end)

function CreateOxyVehicle()

	if DoesEntityExist(oxyVehicle) then

	    SetVehicleHasBeenOwnedByPlayer(oxyVehicle,false)
		SetEntityAsNoLongerNeeded(oxyVehicle)
		DeleteEntity(oxyVehicle)
	end

    local car = GetHashKey(carpick[math.random(#carpick)])
    RequestModel(car)
    while not HasModelLoaded(car) do
        Citizen.Wait(0)
    end

    local spawnpoint = 1
    for i = 1, #carspawns do
	    local caisseo = GetClosestVehicle(carspawns[i]["x"], carspawns[i]["y"], carspawns[i]["z"], 3.500, 0, 70)
		if not DoesEntityExist(caisseo) then
			spawnpoint = i
		end
    end

    oxyVehicle = CreateVehicle(car, carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"], carspawns[spawnpoint]["h"], true, false)
	local plt = GetVehicleNumberPlateText(oxyVehicle)
	DecorSetInt(oxyVehicle,"GamemodeCar",955)
	SetVehicleHasBeenOwnedByPlayer(oxyVehicle,true)
	TriggerEvent("keys:received",plt)


    while true do
    	Citizen.Wait(1)
    	 DrawText3Ds(carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"], "Your Delivery Car (Stolen).")
    	 if #(GetEntityCoords(PlayerPedId()) - vector3(carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"])) < 8.0 then
    	 	return
    	 end
    end

end

function CreateOxyPed()

    local hashKey = `a_m_y_stwhi_01`

    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end


	deliveryPed = CreatePed(pedType, hashKey, OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"], OxyDropOffs[rnd]["h"], 0, 0)
	
	DecorSetBool(deliveryPed, 'ScriptedPed', true)
    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)

    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    searchPockets()
    SetPedKeepTask(deliveryPed, true)

end

function DeleteCreatedPed()
	if DoesEntityExist(deliveryPed) then 
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)
		DecorSetBool(deliveryPed, 'ScriptedPed', false)

		Citizen.Wait(20000)
		DeletePed(deliveryPed)
	end
end

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function CreateBlip()
	DeleteBlip()
	if OxyRun then
		blip = AddBlipForCoord(OxyDropOffs[rnd]["x"],OxyDropOffs[rnd]["y"],OxyDropOffs[rnd]["z"])
	else
		blip = AddBlipForCoord(dropoffpoints[rnd]["x"],dropoffpoints[rnd]["y"],dropoffpoints[rnd]["z"])
	end
    
    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drop Off")
    EndTextCommandSetBlipName(blip)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function searchPockets()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "random@mugging4" )
        TaskPlayAnim( deliveryPed, "random@mugging4", "agitated_loop_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    end
end

function giveAnim()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 3 ) ) then 
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        else
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        end     
    end
end

function DoDropOff(requestMoney)

	cashPayment = 90 + math.random(35)
	local success = true

	searchPockets()

	Wait(1500)

	PlayAmbientSpeech1(deliveryPed, "Chat_State", "Speech_Params_Force")

	if DoesEntityExist(deliveryPed) and not IsEntityDead(deliveryPed) then

			if math.random(10) == 1 then
				TriggerEvent( "player:receiveItem", "Gruppe6Card", 1 )
			end
			
			if math.random(49) == 49 then
				TriggerEvent("traps:luck:aiSale")
			end

			if OxyRun then

				cashPayment = math.random(90,125)
				
				if exports["srp-inventory"]:hasEnoughOfItem("inkedmoneybag",1,false) then     

		        elseif exports["srp-inventory"]:hasEnoughOfItem("rollcash",10,false) then     
		            TriggerEvent("inventory:removeItem","rollcash", 10)   
		            cashPayment = cashPayment + rollcashprice             
		            TriggerEvent("DoLongHudText","Thanks for the extra sauce!")          
				elseif exports["srp-inventory"]:hasEnoughOfItem("band",10,false) then     
					TriggerEvent("inventory:removeItem","band", 10)   
					cashPayment = cashPayment + bandprice           
					TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
				else
		            TriggerEvent("DoLongHudText","Thanks, no extra sauce though?!")
		        end

				if math.random(100) > 45 then
					TriggerEvent( "player:receiveItem", "oxy", math.random(1,3))
				end
				cashPayment = math.random(90, 125)
		end
	end

	local counter = math.random(90, 115)
	while counter > 0 do
		local crds = GetEntityCoords(deliveryPed)
		counter = counter - 1
		Citizen.Wait(1)
	end

	if success then
		searchPockets()
		local counter = math.random(90, 115)
		while counter > 0 do
			local crds = GetEntityCoords(deliveryPed)
			counter = counter - 1
			Citizen.Wait(1)
		end
		giveAnim()
	end

	local crds = GetEntityCoords(deliveryPed)
	local crds2 = GetEntityCoords(PlayerPedId())

	if #(crds - crds2) > 5.0 or not DoesEntityExist(deliveryPed) or IsEntityDead(deliveryPed) then
		success = false
	end


	if success then

		PlayAmbientSpeech1(deliveryPed, "Generic_Thanks", "Speech_Params_Force_Shouted_Critical")
		if math.random(7) == 5 then
			TriggerEvent( "player:receiveItem", "oxy", math.random(1,3))
		end

		TriggerServerEvent('mission:finished', cashPayment)
		--TriggerServerEvent("police:multipledenominators",true)
		TriggerEvent("denoms",true)
		TriggerEvent("client:newStress",true,250)

	else
		TriggerEvent("DoLongHudText","The drop off failed.",2)
	end
	
	DeleteBlip()
	if success then
		Citizen.Wait(2000)
		TriggerEvent("DoLongHudText", "I got the call in, delivery was on point, go await the next one! ",2)
	else
		TriggerEvent("DoLongHudText","The drop off failed - you need stolen items.",2)
	end

	DeleteCreatedPed()
end

function DropItemPed(ai)
    local ai = ai
    local chance = math.random(50)
    if chance > 41 then
        DropDrugs(ai,true)
    elseif chance > 35 then
        DropDrugs(ai,false)
    end
    TriggerServerEvent('mission:finished', cashPayment)
end

function CreateDrugStorePed()

	if DoesEntityExist(drugStorePed) then
		return
	end
	local hashKey = `a_m_y_stwhi_02`
	local pedType = GetPedType(hashKey)
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end
	drugStorePed = CreatePed(pedType, hashKey, pillWorker["x"],pillWorker["y"],pillWorker["z"], 270.0, 1, 1)
	SetEntityHeading(drugStorePed, 180.24)
	DecorSetBool(drugStorePed, 'ScriptedPed', true)
    ClearPedTasks(drugStorePed)
    ClearPedSecondaryTask(drugStorePed)
    TaskSetBlockingOfNonTemporaryEvents(drugStorePed, true)
    SetPedFleeAttributes(drugStorePed, 0, 0)
    SetPedCombatAttributes(drugStorePed, 17, 1)

    SetPedSeeingRange(drugStorePed, 0.0)
    SetPedHearingRange(drugStorePed, 0.0)
    SetPedAlertness(drugStorePed, 0)
    SetPedKeepTask(drugStorePed, true)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
