local tool_shops = {

	{ ['x'] = 44.838947296143, ['y'] = -1748.5364990234, ['z'] = 29.549386978149 , ['r'] = 50.0},
	{ ['x'] = 2749.2309570313, ['y'] = 3472.3308105469, ['z'] = 55.679393768311,  ['r'] = 260.0},
}



local twentyfourseven_shops = {
	{ ['x'] = 25.925277709961, ['y'] = -1347.4022216797, ['z'] = 29.482055664062},
    { ['x'] = -48.34285736084, ['y'] = -1757.7890625, ['z'] = 29.414672851562},
    { ['x'] = -707.9208984375, ['y'] = -914.62414550781, ['z'] = 19.20361328125},
    { ['x'] = 1135.6878662109, ['y'] = -981.71868896484, ['z'] = 46.399291992188},
    { ['x'] = -1223.6307373047, ['y'] = -906.76483154297, ['z'] = 12.312133789062},
    { ['x'] = 373.81979370117, ['y'] = 326.0439453125, ['z'] = 103.55383300781},
    { ['x'] = 1163.6439208984, ['y'] = -324.13186645508, ['z'] = 69.197021484375},
    { ['x'] = -2968.298828125, ['y'] = 390.59341430664, ['z'] = 15.041748046875},
    { ['x'] = -3242.4658203125, ['y'] = 1001.6703491211, ['z'] = 12.817626953125},
    { ['x'] = -1820.7427978516, ['y'] = 792.36926269531, ['z'] = 138.11279296875},
    { ['x'] = 2557.1472167969, ['y'] = 382.12747192383,['z'] = 108.60876464844},
    { ['x'] = 2678.8879394531, ['y'] = 3280.3911132812, ['z'] = 55.228515625},
    { ['x'] = 1961.5648193359, ['y'] = 3740.6901855469, ['z'] = 32.329711914062},
    { ['x'] = 1392.3824462891, ['y'] = 3604.5495605469, ['z'] = 34.97509765625},
    { ['x'] = 1698.158203125, ['y'] = 4924.404296875, ['z'] = 42.052001953125},
    { ['x'] = 1728.9230957031, ['y'] = 6414.3823242188, ['z'] = 35.025634765625},
    { ['x'] = 1166.4000244141, ['y'] = 2709.1647949219, ['z'] = 38.142822265625},
    { ['x'] = 547.49011230469, ['y'] = 2671.2131347656, ['z'] = 42.153076171875},
    --{ ['x'] = 460.9186706543,['y'] = -982.31207275391, ['z'] = 30.678344726562},
    --{ ['x'] = 448.23297119141, ['y'] = -973.95166015625, ['z'] = 34.958251953125},
    { ['x'] = 1841.3670654297, ['y'] = 2591.2878417969,['z'] = 46.01171875},
}

local weashop_locations = {
	{entering = {811.973572,-2155.33862,28.8189938}, inside = {811.973572,-2155.33862,28.8189938}, outside = {811.973572,-2155.33862,28.8189938},delay = 900},
	{entering = { 1692.54, 3758.13, 34.71}, inside = { 1692.54, 3758.13, 34.71}, outside = { 1692.54, 3758.13, 34.71},delay = 600},
	{entering = {252.915,-48.186,69.941}, inside = {252.915,-48.186,69.941}, outside = {252.915,-48.186,69.941},delay = 600},
	{entering = {844.352,-1033.517,28.094}, inside = {844.352,-1033.517,28.194}, outside = {844.352,-1033.517,28.194},delay = 780},
	{entering = {-331.487,6082.348,31.354}, inside = {-331.487,6082.348,31.454}, outside = {-331.487,6082.348,31.454},delay = 600},
	{entering = {-664.268,-935.479,21.729}, inside = {-664.268,-935.479,21.829}, outside = {-664.268,-935.479,21.829},delay = 600},
	{entering = {-1305.427,-392.428,36.595}, inside = {-1305.427,-392.428,36.695}, outside = {-1305.427,-392.428,36.695},delay = 600},
	{entering = {-1119.1, 2696.92, 18.56}, inside = {-1119.1, 2696.92, 18.56}, outside = {-1119.1, 2696.92, 18.56},delay = 600},
	{entering = {2569.978,294.472,108.634}, inside = {2569.978,294.472,108.734}, outside = {2569.978,294.472,108.734},delay = 800},
	{entering = {-3172.584,1085.858,20.738}, inside = {-3172.584,1085.858,20.838}, outside = {-3172.584,1085.858,20.838},delay = 600},
	{entering = {20.0430,-1106.469,29.697}, inside = {20.0430,-1106.469,29.797}, outside = {20.0430,-1106.469,29.797},delay = 600},
}



