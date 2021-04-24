local curDoctors = 0
local isTriageEnabled = false

local hspLocs = {
	[1] = { ["x"] = 326.2477722168, ["y"] = -583.00897216797, ["z"] = 43.317371368408, ["h"] = 330.01126098633, ["name"] = "None", ["fnc"] = "RandomNPC" },
	[2] = { ["x"] = 308.50784301758, ["y"] = -596.73718261719, ["z"] = 43.291816711426, ["h"] = 9.658652305603, ["name"] = "None", ["fnc"] = "RandomNPC" },
	[3] = { ["x"] = 305.08477783203, ["y"] = -598.11743164063, ["z"] = 43.291816711426, ["h"] = 74.243743896484, ["name"] = "None", ["fnc"] = "RandomNPC" },
	[4] = { ["x"] = 331.91491699219, ["y"] = -576.86529541016, ["z"] = 43.317203521729, ["h"] = 66.368347167969, ["name"] = "None", ["fnc"] = "RandomNPC" },
	[5] = { ["x"] = 344.10360717773, ["y"] = -586.115234375, ["z"] = 43.315013885498, ["h"] = 143.51832580566, ["name"] = "None", ["fnc"] = "RandomNPC" },
	[6] = { ["x"] = 347.22564697266, ["y"] = -587.91693115234, ["z"] = 43.31504440307, ["h"] = 67.972259521484, ["name"] = "None", ["fnc"] = "RandomNPC" },
	[7] = { ["x"] = 329.59005737305, ["y"] = -581.37854003906, ["z"] = 43.317241668701, ["h"] = 86.95824432373, ["name"] = "None", ["fnc"] = "aiSCAN" },
	[8] = { ["x"] = 315.22637939453, ["y"] = -593.30419921875, ["z"] = 43.291805267334, ["h"] = 115.40777587891, ["name"] = "None", ["fnc"] = "aiSCAN" },
	[9] = { ["x"] = 353.38198852539, ["y"] = -588.38922119141, ["z"] = 43.315010070801, ["h"] = 61.995723724365, ["name"] = "None", ["fnc"] = "aiSCAN" },
}

RegisterNetEvent("srp-hospitalization:checkin")
AddEventHandler("srp-hospitalization:checkin", function()

	loadAnimDict('anim@narcotics@trash')
	TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',1.0, 1.0, -1, 1, 0, 0, 0, 0)
	local finished = exports["srp-taskbar"]:taskBar(1700,"Checking Credentials")
	if finished == 100 then
		TriggerEvent("reviveFunction")
		Citizen.Wait(500)
		TriggerEvent("bed:checkin")
	end

end)

RegisterNetEvent("srp-hospitalization:page")
AddEventHandler("srp-hospitalization:page", function()
	if exports["isPed"]:isPed("countems") >= 1 then 
		loadAnimDict('anim@narcotics@trash')
		TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',1.0, 1.0, -1, 1, 0, 0, 0, 0)
		local finished = exports["srp-taskbar"]:taskBar(1700,"Paging a Doctor")
		if finished == 100 then
			if exports["isPed"]:isPed("countems") >= 1 and not isTriageEnabled then
				TriggerEvent("DoLongHudText","A doctor has been paged. Please take a seat and wait.",2)
				TriggerServerEvent("phone:triggerPager")
			end
		end
	else
		TriggerEvent('DoLongHudText', 'There is no ems on duty please check in!', 2)
	end
end)

function DrawText3DTest(x,y,z, text)
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

