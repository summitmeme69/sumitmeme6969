local isInService = false
local rank = "inconnu"
local checkpoints = {}
local existingVeh = nil
local handCuffed = false
local isMedic = false
local isCop = false
local isDoctor = false
local isNews = false
local isDead = false
local canFix = false
local currentCallSign = nil


Citizen.CreateThread(function()
	local refreshed = false
	while true do
		local dist = #(vector3(448.23,-996.44,30.69) - GetEntityCoords(PlayerPedId()))
		if dist < 100 and not refreshed then
			DisableInterior(137473, false)
			if not IsInteriorReady(137473) then
				LoadInterior(137473)
			else
				RefreshInterior(137473)
			end
			refreshed = true
		end
		if refreshed and dist > 100 then
			DisableInterior(137473, true)
			refreshed = false
		end
		Wait(2000)
	end
end)


Citizen.CreateThread(function()
	while true do
		local coords = GetEntityCoords(PlayerPedId())
		TriggerServerEvent("srp-base:updatecoords",coords.x,coords.y,coords.z)
		Wait(13000)
	end
end)


RegisterNetEvent('Police:duty')
AddEventHandler('Police:duty', function()
TriggerEvent("duty")
	Wait(1000)
end)


RegisterNetEvent('event:control:openpersonalpd')
AddEventHandler('event:control:openpersonalpd', function()
	local cid = exports["isPed"]:isPed("cid")
	TriggerEvent("server-inventory-open", "1", "personalMRPD-"..cid)
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
  if not isDead then
    isDead = true
  else
    isDead = false
  end
end)

-- RegisterNetEvent('evidence:container')
-- AddEventHandler('evidence:container', function(arg)
-- 	if tonumber(arg) == nil then
-- 		return
-- 	end
-- 	local cid = exports["isPed"]:isPed("cid")
-- 	TriggerServerEvent("server-inventory-open", GetEntityCoords(PlayerPedId()), cid, "1", "Case-"..arg);
-- end)


Citizen.CreateThread(function()
	while true do
   Citizen.Wait(10)

	 -- Run cuff script if police is targeting someone with a weapon and pressed E

	   if isCop and not inmenus then

		   local isInVeh = IsPedInAnyVehicle(PlayerPedId(), false)

		   if isInVeh then

			   if IsControlJustReleased(0,172) or IsDisabledControlJustReleased(0,172) then
				   TriggerEvent("platecheck:frontradar")
				   Citizen.Wait(400)
			   end

			   if IsControlJustReleased(0,173) then
				   TriggerEvent("platecheck:rearradar")
				   Citizen.Wait(400)
			   end

			   if IsControlJustReleased(0,174) then
				   TriggerEvent("startSpeedo")
				   Citizen.Wait(400)
			   end
																		   
		   else

			   if IsControlJustReleased(2,172) and not IsControlPressed(0,19) then
				   TriggerEvent("police:cuffFromMenu",false)
				   Citizen.Wait(400)
			   end

			   if IsControlJustReleased(2,172) and IsControlPressed(0,19) then
				   TriggerEvent("police:cuffFromMenu",true)
				   Citizen.Wait(400)
			   end

			   if IsControlJustReleased(2,173) then
				   TriggerEvent("police:uncuffMenu")
				   Citizen.Wait(400)
			   end
			   -- left arrow
			   if IsControlJustReleased(2,174) then
				   TriggerEvent("escortPlayer")
				   Citizen.Wait(400)
			   end
			   -- right arrow
			   if IsControlJustReleased(2,175) then
				   TriggerEvent("police:forceEnter")
				   Citizen.Wait(400)
			   end

		   -- end

	   end
	   if isMedic and not inmenus then
		   -- up arrow
		   if IsControlJustReleased(2,172) then
			   TriggerEvent("revive")
			   Citizen.Wait(400)
		   end
		   -- down arrow
		   if IsControlJustReleased(2,173) then
			   TriggerEvent("ems:heal")
			   Citizen.Wait(400)
		   end
		   -- left arrow
		   if IsControlJustReleased(2,174) then
			   TriggerEvent("escortPlayer")
			   Citizen.Wait(400)
		   end
		   -- right arrow
		   if IsControlJustReleased(2,175) then
			   TriggerEvent("police:forceEnter")
			   Citizen.Wait(400)
		   end
	   end
	   if isDoctor and not inmenus then
		   -- left arrow
		   if IsControlJustReleased(2,174) then
			   TriggerEvent("escortPlayer")
			   Citizen.Wait(400)
		   end
		   -- up arrow
		   if IsControlJustReleased(2,172) then
			   TriggerEvent("ems:heal")
			   Citizen.Wait(400)
		   end
		   -- down arrow
		   if IsControlJustReleased(2,173) then
			   TriggerEvent("revive")
			   Citizen.Wait(400)
		   end
		   -- right arrow
		   if IsControlJustReleased(2,175) then
			   TriggerEvent("requestWounds")
			   Citizen.Wait(400)
		   end
	   end
   end
end

end)



RegisterNetEvent('event:control:police')
AddEventHandler('event:control:police', function(useID)
	if useID == 1 then
		TriggerServerEvent('police:checkForBar')

	elseif useID == 2 and isCop then
		TriggerEvent("server-inventory-open", "1", "evidenceLocker")
		TriggerServerEvent('police:viewEvidenceLockup')
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)

	elseif useID == 3 and isCop then
		TriggerEvent("server-inventory-open", "1", "evidenceLocker2")
		TriggerServerEvent('police:viewEvidenceLockup')
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)

	elseif useID == 4 and isCop then 
		TriggerEvent("server-inventory-open", "1", "trash-1")

	elseif useID == 5 and not handCuffed and GetLastInputMethod(2) then 
		TriggerEvent('Police:Radio')

	elseif useID == 6 and not handCuffed and GetLastInputMethod(2) then
		local isInVeh = IsPedInAnyVehicle(PlayerPedId(), false)
		if not isInVeh and GetEntitySpeed(PlayerPedId()) > 2.5 then
			TryTackle()
		end

	elseif useID == 7 and not handCuffed and GetLastInputMethod(2) then
		local isInVeh = IsPedInAnyVehicle(PlayerPedId(), false)
		if isInVeh then
			TriggerEvent("toggle:cruisecontrol")
		end
	end
end)

local imcollapsed = 0
RegisterNetEvent('collapsecheck')
AddEventHandler('collapsecheck', function()
  if imcollapsed == 0 then 
    imcollapsed = 1
  else
    beingDragged = false
    dragging = false
    imcollapsed = 0
  end
end)


function getIsCop()
	return isCop
end

function getIsInService()
	return isCop or isMedic
end

function getIsCuffed()
	return handCuffed
end

RegisterNetEvent("srp-jobmanager:playerBecameJob")
AddEventHandler("srp-jobmanager:playerBecameJob", function(job, name, notify)
	if isMedic and job ~= "ems" then isMedic = false isInService = false end
	if isCop and job ~= "police" then isCop = false isInService = false end
	if isNews and job ~= "news" then isNews = false isInService = false end
	if job == "police" then isCop = true TriggerServerEvent('police:getRank',"police") isInService = true end
	if job == "ems" then isMedic = true TriggerServerEvent('police:getRank',"ems") isInService = true end
	if job == "doctor" then isDoctor = true TriggerServerEvent('police:getRank',"doctor") isInService = true end
	if job == "news" then isNews = true isInService = false end
end)

function ChangeToSkinNoUpdatePolice(skin)
	local model = GetHashKey(skin)
	if IsModelInCdimage(model) and IsModelValid(model) then
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(1)
		end
		SetPlayerModel(PlayerId(), model)
		SetPedRandomComponentVariation(PlayerPedId(), true)
		SetModelAsNoLongerNeeded(model)
	else
		TriggerEvent("DoLongHudText","Model not found",2)
	end
end
local scanisokay = false
local scansuccess = false

local recentsearch = 0