local weashop_blips = {}

RegisterNetEvent("shop:isNearPed")
AddEventHandler("shop:isNearPed", function()
	local pedpos = GetEntityCoords(PlayerPedId())
	local found = false
	for k,v in ipairs(twentyfourseven_shops)do
		local dist = #(vector3(v.x, v.y, v.z) - vector3(pedpos.x,pedpos.y,pedpos.z))
		if(dist < 10 and not found)then
			found = true
			TriggerServerEvent("exploiter", "User sold to a shop keeper at store.")
		end
	end
end)

function setShopBlip()

	for station,pos in pairs(weashop_locations) do
		local loc = pos
		pos = pos.entering
		local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
		-- 60 58 137
		SetBlipSprite(blip,110)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 17)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Ammunation')
		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip,true)
		SetBlipAsMissionCreatorBlip(blip,true)
		weashop_blips[#weashop_blips+1]= {blip = blip, pos = loc}
	end

	for k,v in ipairs(tool_shops)do
		
		modelHash = GetHashKey("s_m_m_gaffer_01")
		RequestModel(modelHash)
		while not HasModelLoaded(modelHash) do
			 Wait(1)
		end
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 544)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 0)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Tool Shop")
		EndTextCommandSetBlipName(blip)

		created_ped = CreatePed(0, modelHash , v.x + 0.6 , v.y - 0.4 , v.z - 1,true)
		FreezeEntityPosition(created_ped, true)
		SetEntityHeading(created_ped,  v.r)
		SetEntityInvincible(created_ped, true)
		SetBlockingOfNonTemporaryEvents(created_ped, true)
		TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_AA_SMOKE", 0, true)

	end	

	-- PD SPAWN VEHICLES
	modelHash = GetHashKey("ig_benny")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		 Wait(1)
	end
	created_ped = CreatePed(0, modelHash , 443.56552124023, -973.99517822266, 24.7,true)
	FreezeEntityPosition(created_ped, true)
	SetEntityHeading(created_ped,  222.662109375)
	SetEntityInvincible(created_ped, true)
	SetBlockingOfNonTemporaryEvents(created_ped, true)
	TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_CLIPBOARD", 0, true)

	-- PD SPAWN HELI

	modelHash = GetHashKey("s_m_y_pilot_01")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
	 	Wait(1)
	end
	created_ped2 = CreatePed(0, modelHash , 444.77874755859, -976.54058837891, 42.7,true)
	FreezeEntityPosition(created_ped2, true)
	SetEntityHeading(created_ped2,  222.1897277832)
	SetEntityInvincible(created_ped2, true)
	SetBlockingOfNonTemporaryEvents(created_ped2, true)
	TaskStartScenarioInPlace(created_ped2, "WORLD_HUMAN_CLIPBOARD", 0, true)

	-- EMS SPAWN VEHICLES

	modelHash = GetHashKey("mp_f_bennymech_01")
	RequestModel(modelHash)
	
	while not HasModelLoaded(modelHash) do
	 	Wait(1)
	end
	created_ped4 = CreatePed(0, modelHash , 340.51556396484, -582.76434326172, 27.8,true)
	FreezeEntityPosition(created_ped4, true)
	SetEntityHeading(created_ped4,  79.914192199707)
	SetEntityInvincible(created_ped4, true)
	SetBlockingOfNonTemporaryEvents(created_ped4, true)
	TaskStartScenarioInPlace(created_ped4, "WORLD_HUMAN_CLIPBOARD", 0, true)

	-- EMS SPAWN HELI

	modelHash = GetHashKey("s_m_m_pilot_02")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
	 	Wait(1)
	end
	created_ped5 = CreatePed(0, modelHash , 337.53622436523, -586.513671875, 60.16,true)
	FreezeEntityPosition(created_ped3, true)
	SetEntityHeading(created_ped3,  254.57043457031)
	SetEntityInvincible(created_ped3, true)
	SetBlockingOfNonTemporaryEvents(created_ped3, true)
	TaskStartScenarioInPlace(created_ped3, "WORLD_HUMAN_CLIPBOARD", 0, true)

	-- Cutting Fish
	modelHash = GetHashKey("a_m_m_farmer_01")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		 Wait(1)
	end
	created_ped5 = CreatePed(0, modelHash , -3424.5080566406, 974.40179443359, 7.3466844558716,true)
	FreezeEntityPosition(created_ped5, true)
	SetEntityHeading(created_ped5,  88.371482849121)
	SetEntityInvincible(created_ped5, true)
	SetBlockingOfNonTemporaryEvents(created_ped5, true)
	TaskStartScenarioInPlace(created_ped5, "WORLD_HUMAN_CLIPBOARD", 0, true)

	-- Making Sushi
	modelHash = GetHashKey("a_m_y_beach_01")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		 Wait(1)
	end
	created_ped6 = CreatePed(0, modelHash , -3248.1052246094, 994.96502685547, 12.48 - 1,true)
	FreezeEntityPosition(created_ped6, true)
	SetEntityHeading(created_ped6, 182.60130310059)
	SetEntityInvincible(created_ped6, true)
	SetBlockingOfNonTemporaryEvents(created_ped6, true)
	TaskStartScenarioInPlace(created_ped6, "WORLD_HUMAN_SMOKING_POT", 0, true)

	modelHash = GetHashKey("a_m_m_beach_01")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		 Wait(1)
	end
	created_ped7 = CreatePed(0, modelHash , -1037.5577392578, -1397.0576171875, 4.5531911849976,true)
	FreezeEntityPosition(created_ped7, true)
	SetEntityHeading(created_ped7, 74.969627380371)
	SetEntityInvincible(created_ped7, true)
	SetBlockingOfNonTemporaryEvents(created_ped7, true)
	TaskStartScenarioInPlace(created_ped7, "WORLD_HUMAN_SMOKING_POT", 0, true)

	modelHash = GetHashKey("cs_lestercrest")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
	 	Wait(1)
	end
	ped = CreatePed(0, modelHash , 913.97, -1272.84, 27.1 - 1,true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetEntityHeading(ped, 125.9)
	SetBlockingOfNonTemporaryEvents(ped, true)
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, true)

	-- Hunting Selling
	modelHash = GetHashKey("s_m_y_factory_01")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
	 	Wait(1)
	end
	ped = CreatePed(0, modelHash , 961.89306640625, -2111.5822753906, 31.948415756226 - 1,true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetEntityHeading(ped, 81.99)
	SetBlockingOfNonTemporaryEvents(ped, true)
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, true)

	--Boat Rental
	modelHash = GetHashKey("mp_m_weed_01")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
	 	Wait(1)
	end
	ped = CreatePed(0, modelHash , -1612.7983398438, 5262.236328125, 3.9741015434265 - 1,true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetEntityHeading(ped, 205.71180725098)
	SetBlockingOfNonTemporaryEvents(ped, true)
	TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, true)
	
	-- Gang Boss Area
    modelHash = GetHashKey("s_m_m_bouncer_01")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
         Wait(1)
    end
    created_ped9 = CreatePed(0, modelHash , 115.22476196289, 170.9779510498, 111.45175933838,true)
    FreezeEntityPosition(created_ped9, true)
    SetEntityHeading(created_ped9,  139.38331604004)
    SetEntityInvincible(created_ped9, true)
    SetBlockingOfNonTemporaryEvents(created_ped9, true)
    TaskStartScenarioInPlace(created_ped9, "WORLD_HUMAN_CLIPBOARD", 0, true)

	-- Tow Women

	modelHash = GetHashKey("cs_jimmyboston")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
         Wait(1)
    end
    created_ped12 = CreatePed(0, modelHash , 409.0744934082, -1622.951171875, 28.292060852051,true)
    FreezeEntityPosition(created_ped12, true)
    SetEntityHeading(created_ped12,  207.47480773926)
    SetEntityInvincible(created_ped12, true)
    SetBlockingOfNonTemporaryEvents(created_ped12, true)
    TaskStartScenarioInPlace(created_ped12, "WORLD_HUMAN_AA_SMOKE", 0, true)

    -- Gang Task Boss
    modelHash = GetHashKey("g_m_m_armboss_01")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
         Wait(1)
    end
	RequestAnimDict("timetable@ron@ig_3_couch")
	SetPedFleeAttributes(created_ped9, 0, 0)
	while not HasAnimDictLoaded("timetable@ron@ig_3_couch") do
    Wait(0)
	end
    created_ped10 = CreatePed(0, modelHash , -1610.4289550781, -3011.4833984375, -76.205047607422,true)
    FreezeEntityPosition(created_ped10, true)
    SetEntityHeading(created_ped10,  179.60592651367)
    SetEntityInvincible(created_ped10, true)
    SetBlockingOfNonTemporaryEvents(created_ped10, true)
    TaskPlayAnim(created_ped10, "timetable@ron@ig_3_couch", "base", 1.0,-2.0, -1, 1, 1, true, true, true)

		-- Gang Boss Area
		modelHash = GetHashKey("s_m_m_bouncer_01")
		RequestModel(modelHash)
		while not HasModelLoaded(modelHash) do
			 Wait(1)
		end
		created_ped11 = CreatePed(0, modelHash , -1570.5743408203, -3017.6284179688, -75.406188964844,true)
		FreezeEntityPosition(created_ped11, true)
		SetEntityHeading(created_ped11,  315.01147460938)
		SetEntityInvincible(created_ped11, true)
		SetBlockingOfNonTemporaryEvents(created_ped11, true)
		TaskStartScenarioInPlace(created_ped11, "WORLD_HUMAN_CLIPBOARD", 0, true)

		
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('shop:general')
AddEventHandler('shop:general', function()
	TriggerEvent("server-inventory-open", "2", "Shop")
	Wait(1000)
end)

