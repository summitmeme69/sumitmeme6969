RegisterNetEvent("srp-jobmanager:playerBecameJob")
AddEventHandler("srp-jobmanager:playerBecameJob", function(job, name, notify)
    if isMedic and job ~= "ems" then isMedic = false isInService = false end
    if isCop and job ~= "police" then isCop = false isInService = false end
    if job == "police" then isCop = true isInService = true end
    if job == "ems" then isMedic = true isInService = true end

end)


local scanId = 0
local cityRobbery = false
local myspawns = {}
local isLockpicking = false

local SecurityCamLocations = {
	[1] =  { ['x'] = 24.18,['y'] = -1347.35,['z'] = 29.5,['h'] = 271.32, ['info'] = ' Innocence Blvd - 1', ["recent"] = false },
	[2] =  { ['x'] = -46.56,['y'] = -1757.98,['z'] = 29.43,['h'] = 48.68, ['info'] = ' Grove Street - 2', ["recent"] = false },
	[3] =  { ['x'] = -706.02,['y'] = -913.61,['z'] = 19.22,['h'] = 85.61, ['info'] = ' Little Seoul - 3', ["recent"] = false },
	[4] =  { ['x'] = -1221.97,['y'] = -908.42,['z'] = 12.33,['h'] = 31.1, ['info'] = ' San Andreas Ave - 4', ["recent"] = false },
	[5] =  { ['x'] = 1164.99,['y'] = -322.78,['z'] = 69.21,['h'] = 96.91, ['info'] = ' Mirror Park Blvd - 5', ["recent"] = false },
	[6] =  { ['x'] = 372.25,['y'] = 326.43,['z'] = 103.57,['h'] = 252.9, ['info'] = '  Clinton Ave - 6', ["recent"] = false },
	[7] =  { ['x'] = -1819.98,['y'] = 794.57,['z'] = 138.09,['h'] = 126.56, ['info'] = ' North Rockford Drive - 7', ["recent"] = false },
	[8] =  { ['x'] = -2966.24,['y'] = 390.94,['z'] = 15.05,['h'] = 84.58, ['info'] = '  Great Ocean Highway - 8', ["recent"] = false },
	[9] =  { ['x'] = -3038.92,['y'] = 584.21,['z'] = 7.91,['h'] = 19.43, ['info'] = ' Inseno Road - 9', ["recent"] = false },
	[10] =  { ['x'] = -3242.48,['y'] = 999.79,['z'] = 12.84,['h'] = 351.35, ['info'] = ' Barbareno Road - 10', ["recent"] = false },
	[11] =  { ['x'] = 2557.14,['y'] = 380.64,['z'] = 108.63,['h'] = 353.01, ['info'] = ' Palomino Freeway - 11', ["recent"] = false },
	[12] =  { ['x'] = 1166.02,['y'] = 2711.15,['z'] = 38.16,['h'] = 175.0, ['info'] = '  Harmony Rt 68 - 12', ["recent"] = false },
	[13] =  { ['x'] = 549.32,['y'] = 2671.3,['z'] = 42.16,['h'] = 94.96, ['info'] = ' Rt 68/Joshua Rd - 13', ["recent"] = false },
	[14] =  { ['x'] = 1959.96,['y'] = 3739.99,['z'] = 32.35,['h'] = 296.38, ['info'] = ' Alhambra Drive - 14', ["recent"] = false },
	[15] =  { ['x'] = 2677.98,['y'] = 3279.28,['z'] = 55.25,['h'] = 327.81, ['info'] = ' Senora / Sandy Shores - 15', ["recent"] = false },
	[16] =  { ['x'] = 1697.8,['y'] = 4922.69,['z'] = 42.07,['h'] = 322.95, ['info'] = ' Grapeseed Main - 17', ["recent"] = false },
	[17] =  { ['x'] = 1728.82,['y'] = 6417.38,['z'] = 35.04,['h'] = 233.94, ['info'] = ' North Senora / Pelato - 18', ["recent"] = false },

}