Citizen.CreateThread( function()

	while true do 

		Citizen.Wait(100)
		if recentsearch == 0 then
			endDistance = #(vector3(1842.7,2585.9,45.89) - GetEntityCoords(PlayerPedId()))
			endDistance2 = #(vector3(253.04049682617,-367.97076416016,-44.063812255859) - GetEntityCoords(PlayerPedId()))
			if endDistance < 0.7 or endDistance2 < 0.7 then
				recentsearch = 1000
				scansuccess = true
				if endDistance2 < 2.0 then
					TriggerEvent("scanSuccess",true)
				end
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'metaldetector', 0.05)
				
				currentWeapons = exports["srp-inventory"]:GetCurrentWeapons() 

				if ( #currentWeapons > 0 ) and ( not isCop and not isJudge and not isMedic ) then
					scansuccess = false
					TriggerEvent("weaponcheck:scanner")
					TriggerEvent("scanSuccess",false)
				end
			end
		end

		if recentsearch > 0 or not scansuccess then
			if recentsearch > 0 then
				recentsearch = recentsearch - 1
			end
			if endDistance > 100.0 and endDistance2 > 100.0 then
				Citizen.Wait(10000)
			end
			endDistance3 = #(vector3(2128.45703125,2921.1318359375,-61.901893615723) - GetEntityCoords(PlayerPedId()))
			if endDistance3 < 2.0 then
				currentWeapons = exports["srp-inventory"]:GetCurrentWeapons() 
				if #currentWeapons > 0 or not scansuccess then
					TriggerEvent("checkifcop:scanner",1)
				end
			end
			endDistance4 = #(vector3(2119.45703125,2921.1213378906,-61.901893615723) - GetEntityCoords(PlayerPedId()))
			if endDistance4 < 2.0 then
				currentWeapons = exports["srp-inventory"]:GetCurrentWeapons() 
				if #currentWeapons > 0 or not scansuccess then			
					TriggerEvent("checkifcop:scanner",2)
				end
			end			
		end

	end
end)

RegisterNetEvent("isDoctor")
AddEventHandler("isDoctor", function()
	TriggerServerEvent("jobssystem:jobs", "doctor")
	isDoctor = true
end)


isTher = false
RegisterNetEvent("isTherapist")
AddEventHandler("isTherapist", function()
	TriggerServerEvent("jobssystem:jobs", "therapist")
	isTher = true
end)

isJudge = false
RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
	TriggerServerEvent("jobssystem:jobs", "judge")
	TriggerServerEvent('police:getRank',"judge")
	isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent("nowIsCop")
AddEventHandler("nowIsCop", function(cb)
	cb(isCop)
end)

RegisterNetEvent('police:noLongerCop')
AddEventHandler('police:noLongerCop', function()
	isCop = false
	isInService = false
	currentCallSign = ""
	
	local playerPed = PlayerPedId()
  	TriggerServerEvent("police:officerOffDuty")
	TriggerServerEvent('tattoos:retrieve')
	TriggerServerEvent('Blemishes:retrieve')
	RemoveAllPedWeapons(playerPed)
	
	TriggerEvent("attachWeapons")
	if(existingVeh ~= nil) then

		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
		existingVeh = nil
	end

	TriggerEvent("DoLongHudText",'Signed off Duty!',1)
end)


RegisterNetEvent('police:noLongerEMS')
AddEventHandler('police:noLongerEMS', function()
	isMedic = false
	isInService = false
	currentCallSign = ""
	
	local playerPed = PlayerPedId()	
  	TriggerServerEvent("police:EMSOffDuty")
	TriggerServerEvent('tattoos:retrieve')
	TriggerServerEvent('Blemishes:retrieve')
	RemoveAllPedWeapons(playerPed)
	
	TriggerEvent("attachWeapons")
	if(existingVeh ~= nil) then

		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
		existingVeh = nil
	end

	TriggerEvent("DoLongHudText",'Signed off Duty!',1)
end)



RegisterNetEvent('police:checkPhone')
AddEventHandler('police:checkPhone', function()
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 5) then
		TriggerServerEvent("phone:getSMSOther",GetPlayerServerId(t))
	else

		TriggerEvent("DoLongHudText", "No player near you!",2)

	end
end)

RegisterNetEvent('police:checkLicenses')
AddEventHandler('police:checkLicenses', function()
	t, distance = GetClosestPlayerIgnoreCar()
	if(distance ~= -1 and distance < 5) then
		TriggerServerEvent("police:getLicenses", GetPlayerServerId(t))
	else

		TriggerEvent("DoLongHudText", "No player near you!",2)

	end
end)

RegisterNetEvent('police:checkLicensePlate')
AddEventHandler('police:checkLicensePlate', function(plate)
	if isCop then
		TriggerServerEvent('checkLicensePlate',plate)
	else
		TriggerEvent("DoLongHudText", "Please take your service first!",2)
	end
end)

RegisterNetEvent('police:checkCrimes')
AddEventHandler('police:checkCrimes', function()
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 5) then
		TriggerServerEvent("police:getCrimes", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", "No player near you!",2)
	end
end)

