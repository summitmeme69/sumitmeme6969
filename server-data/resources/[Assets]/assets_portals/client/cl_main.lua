RegisterCommand("refreshcoords", function(source, args)
    TriggerServerEvent("asset_portals:get:coords")
end)


local entercoordscoke, leavecoordscoke, entercoordsrecycle, leavecoordsrecycle, hiddenCraft, hiddenmeth, hiddenmethleave = nil, nil, nil, nil, nil, nil, nil
RegisterNetEvent('asset_portals:recieve:coords')
AddEventHandler('asset_portals:recieve:coords', function(coords1, coords2, coords3, coords4, coords5, coords6, coords7)
    print("Coords Received")
    entercoordscoke = coords1
    leavecoordscoke = coords2

    entercoordsrecycle = coords3
    leavecoordsrecycle = coords4

    hiddenCraft = coords5

	hiddenmeth = coords6
	hiddenmethleave = coords7
    Citizen.Wait(1000)
    print("Coords Set")
end)   
 

Citizen.CreateThread(function()
    while not entercoordscoke do
		Citizen.Wait(0)
	end

    while true do
        Citizen.Wait(5)
        local plyCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z, entercoordscoke.x, entercoordscoke.y, entercoordscoke.z,false)
        if distance <= 0.5 then
            DrawText3D(entercoordscoke.x, entercoordscoke.y, entercoordscoke.z, "[E] - Explore") 
            if IsControlJustReleased(0, 38) then
				TriggerServerEvent("coke:enter")
                DoScreenFadeOut(1)
                Citizen.Wait(100)
                SetEntityCoords(PlayerPedId(), 1088.653, -3187.496, -38.99346)
                DoScreenFadeIn(1000)
                Citizen.Wait(1000)
                TriggerEvent("DoLongHudText", "If you get stuck in here do, /refreshcoords")
            end
        
        else
            if distance >= 1.2 then
                Citizen.Wait(1000)
            end
        end
    
    end
end)


Citizen.CreateThread(function()
    while not leavecoordscoke do
		Citizen.Wait(0)
	end

    while true do
        Citizen.Wait(5)
        local plyCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z, leavecoordscoke.x, leavecoordscoke.y, leavecoordscoke.z,false)
        if distance <= 1.0 then
            DrawText3D(leavecoordscoke.x, leavecoordscoke.y, leavecoordscoke.z, "[E] - Leave") 
            if IsControlJustReleased(0, 38) then
				TriggerServerEvent("coke:leave")
                DoScreenFadeOut(1)
                Citizen.Wait(100)
				SetEntityCoords(PlayerPedId(), entercoordscoke.x,entercoordscoke.y,entercoordscoke.z)
                DoScreenFadeIn(1000)
                Citizen.Wait(1000)
            end
        
        else
            if distance >= 1.2 then
                Citizen.Wait(1000)
            end
        end
    
    end
end)


Citizen.CreateThread(function()
    while not entercoordsrecycle do
		Citizen.Wait(0)
	end

    while true do
        Citizen.Wait(5)
        local plyCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z, entercoordsrecycle.x, entercoordsrecycle.y, entercoordsrecycle.z,false)
        if distance <= 1.0 then
            DrawText3D(entercoordsrecycle.x, entercoordsrecycle.y, entercoordsrecycle.z, "[E] - Enter Recycle") 
            if IsControlJustReleased(0, 38) then
				TriggerServerEvent("recycle:enter")
                DoScreenFadeOut(1)
                Citizen.Wait(100)
                SetEntityCoords(PlayerPedId(), leavecoordsrecycle.x, leavecoordsrecycle.y, leavecoordsrecycle.z)
                renderPropsWhereHouse()
                DoScreenFadeIn(1000)
                Citizen.Wait(1000)
                TriggerEvent("DoLongHudText", "If you get stuck in here do, /refreshcoords")
            end
        
        else
            if distance >= 1.2 then
                Citizen.Wait(1000)
            end
        end
    
    end
end)