storePedLocations = {
	[1] =  { ['x'] = 24.18,['y'] = -1347.35,['z'] = 29.5,['h'] = 271.32, ['info'] = ' Store Robbery 1', ["recent"] = false, ["safe"] = true },
	[2] =  { ['x'] = -46.56,['y'] = -1757.98,['z'] = 29.43,['h'] = 48.68, ['info'] = ' Store Robbery 2', ["recent"] = false, ["safe"] = true },
	[3] =  { ['x'] = -706.02,['y'] = -913.61,['z'] = 19.22,['h'] = 85.61, ['info'] = ' Store Robbery 3', ["recent"] = false, ["safe"] = true },
	[4] =  { ['x'] = -1221.97,['y'] = -908.42,['z'] = 12.33,['h'] = 31.1, ['info'] = ' Store Robbery 4', ["recent"] = false, ["safe"] = true },
	[5] =  { ['x'] = 1164.99,['y'] = -322.78,['z'] = 69.21,['h'] = 96.91, ['info'] = ' Store Robbery 5', ["recent"] = false, ["safe"] = true },
	[6] =  { ['x'] = 372.25,['y'] = 326.43,['z'] = 103.57,['h'] = 252.9, ['info'] = ' Store Robbery 6', ["recent"] = false, ["safe"] = true },
	[7] =  { ['x'] = -1819.98,['y'] = 794.57,['z'] = 138.09,['h'] = 126.56, ['info'] = ' Store Robbery 7', ["recent"] = false, ["safe"] = true },
	[8] =  { ['x'] = -2966.24,['y'] = 390.94,['z'] = 15.05,['h'] = 84.58, ['info'] = ' Store Robbery 8', ["recent"] = false, ["safe"] = true },
	[9] =  { ['x'] = -3038.92,['y'] = 584.21,['z'] = 7.91,['h'] = 19.43, ['info'] = ' Store Robbery 9', ["recent"] = false, ["safe"] = true },
	[10] =  { ['x'] = -3242.48,['y'] = 999.79,['z'] = 12.84,['h'] = 351.35, ['info'] = ' Store Robbery 10', ["recent"] = false, ["safe"] = true },
	[11] =  { ['x'] = 2557.14,['y'] = 380.64,['z'] = 108.63,['h'] = 353.01, ['info'] = ' Store Robbery 11', ["recent"] = false, ["safe"] = true },
	[12] =  { ['x'] = 1166.02,['y'] = 2711.15,['z'] = 38.16,['h'] = 175.0, ['info'] = ' Store Robbery 12', ["recent"] = false, ["safe"] = true },
	[13] =  { ['x'] = 549.32,['y'] = 2671.3,['z'] = 42.16,['h'] = 94.96, ['info'] = ' Store Robbery 13', ["recent"] = false, ["safe"] = true },
	[14] =  { ['x'] = 1959.96,['y'] = 3739.99,['z'] = 32.35,['h'] = 296.38, ['info'] = ' Store Robbery 14', ["recent"] = false, ["safe"] = true },
	[15] =  { ['x'] = 2677.98,['y'] = 3279.28,['z'] = 55.25,['h'] = 327.81, ['info'] = ' Store Robbery 15', ["recent"] = false, ["safe"] = true },
	[16] =  { ['x'] = 1697.8,['y'] = 4922.69,['z'] = 42.07,['h'] = 322.95, ['info'] = ' Store Robbery 17', ["recent"] = false, ["safe"] = true },
	[17] =  { ['x'] = 1728.82,['y'] = 6417.38,['z'] = 35.04,['h'] = 233.94, ['info'] = ' Store Robbery 18', ["recent"] = false, ["safe"] = true },
}