RegisterNetEvent('police:checkBank')
AddEventHandler('police:checkBank', function()
	t, distance, closestPed = GetClosestPlayer()
	if(distance ~= -1 and distance < 7) then
		TriggerServerEvent("police:targetCheckBank", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", "No player near you!",2)
	end
end)

RegisterNetEvent('police:checkInventory')
AddEventHandler('police:checkInventory', function()
	t, distance, closestPed = GetClosestPlayer()
	if(distance ~= -1 and distance < 5) then
		TriggerServerEvent("police:targetCheckInventory", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", "No player near you!",2)
	end
end)

RegisterNetEvent("police:seizeCash")
AddEventHandler("police:seizeCash", function()
	t, distance, closestPed = GetClosestPlayer()
	if distance ~= -1 and distance < 5 then
		TriggerServerEvent("police:SeizeCash", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", "No player near you!",2)
	end

end)

RegisterNetEvent('police:seizeInventory')
AddEventHandler('police:seizeInventory', function()
		t, distance = GetClosestPlayer()
		if(distance ~= -1 and distance < 5) then
			TriggerServerEvent("police:targetseizeInventory", GetPlayerServerId(t))
		else

			TriggerEvent("DoLongHudText", "No player near you!",2)
		end
end)


function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function KneelMedic()
    local player = GetPlayerPed( -1 )
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 

	        loadAnimDict( "amb@medic@standing@tendtodead@enter" )
	        loadAnimDict( "amb@medic@standing@timeofdeath@enter" )
	        loadAnimDict( "amb@medic@standing@tendtodead@idle_a" )
	        loadAnimDict( "random@crash_rescue@help_victim_up" )

			TaskPlayAnim( player, "amb@medic@standing@tendtodead@enter", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (1000)
			TaskPlayAnim( player, "amb@medic@standing@tendtodead@idle_a", "idle_b", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
			Wait (3000)
			TaskPlayAnim( player, "amb@medic@standing@tendtodead@exit", "exit_flee", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (1000)
            TaskPlayAnim( player, "amb@medic@standing@timeofdeath@enter", "enter", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )  
            Wait (500)
            TaskPlayAnim( player, "amb@medic@standing@timeofdeath@enter", "helping_victim_to_feet_player", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )  

    end
end



RegisterNetEvent('revive')
AddEventHandler('revive', function(t)
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 10) then
		TriggerServerEvent("reviveGranted", GetPlayerServerId(t))
		KneelMedic()
	else
		TriggerEvent("DoLongHudText", "No player near you (maybe get closer)!",2)
	end

end)


function VehicleInFront()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 3.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

RegisterNetEvent('police:woxy')
AddEventHandler('police:woxy', function()
	local vehFront = VehicleInFront()
	if vehFront > 0 then
  		loadAnimDict('anim@narcotics@trash')
		TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 3800, 49, 3.0, 0, 0, 0)		
		local finished = exports["srp-taskbar"]:taskBar(4000,"Grabbing Scuba Gear")
	  	if finished == 100 then
	  		loadAnimDict('anim@narcotics@trash')
    		TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 1900, 49, 3.0, 0, 0, 0)	  		
			TriggerEvent("UseOxygenTank")
		end
	end
end)

AddEventHandler('giveRadioToPed', function()
	-- If player doesn't already have a radio (item 67) and has enough inventory room for one, give them the item
	if (not exports["srp-inventory"]:hasEnoughOfItem("radio",1,false) ) then
		TriggerEvent("player:receiveItem","radio",1)
	end
end)

frozenEnabled = false
FreezeEntityPosition(PlayerPedId(), false)
RegisterNetEvent('police:freeze')
AddEventHandler('police:freeze', function(ped)
	if(isCop) then
		ped, distance = GetClosestPlayer()
		if(distance ~= -1 and distance < 5) then
	      	if frozenEnabled then
				FreezeEntityPosition(ped, false)
				SetPlayerInvincible(ped, false)
				SetEntityCollision(ped, true)
				TriggerEvent("DoLongHudText", "Target Unshackled!",1)
				frozenEnabled = false
	      	else 
				SetEntityCollision(ped, false)
				FreezeEntityPosition(ped, true)
				SetPlayerInvincible(ped, true)
				frozenEnabled = true
				TriggerEvent("DoLongHudText", "Target Shackled!",1)
	      	end
	    end
	else
		TriggerEvent("DoLongHudText", "Please take your service first!",2)
	end
end)

function isOppositeDir(a,b)
	local result = 0 
	if a < 90 then
		a = 360 + a
	end
	if b < 90 then
		b = 360 + b
	end	
	if a > b then
		result = a - b
	else
		result = b - a
	end
	if result > 110 then
		return true
	else
		return false
	end
end

RegisterNetEvent('police:remmaskAccepted')
AddEventHandler('police:remmaskAccepted', function()
	TriggerEvent("facewear:adjust", 1, true)
	TriggerEvent("facewear:adjust", 3, true)
	TriggerEvent("facewear:adjust", 4, true)
	--TriggerEvent("facewear:adjust", 5, true)
	TriggerEvent("facewear:adjust", 2, true)
end)

RegisterNetEvent('police:remmask')
AddEventHandler('police:remmask', function(t)
	t, distance = GetClosestPlayer()
	if (distance ~= -1 and distance < 5) then
		if isOppositeDir(GetEntityHeading(t),GetEntityHeading(PlayerPedId())) and not IsPedInVehicle(t,GetVehiclePedIsIn(t, false),false) then
			TriggerServerEvent("police:remmaskGranted", GetPlayerServerId(t))
			AnimSet = "mp_missheist_ornatebank"
			AnimationOn = "stand_cash_in_bag_intro"
			AnimationOff = "stand_cash_in_bag_intro"
			loadAnimDict( AnimSet )
			TaskPlayAnim( PlayerPedId(), AnimSet, AnimationOn, 8.0, -8, -1, 49, 0, 0, 0, 0 )
			Citizen.Wait(500)
			ClearPedTasks(PlayerPedId())						
		end
	else
		TriggerEvent("DoLongHudText", "No player near you (maybe get closer)!",2)
	end
end)

RegisterNetEvent('police:remweapons')
AddEventHandler('police:remweapons', function(t)
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 5) then
		TriggerServerEvent("police:remweaponsGranted", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", "No player near you (maybe get closer)!",2)
	end
end)

tryingcuff = false
RegisterNetEvent('police:cuff2')
AddEventHandler('police:cuff2', function(t,softcuff)
	if not tryingcuff then

		
		tryingcuff = true

		t, distance, ped = GetClosestPlayer()

		Citizen.Wait(1500)
		if(distance ~= -1 and #(GetEntityCoords(ped) - GetEntityCoords(PlayerPedId())) < 2.5 and GetEntitySpeed(ped) < 1.0) then
			TriggerEvent('police:cuff2')
			TriggerServerEvent("police:cuffGranted2", GetPlayerServerId(t), softcuff)
		else
			ClearPedSecondaryTask(PlayerPedId())
			TriggerEvent("DoLongHudText", "No player near you (maybe get closer)!",2)
		end

		tryingcuff = false

	end
end)

RegisterNetEvent('police:cuff')
AddEventHandler('police:cuff', function(t)
	if not tryingcuff then



		TriggerEvent("Police:ArrestingAnim")
		tryingcuff = true

		t, distance = GetClosestPlayer()
		if(distance ~= -1 and distance < 1.5) then
			TriggerServerEvent("police:cuffGranted", GetPlayerServerId(t))
		else
			TriggerEvent("DoLongHudText", "No player near you (maybe get closer)!",2)
		end


		tryingcuff = false
	end
end)

local cuffstate = false


RegisterNetEvent('civ:cuffFromMenu')
AddEventHandler('civ:cuffFromMenu', function()
	TriggerEvent("police:cuffFromMenu",false)
end)

RegisterNetEvent('police:cuffFromMenu')
AddEventHandler('police:cuffFromMenu', function(softcuff)
	if not cuffstate and not handCuffed and not IsPedRagdoll(PlayerPedId()) and not IsPlayerFreeAiming(PlayerId()) and not IsPedInAnyVehicle(PlayerPedId(), false) then
		cuffstate = true

		t, distance = GetClosestPlayer()
		if(distance ~= -1 and distance < 2 and not IsPedRagdoll(PlayerPedId())) then
			if softcuff then
				TriggerEvent("DoLongHudText", "You soft cuffed a player!",1)
			else
				TriggerEvent("DoLongHudText", "You hard cuffed a player!",1)
			end
			
			TriggerEvent("police:cuff2", GetPlayerServerId(t),softcuff)
		end

		cuffstate = false
	end
end)

RegisterNetEvent('police:gsr')
AddEventHandler('police:gsr', function(t)
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 5) then
		TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, 1)
		local finished = exports["srp-taskbar"]:taskBar(15000,"GSR Testing")
		if finished == 100 then
			TriggerServerEvent("police:gsrGranted", GetPlayerServerId(t))
		end
	else
		TriggerEvent("DoLongHudText", "No player near you (maybe get closer)!",2)
	end	
end)

local shotRecently = false

Citizen.CreateThread(function()
	local lastShot = 0
	
	while true do
		Citizen.Wait(1)

		if IsPedShooting(PlayerPedId()) then
			local name = GetSelectedPedWeapon(PlayerPedId())
			if name ~= `WEAPON_STUNGUN` then
				lastShot = GetGameTimer()
				shotRecently = true
			end
		end

		if shotRecently and GetGameTimer() - lastShot >= 1200000 then shotRecently = false end 
	end
end)

RegisterNetEvent("police:hasShotRecently")
AddEventHandler("police:hasShotRecently", function(copId)
	TriggerServerEvent("police:hasShotRecently", shotRecently, copId)
end)

RegisterNetEvent('police:uncuffMenu')
AddEventHandler('police:uncuffMenu', function()
	t, distance = GetClosestPlayer()
	-- error debug fix - syd
	if not IsPedInAnyVehicle(PlayerPedId(), false) then
		if(distance ~= -1 and distance < 2) then
			TriggerServerEvent("falseCuffs", GetPlayerServerId(t))
			TriggerEvent("DoLongHudText", "You uncuffed a player!",1)
		else
			TriggerEvent("DoLongHudText", "No player near you (maybe get closer)!",2)
		end
	end
end)

-- hopefully resolve the death / revive restrain bug.

RegisterNetEvent('resetCuffs')
AddEventHandler('resetCuffs', function()
	ClearPedTasksImmediately(PlayerPedId())
	handcuffType = 49
	handCuffed = false
	handCuffedWalking = false
	TriggerEvent("police:currentHandCuffedState",handCuffed,handCuffedWalking)
	--TriggerEvent("DensityModifierEnable",true)
	TriggerEvent("handcuffed",false)
end)

RegisterNetEvent('falseCuffs')
AddEventHandler('falseCuffs', function()
	ClearPedTasksImmediately(PlayerPedId())
	handcuffType = 49
	handCuffed = false
	handCuffedWalking = false
	TriggerEvent("police:currentHandCuffedState",handCuffed,handCuffedWalking)
	--TriggerEvent("DensityModifierEnable",true)
	TriggerEvent("handcuffed",false)
end)





RegisterNetEvent('police:getArrested2')
AddEventHandler('police:getArrested2', function(cuffer)

	ClearPedTasksImmediately(PlayerPedId())
	CuffAnimation(cuffer)
	
	local cuffPed = GetPlayerPed(GetPlayerFromServerId(tonumber(cuffer)))

	local finished = 0
	if not isDead then
		finished = exports["srp-taskbarskill"]:taskBar(1200,7)
	end
	
	if #(GetEntityCoords( PlayerPedId()) - GetEntityCoords(cuffPed)) < 2.5 and finished ~= 100 then
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'handcuff', 0.4)
		handcuffType = 16
		handCuffed = true
		handCuffedWalking = false
		TriggerEvent("police:currentHandCuffedState",handCuffed,handCuffedWalking)
		TriggerEvent("DoLongHudText", "Cuffed!",1)
		TriggerEvent("handcuffed",true)
		TriggerEvent("DensityModifierEnable",false)	
	end	

end)

function CuffAnimation(cuffer)
	loadAnimDict("mp_arrest_paired")
	local cuffer = GetPlayerPed(GetPlayerFromServerId(tonumber(cuffer)))
	local dir = GetEntityHeading(cuffer)
	--TriggerEvent('police:cuffAttach',cuffer)
	SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, 0.0))
	Citizen.Wait(100)
	SetEntityHeading(PlayerPedId(),dir)
	TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 32, 0, 0, 0, 0)
