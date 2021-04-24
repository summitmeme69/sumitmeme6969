local open = false

RegisterNetEvent('blindfold')
AddEventHandler('blindfold', function(t,src)
	if not open then
		AddHeadObject()
		open = true
		SendNUIMessage({
			action = "open"
		})
	end
end)

RegisterNetEvent('blindfoldoff')
AddEventHandler('blindfoldoff', function(t,src)
if open then
	RemoveHeadObject()
	open = false
	SendNUIMessage({
		action = "close"
	})
end
end)

RegisterNetEvent("blindfolddst",function(t,src)
	t, distance, ped = GetClosestPlayer()
	Citizen.Wait(1500)
	if(distance ~= -1 and #(GetEntityCoords(ped) - GetEntityCoords(PlayerPedId())) < 2.5 and GetEntitySpeed(ped) < 1.0) then
	TriggerServerEvent("blindfold", GetPlayerServerId(t), src)
	TriggerEvent("inventory:removeItem","bag", 1)
	TriggerEvent("DoLongHudText", "Bagged!")
	TriggerEvent("bagged")
	else
		TriggerEvent("DoLongHudText", "No one nearby")
end
end)

RegisterNetEvent("blindfolddstoff",function(t,src)
	t, distance, ped = GetClosestPlayer()
	Citizen.Wait(1500)
	if(distance ~= -1 and #(GetEntityCoords(ped) - GetEntityCoords(PlayerPedId())) < 2.5 and GetEntitySpeed(ped) < 1.0) then
	TriggerServerEvent("blindfoldoff", GetPlayerServerId(t), src)
	TriggerEvent("DoLongHudText", "Removed Bag!")
	else
		TriggerEvent("DoLongHudText", "No one nearby")
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

function AddHeadObject()
	local ped = PlayerPedId()
	local model = `prop_money_bag_01`
  
	if not IsModelValid(model) then
	  print("INVALID PROP")
	  return
	end
  
	RequestModel(model)
  
	while not HasModelLoaded(model) do
	  Wait(0)
	end
  
	local coords = GetEntityCoords(ped)
  
	headobject = CreateObjectNoOffset(model, coords, true, false, false)
  
	while not DoesEntityExist(headobject) do
	  Wait(0)
	end
  
	SetModelAsNoLongerNeeded(model)
  
	boneid = GetPedBoneIndex(ped, 12844)
  
	AttachEntityToEntity(headobject, ped, boneid, 0.2, 0.031, 0.004, 0.1, 270.0, 0.0, 0, 0, 0, 1, 0, 1)
  
	--  SetFollowPedCamViewMode(4)
  
	Citizen.CreateThread(function ()
	--    SetFollowPedCamViewMode(4)
		while open do
		  SetEntityLocallyInvisible(headobject)
		  DisableControlAction(0, 0, true)
		  Citizen.Wait(0)
		end
	end)
  end
  
  function RemoveHeadObject()
	DeleteObject(headobject)
  end
  
  AddEventHandler('onResourceStop', function (resource)
	if resource == GetCurrentResourceName() then
	  RemoveHeadObject()
	end
  end)