safeLocations = {
	[1] =  { ['x'] = 28.26,['y'] = -1339.25,['z'] = 29.5,['h'] = 356.94, ['info'] = ' 1 safe' },
	[2] =  { ['x'] = -43.44,['y'] = -1748.46,['z'] = 29.43,['h'] = 48.64, ['info'] = ' 2 safe' },
	[3] =  { ['x'] = -709.67,['y'] = -904.19,['z'] = 19.22,['h'] = 84.34, ['info'] = ' 3 safe' },
	[4] =  { ['x'] = -1220.84,['y'] = -915.88,['z'] = 11.33,['h'] = 125.89, ['info'] = ' 4 safe' },
	[5] =  { ['x'] = 1159.78,['y'] = -314.06,['z'] = 69.21,['h'] = 99.31, ['info'] = ' 5 safe' },
	[6] =  { ['x'] = 378.08,['y'] = 333.37,['z'] = 103.57,['h'] = 338.48, ['info'] = ' 6 safe' },
	[7] =  { ['x'] = -1829.03,['y'] = 798.92,['z'] = 138.19,['h'] = 127.41, ['info'] = ' 7 safe' },
	[8] =  { ['x'] = -2959.64,['y'] = 387.16,['z'] = 14.05,['h'] = 173.43, ['info'] = ' 8 safe' },
	[9] =  { ['x'] = -3047.55,['y'] = 585.67,['z'] = 7.91,['h'] = 104.0, ['info'] = ' 9 safe' },
	[10] =  { ['x'] = -3249.92,['y'] = 1004.42,['z'] = 12.84,['h'] = 81.06, ['info'] = ' 10 safe' },
	[11] =  { ['x'] = 2549.25,['y'] = 384.91,['z'] = 108.63,['h'] = 84.09, ['info'] = ' 11 safe' },
	[12] =  { ['x'] = 1169.24,['y'] = 2717.96,['z'] = 37.16,['h'] = 266.31, ['info'] = ' 12 safe' },
	[13] =  { ['x'] = 546.42,['y'] = 2663.01,['z'] = 42.16,['h'] = 186.64, ['info'] = ' 13 safe' },
	[14] =  { ['x'] = 1959.27,['y'] = 3748.78,['z'] = 32.35,['h'] = 26.58, ['info'] = ' 14 safe' },
	[15] =  { ['x'] = 2672.89,['y'] = 3286.54,['z'] = 55.25,['h'] = 60.89, ['info'] = ' 15 safe' },
	[16] =  { ['x'] = 1707.66,['y'] = 4920.13,['z'] = 42.07,['h'] = 320.34, ['info'] = ' 17 safe' },
	[17] =  { ['x'] = 1734.69,['y'] = 6420.48,['z'] = 35.04,['h'] = 332.9, ['info'] = ' 18 safe' },
}


local inCam = false
local securityCam = 0
local CorrectStore = 0

RegisterNetEvent("lucky:store")
AddEventHandler("lucky:store", function()
	CorrectStore = math.random(17)
	TriggerEvent('phone:addnotification', 'EMAIL', "Hey, I heard a store has some hot shit in it, go check it out @ " .. SecurityCamLocations[CorrectStore]["info"])
	TriggerEvent("DoLongHudText", "Your GPS has been updated!")
	SetNewWaypoint(SecurityCamLocations[CorrectStore]["x"], SecurityCamLocations[CorrectStore]["y"])
end)



RegisterNetEvent("security:camera")
AddEventHandler("security:camera", function(camNumber)
	camNumber = tonumber(camNumber)
	if inCam then
		inCam = false
		TriggerEvent('animation:tablet',false)
		Wait(250)
		ClearPedTasks(PlayerPedId())
	else
		if camNumber > 0 and camNumber < #SecurityCamLocations+1 then
			TriggerEvent("security:startcamera",camNumber)
		else
			TriggerEvent("notification","This camera appears to be faulty",2)
		end
	end
end)