Citizen.CreateThread(function()
    while not leavecoordsrecycle do
		Citizen.Wait(0)
	end

    while true do
        Citizen.Wait(5)
        local plyCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z, leavecoordsrecycle.x, leavecoordsrecycle.y, leavecoordsrecycle.z,false)
        if distance <= 1.0 then
            DrawText3D(leavecoordsrecycle.x, leavecoordsrecycle.y, leavecoordsrecycle.z, "[E] - Leave Recycle") 
            if IsControlJustReleased(0, 38) then
				TriggerServerEvent("recycle:leave")
                DoScreenFadeOut(1)
                Citizen.Wait(100)
                SetEntityCoords(PlayerPedId(), entercoordsrecycle.x, entercoordsrecycle.y, entercoordsrecycle.z)
                CleanUpArea()
                DoScreenFadeIn(1000)
                Citizen.Wait(1000)
                TriggerEvent("DoLongHudText", "If you get stuck in here do, /refreshcoords")
            end
        
        else
            if distance >= 1.2 then
                Citizen.Wait(1000)
            end
        end
    
    end
end)

Citizen.CreateThread(function()
    while not hiddenmeth do
		Citizen.Wait(0)
	end

    while true do
        Citizen.Wait(5)
        local plyCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z, hiddenmeth.x, hiddenmeth.y, hiddenmeth.z,false)
		if distance <= 0.5 then
			if exports["srp-inventory"]:hasEnoughOfItem("key", 1) then 
				DrawText3D(hiddenmeth.x, hiddenmeth.y, hiddenmeth.z, "[E] - Enter")
				if IsControlJustReleased(0, 38) then
					TriggerServerEvent("meth:enter")
					DoScreenFadeOut(1)
					Citizen.Wait(100)
					SetEntityCoords(PlayerPedId(),  996.96026611328, -3200.6701660156, -36.39372253418)
					DoScreenFadeIn(1000)
					Citizen.Wait(1000)
					TriggerEvent("DoLongHudText", "If you get stuck in here do, /refreshcoords")
				end
			end
        
		else
			if distance >= 1.2 then
				Citizen.Wait(1000)
			end
		end
    
    end
end)

Citizen.CreateThread(function()
    while not hiddenmethleave do
		Citizen.Wait(0)
	end

    while true do
        Citizen.Wait(5)
        local plyCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z, hiddenmethleave.x, hiddenmethleave.y, hiddenmethleave.z,false)
        if distance <= 0.5 then
            DrawText3D(996.96026611328, -3200.6701660156, -36.39372253418, "[E] - Exit") 
            if IsControlJustReleased(0, 38) then
				TriggerEvent("stopcooking")
				TriggerServerEvent("meth:leave")
				Citizen.Wait(5)
                DoScreenFadeOut(1)
                Citizen.Wait(100)
                SetEntityCoords(PlayerPedId(), hiddenmeth.x, hiddenmeth.y, hiddenmeth.z)
                DoScreenFadeIn(1000)
                Citizen.Wait(1000)
            end
        
        else
            if distance >= 1.2 then
                Citizen.Wait(1000)
            end
        end
    
    end
end)

function DrawText3D(x,y,z, text)
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