end

RegisterNetEvent('police:cuffAttach')
AddEventHandler('police:cuffAttach', function(cuffer)
	local count = 350
	while count > 0 do
		Citizen.Wait(1)
		count = count - 1
		AttachEntityToEntity(PlayerPedId(), cuffer, 11816, 0.0, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
	end
	DetachEntity(PlayerPedId(), true, false)	
end)

RegisterNetEvent('police:cuffTransition')
AddEventHandler('police:cuffTransition', function()
	loadAnimDict("mp_arrest_paired")
	Citizen.Wait(100)
	TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
	Citizen.Wait(3500)
	ClearPedTasksImmediately(PlayerPedId())
end)

RegisterNetEvent('police:getArrested')
AddEventHandler('police:getArrested', function(cuffer)

		if(handCuffed) then
			Citizen.Wait(3500)
			ClearPedTasksImmediately(PlayerPedId())
			handCuffed = false
			handcuffType = 49
			TriggerEvent("police:currentHandCuffedState",handCuffed,handCuffedWalking)
			TriggerEvent("handcuffed",true)
			TriggerEvent("DensityModifierEnable",true)
		else
			ClearPedTasksImmediately(PlayerPedId())
			CuffAnimation(cuffer) 

			local cuffPed = GetPlayerPed(GetPlayerFromServerId(tonumber(cuffer)))
			if Vdist2( GetEntityCoords( GetPlayerPed(-1) , GetEntityCoords(cuffPed) ) ) < 1.5 then
				handcuffType = 49
				handCuffed = true
				TriggerEvent("police:currentHandCuffedState",handCuffed,handCuffedWalking)
				TriggerEvent("handcuffed",false)
				TriggerEvent("DensityModifierEnable",false)
			end
		end
end)


RegisterNetEvent('police:jailing')
AddEventHandler('police:jailing', function(args)
	Citizen.Trace("Jailing in process.")
	TriggerServerEvent('police:jailGranted', args )
	TriggerServerEvent('updateJailTime', tonumber(args[2]))
end)

RegisterNetEvent('startJail')
AddEventHandler('startJail', function(minutes)
	TriggerServerEvent('updateJailTime', tonumber(minutes))
end)

RegisterNetEvent('police:forceEnter')
AddEventHandler('police:forceEnter', function(id)

	ped, distance, t = GetClosestPedIgnoreCar()
	if(distance ~= -1 and distance < 3) then

		local isInVeh = IsPedInAnyVehicle(ped, true)
		if not isInVeh then
			playerped = PlayerPedId()
	        coordA = GetEntityCoords(playerped, 1)
	        coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
	        v = getVehicleInDirection(coordA, coordB)
	        if GetVehicleEngineHealth(v) < 100.0 then
	        	TriggerEvent("DoLongHudText", "That vehicle is too damaged!",2)
	        	return
	        end
			local netid = NetworkGetNetworkIdFromEntity(v)	
			TriggerEvent('forcedEnteringVeh', GetPlayerServerId(t))
			TriggerServerEvent("police:forceEnterAsk", GetPlayerServerId(t), netid)
			TriggerEvent("dr:releaseEscort")
		else
			TriggerEvent("unseatPlayer")
		end

	else
		TriggerEvent("DoLongHudText", "No player near you (maybe get closer)!",2)
	end
end)


RegisterNetEvent('police:forcedEnteringVeh')
AddEventHandler('police:forcedEnteringVeh', function(sender)

	local vehicleHandle = NetworkGetEntityFromNetworkId(sender)
    if vehicleHandle ~= nil then

      if IsEntityAVehicle(vehicleHandle) then
      	TriggerEvent("respawn:sleepanims")
      	Citizen.Wait(1000)
        for i=1,GetVehicleMaxNumberOfPassengers(vehicleHandle) do
          if IsVehicleSeatFree(vehicleHandle,i) then
		 	TriggerEvent("unEscortPlayer")
			Citizen.Wait(100)
            SetPedIntoVehicle(PlayerPedId(),vehicleHandle,i)
            return true
          end
        end
	    if IsVehicleSeatFree(vehicleHandle,0) then
	    	TriggerEvent("unEscortPlayer") 
			Citizen.Wait(100)
	        SetPedIntoVehicle(PlayerPedId(),vehicleHandle,0)
	        
	    end
      end
    end
end)

Citizen.CreateThread(function()
	local src = source
    while true do
        Wait(2000)
            ped = PlayerPedId()
            if IsEntityInWater(ped) and handCuffed then
                TriggerEvent('DoLongHudText', 'Uncuffed!', 1)
                Wait(100)
            	if IsEntityInWater(ped) and handCuffed then
					handCuffed = false
                    TriggerEvent('DoLongHudText', 'Uncuffed because shitters forgot to.', 2)
					ClearPedTasksImmediately(PlayerPedId())
                	else
                    TriggerEvent('DoLongHudText', 'Sup', 2)
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

function GetClosestPlayers(targetVector,dist)
	local players = GetPlayers()
	local ply = PlayerPedId()
	local plyCoords = targetVector
	local closestplayers = {}
	local closestdistance = {}
	local closestcoords = {}

	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
			if(distance < dist) then
				valueID = GetPlayerServerId(value)
				closestplayers[#closestplayers+1]= valueID
				closestdistance[#closestdistance+1]= distance
				closestcoords[#closestcoords+1]= {targetCoords["x"], targetCoords["y"], targetCoords["z"]}
				
			end
		end
	end
	return closestplayers, closestdistance, closestcoords
end


function GetClosestPlayerAny()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)


	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
			if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance



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
function GetClosestPedIgnoreCar()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local closestPlayerId = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = target
				closestPlayerId = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance, closestPlayerId
end
function GetClosestPlayerIgnoreCar()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

handCuffedWalking = false
RegisterNetEvent('handCuffedWalking')
AddEventHandler('handCuffedWalking', function()

	if handCuffedWalking then
		handCuffedWalking = false
		TriggerEvent("handcuffed",false)
		TriggerEvent("animation:PlayAnimation","cancel")
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'handcuff', 0.4)
		TriggerEvent("police:currentHandCuffedState",false,false)
		return
	end
	
	handCuffedWalking = true
	handCuffed = false
	TriggerEvent("handcuffed",true)

	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'handcuff', 0.4)

	TriggerEvent("police:currentHandCuffedState",handCuffed,handCuffedWalking)

end)

handcuffs = 0
function alterHandcuffs(cuffMode)
	local factor = cuffMode
	if cuffMode then
		local hcmodel = "prop_cs_cuffs_01"
		local plyCoords = GetEntityCoords(PlayerPedId(), false)
		local handcuffs = CreateObject(GetHashKey(hcmodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
		AttachEntityToEntity(handcuffs, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.05, 0.0, 0.0, 0.0, 80.0, 1, 0, 0, 0, 0, 1)
	else
		DeleteEntity(handcuffs)
		handcuffs = 0
	end
end

local notified = false
local disabledWeapons = false
RegisterNetEvent("disabledWeapons")
AddEventHandler("disabledWeapons", function(sentinfo)
	SetCurrentPedWeapon(PlayerPedId(), `weapon_unarmed`, 1)
	disabledWeapons = sentinfo
end)

RegisterNetEvent("weaponcheck:scanner")
AddEventHandler("weaponcheck:scanner", function()
	if not disabledWeapons then
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'metaldetected', 0.2)
	end	
end)


RegisterNetEvent("checkifcop:scanner")
AddEventHandler("checkifcop:scanner", function(notificationNumber)

	if scansuccess or isJudge or isCop or isMedic or handCuffed or handCuffedWalking or escort or beingDragged or disabledWeapons then
		return
	end

	if notificationNumber == 2 then
		TriggerEvent('gangs:setHatredFull')
		Citizen.Wait(20000)
		return
	end

	if notified then
		return
	end
	notified = true
	TriggerEvent("DoLongHudText",'You must drop off your weapons and be scanned - stop or be shot!',2) 
	Citizen.Wait(10000)
	notified = false

end)



Citizen.CreateThread(function() 

  while true do

	Citizen.Wait(1)
	

    if disabledWeapons then
		DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
		DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
    end

    if beingDragged or escort then
		DisableControlAction(1, 23, true)  -- F
		DisableControlAction(1, 106, true) -- VehicleMouseControlOverride
		DisableControlAction(1, 140, true) --Disables Melee Actions
		DisableControlAction(1, 141, true) --Disables Melee Actions
		DisableControlAction(1, 142, true) --Disables Melee Actions	
		DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
		DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
		DisableControlAction(2, 32, true)
		DisableControlAction(1, 33, true)
		DisableControlAction(1, 34, true)
		DisableControlAction(1, 35, true)
		DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
		DisableControlAction(0, 59)
		DisableControlAction(0, 60)
		DisableControlAction(2, 31, true) 
		SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    end

    if handCuffedWalking or handCuffed then
    	
    	if handCuffed and CanPedRagdoll(PlayerPedId()) then
    		SetPedCanRagdoll(PlayerPedId(), false)
    	end

    	number = 49

    	if handCuffed then 
    		number = 16
		else 
			number = 49
		end

		DisableControlAction(1, 23, true)  -- F
		DisableControlAction(1, 106, true) -- VehicleMouseControlOverride
		DisableControlAction(1, 140, true) --Disables Melee Actions
		DisableControlAction(1, 141, true) --Disables Melee Actions
		DisableControlAction(1, 142, true) --Disables Melee Actions	
		DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
		DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
		local dead = exports["isPed"]:isPed("dead")
		local intrunk = exports["isPed"]:isPed("intrunk")
		if (not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) and not dead and not intrunk) or (IsPedRagdoll(PlayerPedId()) and not dead and not intrunk) then
	    	RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded("mp_arresting") do
				Citizen.Wait(1)
			end
			TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, number, 0, 0, 0, 0)
		end
		if dead or intrunk then
			Citizen.Wait(1000)
		end

    end

	if not handCuffed and not CanPedRagdoll(PlayerPedId()) then
		SetPedCanRagdoll(PlayerPedId(), true)
	end

  end

end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end


intmenuopen = false
handcuffType = 16


local isTargetCuffed = false

function cuffCheck()
	if not handCuffed and not IsPedRagdoll(PlayerPedId()) and not IsPlayerFreeAiming(PlayerId()) and not IsPedInAnyVehicle(PlayerPedId(), false) then
		t, distance = GetClosestPlayer()
		if(distance ~= -1 and distance < 3 and not IsPedRagdoll(PlayerPedId())) then
			TriggerServerEvent("police:IsTargetCuffed", GetPlayerServerId(t)) 
		end
	end
end

RegisterNetEvent('police:isPlayerCuffed')
AddEventHandler('police:isPlayerCuffed', function(requestedID)
	TriggerServerEvent("police:confirmIsCuffed",requestedID,handCuffed)
end)


RegisterNetEvent('police:TargetIsCuffed')
AddEventHandler('police:TargetIsCuffed', function(result)
	isTargetCuffed = result
	if isTargetCuffed then
		TriggerEvent("openSubMenu","handcuffer")
	else
		TriggerEvent("police:cuffFromMenu")
	end
	isTargetCuffed = false
end)

RegisterNetEvent('police:AttemptCuffFromInventory')
AddEventHandler('police:AttemptCuffFromInventory', function()
	cuffCheck()
end)


local inmenus = false
RegisterNetEvent('inmenu')
AddEventHandler('inmenu', function(change)
	inmenus = change
end)

gangNum = 0
GangMember = false
RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(gangNumInput)
	gangNum = gangNumInput
	if gangNumInput == 1 then
		GangMember = true
	elseif gangNumInput == 2 then
		GangMember = true
	end
end)


RegisterNetEvent('table:enable')
AddEventHandler('table:enable', function()
	TriggerServerEvent("blackjack:table_open",true)
end)

RegisterNetEvent('table:disable')
AddEventHandler('table:disable', function()
	TriggerServerEvent("blackjack:table_open",false)
end)

RegisterNetEvent('requestWounds')
AddEventHandler('requestWounds', function()
	t, distance = GetClosestPlayerAny()
	if t ~= nil and t ~= -1 then
		if(distance ~= -1 and distance < 5) then
			TriggerServerEvent("Evidence:GetWounds", GetPlayerServerId(t))
		end
	end
end)
RegisterNetEvent("ems:heal")
AddEventHandler("ems:heal", function()
	t, distance = GetClosestPlayerAny()
	if t ~= nil and t ~= -1 then
		if(distance ~= -1 and distance < 5) then

			local myjob = exports["isPed"]:isPed("myjob")
			if myjob ~= "ems" and myjob ~= "doctor" then
				local bandages = exports["srp-inventory"]:getQuantity("bandage")
				if bandages == 0 then
					return
				else
					TriggerEvent('inventory:removeItem',"bandage", 1)
				end
			end

			TriggerEvent("animation:PlayAnimation","layspike")
			TriggerServerEvent("ems:healplayer", GetPlayerServerId(t))
		end
	end
end)

RegisterNetEvent("ems:stomachpump")
AddEventHandler("ems:stomachpump", function()
	t, distance = GetClosestPlayerAny()
	if t ~= nil and t ~= -1 then
		if(distance ~= -1 and distance < 5) then
			local finished = exports["srp-taskbar"]:taskBar(10000,"Inserting stomach pump 🤢", false, true)
			TriggerEvent("animation:PlayAnimation","cpr")
			if finished == 100 then
				local particleDict = "scr_familyscenem"
				local particleName = "scr_trev_amb_puke"
				RequestNamedPtfxAsset(particleDict)
				while not HasNamedPtfxAssetLoaded(particleDict) do Citizen.Wait(0) end
				local endTime = GetCloudTimeAsInt() + 5
				local particleFxHandle = 0
				SetPtfxAssetNextCall(particleDict)
				particleFxHandle = StartParticleFxLoopedOnEntityBone(particleName, GetPlayerPed(t), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(GetPlayerPed(t), 31086), 1.3, 0.0, 0.0, 0.0)
				SetParticleFxLoopedAlpha(particleFxHandle, 10.0)
				TriggerServerEvent("ems:stomachpumptarget", GetPlayerServerId(t))
			end
			TriggerEvent("animation:cancel")
		end
	end
end)

RegisterNetEvent('binoculars:Activate')
AddEventHandler('binoculars:Activate', function()
	if not handCuffed and not handCuffedWalking then
	   TriggerEvent("binoculars:Activate2")
	end
end)

RegisterNetEvent('camera:Activate')
AddEventHandler('camera:Activate', function()
	if not handCuffed and not handCuffedWalking then
	   TriggerEvent("camera:Activate2")
	end
end)

RegisterNetEvent('car:swapseat')
AddEventHandler('car:swapseat', function(num)
	local num = tonumber(num)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	SetPedIntoVehicle(PlayerPedId(),veh,num)
end)


RegisterNetEvent('car:swapdriver')
AddEventHandler('car:swapdriver', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	SetPedIntoVehicle(PlayerPedId(), veh, -1)
end)

RegisterNetEvent('car:swapfp')
AddEventHandler('car:swapfp', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	SetPedIntoVehicle(PlayerPedId(), veh, 0)
end)

RegisterNetEvent('car:swapbl')
AddEventHandler('car:swapbl', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	SetPedIntoVehicle(PlayerPedId(), veh, 1)
end)

RegisterNetEvent('car:swapbr')
AddEventHandler('car:swapbr', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	SetPedIntoVehicle(PlayerPedId(), veh, 2)
end)





imdead = 0
RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
	if imdead == 0 then 
		imdead = 1
	else
		beingDragged = false
		dragging = false
		imdead = 0
	end
    lightbleed = false
    heavybleed = false
    lightestbleed = false
	lasthealth = GetEntityHealth(PlayerPedId())
end)