RegisterNetEvent("police:notifySecurityCam")
AddEventHandler("police:notifySecurityCam", function(currentRobbery)
	local myjob = exports["isPed"]:isPed("myjob")
	if myjob == "police" then
		TriggerEvent('chatMessage', "DISPATCH ", 3, "Security Camera number " .. currentRobbery .. " has been triggered.", 5000)
	end
end)

-- store robbery checks

RegisterNetEvent("store:dosafe")
AddEventHandler("store:dosafe", function()
	local police = exports["isPed"]:isPed("countpolice")
	if police >= 2 then
		local storeid = isStoreRobbery()
		TriggerServerEvent('conviencesafe:log')
		TriggerEvent("srp-dispatch:storerobbery")
		TriggerServerEvent("police:camrobbery",storeid)
		TriggerEvent("client:newStress",true,200)	
		TriggerEvent("safecracking:loop",8,"robbery:safe")
	else
		TriggerEvent("DoLongHudText", "Not enough cops online")
	end
end)



local fuck = 0
local you = 0



RegisterNetEvent("store:register")
AddEventHandler("store:register", function(storeid,regid)
	local police = exports["isPed"]:isPed("countpolice")
	if police >= 2 then
		TriggerEvent("srp-dispatch:storerobbery")
		TriggerServerEvent('convienceregister:log')
		TriggerServerEvent("police:camrobbery",storeid)
		TriggerEvent("client:newStress",true,200)	
		TriggerEvent("safecracking:loop",3,"robbery:register")
		fuck = storeid
		you = regid
		isLockpicking = true
	else
		TriggerEvent("DoLongHudText", "Not enough cops online")
	end
end)




RegisterNetEvent("inv:advancedLockpick")
AddEventHandler("inv:advancedLockpick", function()
	
	if isLockpicking then return end
	local storeid = isStoreRobbery()
	if storeid ~= 0 then
		local safeCoords = safeLocations[storeid]

		if #(vector3(safeCoords["x"],safeCoords["y"],safeCoords["z"]) - GetEntityCoords(PlayerPedId())) < 3.0 then
			TriggerServerEvent("store:robbery:safe", storeid)
			return
		end 

		local curCoords = GetEntityCoords(PlayerPedId())

		local RegisterObject = GetClosestObjectOfType(curCoords, 2.0, 303280717, 0, 0, 0)
		local GoodSpot = GetOffsetFromEntityInWorldCoords(RegisterObject, 0.0, -0.6, 0.0)

		if #(GoodSpot - curCoords) > 1.0 then
			TriggerEvent("notification","You must be at the front of the register")
			isLockpicking = false
			return
		end
		if RegisterObject then		
			local objHead = GetEntityHeading(RegisterObject)
			local plyHead = GetEntityHeading(PlayerPedId())
			if objHead - plyHead > 20.0 and objHead - plyHead < 340.0 then
				TriggerEvent("notification","You must face the register")
				isLockpicking = false
				return
			end
			TriggerServerEvent("store:robbery:register",storeid,RegisterObject)
			 robbed = true 
			return
		end

	end

end)
RegisterNetEvent("robbery:register:finishedLockpick")
AddEventHandler("robbery:register:finishedLockpick", function()
	isLockpicking = false
end)


RegisterNetEvent("robbery:register")
AddEventHandler("robbery:register", function()
	local storeid = isStoreRobbery()
	isLockpicking = false
	TriggerServerEvent("store:robbery:register:success",fuck,you)
	TriggerEvent("player:receiveItem","rollcash",math.random(10,35))
end)

RegisterNetEvent("robbery:safe")
AddEventHandler("robbery:safe", function()

	local storeid = isStoreRobbery()
	if tonumber(storeid) == tonumber(CorrectStore) then
		CorrectStore = 0

		if math.random(20) > 5 then
		    if math.random(100) > 70 then
		      TriggerEvent("player:receiveItem","Gruppe6Card2",1)
		    else
		      TriggerEvent("player:receiveItem","Gruppe6Card3",1)
		    end
		end

		TriggerEvent("player:receiveItem","band",math.random(10,15))

	end

	if math.random(25) > 5 then
    	TriggerEvent("player:receiveItem","Gruppe6Card",1)
	end

	TriggerEvent("player:receiveItem","rollcash",math.random(45, 80))

end)




