RegisterNetEvent('srp-outlawalert:gunshotInProgress')
AddEventHandler('srp-outlawalert:gunshotInProgress', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local gunshotBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(gunshotBlip,  110)
		SetBlipColour(gunshotBlip,  1)
		SetBlipScale(gunshotBlip, 1.2)
		SetBlipAsShortRange(gunshotBlip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-71A Shots Fired')
		EndTextCommandSetBlipName(gunshotBlip)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if alpha == 0 then
				RemoveBlip(policedown)
				return
			end
		end
	
	end
end)

AddEventHandler('srp-alerts:gunshot', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:shoot', {x = pos.x, y = pos.y, z = pos.z})
end)


---- 10-13s Officer Down ----

RegisterNetEvent('srp-alerts:policealertA')
AddEventHandler('srp-alerts:policealertA', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local policedown = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(policedown,  84)
		SetBlipColour(policedown,  1)
		SetBlipScale(policedown, 1.2)
		SetBlipAsShortRange(policedown,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-13A Officer Down')
		EndTextCommandSetBlipName(policedown)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'polalert', 0.2)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(policedown, alpha)

		if alpha == 0 then
			RemoveBlip(policedown)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:1013A', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:teenA', {x = pos.x, y = pos.y, z = pos.z})
end)

RegisterNetEvent('srp-alerts:policealertB')
AddEventHandler('srp-alerts:policealertB', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local policedown2 = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(policedown2, 84)
		SetBlipColour(policedown2, 1)
		SetBlipScale(policedown2, 1.2)
		SetBlipAsShortRange(policedown2,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-13B Officer Down')
		EndTextCommandSetBlipName(policedown2)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(policedown2, alpha)

		if alpha == 0 then
			RemoveBlip(policedown2)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:1013B', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:teenB', {x = pos.x, y = pos.y, z = pos.z})
end)


RegisterNetEvent('srp-alerts:panic')
AddEventHandler('srp-alerts:panic', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local panic = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		SetBlipSprite(panic, 459)
		SetBlipColour(panic, 1)
		SetBlipScale(panic, 1.2)
		SetBlipAsShortRange(panic,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-78 Officer Panic Botton')
		EndTextCommandSetBlipName(panic)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'polalert', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(panic, alpha)

		if alpha == 0 then
			RemoveBlip(panic)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:policepanic', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:teenpanic', {x = pos.x, y = pos.y, z = pos.z})
end)


---- 10-14 EMS ----

RegisterNetEvent('srp-alerts:tenForteenA')
AddEventHandler('srp-alerts:tenForteenA', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local medicDown = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(medicDown, 84)
		SetBlipColour(medicDown, 1)
		SetBlipScale(medicDown, 1.2)
		SetBlipAsShortRange(medicDown,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-14A Medic Down')
		EndTextCommandSetBlipName(medicDown)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'polalert', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(medicDown, alpha)

		if alpha == 0 then
			RemoveBlip(medicDown)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:1014A', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:fourA', {x = pos.x, y = pos.y, z = pos.z})
end)


RegisterNetEvent('srp-alerts:tenForteenB')
AddEventHandler('srp-alerts:tenForteenB', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local medicDown2 = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(medicDown2, 84)
		SetBlipColour(medicDown2, 1)
		SetBlipScale(medicDown2, 1.2)
		SetBlipAsShortRange(medicDown2,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-14B Officer Down')
		EndTextCommandSetBlipName(medicDown2)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(medicDown2, alpha)

		if alpha == 0 then
			RemoveBlip(medicDown2)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:1014B', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:fourB', {x = pos.x, y = pos.y, z = pos.z})
end)

---- Down Person ----

RegisterNetEvent('srp-alerts:downalert')
AddEventHandler('srp-alerts:downalert', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local injured = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(injured,  126)
		SetBlipColour(injured,  18)
		SetBlipScale(injured, 1.2)
		SetBlipAsShortRange(injured,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-47 Injured Person')
		EndTextCommandSetBlipName(injured)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'dispatch', 0.1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(injured, alpha)

		if alpha == 0 then
			RemoveBlip(injured)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:downguy', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:downperson', {x = pos.x, y = pos.y, z = pos.z})
end)

---- assistance ----
RegisterNetEvent('srp-alerts:assistance')
AddEventHandler('srp-alerts:assistance', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then	
		local alpha = 250
		local assistance = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(assistance,  126)
		SetBlipColour(assistance,  18)
		SetBlipScale(assistance, 1.2)
		SetBlipAsShortRange(assistance,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Assistance Needed')
		EndTextCommandSetBlipName(assistance)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'dispatch', 0.1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(assistance, alpha)

		if alpha == 0 then
			RemoveBlip(assistance)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:assistanceneeded', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:assistancen', {x = pos.x, y = pos.y, z = pos.z})
end)