RegisterNetEvent('clientcheckLicensePlate')
AddEventHandler('clientcheckLicensePlate', function()
	if isCop then
	  playerped = PlayerPedId()
      coordA = GetEntityCoords(playerped, 1)
      coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
      targetVehicle = getVehicleInDirection(coordA, coordB)
     	targetspeed = GetEntitySpeed(targetVehicle) * 3.6
     	herSpeedMph = GetEntitySpeed(targetVehicle) * 2.236936
      licensePlate = GetVehicleNumberPlateText(targetVehicle)
      local vehicleClass = GetVehicleClass(targetVehicle)

      if licensePlate == nil then

      	TriggerEvent("DoLongHudText", 'Can not target vehicle',2)

      else
			TriggerServerEvent('checkLicensePlate',licensePlate)
		end
	end
end)


RegisterCommand('911', function(source, args)
TriggerServerEvent('911', args)
end)

RegisterCommand('911r', function(source, args)
	TriggerServerEvent('911r', args)
end)

RegisterCommand('311', function(source, args)
	TriggerServerEvent('311', args)
end)
	
RegisterCommand('311r', function(source, args)
	TriggerServerEvent('311r', args)
end)

RegisterNetEvent('sniffVehicle')
AddEventHandler('sniffVehicle', function()
	if isCop then
	  playerped = PlayerPedId()
      coordA = GetEntityCoords(playerped, 1)
      coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
      targetVehicle = getVehicleInDirection(coordA, coordB)
     	targetspeed = GetEntitySpeed(targetVehicle) * 3.6
     	herSpeedMph = GetEntitySpeed(targetVehicle) * 2.236936
      licensePlate = GetVehicleNumberPlateText(targetVehicle)

      if licensePlate == nil then

      	TriggerEvent("DoLongHudText", 'Can not target vehicle',2)

      else
			TriggerServerEvent('sniffLicensePlateCheck',licensePlate)
		end
	end
end)