local checkupCounter = 45 + math.random(10,25)
local hospitalization = {}
local myspawns = {}
local skipCheckup = false
hospitalization.level = 0
hospitalization.illness = "None"
hospitalization.time = 0
--     level,illness,time = getHospitalization(cid)
RegisterNetEvent("client:hospitalization:status")
AddEventHandler("client:hospitalization:status", function(passedVar1,passedVar2,passedVar3)
	hospitalization.level = passedVar1
	hospitalization.illness = passedVar2
	hospitalization.time = passedVar3
	if hospitalization.illness == "icu" and not ICU then
		ICUscreen(false)
		return
	end		

	if hospitalization.illness == "dead" and not ICU then
		ICUscreen(true)
		return
	end	

end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end


--sounds
--heartmonbeat
--heartmondead
--ventilator
--TriggerEvent("InteractSound_CL:PlayOnOne","heartmonbeat",0.1)
ICU = false
dead = false
local counter = 0
function ICUscreen(dying)
	counter = 0
	ICU = true
	dead = false
	while ICU do
		SetEntityCoords(PlayerPedId(),345.02133178711,-590.51824951172,60.109081268311)
		FreezeEntityPosition(PlayerPedId(),true)	
		SetEntityHealth(PlayerPedId(), 200.0)
		SetEntityInvincible(PlayerPedId(),true)
		Citizen.Wait(2300)
		if math.random(15) > 14 then
			TriggerEvent("changethirst")
			TriggerEvent("changehunger")
		end
		TriggerEvent("InteractSound_CL:PlayOnOne","ventilator",0.2)

		counter = counter + 1

		if counter > 20 then
			dead = true
		end

		if dead then

			if dying then
				TriggerEvent("InteractSound_CL:PlayOnOne","heartmondead",0.5)
				Citizen.Wait(9500)
			end

			ICU = false
			logout()
			return

		end

	end

end

function logout()
	TriggerEvent("srp-base:clearStates")
	exports["srp-base"]:getModule("SpawnManager"):Initialize()
end

Citizen.CreateThread( function()
	while true do 
		if ICU then
			DrawRect(0,0, 10.0, 10.0, 1, 1, 1, 255)
			DisableControlAction(0, 47, true)
		end
		Citizen.Wait(1)
	end
end)
local checktypes = {
	[1] = "Prescription Pickup",
	[2] = "Result Review",
	[3] = "Injury Checkup"
}
Citizen.CreateThread( function()
	while true do 
		Citizen.Wait(60000)
		if hospitalization.illness == "ICU" and not ICU then
			ICUscreen(false)
		end		
		if hospitalization.illness == "DEAD" and not ICU then
			ICUscreen(true)
		end		
		if checkupCounter > 0 then
			if hospitalization.level > 0 and checkupCounter == 45 and not skipCheckup then
				mychecktype = math.random(1,3)

				TriggerEvent("chatMessage", "EMAIL ", 8, "You are ready for your next " .. checktypes[mychecktype] .. " at the hospital! (Regarding: "..hospitalization.illness..") Failure to report may be bad for your health.")
				skipCheckup = true
			end			
			checkupCounter = checkupCounter - 1
		else
			checkupCounter = 60 + math.random(80)			
			if hospitalization.level > 0 then
				if skipCheckup then
					TriggerEvent("client:newStress",true,math.random(500))
				end
			end
		end
	end
end)

RegisterNetEvent("job:counts")
AddEventHandler("job:counts", function(activePolice,activeEms,activeTaxi,activeTow, activeDoctors)
    curPolice = activePolice
    curEms = activeEms
    curTaxi = activeTaxi
    curTow = activeTow
    curDoctors = activeDoctors
end)

AddEventHandler("playerSpawned", function()
	TriggerServerEvent('doctor:setTriageState')
	TriggerEvent("loading:disableLoading")
end)

RegisterNetEvent("doctor:setTriageState")
AddEventHandler("doctor:setTriageState", function(pState)
	isTriageEnabled = pState
end)

RegisterNetEvent("SpawnPeds")
AddEventHandler("SpawnPeds", function()
	scanned = true
	for i = 3, 9 do
		local pedType = hspLocs[i]["fnc"]

		pedType = 1092080539


		local x = hspLocs[i]["x"]
		local y = hspLocs[i]["y"]
		local z = hspLocs[i]["z"]
		local h = hspLocs[i]["h"]

        RequestModel(pedType)

        while not HasModelLoaded(pedType) do
            Citizen.Wait(0)
        end

        local IsPedNearCoords = exports["isPed"]:IsPedNearCoords(x,y,z)
        if not IsPedNearCoords then

        	if GetPedType(pedType) ~= nil then
				local hospPed = CreatePed(GetPedType(pedType), pedType, x,y,z, h, 1, 1)
				DecorSetBool(hospPed, 'ScriptedPed', true)
				myspawns[#myspawns+1] = hospPed

				TaskStartScenarioAtPosition(hospPed, randomScenario(), x,y,z, h, 0, 0, 1)
				
				SetEntityInvincible(hospPed, true)
				if i < 6 then
		            TaskSetBlockingOfNonTemporaryEvents(hospPed, true)
		        end
	            SetPedFleeAttributes(hospPed, 0, 0)
	            SetPedCombatAttributes(hospPed, 17, 1)

	            SetPedSeeingRange(hospPed, 0.0)
	            SetPedHearingRange(hospPed, 0.0)
	            SetPedAlertness(hospPed, 0)
				SetPedKeepTask(hospPed, true)


			end
		
		end

	end
	Citizen.Wait(10000)
	scanned = false
end)



function randomHspPed()
	local math = math.random(6)
	ret = 1092080539
	if math == 5 then
		ret = 1092080539
	elseif math == 4 then
		ret = 1092080539
	elseif math == 3 then
		ret = 1092080539		
	end
	return ret
end

function randomScenario()
	local math = math.random(10)
	ret = "WORLD_HUMAN_CLIPBOARD"
	if math == 5 then
		ret = "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT"
	elseif math < 4 then
		ret = "CODE_HUMAN_MEDIC_TIME_OF_DEATH"
	end

	return ret
end
function findNPC(x,y,z)
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    local pedfound = false
    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(vector3(x,y,z) - pos)
        if distance < 11.0 and (distanceFrom == nil or distance < distanceFrom) then
        	pedfound = true
        end
        success, ped = FindNextPed(handle)
    until not success or pedfound
    EndFindPed(handle)
    return pedfound
end