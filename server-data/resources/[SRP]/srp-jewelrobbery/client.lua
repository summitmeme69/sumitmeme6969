local PlayerData = {}
local bomba, seguridad = false, true
local timer = GetGameTimer()
local stand = {
	{x = -627.23, y = -234.98, z = 38.52, abierto = false},
	{x = -627.67, y = -234.35, z = 38.52, abierto = false},
	{x = -626.53, y = -233.52, z = 38.52, abierto = false},
	{x = -626.09, y = -234.15, z = 38.52, abierto = false},
	{x = -625.27, y = -238.31, z = 38.52, abierto = false},
	{x = -626.26, y = -239.03, z = 38.52, abierto = false},
	{x = -623.98, y = -230.73, z = 38.52, abierto = false},
	{x = -622.50, y = -232.60, z = 38.52, abierto = false},
	{x = -619.87, y = -234.82, z = 38.05, abierto = false},
	{x = -618.79, y = -234.05, z = 38.05, abierto = false},
	{x = -617.11, y = -230.20, z = 38.05, abierto = false},
	{x = -617.87, y = -229.15, z = 38.05, abierto = false},
	{x = -619.16, y = -227.18, z = 38.05, abierto = false},
	{x = -619.99, y = -226.15, z = 38.05, abierto = false},
	{x = -625.25, y = -227.24, z = 38.05, abierto = false},
	{x = -624.27, y = -226.64, z = 38.05, abierto = false},
	{x = -623.58, y = -228.57, z = 38.05, abierto = false},
	{x = -621.48, y = -228.84, z = 38.05, abierto = false},
	{x = -620.17, y = -230.90, z = 38.05, abierto = false},
	{x = -620.60, y = -232.90, z = 38.05, abierto = false}
}