RegisterNetEvent('police:general')
AddEventHandler('police:general', function()
	TriggerEvent("server-inventory-open", "10", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('toolshop:general')
AddEventHandler('toolshop:general', function()
	TriggerEvent("server-inventory-open", "4", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('courthouse:idbuy')
AddEventHandler('courthouse:idbuy', function()
	TriggerEvent("player:receiveItem",'idcard', 1)
	Wait(1000)
end)

-------------------------------------
-------- Mechanic Shops Shit --------
-------------------------------------

RegisterNetEvent('mech:craft')
AddEventHandler('mech:craft', function()
	local job = exports["isPed"]:isPed("myJob")
	if job == "auto_bodies" or job == 'paleto_mech' or job == 'auto_exotics' or job == 'tuner_shop' or job == "best_buds" or job == "bean_machine" then
		TriggerEvent("server-inventory-open", "27", "Craft");	
		Wait(1000)
	else
		TriggerEvent("DoLongHudText", "You dont have access to this", 2)
	end
end)

RegisterNetEvent("open:storage")
AddEventHandler("open:storage", function(shop)
	local job = exports["isPed"]:isPed("myJob")
	if job == "auto_bodies" or job == 'paleto_mech' or job == 'auto_exotics' or job == 'tuner_shop' or job == "best_buds" or job == "bean_machine" or job == "burger_shot" then
		TriggerEvent("server-inventory-open", "1", job);
		Wait(1000)
	else
		TriggerEvent("DoLongHudText", "You dont have access to this", 2)
	end
end)

RegisterNetEvent("open:tray")
AddEventHandler("open:tray", function(shop)
	TriggerEvent("server-inventory-open", "1", shop);
	Wait(1000)
end)

-----------------------
-------- Shops --------
-----------------------

RegisterNetEvent('shops:food')
AddEventHandler('shops:food', function()
	TriggerEvent("server-inventory-open", "550", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('taco:craft')
AddEventHandler('taco:craft', function()
	TriggerEvent("server-inventory-open", "18", "Craft");	
	Wait(1000)
end)

RegisterNetEvent('shops:coffee')
AddEventHandler('shops:coffee', function()
	TriggerEvent("server-inventory-open", "549", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('shops:soda')
AddEventHandler('shops:soda', function()
	TriggerEvent("server-inventory-open", "548", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('shops:water')
AddEventHandler('shops:water', function()
	TriggerEvent("server-inventory-open", "551", "Shop");	
	Wait(1000)
end)

------------------------
------ Burgershot ------
------------------------

RegisterNetEvent('burgershot:craft')
AddEventHandler('burgershot:craft', function()
	TriggerEvent("server-inventory-open", "897", "Craft");	
	Wait(1000)
end)

RegisterNetEvent('burgershot:order')
AddEventHandler('burgershot:order', function()
	TriggerEvent("server-inventory-open", "654", "Shop");	
	Wait(1000)
end)


------------------------
------ Bean Machine ------
------------------------


RegisterNetEvent('bean:craft')
AddEventHandler('bean:craft', function()
	TriggerEvent("server-inventory-open", "1312", "Craft");	
	Wait(1000)
end)

RegisterNetEvent('bean:order')
AddEventHandler('bean:order', function()
	TriggerEvent("server-inventory-open", "1311", "Shop");	
	Wait(1000)
end)

-------------------------------
------ Police Department ------
-------------------------------

RegisterNetEvent('evidence:general')
AddEventHandler('evidence:general', function()
	local job = exports["isPed"]:isPed("myJob")
	if (job == "police") then
		TriggerEvent("server-inventory-open", "1", "trash-1")
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
		Wait(1000)
	end
end)

RegisterNetEvent('personallocker:general')
AddEventHandler('personallocker:general', function()
	local cid = exports["isPed"]:isPed("cid")
	local job = exports["isPed"]:isPed("myJob")
	if (job == "police") then
		TriggerEvent("server-inventory-open", "1", "personalMRPD-"..cid)
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
		Wait(1000)
	end
end)

RegisterNetEvent('pmeth:general')
AddEventHandler('pmeth:general', function()
	local finished = exports["srp-taskbar"]:taskBar(60000,"Searching...")
	if (finished == 100) then
		TriggerEvent("server-inventory-open", "25", "Shop")
		Wait(1000)
	end
end)

RegisterNetEvent('prisonap:general')
AddEventHandler('prisonap:general', function()
	local finished = exports["srp-taskbar"]:taskBar(60000,"Searching...")
	if (finished == 100) then
	  	TriggerEvent("server-inventory-open", "26", "Shop");
	  	Wait(1000)
  	end
end)


RegisterNetEvent('prisonlp:general')
AddEventHandler('prisonlp:general', function()
	local finished = exports["srp-taskbar"]:taskBar(60000,"Searching...")
	if (finished == 100) then
	  	TriggerEvent("server-inventory-open", "921", "Craft");
	  	Wait(1000)
  	end
end)

RegisterNetEvent('slushy:general')
AddEventHandler('slushy:general', function()
	local finished = exports["srp-taskbar"]:taskBar(60000,"Making a god slushy...")
	if (finished == 100) then
		TriggerEvent("server-inventory-open", "998", "Shop")
		Wait(1000)
	end
end)

-- RegisterNetEvent('lockpickshit:general')
-- AddEventHandler('lockpickshit:general', function()
-- 	local finished = exports["srp-taskbar"]:taskBar(60000,"What dis????")
-- 	if (finished == 100) then
-- 		TriggerEvent("server-inventory-open", "205", "Shop")
-- 		Wait(1000)
-- 	end
-- end)

RegisterNetEvent('pfood:general')
AddEventHandler('pfood:general', function()
	TriggerEvent("server-inventory-open", "22", "Shop")
	Wait(1000)
end)

RegisterNetEvent('bestbuds:shop')
AddEventHandler('bestbuds:shop', function()
	TriggerEvent("server-inventory-open", "99", "Shop")
	Wait(1000)
end)

RegisterNetEvent('pnpc:general')
AddEventHandler('pnpc:general', function()
	TriggerEvent("server-inventory-open", "997", "Craft")
	Wait(1000)
end)

RegisterNetEvent('recycle:trade')
AddEventHandler('recycle:trade', function()
	TriggerEvent("server-inventory-open", "103", "Craft")
	Wait(1000)
end)

RegisterNetEvent('ems:general')
AddEventHandler('ems:general', function()
	local job = exports["isPed"]:isPed("myJob")
	if (job == "ems" or job == "doctor") then
		TriggerEvent("server-inventory-open", "15", "Shop");	
	else
		TriggerEvent("DoLongHudText", "You aint a EMS, bounce out!", 2)
	end
end)

RegisterNetEvent('weapon:general')
AddEventHandler('weapon:general', function()
	local weaponslicence = exports["isPed"]:isPed("weaponslicence")
	if weaponslicence ~= 0 then
		TriggerEvent("server-inventory-open", "5", "Shop");
		Wait(1000)
	else
		TriggerEvent("server-inventory-open", "6", "Shop");
		Wait(1000)
		TriggerEvent("DoLongHudText", "You dont have an active firearms license, contact the police.", 2)
	end
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

Citizen.CreateThread(function()
	setShopBlip()
end)

-- Blips

local shops = {
    { 1961.1140136719, 3741.4494628906, 32.34375 },
	{ 1392.4129638672, 3604.47265625, 34.980926513672 },
	{ 546.98962402344, 2670.3176269531, 42.156539916992 },
	{ 2556.2534179688, 382.876953125, 108.62294769287 },
	{ -1821.9542236328, 792.40191650391, 138.13920593262 },
	{ -1223.6690673828, -906.67517089844, 12.326356887817 },
	{ -708.19256591797, -914.65264892578, 19.215591430664 },
	{ 26.419162750244, -1347.5804443359, 29.497024536133 },
	{ -47.64859, -1757.004, 29.421 },
	{ -707.394, -910.114, 19.2156 },
	{ 1162.87, -319.218, 69.2051 },
	{ 373.872, 331.028, 103.566 },
	{ 2552.47, 381.031, 108.623 },
	{ -1823.67, 796.291, 138.126 },
	{ 2673.91, 3281.77, 55.2411 },
	{ 1957.64, 3744.29, 32.3438 },
	{ 1701.97, 4921.81, 42.0637 },
	{ 1730.06, 6419.63, 35.0372 },
	{ 1842.973, 2570.243, 46.02 },
	{ 460.2752, -982.3342, 30.68969 },
	{ 5195.495, -5136.117, 3.349587 },
}

local showshops = true

RegisterNetEvent('shops:showshops')
AddEventHandler('shops:showshops', function()
    showshops = not showshops
   for _, item in pairs(shops) do
        if not showshops then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[3])
            SetBlipSprite(item.blip, 52)
            SetBlipScale(item.blip, 0.7)
			SetBlipColour(item.blip, 2)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Shop")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

Citizen.CreateThread(function()
    showshops = false
    TriggerEvent('shops:showshops')
end) 