---- Car Crash ----

RegisterNetEvent('srp-alerts:vehiclecrash')
AddEventHandler('srp-alerts:vehiclecrash', function()
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'ems' or job == 'news' then
		local alpha = 250
		local targetCoords = GetEntityCoords(PlayerPedId(), true)
		local recket = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(recket,  488)
		SetBlipColour(recket,  1)
		SetBlipScale(recket, 1.2)
		SetBlipAsShortRange(recket,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-50 Vehicle Crash')
		EndTextCommandSetBlipName(recket)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(recket, alpha)

		if alpha == 0 then
			RemoveBlip(recket)
		return
      end
    end
  end
end)

---- Store Robbery ----
RegisterNetEvent('srp-alerts:storerobbery')
AddEventHandler('srp-alerts:storerobbery', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local store = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipHighDetail(store, true)
		SetBlipSprite(store, 52)
		SetBlipColour(store, 1)
		SetBlipScale(store, 1.2)
		SetBlipAsShortRange(store,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-31B Robbery In Progress')
		EndTextCommandSetBlipName(store)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(store, alpha)

		if alpha == 0 then
			RemoveBlip(store)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:robstore', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:storerob', {x = pos.x, y = pos.y, z = pos.z})
end)

---- House Robbery ----

RegisterNetEvent('srp-alerts:houserobbery')
AddEventHandler('srp-alerts:houserobbery', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local burglary = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipHighDetail(burglary, true)
		SetBlipSprite(burglary,  411)
		SetBlipColour(burglary,  1)
		SetBlipScale(burglary, 1.2)
		SetBlipAsShortRange(burglary,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-31A Burglary')
		EndTextCommandSetBlipName(burglary)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(burglary, alpha)

		if alpha == 0 then
			RemoveBlip(burglary)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:robhouse', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:houserob', {x = pos.x, y = pos.y, z = pos.z})
end)

---- Bank Truck ----

RegisterNetEvent('srp-alerts:banktruck')
AddEventHandler('srp-alerts:banktruck', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local truck = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite(truck,  477)
		SetBlipColour(truck,  76)
		SetBlipScale(truck, 1.2)
		SetBlipAsShortRange(Blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 Bank Truck In Progress')
		EndTextCommandSetBlipName(truck)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(truck, alpha)

		if alpha == 0 then
			RemoveBlip(truck)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:bankt', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:tbank', {x = pos.x, y = pos.y, z = pos.z})
end)

---- Jewerly Store ----

RegisterNetEvent('srp-alerts:jewelrobbey')
AddEventHandler('srp-alerts:jewelrobbey', function()
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local jew = AddBlipForCoord(-634.02, -239.49, 38)

		SetBlipSprite(jew,  487)
		SetBlipColour(jew,  4)
		SetBlipScale(jew, 1.2)
		SetBlipAsShortRange(Blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 In Progress')
		EndTextCommandSetBlipName(jew)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(jew, alpha)

		if alpha == 0 then
			RemoveBlip(jew)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:jewrob', function()
	TriggerServerEvent('srp-alerts:robjew')
end)


-- Crypto hacking
RegisterNetEvent('srp-alerts:crypto')
AddEventHandler('srp-alerts:crypto', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local crypto = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipHighDetail(crypto, true)
		SetBlipSprite(crypto, 521)
		SetBlipColour(crypto, 1)
		SetBlipScale(crypto, 1)
		SetBlipAsShortRange(crypto,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('**Phone Call** Just got some word of some guys hacking into a network up in Sandy, might wanna check this shit out. - Anonymous Man')
		EndTextCommandSetBlipName(crypto)
		PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(crypto, alpha)

		if alpha == 0 then
			RemoveBlip(crypto)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:cryptohack', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:cryptohack', {x = pos.x, y = pos.y, z = pos.z})
end)

-- Pacific Standard
RegisterNetEvent('srp-alerts:pacific')
AddEventHandler('srp-alerts:pacific', function()
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local pacific = AddBlipForCoord(-634.02, -239.49, 38)

		SetBlipSprite(pacific, 487)
		SetBlipColour(pacific, 4)
		SetBlipScale(pacific, 1.2)
		SetBlipAsShortRange(Blip, 1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 In Progress')
		EndTextCommandSetBlipName(pacific)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(pacific, alpha)

		if alpha == 0 then
			RemoveBlip(pacific)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:AlertPacific', function()
	TriggerServerEvent('srp-alerts:AlertPacific:sv')
end)

-- Coke Plane
RegisterNetEvent('srp-alerts:methexplosion')
AddEventHandler('srp-alerts:methexplosion', function(targetCoords)
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local methexplosion = AddBlipForCoord(150.52998352051, 322.67651367188, 112.33367919922)

		SetBlipSprite(methexplosion, 486)
		SetBlipColour(methexplosion, 1)
		SetBlipScale(methexplosion, 1.2)
		SetBlipAsShortRange(Blip, 1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Explosion Reported Near The Beach')
		EndTextCommandSetBlipName(methexplosion)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(methexplosion, alpha)

		if alpha == 0 then
			RemoveBlip(methexplosion)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:methexplosion', function()
	local pos = GetEntityCoords(PlayerPedId(), true)
	TriggerServerEvent('srp-alerts:methexplosion:sv', {x = pos.x, y = pos.y, z = pos.z})
end)

-- Union Heist
RegisterNetEvent('srp-alerts:AlertUnion:cl')
AddEventHandler('srp-alerts:AlertUnion:cl', function()
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local jew = AddBlipForCoord(-3.4843490123749, -686.92999267578, 16.130863189697)

		SetBlipSprite(jew,  487)
		SetBlipColour(jew,  4)
		SetBlipScale(jew, 1.2)
		SetBlipAsShortRange(Blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 In Progress')
		EndTextCommandSetBlipName(jew)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(jew, alpha)

		if alpha == 0 then
			RemoveBlip(jew)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:AlertUnion', function()
	TriggerServerEvent('srp-alerts:AlertUnion:sv')
end)


RegisterNetEvent('srp-alerts:AlertUnion:clC4')
AddEventHandler('srp-alerts:AlertUnion:clC4', function()
	local job = exports["isPed"]:isPed("myjob")
	if job == 'police' or job == 'news' then
		local alpha = 250
		local jew = AddBlipForCoord(-3.4843490123749, -686.92999267578, 16.130863189697)

		SetBlipSprite(jew,  487)
		SetBlipColour(jew,  4)
		SetBlipScale(jew, 1.2)
		SetBlipAsShortRange(Blip,  1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('10-90 In Progress')
		EndTextCommandSetBlipName(jew)
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'bankalarm', 0.3)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(jew, alpha)

		if alpha == 0 then
			RemoveBlip(jew)
		return
      end
    end
  end
end)

AddEventHandler('srp-alerts:AlertUnionC4', function()
	TriggerServerEvent('srp-alerts:AlertUnion:svC4')
end)


RegisterNetEvent('srp-dispatch:drugjob')
AddEventHandler("srp-dispatch:drugjob",function()
  AlertDrugJob()
end)

RegisterNetEvent('srp-dispatch:union')
AddEventHandler("srp-dispatch:union",function()
  AlertUnion()
end)

RegisterNetEvent('srp-dispatch:methexplosion')
AddEventHandler("srp-dispatch:methexplosion",function()
  AlertMeth()
end)

RegisterNetEvent('srp-dispatch:pacific')
AddEventHandler("srp-dispatch:pacific",function()
  AlertPacific()
end)

RegisterNetEvent('srp-dispatch:cokeplane')
AddEventHandler("srp-dispatch:cokeplane",function()
  AlertCoke()
end)

RegisterNetEvent('srp-dispatch:unionC4')
AddEventHandler("srp-dispatch:unionC4",function()
  AlertUnionC4()
end)


RegisterNetEvent('srp-dispatch:bankrobbery')
AddEventHandler("srp-dispatch:bankrobbery",function()
  AlertFleecaRobbery()
end)

RegisterNetEvent('srp-dispatch:jailbreak')
AddEventHandler("srp-dispatch:jailbreak",function()
  AlertJailBreak()
end)

RegisterNetEvent('srp-dispatch:jewelrobbery')
AddEventHandler("srp-dispatch:jewelrobbery",function()
  AlertJewelRob()
  return
end)

RegisterNetEvent('srp-dispatch:cryptohack')
AddEventHandler("srp-dispatch:cryptohack",function()
  crypto()
end)

RegisterNetEvent('srp-dispatch:houserobbery')
AddEventHandler("srp-dispatch:houserobbery",function()
  AlertCheckRobbery2()
end)

RegisterNetEvent('srp-dispatch:storerobbery')
AddEventHandler("srp-dispatch:storerobbery",function()
  AlertpersonRobbed(vehicle)
end)

RegisterNetEvent('srp-dispatch:carjacking')
AddEventHandler("srp-dispatch:carjacking",function()
  AlertCheckLockpick(object)
end)

RegisterNetEvent('srp-dispatch:downplayer')
AddEventHandler("srp-dispatch:downplayer",function()
	TriggerEvent("police:1047")
end)