RegisterCommand('cctv', function(source, args)
	camNumber = tonumber(args[1])
	local job = exports["isPed"]:isPed("myjob")
	if job == "police" and args[1] ~= nil then
		TriggerEvent('security:startcamera', camNumber)
		if args[1] == "off" then
			inCam = false
			TriggerEvent('animation:tablet',false)
		
		else
			TriggerEvent('notification', 'Accesing Camera Number ' .. camNumber .. '', 1)
		end
	else
		TriggerEvent('notification', 'Invalid Permissions Attempted to Access Camera ' .. camNumber .. ' | Job Required: Police, Government Alerted', 2)
		print('Invalid Permissions Attempted to Access ' .. camNumber .. 'Job Required: Police')
	end
end)

RegisterNetEvent("security:startcamera")
AddEventHandler("security:startcamera", function(camNumber)
	if inCam then
		return
	end

	TriggerEvent('animation:tablet',true)
	local camNumber = tonumber(camNumber)
	local x = SecurityCamLocations[camNumber]["x"]
	local y = SecurityCamLocations[camNumber]["y"]
	local z = SecurityCamLocations[camNumber]["z"]
	local h = SecurityCamLocations[camNumber]["h"]

	inCam = true

	SetTimecycleModifier("heliGunCam")
	SetTimecycleModifierStrength(1.0)
	local scaleform = RequestScaleformMovie("TRAFFIC_CAM")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	local lPed = PlayerPedId()
	securityCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	SetCamCoord(securityCam,x,y,z+1.2)						
	SetCamRot(securityCam, -15.0,0.0,h)
	SetCamFov(securityCam, 110.0)
	RenderScriptCams(true, false, 0, 1, 0)
	PushScaleformMovieFunction(scaleform, "PLAY_CAM_MOVIE")
	SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
	PopScaleformMovieFunctionVoid()

	while inCam do
		SetCamCoord(securityCam,x,y,z+1.2)						
		SetCamRot(securityCam, -15.0,0.0,h)
		PushScaleformMovieFunction(scaleform, "SET_ALT_FOV_HEADING")
		PushScaleformMovieFunctionParameterFloat(GetEntityCoords(h).z)
		PushScaleformMovieFunctionParameterFloat(1.0)
		PushScaleformMovieFunctionParameterFloat(GetCamRot(securityCam, 2).z)
		PopScaleformMovieFunctionVoid()
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		Citizen.Wait(1)
	end
	ClearFocus()
	ClearTimecycleModifier()
	RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
	SetScaleformMovieAsNoLongerNeeded(scaleform) -- Cleanly release the scaleform
	DestroyCam(securityCam, false)
	SetNightvision(false)
	SetSeethrough(false)	


end)

function isStoreRobbery()
	local dstMin = 999.0
	for i = 1, #storePedLocations do
		local dstScanned = #(GetEntityCoords(PlayerPedId()) - vector3(storePedLocations[i]["x"],storePedLocations[i]["y"],storePedLocations[i]["z"]))
		if dstScanned < dstMin then
			dstMin = dstScanned
			scanId = i
		end
	end
	if dstMin < 20.0 then
		return scanId
	else
		return 0
	end
end