RegisterNetEvent('showID')
AddEventHandler('showID', function()
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 5) then
		TriggerEvent("DoLongHudText", 'Player Found: ' .. GetPlayerServerId(t) .. ' ID#',1)

		 TriggerServerEvent('gc:showthemIdentity', GetPlayerServerId(t))
    else
    	TriggerEvent("DoLongHudText", 'No Player Found',2)

    end
end)
inanimation = false

RegisterNetEvent('animation:phonecall')
AddEventHandler('animation:phonecall', function()
inanimation = true
		if not handCuffed then

			local lPed = PlayerPedId()

			RequestAnimDict("random@arrests")
			while not HasAnimDictLoaded("random@arrests") do
				Citizen.Wait(0)
			end
			
			if IsEntityPlayingAnim(lPed, "random@arrests", "idle_c", 3) then
				ClearPedSecondaryTask(lPed)

			else
				TaskPlayAnim(lPed, "random@arrests", "idle_c", 8.0, -8, -1, 49, 0, 0, 0, 0)
				seccount = 10
				while seccount > 0 do
					Citizen.Wait(1000)
					seccount = seccount - 1

				end
				ClearPedSecondaryTask(lPed)
			end		
		else
			ClearPedSecondaryTask(lPed)
		end
inanimation = false
end)


cruisecontrol = false


RegisterNetEvent('toggle:cruisecontrol')
AddEventHandler('toggle:cruisecontrol', function()

	local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local driverPed = GetPedInVehicleSeat(currentVehicle, -1)

	if driverPed == PlayerPedId() then

		if cruisecontrol then
			SetEntityMaxSpeed(currentVehicle, 999.0)
			cruisecontrol = false
			TriggerEvent("DoLongHudText","Speed Limiter Inactive",5)
		else
			speed = GetEntitySpeed(currentVehicle)
			if speed > 15.0 then
			SetEntityMaxSpeed(currentVehicle, speed)
			cruisecontrol = true
				TriggerEvent("DoLongHudText","Speed Limiter Active",5)
			else
				TriggerEvent("DoLongHudText","Speed Limiter can only activate over 35mph",2)
			end
		end

	end
end)
RegisterNetEvent('animation:tacklelol')
AddEventHandler('animation:tacklelol', function()

		if not handCuffed and not IsPedRagdoll(PlayerPedId()) then

			local lPed = PlayerPedId()

			RequestAnimDict("swimming@first_person@diving")
			while not HasAnimDictLoaded("swimming@first_person@diving") do
				Citizen.Wait(1)
			end
			
			if IsEntityPlayingAnim(lPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
				ClearPedSecondaryTask(lPed)

			else
				TaskPlayAnim(lPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 8.0, -8, -1, 49, 0, 0, 0, 0)
				seccount = 3
				while seccount > 0 do
					Citizen.Wait(100)
					seccount = seccount - 1

				end
				ClearPedSecondaryTask(lPed)
				SetPedToRagdoll(PlayerPedId(), 150, 150, 0, 0, 0, 0) 
			end		

		end

end)


RegisterNetEvent('client:takephone')
AddEventHandler('client:takephone', function(t)
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 10) then
		TriggerServerEvent("server:takephone", GetPlayerServerId(t))
		TriggerEvent("DoLongHudText", 'Removed Phone Devices..',1)
	else
		TriggerEvent("DoLongHudText", 'No Player Found',2)
	end
end)

RegisterNetEvent('police:remweapons')
AddEventHandler('police:remweapons', function(t)
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 10) then
		TriggerServerEvent("police:remweaponsGranted", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", 'No Player Found',1)
	end
end)
	