function renderPropsWhereHouse()
	CreateObject(GetHashKey("ex_prop_crate_bull_sc_02"),1003.63013,-3108.50415,-39.9669662,false,false,false)
	CreateObject(GetHashKey("ex_prop_crate_wlife_bc"),1018.18011,-3102.8042,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_prop_crate_closed_bc"),1006.05511,-3096.954,-37.8179666,false,false,false)
	CreateObject(GetHashKey("ex_prop_crate_wlife_sc"),1003.63013,-3102.8042,-37.81769,false,false,false)
	CreateObject(GetHashKey("ex_prop_crate_jewels_racks_sc"),1003.63013,-3091.604,-37.8179666,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1013.330000003,-3102.80400000,-35.62896000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1015.75500000,-3102.80400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1015.75500000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_BC"),1018.18000000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1026.75500000,-3111.38400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_BC"),1003.63000000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_BC"),1026.75500000,-3106.52900000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1026.75500000,-3106.52900000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_SC"),1010.90500000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),1013.33000000,-3108.50400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),1015.75500000,-3108.50400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_SC_02"),1010.90500000,-3096.95400000,-39.86697000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_SC"),993.35510000,-3111.30400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),993.35510000,-3108.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_SC"),1013.33000000,-3096.95400000,-37.8177600,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_clothing_BC"),1018.180000000,-3096.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_clothing_BC"),1008.48000000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1003.63000000,-3108.50400000,-35.61234000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Narc_BC"),1026.75500000,-3091.59400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Narc_BC"),1026.75500000,-3091.59400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_SC"),1008.48000000,-3108.50400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_SC"),1018.18000000,-3096.95400000,-37.81240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Wlife_BC"),1018.18000000,-3091.60400000,-35.74857000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Med_BC"),1008.48000000,-3091.60400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_SC"),1013.33000000,-3108.50400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1026.75500000,-3108.88900000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_biohazard_BC"),1010.90500000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Wlife_BC"),1015.75500000,-3091.60400000,-35.74857000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_biohazard_BC"),1003.63000000,-3108.50400000,-37.81561000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1008.48000000,-3096.954000000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),1006.05500000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_RW"),1013.33000000,-3091.60400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Narc_SC"),1026.75500000,-3094.014000000,-37.81684000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),1015.75500000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1010.90500000,-3096.95400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Ammo_BC"),1013.33000000,-3102.80400000,-37.81427000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Money_BC"),1003.63000000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1003.63000000,-3096.95400000,-37.81187000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1010.90500000,-3091.60400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_BC"),1013.33000000,-3091.60400000,-35.74885000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_BC"),1026.75500000,-3091.59400000,-35.74885000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_BC"),1026.75500000,-3094.0140000,-35.74885000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_BC"),1026.75500000,-3096.43400000,-35.74885000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_clothing_SC"),1013.33000000,-3091.604000000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_biohazard_SC"),1006.05500000,-3108.50400000,-37.81576000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),993.35510000,-3106.60400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1026.75500000,-3111.38400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),1026.75500000,-3096.4340000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1015.75500000,-3096.95400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_HighEnd_pharma_BC"),1003.63000000,-3091.60400000,-35.62571000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_HighEnd_pharma_SC"),1015.75500000,-3091.60400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_BC"),1013.330000000,-3096.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_SC"),1018.18000000,-3102.80400000,-37.81776000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_BC"),1013.33000000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1018.18000000,-3108.50400000,-37.81234000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_BC"),1010.90500000,-3108.50400000,-35.75240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Med_SC"),1026.75500000,-3108.88900000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Money_SC"),1010.90500000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Med_SC"),1008.48000000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_BC"),1018.180000000,-3108.50400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_SC_02"),1008.48000000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_BC"),993.35510000,-3106.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1008.480000000,-3102.804000000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),993.35510000,-3111.30400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_HighEnd_pharma_BC"),1018.18000000,-3091.60400000,-37.81572000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1015.75500000,-3102.80400000,-37.81234000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_racks_BC"),1003.63000000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Money_SC"),1006.05500000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1003.630000000,-3096.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_SC"),1006.05500000,-3102.80400000,-37.81544000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Expl_bc"),1010.90500000,-3102.80400000,-37.81982000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1006.05500000,-3096.9540000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1006.05500000,-3102.80400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1010.90500000,-3108.50400000,-37.81529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),1015.75500000,-3096.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1010.90500000,-3096.95400000,-37.81234000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1010.90500000,-3102.804000000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1008.48000000,-3102.80400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),993.35510000,-3106.60400000,-37.81342000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Money_SC"),1015.75500000,-3091.604000000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Med_BC"),1026.75500000,-3106.52900000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_SC_02"),1015.75500000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_SC"),1010.905000000,-3091.60400000,-37.81240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1006.05500000,-3091.60400000,-35.62796000,false,false,false) -- This one
	CreateObject(GetHashKey("ex_Prop_Crate_pharma_SC"),1026.75500000,-3096.43400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1006.05500000,-3108.50400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_SC"),1015.75500000,-3108.504000000,-37.81776000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_BC"),1018.18000000,-3102.80400000,-35.75240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_BC"),1008.48000000,-3108.50400000,-35.75240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),993.35510000,-3111.30400000,-37.81342000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_racks_SC"),1026.75500000,-3111.384000000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_SC"),1006.05500000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),1013.33000000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_SC"),1013.33000000,1013.33000000,1013.33000000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_BC"),1026.75500000,-3108.889000000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_SC_02"),993.35510000,-3108.95400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1008.48000000,-3091.60400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_SC"),993.35510000,-3108.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_XLDiam"),1026.75500000,-3094.01400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_watch"),1013.33000000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_SHide"),1018.18000000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Oegg"),1006.05500000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_MiniG"),1018.18000000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_FReel"),11008.48000000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_SC"),1006.05500000,-3091.60400000,-37.81985000,false,false,false) -- -64
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),1026.75500000,-3091.59400000,-39.99757,false,false,false)

	local tool1 = CreateObject(-573669520,1022.6115112305,-3107.1694335938,-39.999912261963,false,false,false)
	local tool2 = CreateObject(-573669520,1022.5317382813,-3095.3305664063,-39.999912261963,false,false,false)
	local tool3 = CreateObject(-573669520,996.60125732422,-3099.2927246094,-39.999923706055,false,false,false)
	local tool4 = CreateObject(-573669520,1002.0411987305,-3108.3645019531,-39.999897003174,false,false,false)

	SetEntityHeading(tool1,GetEntityHeading(tool1)-130)
	SetEntityHeading(tool2,GetEntityHeading(tool2)-40)
	SetEntityHeading(tool3,GetEntityHeading(tool3)+90)
	SetEntityHeading(tool4,GetEntityHeading(tool4)-90)