Citizen.CreateThread(function ()
	while true do	
		local w = 500
		local p = PlayerPedId()
		local c = GetEntityCoords(p)
		local b = false
		if not seguridad then
			w = 5
			for i = 1, #stand do
				local s = stand[i]
				if GetDistanceBetweenCoords(c, s.x, s.y, s.z, true) < 1 and not s.abierto then 				
					DrawText3D(s.x, s.y, s.z,Config.Lang['break'])
					if GetDistanceBetweenCoords(c, s.x, s.y, s.z, true) < 1 then
						if IsControlJustPressed(0, 38) then				
							if IsPedArmed(PlayerPedId(), 4) then
								s.abierto = true 
								PlaySoundFromCoord(-1, "Glass_Smash", s.x, s.y, s.z, "", 0, 0, 0)
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
								RequestNamedPtfxAsset("scr_jewelheist")
								end
								while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
								Citizen.Wait(0)
								end
								SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", s.x, s.y, s.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								anim("missheist_jewel") 
								TaskPlayAnim(p, "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								Citizen.Wait(5000)
								ClearPedTasksImmediately(p)
								TriggerServerEvent('srp-jewelrobbery:AwardItems')
							else
								TriggerEvent('DoLongHudText', 'You are missing a weapon!', 2)							
							end
						end
					end
				end
			end
			if GetGameTimer() - timer > Config.RobTime * 1000 * 60 then
				seguridad = true
				bomba = false
			end
		else
			w = 3000
		end
		Citizen.Wait(w)
	end
end)

RegisterNetEvent('av_vangelico:bomba')
AddEventHandler('av_vangelico:bomba', function()
	local p = PlayerPedId()
	RequestAnimDict('anim@heists@ornate_bank@thermal_charge')
		if HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge') then
			SetEntityCoords(PlayerPedId(), -636.23840332031, -214.1, 52.6)
			SetEntityHeading(PlayerPedId(), 32.896125793457)
			FreezeEntityPosition(PlayerPedId(),true)
            local fwd, _, _, pos = GetEntityMatrix(p)
            local np = (fwd * 0.8) + pos            
            SetEntityCoords(p, np.xy, np.z - 1)
            local rot, pos = GetEntityRotation(p), GetEntityCoords(p)
            SetPedComponentVariation(p, 5, -1, 0, 0)
            local b = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), pos.x, pos.y, pos.z,  true,  true, false)
            local sc = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 2, 0, 0, 1065353216, 0, 1.3)
            SetEntityCollision(b, 0, 1)
            NetworkAddPedToSynchronisedScene(p, sc, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(b, sc, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
            NetworkStartSynchronisedScene(sc)
            Citizen.Wait(1500)
            pos = GetEntityCoords(p)
            prop = CreateObject(GetHashKey("hei_prop_heist_thermite"), pos.x, pos.y, pos.z + 0.2, 1, 1, 1)
            SetEntityCollision(prop, 0, 1)
            AttachEntityToEntity(prop, p, GetPedBoneIndex(p, 28422), 0, 0, 0, 0, 0, 180.0, 1, 1, 0, 1, 1, 1)
            Citizen.Wait(4000)
			DeleteObject(b)
            SetPedComponentVariation(p, 5, 45, 0, 0)
            DetachEntity(prop, 1, 1)
            FreezeEntityPosition(prop, 1)
            SetEntityCollision(prop, 0, 1)
            pCoords = GetEntityCoords(prop)
            TriggerServerEvent('av_vangelico:efecto', prop)
			Citizen.Wait(4000)
			NetworkStopSynchronisedScene(sc)
			DeleteObject(prop)
			seguridad = false
			FreezeEntityPosition(PlayerPedId(),false)
			TriggerServerEvent("srp-doors:alterlockstate", 23)
			TriggerServerEvent("srp-doors:alterlockstate", 24)
			TriggerEvent('DoLongHudText', 'You started the robbery', 2)
			TriggerEvent("srp-dispatch:jewelrobbery")
			TriggerServerEvent('av_vangelico:gas')
			TriggerServerEvent('jewelrobbery:log')
		end
end)

RegisterNetEvent('av_vangelico:bombaFx')
AddEventHandler('av_vangelico:bombaFx', function(entity)
	RequestNamedPtfxAsset('scr_ornate_heist')
		if HasNamedPtfxAssetLoaded('scr_ornate_heist') then
			SetPtfxAssetNextCall("scr_ornate_heist")
            explosiveEffect = StartParticleFxLoopedOnEntity("scr_heist_ornate_thermal_burn", entity, 0.0, 2.0, 0.0, 0.0, 0.0, 0.0, 2.0, 0, 0, 0, 0)
			Citizen.Wait(4000)
			StopParticleFxLooped(explosiveEffect, 0)
		end
end)

RegisterNetEvent('av_vangelico:humo')
AddEventHandler('av_vangelico:humo', function()
	if #(GetEntityCoords(PlayerPedId()) - vector3(-632.39, -238.26, 38.07)) < 300 then
		local cuenta = 0
		RequestNamedPtfxAsset('core')
		while not HasNamedPtfxAssetLoaded('core') do
			Citizen.Wait(1)
		end
		while true do 
			cuenta = cuenta + 1			
			if cuenta == Config.GasTime * 15 then break end		
			UseParticleFxAssetNextCall('core')
			StartParticleFxLoopedAtCoord("veh_respray_smoke", -621.85, -230.71, 38.05, 0.0, 0.0, 0.0, 4.0, false, false, false, 0)	
			Citizen.Wait(4000)		
		end
	end
end)


function anim(dict)  
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function hasWeapon(weapon)	
	for i = 1, #Config.Weapons do
		if weapon == Config.Weapons[i] then
			return true
		end
	end
	return false
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('jewel:thermite')
AddEventHandler('jewel:thermite', function()
	if exports["isPed"]:isPed("countpolice") >= 4 then
		local thermite = exports["srp-inventory"]:hasEnoughOfItem("thermite",1,false)
		if thermite then
			TriggerEvent("inventory:removeItem","thermite", 1)   
			if exports['srp-thermite']:startGame(25,1,13,500) then
				seguridad = true
				bomba = true
				TriggerEvent('av_vangelico:bomba')
			else
				local coords = GetEntityCoords(PlayerPedId())
				FreezeEntityPosition(PlayerPedId(), false)
				Citizen.Wait(1000)
				exports['srp-thermite']:startFireAtLocation(coords.x, coords.y, coords.z - 1, 15000)
				TriggerEvent('DoLongHudText', 'Washed!', 2)
			end
		else
			TriggerEvent('DoLongHudText', 'You Dont Have The Correct Supplies!', 2)
		end
	else
		TriggerEvent('DoLongHudText', 'Aint enough cops on the streets playa', 2)
	end
end)