RegisterNetEvent('unseatPlayer')
AddEventHandler('unseatPlayer', function()
	t, distance = GetClosestPlayerIgnoreCar()
	if(distance ~= -1 and distance < 10) then
		local ped = PlayerPedId()  
		pos = GetEntityCoords(ped,  true)

		TriggerServerEvent('unseatAccepted',GetPlayerServerId(t),pos["x"], pos["y"], pos["z"])
		Citizen.Wait(1000)
		TriggerServerEvent("police:escortAsk", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", 'No Player Found',1)
	end
end)

RegisterNetEvent("K9:Huntfind")
AddEventHandler("K9:Huntfind", function()

	t, distance = GetClosestPlayer()
	players, distances, coords = GetClosestPlayers(GetEntityCoords(PlayerPedId(), 0),150)
	if(#players > 0) then
		TriggerServerEvent('huntAccepted', players, distances, coords)
		TriggerEvent("DoLongHudText", 'Hunting',1)
	else
		TriggerEvent("DoLongHudText", 'No Scent to pickup on..',2)
	end

end)


RegisterNetEvent("K9:Sniff")
AddEventHandler("K9:Sniff", function()

	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 10) then
		TriggerServerEvent('sniffAccepted',GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", 'No Player Found',2)
	end

end)


TimerEnabled = false

function TryTackle()
		if not TimerEnabled then
			t, distance = GetClosestPlayer()
			if(distance ~= -1 and distance < 2) then
				local maxheading = (GetEntityHeading(PlayerPedId()) + 15.0)
				local minheading = (GetEntityHeading(PlayerPedId()) - 15.0)
				local theading = (GetEntityHeading(t))

				TriggerServerEvent('CrashTackle',GetPlayerServerId(t))
				TriggerEvent("animation:tacklelol") 

				TimerEnabled = true
				Citizen.Wait(4500)
				TimerEnabled = false

			else
				TimerEnabled = true
				Citizen.Wait(1000)
				TimerEnabled = false

			end

		end
--SetPedToRagdoll(PlayerPedId(), 500, 500, 0, 0, 0, 0) 
end

RegisterNetEvent('playerTackled')
AddEventHandler('playerTackled', function()
	SetPedToRagdoll(PlayerPedId(), math.random(8500), math.random(8500), 0, 0, 0, 0) 

	TimerEnabled = true
	Citizen.Wait(1500)
	TimerEnabled = false
end)

RegisterNetEvent('unseatPlayerFinish')
AddEventHandler('unseatPlayerFinish', function(x,y,z)
	local intrunk = exports["isPed"]:isPed("intrunk")
	if not intrunk then
		local ped = PlayerPedId()  
		ClearPedTasksImmediately(ped)
		local veh = GetVehiclePedIsIn(ped, false)
        TaskLeaveVehicle(ped, veh, 256)
		SetEntityCoords(ped, x, y, z)
	end
end)


function LoadAnimationDictionary(animationD) -- Simple way to load animation dictionaries to save lines.
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end





otherid = 0
escort = false
keystroke = 49
triggerkey = false

dragging = false
beingDragged = false

escortStart = false
shitson = false

RegisterNetEvent('dragPlayer')
AddEventHandler('dragPlayer', function()
	local handcuffed = exports["isPed"]:isPed("handcuffed")
	if handcuffed then
		TriggerEvent("DoLongHudText","You are in handcuffs!",2)
		return
	end
	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 1.0) then
		if not beingDragged then
			DetachEntity(PlayerPedId(), true, false)
			TriggerServerEvent("police:dragAsk", GetPlayerServerId(t))
		end
	end
end)

RegisterNetEvent('drag:stopped')
AddEventHandler('drag:stopped', function(sentid)
	if tonumber(sentid) == tonumber(otherid) and beingDragged then
		shitson = false
		beingDragged = false
		DetachEntity(PlayerPedId(), true, false)
		TriggerEvent("deathdrop",beingDragged)
	end
end)

RegisterNetEvent('escortPlayer')
AddEventHandler('escortPlayer', function()
	local handcuffed = exports["isPed"]:isPed("handcuffed")
	if handcuffed then
		TriggerEvent("DoLongHudText","You are in handcuffs!",2)
		return
	end
	t, distance = GetClosestPlayer()
	if not IsPedInAnyVehicle(PlayerPedId(), false) then
		if(distance ~= -1 and distance < 5) then
			if not escort then
				Wait(800)
				TriggerServerEvent("police:escortAsk", GetPlayerServerId(t))
			end
		else
			escorting = false
		end
	end
end)

RegisterNetEvent("unEscortPlayer")
AddEventHandler("unEscortPlayer", function()
	escort = false
	beingDragged = false
	ClearPedTasks(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)


RegisterNetEvent("dr:dragging")
AddEventHandler('dr:dragging', function()
	dragging = not dragging

	if not dragging and IsPedInAnyVehicle(PlayerPedId(), false) then
		return
	end
	
	if not dragging then
		ClearPedTasksImmediately(PlayerPedId())
		DetachEntity(PlayerPedId(), true, false)
	end
end)

local escorting = false

RegisterNetEvent("dr:releaseEscort")
AddEventHandler("dr:releaseEscort", function()
	escorting = false
end)




RegisterNetEvent("dr:escort")
AddEventHandler('dr:escort', function(pl)
	otherid = tonumber(pl)
	if not escort and IsPedInAnyVehicle(PlayerPedId(), false) then
		return
	end
	escort = not escort
	if not escort then
		TriggerServerEvent("dr:releaseEscort",otherid)
	end

end)

RegisterNetEvent("dr:drag")
AddEventHandler('dr:drag', function(pl)
	otherid = tonumber(pl)
	beingDragged = not beingDragged
	if beingDragged then
		SetEntityCoords(PlayerPedId(),GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(otherid))))
	end
	Citizen.Wait(1000)
	TriggerEvent("deathdrop",beingDragged)
end)





RegisterNetEvent("dr:escortingEnabled")
AddEventHandler('dr:escortingEnabled', function()
	escorting = true
end)




--GetEntityAttachedTo(PlayerPedId())

Citizen.CreateThread(function()
	while true do
		if escorting or dragging then
			if IsPedRunning(PlayerPedId()) or IsPedSprinting(PlayerPedId()) then
				SetPlayerControl(PlayerId(), 0, 0)
				Citizen.Wait(1000)
				SetPlayerControl(PlayerId(), 1, 1)
			end
		else
			Citizen.Wait(1000)
		end
		Citizen.Wait(1)
	end
end)


Citizen.CreateThread(function()
	while true do

		if IsEntityDead(GetPlayerPed(GetPlayerFromServerId(otherid))) and (escort) then 
			DetachEntity(PlayerPedId(), true, false)
			shitson = false	
			escort = false
			local pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(GetPlayerFromServerId(otherid)), 0.0, 0.8, 2.8)
			SetEntityCoords(PlayerPedId(),pos)
		end


		if escort or beingDragged then
			local ped = GetPlayerPed(GetPlayerFromServerId(otherid))
			local myped = PlayerPedId()
			if escort then
				x,y,z = 0.54, 0.44, 0.0
			else
				x,y,z = 0.0, 0.44, 0.0
			end
			if not beingDragged then
				AttachEntityToEntity(myped, ped, 11816, x, y, z, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			else
				AttachEntityToEntity(myped, ped, 1, -0.68, -0.2, 0.94, 180.0, 180.0, 60.0, 1, 1, 0, 1, 0, 1)
			end
			
			shitson = true
			--escortStart = true
		else
			if not beingDragged and not escort and shitson then
				DetachEntity(PlayerPedId(), true, false)	
				shitson = false	
				Citizen.Trace("no escort or drag")
				ClearPedTasksImmediately(PlayerPedId())
			end
		end

		if dragging then

			if not IsEntityPlayingAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 3) then
				LoadAnimationDictionary( "missfinale_c2mcs_1" ) 
				TaskPlayAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 1.0, 1.0, -1, 50, 0, 0, 0, 0)
			end
			local dead = exports["isPed"]:isPed("dead")
			if dead or IsControlJustPressed(0, 38) or (`WEAPON_UNARMED` ~= GetSelectedPedWeapon(PlayerPedId())) then
				dragging = false
				ClearPedTasks(PlayerPedId())
				TriggerServerEvent("dragPlayer:disable")
			end

		end

		if beingDragged then
			if not IsEntityPlayingAnim(PlayerPedId(), "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 3) then
				LoadAnimationDictionary( "amb@world_human_bum_slumped@male@laying_on_left_side@base" ) 
				TaskPlayAnim(PlayerPedId(), "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
			end
		end
		Citizen.Wait(1)
	end
end)


RegisterNetEvent('FlipVehicle')
AddEventHandler('FlipVehicle', function()
	local finished = exports["srp-taskbar"]:taskBar(5000,"Flipping Vehicle Over",false,true)	
	if finished == 100 then
		local playerped = PlayerPedId()
	    local coordA = GetEntityCoords(playerped, 1)
	    local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
		local targetVehicle = getVehicleInDirection(coordA, coordB)
		local pPitch, pRoll, pYaw = GetEntityRotation(playerped)
		local vPitch, vRoll, vYaw = GetEntityRotation(targetVehicle)
		SetEntityRotation(targetVehicle, pPitch, vRoll, vYaw, 1, true)
		Wait(10)
		SetVehicleOnGroundProperly(targetVehicle)
	end
end)

RegisterCommand("impound", function(source, args)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' then
		TriggerEvent('impoundVeh')
	end
end)

function deleteVeh(ent)
	SetVehicleHasBeenOwnedByPlayer(ent, true)
	NetworkRequestControlOfEntity(ent)
	local finished = exports["srp-taskbar"]:taskBar(7500,"Impounding",false,true)	
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(ent))
	DeleteEntity(ent)
	DeleteVehicle(ent)
	SetEntityAsNoLongerNeeded(ent)