end


function CleanUpArea()
    local playerped = GetPlayerPed(-1)
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = GetDistanceBetweenCoords(plycoords, pos, true)
        if distance < 50.0 and ObjectFound ~= playerped then
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
    EndFindObject(handle)
end

RegisterNetEvent('hospital:roof')
AddEventHandler('hospital:roof', function()
	DoScreenFadeOut(1)
	Citizen.Wait(100)
	TriggerEvent('InteractSound_CL:PlayOnOne', 'elevator', 0.8)
	SetEntityCoords(PlayerPedId(), 338.64, -583.83, 74.17)
	DoScreenFadeIn(1000)
	Citizen.Wait(1000)
end)

RegisterNetEvent('hospital:lower')
AddEventHandler('hospital:lower', function()
	DoScreenFadeOut(1)
	Citizen.Wait(100)
	TriggerEvent('InteractSound_CL:PlayOnOne', 'elevator', 0.8)
	SetEntityCoords(PlayerPedId(), 344.42633056641, -586.25030517578, 28.79683303833)
	DoScreenFadeIn(1000)
	Citizen.Wait(1000)
end)

RegisterNetEvent('hospital:roofexit')
AddEventHandler('hospital:roofexit', function()
	DoScreenFadeOut(1)
	Citizen.Wait(100)
	TriggerEvent("dooranim")
	TriggerEvent('InteractSound_CL:PlayOnOne','DoorOpen', 0.7)
	SetEntityCoords(PlayerPedId(), 332.24652099609, -595.69305419922, 43.284049987793)
	DoScreenFadeIn(1000)
	Citizen.Wait(1000)
end)

RegisterNetEvent('hospital:elevatorup')
AddEventHandler('hospital:elevatorup', function()
	DoScreenFadeOut(1)
	Citizen.Wait(100)
	TriggerEvent('InteractSound_CL:PlayOnOne', 'elevator', 0.8)
	SetEntityCoords(PlayerPedId(), 330.39865112305, -601.16101074219, 43.284111022949)

	DoScreenFadeIn(1000)
	Citizen.Wait(1000)
end)

RegisterNetEvent('courthouse:enter')
AddEventHandler('courthouse:enter', function()
	DoScreenFadeOut(1)
	Citizen.Wait(100)
	TriggerEvent("dooranim")
	TriggerEvent('InteractSound_CL:PlayOnOne', 'DoorOpen', 0.8)
	SetEntityCoords(PlayerPedId(), 268.88739013672, -371.68246459961, -44.137741088867)
	SetEntityHeading(PlayerPedId(), 58.108573913574)
	DoScreenFadeIn(1000)
	Citizen.Wait(1000)
end)

RegisterNetEvent('courthouse:exit')
AddEventHandler('courthouse:exit', function()
	DoScreenFadeOut(1)
	Citizen.Wait(100)
	TriggerEvent("dooranim")
	TriggerEvent('InteractSound_CL:PlayOnOne', 'DoorOpen', 0.8)
	SetEntityCoords(PlayerPedId(), 232.89019775391, -411.29730224609, 48.111999511719)
	SetEntityHeading(PlayerPedId(), 355.73016357422)
	DoScreenFadeIn(1000)
	Citizen.Wait(1000)
end)

