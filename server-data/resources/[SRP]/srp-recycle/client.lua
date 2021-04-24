local RecyclePoints = {
	{1015.4642333984,-3110.4521484375,-38.99991607666,["time"] = 0,["used"] = false},  
	{1011.2679443359,-3110.8725585938,-38.99991607666,["time"] = 0,["used"] = false},  
	{1005.8571777344,-3110.6271972656,-38.99991607666,["time"] = 0,["used"] = false},  
	{995.37841796875,-3108.6293945313,-38.99991607666,["time"] = 0,["used"] = false}, 
	{1003.0407104492,-3104.7854003906,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1008.2990112305,-3106.94140625,-38.999881744385,["time"] = 0,["used"] = false},  
	{1010.9890136719,-3104.5573730469,-38.999881744385,["time"] = 0,["used"] = false},  
	{1013.3607788086,-3106.8874511719,-38.999881744385,["time"] = 0,["used"] = false},  
	{1017.8317260742,-3104.5822753906,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1019.0430297852,-3098.9851074219,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1013.7381591797,-3100.9680175781,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1009.3251342773,-3098.8120117188,-38.999881744385,["time"] = 0,["used"] = false},  
	{1005.9111938477,-3100.9387207031,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1003.2393798828,-3093.9182128906,-38.999885559082,["time"] = 0,["used"] = false}, 
	{1008.0280151367,-3093.384765625,-38.999885559082,["time"] = 0,["used"] = false}, 
	{1010.8000488281,-3093.544921875,-38.999885559082,["time"] = 0,["used"] = false}, 
	{1016.1090087891,-3095.3405761719,-38.999885559082,["time"] = 0,["used"] = false},  
	{1018.2312011719,-3093.1293945313,-38.999885559082,["time"] = 0,["used"] = false},  
	{1025.1221923828,-3091.4680175781,-38.999885559082,["time"] = 0,["used"] = false}, 
	{1024.9321289063,-3096.4670410156,-38.999885559082,["time"] = 0,["used"] = false}, 
}

local dropPoints = {
	{1001.375,-3108.3840332031,-38.999900817871},
	{997.32006835938,-3099.3923339844,-38.999900817871},
	{1022.0564575195,-3095.892578125,-38.999855041504},
	{1022.1699829102,-3106.6181640625,-38.999855041504},
}

RegisterNetEvent('missionSystem:updatePoints')
AddEventHandler('missionSystem:updatePoints', function(result)
	RecyclePoints = result
end)
-----------------------------
-- Metal Harvest
-----------------------------
isRunningCrate = false

function runRecycle()
	isRunningCrate = true
	local isHolding = false

	TriggerEvent("attachItem","crate01")
    RequestAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(GetPlayerPed(-1),"anim@heists@box_carry@","idle",2.0, -8, 180, 49, 0, 0, 0, 0)
    Wait(1000)
    TaskPlayAnim(GetPlayerPed(-1),"anim@heists@box_carry@","idle",2.0, -8, 180000000, 49, 0, 0, 0, 0)
	TriggerEvent("animation:disable", true)
	TriggerEvent("AnimSet:default")
    isHolding = true
    local rnd = math.random(1,4)

    while isHolding do
    	Wait(0)
    	if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),dropPoints[rnd][1],dropPoints[rnd][2],dropPoints[rnd][3], true) <= 40 then
    		DrawText3Ds(dropPoints[rnd][1],dropPoints[rnd][2],dropPoints[rnd][3], "[E] Drop Material")
    		if IsControlJustPressed(1, 38) and IsPedInAnyVehicle(GetPlayerPed(-1), false) ~= 1 then
	    		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),dropPoints[rnd][1],dropPoints[rnd][2],dropPoints[rnd][3], true) <= 3 then
	    			isHolding = false
	    		end
			end
			if IsPedRunning(PlayerPedId()) then
				SetPedToRagdoll(PlayerPedId(),2000,2000, 3, 0, 0, 0)
				Wait(2100)
				TaskPlayAnim(GetPlayerPed(-1),"anim@heists@box_carry@","idle",2.0, -8, 180000000, 49, 0, 0, 0, 0)
			end
    	end
    end

    ClearPedTasks(GetPlayerPed(-1))
    TriggerEvent("destroyProp")
    FreezeEntityPosition(GetPlayerPed(-1),true)
    RequestAnimDict("mp_car_bomb")
    TaskPlayAnim(GetPlayerPed(-1),"mp_car_bomb","car_bomb_mechanic",2.0, -8, 180,49, 0, 0, 0, 0)
    Wait(100)
    TaskPlayAnim(GetPlayerPed(-1),"mp_car_bomb","car_bomb_mechanic",2.0, -8, 1800000,49, 0, 0, 0, 0)
    Wait(3000)
    ClearPedTasks(GetPlayerPed(-1))
    FreezeEntityPosition(GetPlayerPed(-1),false)

    if math.random(1,5) == 2 then
    	TriggerEvent('player:receiveItem',"recyclablematerial", math.random(1,3))
    else
    	TriggerEvent('player:receiveItem',"recyclablematerial", 1)
	end

	TriggerEvent("DoLongHudText","Nice work, keep it up!")
	TriggerEvent("animation:disable", false)
    isRunningCrate = false
--	end
end



isTrading = false
isFishing = false



Citizen.CreateThread(function()

	while true do
		Wait(5)
		local PlayerPos = GetEntityCoords(PlayerPedId())
		
		for k,v in pairs(RecyclePoints) do
			if GetDistanceBetweenCoords(PlayerPos, v[1],v[2],v[3], true) <= 3 and not v.used and not isRunningCrate then
				DrawText3Ds(v[1],v[2],v[3], "Material, Pickup with E")
			end
		end
		
		if IsControlJustPressed(1, 38) and IsPedInAnyVehicle(GetPlayerPed(-1), false) ~= 1 then
			for k,v in pairs(RecyclePoints) do
				if GetDistanceBetweenCoords(PlayerPos, v[1],v[2],v[3], true) <= 2 then
					if not v.used and not isRunningCrate then
						v.used = true
						TriggerServerEvent('missionSystem:UpdateClients',RecyclePoints,k)
						runRecycle()
					end
				end
			end
			
			Wait(2500)

		end

	end

end)



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