end

RegisterNetEvent('impoundVeh')
AddEventHandler('impoundVeh', function()
	local job = exports["isPed"]:isPed("myjob")
	if job == "auto_bodies" or job == 'paleto_mech' or job == 'auto_exotics' or job == 'tuner_shop' or job == "ems" or job == "police" or job == "car_shop" then
		coordA = GetEntityCoords(PlayerPedId(), 1)
		coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
		vehicle = getVehicleInDirection(coordA, coordB)
		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			licensePlate = GetVehicleNumberPlateText(vehicle)
			TriggerServerEvent("srp-imp:ImpoundCar", licensePlate)
			TriggerEvent("animation:impound")
			FreezeEntityPosition(PlayerPedId(),true)
			local finished = exports["srp-taskbar"]:taskBar("3000","Completing Task")
			if finished == 100 then
				ClearPedTasks(PlayerPedId())
				FreezeEntityPosition(PlayerPedId(),false)
				deleteVeh(vehicle)
				TriggerEvent("DoShortHudText","Impounded with retrieval price of $500")
			else
				FreezeEntityPosition(PlayerPedId(),false)
				ClearPedTasks(PlayerPedId())
			end
		end
	end
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



RegisterNetEvent('animation:runtextanim')
AddEventHandler('animation:runtextanim', function(anim)
	if not handCuffed and not IsPedRagdoll(PlayerPedId()) then
		TriggerEvent('animation:runtextanim2',anim)
	end
end)

function GroupRank(groupid)
  local rank = 0
  local mypasses = exports["isPed"]:isPed("passes")
  for i=1, #mypasses do
    if mypasses[i]["pass_type"] == groupid then
      rank = mypasses[i]["rank"]
    end 
  end
  return rank
end

RegisterCommand('trunkgetin', function(source)
	TriggerEvent('ped:forceTrunkSelf')
end)

RegisterNetEvent('duty')
AddEventHandler('duty', function()
	TriggerEvent('srp-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "attempt:duty:police"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "police:noLongerCop"
            }
        },
    })
end)

RegisterNetEvent("attempt:duty:police")
AddEventHandler("attempt:duty:police", function()
	TriggerServerEvent("attemptduty")
end)


RegisterNetEvent('police:giveweapon')
AddEventHandler('police:giveweapon', function()
	t, distance, closestPed = GetClosestPlayer()
	if(distance ~= -1 and distance < 1.5) then
		TriggerServerEvent("police:grantFirearms", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", "No player near you!",2)
	end
end)

RegisterNetEvent('police:removeweapon')
AddEventHandler('police:removeweapon', function()
	t, distance, closestPed = GetClosestPlayer()
	if(distance ~= -1 and distance < 1.5) then
		TriggerServerEvent("police:RevokeFirearms", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", "No player near you!",2)
	end
end)

RegisterNetEvent('police:givehunting')
AddEventHandler('police:givehunting', function()
	t, distance, closestPed = GetClosestPlayer()
	if(distance ~= -1 and distance < 1.5) then
		TriggerServerEvent("police:grantHunting", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", "No player near you!",2)
	end
end)

RegisterNetEvent('police:removehunting')
AddEventHandler('police:removehunting', function()
	t, distance, closestPed = GetClosestPlayer()
	if(distance ~= -1 and distance < 1.5) then
		TriggerServerEvent("police:RevokeHunting", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", "No player near you!",2)
	end
end)


RegisterNetEvent('police:givefishing')
AddEventHandler('police:givefishing', function()
	t, distance, closestPed = GetClosestPlayer()
	if(distance ~= -1 and distance < 1.5) then
		TriggerServerEvent("police:grantFishing", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", "No player near you!",2)
	end
end)

RegisterNetEvent('police:removefishing')
AddEventHandler('police:removefishing', function()
	t, distance, closestPed = GetClosestPlayer()
	if(distance ~= -1 and distance < 1.5) then
		TriggerServerEvent("police:RevokeFishing", GetPlayerServerId(t))
	else
		TriggerEvent("DoLongHudText", "No player near you!",2)
	end
end)


RegisterNetEvent("police:bill")
AddEventHandler("police:bill", function()
    local bill = exports["srp-applications"]:KeyboardInput({
        header = "Create Receipt",
        rows = {
            {
                id = 0,
                txt = "Server ID"
            },
            {
                id = 1,
                txt = "Amount"
            }
        }
    })
    if bill then
        TriggerServerEvent("police:bill:player", bill[1].input, bill[2].input)
    end
end)

RegisterCommand('bill', function(source)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' then
		TriggerEvent('police:bill')
	end
end)


RegisterNetEvent("serial:search")
AddEventHandler("serial:search", function()
    local serialS = exports["srp-applications"]:KeyboardInput({
        header = "Weapon Serial Lookup",
        rows = {
            {
                id = 1,
                txt = "Serial"
            }
        }
    })
    if serialS then
        TriggerServerEvent("serial:search:weapon", serialS[1].input)
    end
end)

local NearPD = false
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(5)
		local plyCoords = GetEntityCoords(PlayerPedId())
        local distance4 = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z, 428.69555664063, -981.03894042969, 30.710065841675,false)        
        if distance4 <= 70 then
			local job = exports["isPed"]:isPed("myjob")
			if job == 'police' then
				NearPD = true
            end
		else
			NearPD = false
			if distance4 >= 1.3 then
				Citizen.Wait(1000)
			end
		end
	end
end)

local NearDavisPD = false
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(5)
		local plyCoords = GetEntityCoords(PlayerPedId())
        local distance4 = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z, 364.99200439453, -1603.34375, 29.292039871216,false)        
        if distance4 <= 70 then
			local job = exports["isPed"]:isPed("myjob")
			if job == 'police' then
				NearDavisPD = true
            end
		else
			NearDavisPD = false
			if distance4 >= 1.3 then
				Citizen.Wait(1000)
			end
		end
	end
end)

RegisterCommand("evidence", function(source, args)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' then
		if NearPD == true or NearDavisPD == true then
			TriggerEvent("server-inventory-open", "1", "CASE ID: "..args[1])
		else
			TriggerEvent("DoLongHudText", "Your not near Davis/MRPD.", 2)
		end
	end
end)

RegisterCommand("fire", function(source, args)
	local src = source
	local job = exports["isPed"]:isPed("myjob")
	local cid = tonumber(args[1])
	if job ~= "Unemployed" then
		TriggerServerEvent("fire:event", job, cid)
	end
end)

RegisterNetEvent("fired:success")
AddEventHandler("fired:success", function(cidsent)
	local cid = exports["isPed"]:isPed("cid")
	if tonumber(cid) == tonumber(cidsent) then
		TriggerEvent("DoLongHudText", "You just got fired")
		TriggerEvent("srp-jobmanager:playerBecameJob", "Unemployed", "Unemployed", false)
	end
end)