local recentSpawn = false
Citizen.CreateThread(function()
	--SafeCheck()
    while true do

    	local dstMin = 999.0
    	for i = 1, #storePedLocations do
    		local dstScanned = #(GetEntityCoords(PlayerPedId()) - vector3(storePedLocations[i]["x"],storePedLocations[i]["y"],storePedLocations[i]["z"]))
    		if dstScanned < dstMin then
    			dstMin = dstScanned
    			scanId = i
    		end
    	end
    	if dstMin > 30.0 then
    		scanId = 0
    		Wait(math.ceil(dstMin*5))
    		if #myspawns > 0 then
    			for i = 1, #myspawns do

    				SetEntityAsNoLongerNeeded(myspawns[i],true)
    			end
    		end
    		myspawns = {}
    		
    	else
    		local playerPed = PlayerPedId()
    		local inveh = IsPedInAnyVehicle(playerPed, true)
    		if not recentSpawn and not inveh then
	    		SpawnPed(scanId)
	    	end
	    	if #(GetEntityCoords(PlayerPedId()) - vector3(-47.93, -963.22, 29.38)) < 2000.0 and not cityRobbery then
	    		
	    		cityRobbery = true
	    	else
	    		cityRobbery = false
	    	end

	    	
	        Wait(1)
	    end
    end
end)



function SpawnPed(i)
	recentSpawn = true
	pedType = `mp_m_shopkeep_01`
	local x = storePedLocations[i]["x"]
	local y = storePedLocations[i]["y"]
	local z = storePedLocations[i]["z"]
	local h = storePedLocations[i]["h"]

    RequestModel(pedType)

    while not HasModelLoaded(pedType) do
        Citizen.Wait(0)
    end

    local IsPedNearCoords = exports["isPed"]:IsPedNearCoords(x,y,z)
    if not IsPedNearCoords then
    	if GetPedType(pedType) ~= nil then
			local shopPed = CreatePed(GetPedType(pedType), pedType, x,y,z, h, 1, 1)
			myspawns[#myspawns+1] = shopPed
			SetPedKeepTask(shopPed, true)
			SetPedDropsWeaponsWhenDead(shopPed,false)
	        SetPedFleeAttributes(shopPed, 0, 0)
	        SetPedCombatAttributes(shopPed, 17, 1)
	        SetPedSeeingRange(shopPed, 0.0)
	        SetPedHearingRange(shopPed, 0.0)
	        SetPedAlertness(shopPed, 0.0)
		end
	end
	Citizen.Wait(10000)
	recentSpawn = false
end


LuckySpot = false

Citizen.CreateThread(function()
	exports["srp-polyzone"]:AddBoxZone("store_robbery_lucky", vector3(913.97, -1272.84, 27.1), 1.8, 1.2, {
		name="store_robbery_lucky",
		heading=37,
		minZ=25.95,
		maxZ=28.15
	})
end)

RegisterNetEvent('srp-polyzone:enter')
AddEventHandler('srp-polyzone:enter', function(name)
    if name == "store_robbery_lucky" then
        LuckySpot = true     
        LuckyDrawPlace()
		TriggerEvent('srp-ui:ShowUI', 'show', ("[E] %s"):format("Talk")) 
    end
end)

RegisterNetEvent('srp-polyzone:exit')
AddEventHandler('srp-polyzone:exit', function(name)
    if name == "store_robbery_lucky" then
        LuckySpot = false  
		TriggerEvent('srp-ui:HideUI')   
    end
end)

function LuckyDrawPlace()
	Citizen.CreateThread(function()
        while LuckySpot do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
				if exports["srp-inventory"]:hasEnoughOfItem("pix1",1,false) then			
					TriggerEvent("inventory:removeItem", "pix1", 1)
					FreezeEntityPosition(PlayerPedId(),true)
					TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
					local finished = exports["srp-taskbar"]:taskBar(7500,"Gathering Information")
					if finished == 100 then					
						FreezeEntityPosition(PlayerPedId(),false)						
						TriggerEvent('lucky:store')    
						ClearPedTasksImmediately(PlayerPedId())
					else
						FreezeEntityPosition(PlayerPedId(),false)	
						ClearPedTasksImmediately(PlayerPedId())
						TriggerEvent("player:receiveItem", "pix1", 1)
					end
				else
					TriggerEvent("DoLongHudText", "Jack: You\'re Missing Something", 2)
				end
			end
		end
	end)
end