RegisterNetEvent('courtroom:enter')
AddEventHandler('courtroom:enter', function()
	DoScreenFadeOut(1)
	Citizen.Wait(100)
	TriggerEvent("dooranim")
	TriggerEvent('InteractSound_CL:PlayOnOne', 'DoorOpen', 0.8)
	SetEntityCoords(PlayerPedId(), 313.28521728516, -1611.4333496094, -66.78596496582)
	SetEntityHeading(PlayerPedId(), 223.73556518555)
	DoScreenFadeIn(1000)
	Citizen.Wait(1000)
end)

RegisterNetEvent('courtroom:exit')
AddEventHandler('courtroom:exit', function()
	DoScreenFadeOut(1)
	Citizen.Wait(100)
	TriggerEvent("dooranim")
	TriggerEvent('InteractSound_CL:PlayOnOne', 'DoorOpen', 0.8)
	SetEntityCoords(PlayerPedId(), 249.25679016113, -364.86428833008, -44.137630462646)
	SetEntityHeading(PlayerPedId(), 236.24726867676)
	DoScreenFadeIn(1000)
	Citizen.Wait(1000)
end)

-- Gang
local weapon = false

weapons = {
	"-1121678507",	
	"-1045183535",	
	"-879347409",	
	"-72657034",
	"-1074790547",	
	"-1075685676",	
	"-1355376991",	
	"-1357824103",	
	"-1654528753",	
	"-1810795771",	
	"-2066285827",	
	"-2084633992",	
	"-270015777",	
	"-538741184",	
	"-619010992",	
	"-771403250",	
	"-86904375",	
	"100416529",	
	"101631238",	
	"1141786504",	
	"1198879012",	
	"1233104067",	
	"125959754",	
	"126349499",	
	"1305664598",	
	"1317494643",	
	"137902532",	
	"1432025498",	
	"1593441988",	
	"1627465347",	
	"1649403952",	
	"1672152130",	
	"171789620",	
	"1737195953",	
	"2017895192",	
	"2024373456",	
	"2132975508",	
	"2138347493",	
	"2144741730",	
	"2210333304",	
	"2227010557",	
	"2343591895",	
	"2460120199",	
	"2484171525",	
	"2508868239",	
	"2578377531",	
	"2578778090",	
	"2640438543",	
	"2726580491",	
	"2828843422",	
	"2874559379",	
	"2937143193",	
	"2982836145",	
	"3125143736",	
	"317205821",	
	"3173288789",	
	"3218215474",	
	"3219281620",	
	"3220176749",	
	"3231910285",	
	"324215364",	
	"3342088282",	
	"3441901897",	
	"3523564046",	
	"3638508604",	
	"3675956304",	
	"3696079510",	
	"3713923289",	
	"3800352039",	
	"4019527611",	
	"4024951519",	
	"4191993645",	
	"4192643659",	
	"419712736",	
	"453432689",	
	"487013001",	
	"584646201",	
	"615608432",	
	"736523883",	
	"741814745",	
	"883325847",	
	"911657153",	
	"940833800",	
	"984333226"	
}

RegisterNetEvent("gangteleport")
AddEventHandler("gangteleport", function()
        TriggerEvent("DoLongHudText", "I gotta pat you down real quick.")
        Citizen.Wait(5000)
        for k,v in pairs(weapons) do
            if exports["srp-inventory"]:getQuantity(v) ~= 0 then
            weapon = true
            end
        end
        if weapon == false then
        TriggerEvent("DoLongHudText", "Boss said to meet him upstairs.")
            SetEntityCoords(PlayerPedId(), -1569.3233642578, -3017.5793457031, -74.406089782715)
            SetEntityHeading(PlayerPedId(), 6.7822766304016)
            DoScreenFadeIn(1000)
            Citizen.Wait(1000)
            elseif weapon == true then
            TriggerEvent("DoLongHudText", "Boss Won't Speak To You Unless You Remove Those Weapons, Come Back When You Drop Them Off")
            weapon = false
        end
    end)

RegisterNetEvent("gangleave")
AddEventHandler("gangleave", function()
    SetEntityCoords(PlayerPedId(), 114.94241333008, 170.44744873047, 112.45175933838)
    SetEntityHeading(PlayerPedId(), 6.7822766304016)
    DoScreenFadeIn(1000)
    Citizen.Wait(1000)
end)
