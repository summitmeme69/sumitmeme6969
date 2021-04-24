local ongoing = false
local cooking = false

RegisterNetEvent("meth:start")
AddEventHandler("meth:start", function()
	local playerped = PlayerPedId()
	local plyCoords = GetEntityCoords(PlayerPedId())
	local distance = (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 1005.694152832, -3201.3181152344, -38.84700012207, false))		
	if exports["srp-inventory"]:hasEnoughOfItem("acetone",5,false) and exports["srp-inventory"]:hasEnoughOfItem("sudafed",2,false) and exports["srp-inventory"]:hasEnoughOfItem("antifreeze",3,false) and ongoing == false then
		TriggerEvent("animation:meth")
		FreezeEntityPosition(PlayerPedId(),true)
		SetEntityHeading(PlayerPedId(), 178.82402038574)
		local finished = exports["srp-taskbar"]:taskBar(10000,"Putting Materials Into The Cooker")
		if (finished == 100) then
			FreezeEntityPosition(PlayerPedId(),false)
			if math.random(1,30) == 18  then
				TriggerEvent("inventory:removeItem","acetone", 5)
				TriggerEvent("inventory:removeItem","sudafed", 2)
				TriggerEvent("inventory:removeItem","antifreeze", 3)
				TriggerEvent("DoLongHudText", "You Placed The Ingredients In Wrong!")
				TriggerEvent("srp-dispatch:methexplosion")
				DaBabyBoom()
			else
				TriggerEvent("inventory:removeItem","acetone", 5)
				TriggerEvent("inventory:removeItem","sudafed", 2)
				TriggerEvent("inventory:removeItem","antifreeze", 3)
				TriggerEvent("DoLongHudText", "You Successfully Turned On The Cooker, Wait 3 Minutes For Results.")
				ongoing = true
				cooking = true
				Citizen.Wait(180000)
				TriggerEvent("DoLongHudText", "I hear bubbling coming from the cooker, may wanna go check on it.")
				Citizen.Wait(5000)
				if cooking == true then
					TriggerEvent("DoLongHudText", "Finished!")
					TriggerEvent("player:receiveItem","meth", 1)
					ongoing = false
					cooking = false
				elseif cooking == false then
					TriggerEvent("DoLongHudText", "Failed!")
				end
			end
		end
	end
end)


RegisterNetEvent('animation:load')
AddEventHandler('animation:load', function(dict)
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end)

RegisterNetEvent('animation:meth')
AddEventHandler('animation:meth', function()
	inanimation = true
	local lPed = GetPlayerPed(-1)
	RequestAnimDict("mini@repair")
	while not HasAnimDictLoaded("mini@repair") do
		Citizen.Wait(0)
	end

	if IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
		ClearPedSecondaryTask(lPed)
	else
		TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 49, 0, 0, 0, 0)
		seccount = 4
		while seccount > 0 do
			Citizen.Wait(10000)
			FreezeEntityPosition(PlayerPedId(),false)
			seccount = seccount - 1
		end
		ClearPedSecondaryTask(lPed)
	end		
	inanimation = false
end)

RegisterNetEvent("meth:sell")
AddEventHandler("meth:sell", function()
	if exports["srp-inventory"]:hasEnoughOfItem("meth",1,false) then
		local finished = exports["srp-taskbar"]:taskBar(3000,"Handing Over Something")
		if (finished == 100) then
			TriggerEvent("inventory:removeItem","meth", 1)
			TriggerEvent("DoLongHudText", "Thanks Man, Heres a lil something for that.")
			Citizen.Wait(5000)
			TriggerServerEvent("meth:givemoney")
		end
	end
end)


function DaBabyBoom()
	local ped = PlayerPedId()
    local coords = vector3(1005.694152832, -3201.3181152344, -38.84700012207)
	local coords2 = vector3(1009.1714477539, -3198.2309570312, -39.580497741699)
	RequestWeaponAsset(GetHashKey("WEAPON_RPG")) 
    while not HasWeaponAssetLoaded(GetHashKey("WEAPON_RPG")) do
        Wait(0)
    end
	ShootSingleBulletBetweenCoords( 
		coords.x,
        coords.y,
        coords.z, 
	    coords.x,
        coords.y,
        coords.z,  
		500,
		true,
		GetHashKey("WEAPON_RPG"),
		ped,
		true,
		true,
		-1.0
    )
	ShootSingleBulletBetweenCoords( 
		coords2.x,
        coords2.y,
        coords2.z, 
	    coords2.x,
        coords2.y,
        coords2.z,  
		500,
		true,
		GetHashKey("WEAPON_RPG"),
		ped,
		true,
		true,
		-1.0
    )
	while true do 
		Citizen.Wait(5)
		StopFireInRange(coords.x,coords.y,coords.z, 300.0)
	end
end

RegisterNetEvent("stopcooking")
AddEventHandler("stopcooking", function()
	if cooking == true then
		TriggerEvent("DoLongHudText", "Failed, You Left The Meth Lab To Early!")
		cooking = false
		ongoing = false
	end
end)

Citizen.CreateThread(function()
	DaBabyDrugs()
end)

function DaBabyDrugs()
	local roll = math.random(4)
    if roll == 1 then
	modelHash = GetHashKey("s_m_y_dealer_01")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		 Wait(1)
	end
	created_ped5 = CreatePed(0, modelHash , 203.00288391113, -2016.6826171875, 17.5706615448,true)
	FreezeEntityPosition(created_ped5, true)
	SetEntityHeading(created_ped5,  260.40087890625)
	SetEntityInvincible(created_ped5, true)
	SetBlockingOfNonTemporaryEvents(created_ped5, true)
	TaskStartScenarioInPlace(created_ped5, "WORLD_HUMAN_SMOKING_POT", 0, true)
elseif roll == 2 then
	modelHash = GetHashKey("s_m_y_dealer_01")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		 Wait(1)
	end
	created_ped5 = CreatePed(0, modelHash , 225.73658752441, -1760.8559570312, 27.695140838623,true)
	FreezeEntityPosition(created_ped5, true)
	SetEntityHeading(created_ped5,  266.12237548828)
	SetEntityInvincible(created_ped5, true)
	SetBlockingOfNonTemporaryEvents(created_ped5, true)
	TaskStartScenarioInPlace(created_ped5, "WORLD_HUMAN_SMOKING_POT", 0, true)
elseif roll == 3 then
	modelHash = GetHashKey("s_m_y_dealer_01")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		 Wait(1)
	end
	created_ped5 = CreatePed(0, modelHash , -255.40719604492, -1542.0688476562, 30.936147689819,true)
	FreezeEntityPosition(created_ped5, true)
	SetEntityHeading(created_ped5,  180.49224853516)
	SetEntityInvincible(created_ped5, true)
	SetBlockingOfNonTemporaryEvents(created_ped5, true)
	TaskStartScenarioInPlace(created_ped5, "WORLD_HUMAN_SMOKING_POT", 0, true)
elseif roll == 4 then
	modelHash = GetHashKey("s_m_y_dealer_01")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		 Wait(1)
	end
	created_ped5 = CreatePed(0, modelHash , 1235.3387451172, -413.82913208008, 67.928161621094,true)
	FreezeEntityPosition(created_ped5, true)
	SetEntityHeading(created_ped5,  303.48379516602)
	SetEntityInvincible(created_ped5, true)
	SetBlockingOfNonTemporaryEvents(created_ped5, true)
	TaskStartScenarioInPlace(created_ped5, "WORLD_HUMAN_SMOKING_POT", 0, true)
end
end
