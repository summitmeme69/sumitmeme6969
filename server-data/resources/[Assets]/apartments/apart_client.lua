local displayApartBlips = true

local interiors = {

-- apartments


}
local clothingcoords = {x = 0, y = 0, z = 0, h = 0}
local storagecoords = {x = 0, y = 0, z = 0, h = 0}
local garagescoords = {x = 0, y = 0, z = 0, h = 0}
local insidehouse = false
local rentedOffices = {}
local curHouseCoords = { ['x'] = 0.22,['y'] = 0.67,['z'] = 0.79,['h'] = 0.41, ['info'] = ' default ' }
local apartmentCraft = {
    [4] = {-273.47332763672,-949.95874023438,92.519622802734},
    [5] = {-12.486763000488,-598.58776855469,79.430191040039},
    [6] = {-27.672889709473,-587.68591308594,90.12353515625},
    [7] = {-467.10076904297,-699.30908203125,77.095626831055},
    [8] = {-795.51818847656,328.05123901367,217.03817749023},
    [9] = {0,0,0},
    [10] = {0,0,0},
    [11] = {0,0,0},
    [12] = {0,0,0},
    [13] = {120.0290222168,566.74981689453,176.6971282959},
    [14] = {378.38751220703,429.40719604492,138.30012512207},
    [15] = {-175.73382568359,492.81289672852,130.04368591309},
    [16] = {337.07977294922,438.06484985352,141.77076721191},
    [17] = {0,0,0},
    [18] = {-622.29577636719,55.076812744141,97.599594116211},
    [19] = {-772.45220947266,326.41375732422,176.81233215332},
    [20] = {-1558.6561279297,-570.78936767578,108.52295684814},
    [21] = {-1466.4221191406,-526.12689208984,73.443634033203},
    [22] = {-1466.6994628906,-526.49060058594,73.443634033203},
    [23] = {-1457.9486083984,-531.32458496094,69.565284729004},
    [24] = {-1458.0120849609,-530.94244384766,69.565284729004},
    [25] = {-1458.1560058594,-531.05981445313,56.937641143799},
    [26] = {-1458.2700195313,-531.740234375,56.937641143799},
    [27] = {-928.00549316406,-376.24533081055,113.6741104126},
    [28] = {0,0,0},
    [29] = {-915.87677001953,-376.46038818359,109.44897460938},
    [30] = {-913.70495605469,-374.43060302734,85.489166259766},
    [31] = {-898.92443847656,-449.21166992188,126.54309844971},
    [32] = {-895.00018310547,-443.83084106445,95.469779968262},
    [33] = {0,0,0},
    [34] = {0,0,0},
    [35] = {0,0,0},
    [36] = {0,0,0},
    [37] = {0,0,0},
    [38] = {-795.90240478516,327.22695922852,217.03819274902},
    [39] = {-126.52939605713,-636.41564941406,168.82038879395},
    [40] = {-82.335220336914,-806.50543212891,243.38583374023},
    [41] = {-1377.6461181641,-464.69641113281,72.042137145996},
    [42] = {0,0,0},
    [43] = {0,0,0},
    [44] = {0,0,0}
}

RegisterNetEvent('GPSLocations')
AddEventHandler('GPSLocations', function()
	if GPSblip ~= nil then
		RemoveBlip(GPSblip)
		GPSblip = nil
	end	
	TriggerEvent("DoLongHudText","GPS has been deactivated, please select your route!")
	TriggerEvent("GPSActivated",false)
	TriggerEvent("openGPS",robberycoordsMansions,robberycoords,rentedOffices)
end)

local house_poi = { 
	["info"] = "No House Selected", 
	["house_id"] = 0, 
	["house_model"] = 0,
	["garages"] = {}, 
	["creationpoints"] = {},
	["backdoorinside"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0  },
	["backdooroutside"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0  },
	["clothing"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0  },
	["storage"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0  },
}

RegisterNetEvent('GPS:SetRoute')
AddEventHandler('GPS:SetRoute', function(house_id,house_model)
	
	local house_id = tonumber(house_id)
	local house_model = tonumber(house_model)

	if house_model == 1 then
		mygps = robberycoords[house_id]
		
	elseif house_model == 2 then
		
		mygps = robberycoordsMansions[house_id]
	elseif house_model == 3 then
		
		mygps = rentedOffices[house_id]["location"]
		mygps["info"] = rentedOffices[house_id]["name"]
	else
		mygps = customGPSlocations[house_id]
	end
	if GPSblip ~= nil then
		RemoveBlip(GPSblip)
	end
	GPSblip = AddBlipForCoord(mygps["x"],mygps["y"],mygps["z"])
	TriggerEvent("GPSActivated",true)
	SetBlipRoute(GPSblip, 1)
	SetBlipAsFriendly(GPSblip, 1)
	SetBlipColour(GPSblip, 6)
	TriggerEvent("DoLongHudText","Your GPS location has been set to " .. mygps["info"] .. "!")

end)

--hospitals/police station/bank is held by the mayor

local lang = 'en' 
local txt = {
  ['fr'] = {
        ['fermermenu'] = 'Fermer le menu',
        ['sonner'] = 'Sonner a la porte',
        ['gohome'] = 'Rentrer chez moi',
        ['vendre'] = 'Revendre l\'appartement',
        ['acheter'] = 'Acheter l\'appartement',
        ['visiter'] = 'Visiter l\'appartement',
        ['menu'] = 'Appuyez sur ~g~E~s~ pour ouvrir le menu',
        ['soon'] = 'Cette fonctionnalite arrivera bientot'
  },

    ['en'] = {
        ['fermermenu'] = 'Close menu',
        ['sonner'] = 'Ring the doorbell',
        ['gohome'] = 'Go to home',
        ['vendre'] = 'Sell apartment',
        ['acheter'] = 'Buy apartment',
        ['visiter'] = 'Visit the apartment',
        ['visiterC'] = 'Enter as Police',
        ['visiter2'] = 'Enter unlocked house.',
        ['lock'] = 'Lock the apartment',
        ['unlock'] = 'Unlock the apartment',
        ['menu'] = 'Press ~g~E~s~ to open property menu',
        ['soon'] = 'This functionality will come soon'
    }
}

local entrer = false
local isBuy = 0
local lockStatus = 1
 
distance = 50.5999 -- distance to draw
timer = 0
current_int = 0
 
RegisterNetEvent("update:bank")
AddEventHandler("update:bank", function(ownercid,amount,newBal)
  local cid = exports["isPed"]:isPed("cid")
  local cid = tonumber(cid)
  local ownercid = tonumber(ownercid)
  if cid == ownercid then
    TriggerEvent("DoLongHudText","A contract was just paid to your bank in the amount of $" .. amount)
    TriggerEvent("banking:updateBalance", newBal, false)
  end
end)

RegisterNetEvent("apart:lockStatus")
AddEventHandler("apart:lockStatus", function(lockUpdateStatus)
  lockStatus = lockUpdateStatus
end)

RegisterNetEvent("apart:rentOverdue")
AddEventHandler("apart:rentOverdue", function()
  isBuy = 3
end)

RegisterNetEvent("apart:isBuy")
AddEventHandler("apart:isBuy", function()
  isBuy = 1
end)
 
RegisterNetEvent("apart:isNotBuy")
AddEventHandler("apart:isNotBuy", function()
  isBuy = 0
end)

RegisterNetEvent("apart:isMine")
AddEventHandler("apart:isMine", function()
  isBuy = 2
end)

RegisterNetEvent("apart:isFriend")
AddEventHandler("apart:isFriend", function()
  isBuy = 4
end)

function GetHouseInformation()
	local house_model = 0
	local house_id = 0
	local housefound = false
	local houseinfo = { [1] = house_id, [2] = house_model }
	for i=1,#robberycoords do
		if (#(vector3(robberycoords[i]["x"],robberycoords[i]["y"],robberycoords[i]["z"]) - GetEntityCoords(PlayerPedId())) < 1.2 ) then
			house_id = i

			if robberycoords[i]["trailer"] ~= nil
			then
				house_model = 5
			else
				house_model = 1
			end
			housefound = true
			curHouseCoords = robberycoords[i]

		end
	end

	if house_id == 0 then

		for i=1,#robberycoordsMansions do
			if (#(vector3(robberycoordsMansions[i]["x"],robberycoordsMansions[i]["y"],robberycoordsMansions[i]["z"]) - GetEntityCoords(PlayerPedId())) < 1.1 ) then
				house_id = i
				house_model = 2
				housefound = true
				curHouseCoords = robberycoordsMansions[i]
			end
		end
	end

	if house_id == 0 then

		for i=1,#rentedOffices do
			if (#(vector3(rentedOffices[i]["location"]["x"],rentedOffices[i]["location"]["y"],rentedOffices[i]["location"]["z"]) - GetEntityCoords(PlayerPedId())) < 1.1 ) then
				house_id = rentedOffices[i]["house_id"]
				house_model = rentedOffices[i]["house_model"]
				housefound = true

				curHouseCoords = rentedOffices[i]["location"]
			end
		end

	end

	if housefound then
		houseinfo = { [1] = house_id, [2] = house_model }
		return houseinfo
	else
		TriggerEvent("DoLongHudText","No house found!",2)
	end
end


function GetHouseInformation2()
	local house_model = 0
	local house_id = 0
	local housefound = false
	local houseinfo = { [1] = house_id, [2] = house_model }
	for i=1,#robberycoords do
		if (#(vector3(robberycoords[i]["x"],robberycoords[i]["y"],robberycoords[i]["z"]) - GetEntityCoords(PlayerPedId())) < 10) then
			house_id = i

			if robberycoords[i]["trailer"] ~= nil
			then
				house_model = 5
			else
				house_model = 1
			end
			housefound = true
			curHouseCoords = robberycoords[i]

		end
	end

	if house_id == 0 then

		for i=1,#robberycoordsMansions do
			if (#(vector3(robberycoordsMansions[i]["x"],robberycoordsMansions[i]["y"],robberycoordsMansions[i]["z"]) - GetEntityCoords(PlayerPedId())) < 10) then
				house_id = i
				house_model = 2
				housefound = true
			
				curHouseCoords = robberycoordsMansions[i]
			end
		end
	end


	if housefound then
		houseinfo = { [1] = house_id, [2] = house_model }
		return houseinfo
	end
end

local startingGarages = {}
RegisterNetEvent('house:spawnpoints')
AddEventHandler('house:spawnpoints', function(spawns)
	if spawns["info"] ~= nil then

		modifyingTable = spawns
		startingGarages = modifyingTable["garages"]
	end
	TriggerEvent("DoLongHudText","Loaded.",91)
end)


local garageswiped = false
modifyingTable = { 
	["info"] = "No House Selected", 
	["house_id"] = 0, 
	["house_model"] = 0,
	["garages"] = {}, 
	["creationpoints"] = {},
	["backdoorinside"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0  },
	["backdooroutside"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0  },
	["clothing"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0  },
	["storage"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0  },
}
function resetModifyingTable()
	modifyingTable["garages"] = {}
	modifyingTable["creationpoints"] = {}
	modifyingTable["backdoorinside"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0  }
	modifyingTable["backdooroutside"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0  }
	modifyingTable["clothing"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0  }
	modifyingTable["storage"] = { ["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0  }
end

RegisterNetEvent("openFurniture")
AddEventHandler("openFurniture", function()
	if entryType == 2 then
		if mansion or mansion2 or office or mansion3 then
			TriggerServerEvent("CheckFurniture",myhouseid, 2)
		elseif trailer then
			TriggerServerEvent("CheckFurniture",myhouseid,5)
		else
			TriggerServerEvent("CheckFurniture",myhouseid,1)
		end
	end
end)

modifying = false
RegisterNetEvent('housing:info:realtor')
AddEventHandler('housing:info:realtor', function(args)
	if modifying then
		if args == "reset" then
			resetModifyingTable()
			TriggerEvent("DoLongHudText","Your house editing has been reset but has not saved!",91)
			return
		end

		if args == "stop" then
			modifying = false
			resetModifyingTable()
			TriggerEvent("DoLongHudText","You have stopped!",91)
			return
		end

		if args == "creationpoint" then
			local coords = GetEntityCoords(PlayerPedId())
			local heading = GetEntityHeading(PlayerPedId())
			modifyingTable["creationpoints"][#modifyingTable["creationpoints"] + 1] = { ["x"] = coords["x"], ["y"] = coords["y"], ["z"] = coords["z"], ["h"] = heading }
			TriggerEvent("DoLongHudText","A new creation point has been set, there is " .. #modifyingTable["creationpoints"] .. " in total!",91)
			return
		end

		if args == "setclothing" then
			local coords = GetEntityCoords(PlayerPedId())
			local heading = GetEntityHeading(PlayerPedId())
			modifyingTable["clothing"] = { ["x"] = coords["x"], ["y"] = coords["y"], ["z"] = coords["z"], ["h"] = heading }
			TriggerEvent("DoLongHudText","A new clothing area has been set, there is 1 in total!",91)
			return
		end

		if args == "setstorage" then
			local coords = GetEntityCoords(PlayerPedId())
			local heading = GetEntityHeading(PlayerPedId())
			modifyingTable["storage"] = { ["x"] = coords["x"], ["y"] = coords["y"], ["z"] = coords["z"], ["h"] = heading }
			TriggerEvent("DoLongHudText","A new storage area has been set, there is 1 in total!",91)
			return
		end

		if args == "setgarage" then
			local houseinfo = GetHouseInformation()
			local coords = GetEntityCoords(PlayerPedId())
			local heading = GetEntityHeading(PlayerPedId())
			modifyingTable["garages"] = { ["x"] = coords["x"], ["y"] = coords["y"], ["z"] = coords["z"], ["h"] = heading }
			TriggerEvent("DoLongHudText","A new garage has been set!",91)
			TriggerServerEvent("housing:garagesSET", modifyingTable["garages"], modifyingTable["house_id"])
			return
		end

		if args == "wipegarages" then
			local coords = GetEntityCoords(PlayerPedId())
			local heading = GetEntityHeading(PlayerPedId())
			modifyingTable["garages"] = {}
			TriggerEvent("DoLongHudText","Garages for " .. modifyingTable["info"] .. " have been wiped!",91)
			TriggerServerEvent("housing:garagesSET", modifyingTable["garages"], modifyingTable["house_id"])
			garageswiped = true
			return
		end

		if args == "backdoorinside" then
			local coords = GetEntityCoords(PlayerPedId())
			local heading = GetEntityHeading(PlayerPedId())
			modifyingTable["backdoorinside"] = { ["x"] = coords["x"], ["y"] = coords["y"], ["z"] = coords["z"], ["h"] = heading }
			TriggerEvent("DoLongHudText","Door Set",91)
			return
		end

		if args == "backdooroutside" then
			local coords = GetEntityCoords(PlayerPedId())
			local heading = GetEntityHeading(PlayerPedId())
			modifyingTable["backdooroutside"] = { ["x"] = coords["x"], ["y"] = coords["y"], ["z"] = coords["z"], ["h"] = heading }
			TriggerEvent("DoLongHudText","Door Set",91)
			return
		end

		if args == "update" then
			TriggerServerEvent("house:updatespawns",modifyingTable, modifyingTable["house_id"])
			return
		end

	end

	local houseinfo = GetHouseInformation()
	if houseinfo == nil then
		return
	end	


	if args == "unlock" and modifying then

		TriggerServerEvent("housing:unlockRE",houseinfo[1],houseinfo[2])
		return
	end

	if args == "unlock2" then
		TriggerServerEvent("housing:unlock",houseinfo[1],houseinfo[2])
	end

	if args == "PropertyOutstanding" then
		TriggerServerEvent("house:PropertyOutstanding",houseinfo[1],houseinfo[2])
	end



	if args == "unlock" then
		TriggerServerEvent("housing:unlock",houseinfo[1],houseinfo[2])
	elseif args == "modify" then
		
		if modifying then
			TriggerEvent("DoLongHudText",modifyingTable["info"] .. " is already being modified.",91)
		else
			garageswiped = false
			local house_model = houseinfo[2]
			local house_id = houseinfo[1]
			local house_name = robberycoords[house_id]["info"]
			if house_model == 2 then
				house_name = robberycoordsMansions[house_id]["info"]
			end	


			modifyingTable["info"] = house_name
			modifyingTable["house_model"] = house_model
			modifyingTable["house_id"] = house_id
			modifying = true
			TriggerServerEvent("housing:requestSpawnTable",modifyingTable, house_id, modifyingTable["info"])
			TriggerEvent("DoLongHudText",house_name .. " is loading.",95)

		end

	end

end)



RegisterNetEvent("UpdateCurrentHouseSpawns")
AddEventHandler("UpdateCurrentHouseSpawns", function(id, data)
	local id = tonumber(id)
	house_poi = json.decode(data)
end)

RegisterNetEvent('housing:transferHouseAttempt')
AddEventHandler('housing:transferHouseAttempt', function(cid)
	if cid ~= nil then
		if modifying then
			TriggerServerEvent("house:transferHouse",modifyingTable["house_id"],modifyingTable["house_model"],cid)
		else
			TriggerEvent("DoLongHudText","You must have a house in modify mode to transfer it!",91)
		end
	end
end)

RegisterNetEvent('housing:evictHouseAttempt')
AddEventHandler('housing:evictHouseAttempt', function()
	if modifying then
		TriggerServerEvent("house:evictHouse",modifyingTable["house_id"],modifyingTable["house_model"],exports["isPed"]:isPed("cid"))
	else
		TriggerEvent("DoLongHudText","You must have a house in modify mode to evict the residents!",91)
	end
end)


RegisterNetEvent("sendGarges")
AddEventHandler("sendGarges", function(garges, id, name)
	local shit = json.encode(garges)
	TriggerEvent('house:garagelocations', shit, id, name)
end)


markerColor = 
{
	["Red"] = 222,
	["Green"] = 50,
	["Blue"] = 50
}

outsidehouse = false

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1)
-- 		local plyId = PlayerPedId()
-- 		local plyCoords = GetEntityCoords(plyId)
-- 		local backdooroutside = house_poi["backdooroutside"]
-- 		local backdoorinside = house_poi["backdoorinside"]
-- 		local clothing = house_poi["clothing"]
-- 		local storage = house_poi["storage"]
-- 		if backdooroutside["x"] ~= 0.0 and outsidehouse then
-- 			if #(vector3(backdooroutside["x"],backdooroutside["y"],backdooroutside["z"]-0.3) - plyCoords) < 3.0 then
-- 				DrawMarker(20,backdooroutside["x"],backdooroutside["y"],backdooroutside["z"]-0.3,0,0,0,0,0,0,0.701,1.0001,0.3001,markerColor.Red,markerColor.Green, markerColor.Blue,11,0,0,0,0)
-- 			end
-- 			if #(vector3(backdooroutside["x"],backdooroutside["y"],backdooroutside["z"]-0.3) - plyCoords) < 1.5 then
-- 				DrawText3Ds(backdooroutside["x"],backdooroutside["y"],backdooroutside["z"] , '~g~E~s~ to enter house.')
-- 				if IsControlJustReleased(2, 38) then
-- 					TriggerServerEvent("house:enterhousebackdoor", house_poi["house_id"], house_poi["house_model"], backdoorinside["x"],backdoorinside["y"],backdoorinside["z"])
-- 					Citizen.Wait(3000)
-- 				end
-- 			end	
-- 		end
		
-- 		if backdoorinside["x"] ~= 0.0 and insidehouse then
-- 			if #(vector3(backdoorinside["x"],backdoorinside["y"],backdoorinside["z"]-0.3) - plyCoords) < 3.0 then
-- 				DrawMarker(20,backdoorinside["x"],backdoorinside["y"],backdoorinside["z"]-0.3,0,0,0,0,0,0,0.701,1.0001,0.3001,markerColor.Red,markerColor.Green, markerColor.Blue,11,0,0,0,0)
-- 			end
-- 			if #(vector3(backdoorinside["x"],backdoorinside["y"],backdoorinside["z"]-0.3) - plyCoords) < 1.5 then
-- 				DrawText3Ds( backdoorinside["x"],backdoorinside["y"],backdoorinside["z"] , '~g~E~s~ to leave house.')
-- 				if IsControlJustReleased(2, 38) then
-- 					outsidehouse = true
-- 					insidehouse = false
-- 					TriggerEvent("housing:exit:backdoor",backdooroutside["x"],backdooroutside["y"],backdooroutside["z"],backdooroutside["h"])
-- 					Citizen.Wait(3000)
-- 				end
-- 			end	
-- 		end
-- 		if clothing["x"] ~= 0.0 and insidehouse then
-- 			if #(vector3(clothing["x"],clothing["y"],clothing["z"]-0.3) - plyCoords) < 1.5 then
-- 				DrawText3Ds( clothing["x"],clothing["y"],clothing["z"] , '/outfits to change clothing' )
-- 				TriggerEvent("srp-clothing:enable", true)
-- 			else
-- 				TriggerEvent("srp-clothing:enable", false)
-- 			end
-- 		end

-- 		if storage["x"] ~= 0.0 and insidehouse then
-- 			if #(vector3(storage["x"],storage["y"],storage["z"]-0.3) - plyCoords) < 1.5 then
-- 				DrawText3Ds( storage["x"],storage["y"],storage["z"] , 'Press ~g~E~s~ to open your stash.')
-- 				if IsControlJustReleased(2, 38) then
-- 					TriggerEvent("server-inventory-open", "1", "house-"..house_poi["info"])

-- 				end
-- 			end
-- 		end	
			
		
-- 	end
-- end)

RegisterNetEvent('housing:exit:backdoor')
AddEventHandler('housing:exit:backdoor', function(x,y,z,h)
	DeleteSpawnedHouse(0,false)
	SetEntityCoords(PlayerPedId(),x,y,z)
	SetEntityHeading(PlayerPedId(),h)
	TriggerEvent("inhouse",false)
	myhouseid = 0
	myhousetype = 0
	entryType = 0
end)



local buying = 0
local buy = false

--fix upgrading
RegisterNetEvent('housing:findsalecid')
AddEventHandler('housing:findsalecid', function(checkcid,price,house_id,house_model,storage,clothing,garages)
	-- name is only passed on rented offices / small shops.
	if buying > 0 then
		return
	end

	local cid = exports["isPed"]:isPed("cid")
	local upfront = math.ceil(price * 0.5)

	if tonumber(cid) ~= tonumber(checkcid) then
		return
	end

	buying = 30000
	buy = false

	local housename = "Error"

	housename = robberycoords[house_id]["info"]
	if house_model == 2 then
		housename = robberycoordsMansions[house_id]["info"]
	end
	
	local weekly = upfront/20
	local weeklyafter = upfront/50

	TriggerEvent("DoLongHudText", "The downpayment is $" .. upfront .. " , if you would like to cancel this dont do /confirm", 1)
	Citizen.Wait(5000)

		
	while buying > 0 do
		TriggerEvent("DoLongHudText","Your Agreement is a lease-purchase with the Real Estate Company.  Half of total purchase price as down payment must be made upon closing with 5 percent of remaining balance paid per week for a total of 14 weeks. If the client causes any harm to any employee of the Real Estate Company or does not make proper payment for 7 days, this agreement is revoked, and property surrendered.  This clause will be in perpetuity of the leaseholder’s occupation of the property. Type /confirm to confirm.", 91)
		Citizen.Wait(5000)
		buying = buying - 1

	end

	if buy then
		TriggerEvent("DoLongHudText","Attempting purchase - please wait.",91)
			TriggerServerEvent("house:purchasehouse",tonumber(checkcid),house_id,house_model,upfront,price,housename,storage,clothing,garages,false)
	end

end)

RegisterNetEvent('housing:attemptpay')
AddEventHandler('housing:attemptpay', function()
local houseinfo = GetHouseInformation()
if houseinfo == nil then
	TriggerEvent("DoLongHudText","No house found!",2)
	return
end

local house_model = houseinfo[2]
local house_id = houseinfo[1]
local house_name = ""

if house_model == 1 then
	house_name = robberycoords[house_id]["info"]
end

if house_model == 2 then
	house_name = robberycoordsMansions[house_id]["info"]
end

if house_model == 3 then
	house_name = rentedOffices[tonumber(house_id)]["name"]
end



TriggerServerEvent("house:dopayment", house_id, house_model)
TriggerEvent("DoLongHudText","Attempting to pay Mortgage for " .. house_name, 1)

end)

local housenameraid = "none"
RegisterNetEvent('housing:enter')
AddEventHandler('housing:enter', function()
	housenameraid = "none"
	local houseinfo = GetHouseInformation()
	if houseinfo == nil then
		return
	end

	local house_model = houseinfo[2]
	local house_id = houseinfo[1]

	local house_name = ""

	if house_model == 1 then
		house_name = robberycoords[house_id]["info"]
	elseif house_model == 2 then
		house_name = robberycoordsMansions[house_id]["info"]
	elseif house_model == 3 then
		house_name = rentedOffices[tonumber(house_id)]["name"]
	elseif house_model == 4 then
		house_name = rentedOffices[tonumber(house_id)]["name"]
	elseif house_model == 5 then -- Trailers
		house_name = robberycoords[tonumber(house_id)]["info"]
	end	

	
	local myJob = exports["isPed"]:isPed("job")
	local LEO = false
	local RealEstate = false
	
	if myJob == "Police" or myJob == "Judge" then
		LEO = true
	end
	if myJob == "RealEstate" then
		RealEstate = true
	end

	if modifying or LEO then
		TriggerServerEvent("house:enterhouse",exports['isPed']:isPed('cid'), house_id,house_model,true)
		housenameraid = house_name
	else
		TriggerServerEvent("house:enterhouse",exports['isPed']:isPed('cid'), house_id,house_model,false)
		housenameraid = "none"
	end
	TriggerServerEvent("housing:getGarage", house_id, house_model)
end)


RegisterNetEvent("house:entersuccess")
AddEventHandler("house:entersuccess", function(house_id,house_model,furniture, x,y,z)
	local backdoorcoords = x,y,z
	myhouseid = house_id
	myhousetype = house_model
	entryType = 2
	mansion = false
	rentedOffice = false
	rentedShop = false
	apartment = false
	beachhouse = false
	office = false
	IntegrityHouse = false
	mansion2 = false
	mansion3 = false
	shithouse = false
	shopshit = false
	trailer = false

	DoScreenFadeOut(1000)

	while IsScreenFadingOut() do
		Citizen.Wait(100)
	end

	if rentedOffices[tonumber(house_id)] then
		if (rentedOffices[tonumber(house_id)]["trap"] ~= nil) then
			DoScreenFadeOut(1)
			TriggerEvent("house:entering")
		end
	end
	curHouseCoords = robberycoords[house_id]
	if house_model == 2 then
		curHouseCoords = robberycoordsMansions[house_id]
	end

	if house_model == 1 then
		if robberycoords[myhouseid]["apt"] == 1 then
			apartment = true
			buildApartment(robberycoords[myhouseid]["h"]+90.0)
		elseif robberycoords[myhouseid]["apt"] == 2 then
			beachhouse = true
			buildTrevor()
		elseif robberycoords[myhouseid]["apt"] == 3 then
			shithouse = true
			buildNorth()
		elseif robberycoords[myhouseid]["apt"] == 4 then
			shopshit = true
			buildShop()
		elseif robberycoords[myhouseid]["apt"] == 0 then
			IntegrityHouse = true
			buildHouse()
		end

	elseif house_model == 2 then
		if robberycoordsMansions[myhouseid]["office"] == 2 then
			mansion2 = true
			buildFranklin()			
		elseif robberycoordsMansions[myhouseid]["office"] == 0 then
			buildMansionBasic()		
			mansion3 = true
		else
			mansion = true
			buildMansion()
		end
	elseif house_model == 5 then
		trailer = true
		buildTrailer()
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
	end

	if backdoorcoords ~= nil then
		SetEntityCoords(PlayerPedId(),x,y,z)
	end

	TriggerEvent("inhouse",true)
	TriggerEvent("placefurniture",furniture)
	insidehouse = true
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end)


inhouse = false
RegisterNetEvent("inhouse")
AddEventHandler("inhouse", function(status)
	inhouse = status
end)


RegisterCommand('confirm', function()
    TriggerEvent('housing:confirmed')
end)

RegisterCommand('enter', function()
    TriggerEvent('housing:enter')
end)

RegisterCommand('furniture', function()
	TriggerEvent('openFurniture')
end)


RegisterNetEvent('housing:confirmed')
AddEventHandler('housing:confirmed', function()
	buy = true
	buying = 0
end)

RegisterNetEvent('housing:sendPurchaseAttempt')
AddEventHandler('housing:sendPurchaseAttempt', function(cid,price)
	if cid ~= nil and price ~= nil then
        if modifying then
			TriggerServerEvent("housing:attemptsale",cid,price,modifyingTable["house_id"],modifyingTable["house_model"], modifyingTable["storage"], modifyingTable["clothing"], modifyingTable["garages"])
		else
			TriggerEvent("DoLongHudText","You must have a house in modify mode to sell it!",91)
		end
	end
end)

-- Citizen.CreateThread(function()
-- 	Wait(300)
-- 	local updatetime = 0
--  	while true do
-- 		Citizen.Wait(1)

-- 		if modifying then

-- 			for i = 1, #modifyingTable["creationpoints"] do
-- 				DrawText3Ds( modifyingTable["creationpoints"][i]["x"],modifyingTable["creationpoints"][i]["y"],modifyingTable["creationpoints"][i]["z"] , 'Creation Point #' .. i )
-- 			end

-- 			for i = 1, #modifyingTable["garages"] do
-- 				DrawText3Ds( modifyingTable["garages"][i]["x"],modifyingTable["garages"][i]["y"],modifyingTable["garages"][i]["z"] , 'Garage Spawn Point #' .. i )
-- 			end

-- 			if modifyingTable["backdoorinside"]["x"] ~= 0.0 then
-- 				DrawText3Ds( modifyingTable["backdoorinside"]["x"],modifyingTable["backdoorinside"]["y"],modifyingTable["backdoorinside"]["z"] , 'Backdoor Inside' )
-- 			end

-- 			if modifyingTable["backdooroutside"]["x"] ~= 0.0 then
-- 				DrawText3Ds( modifyingTable["backdooroutside"]["x"],modifyingTable["backdooroutside"]["y"],modifyingTable["backdooroutside"]["z"] , 'Backdoor Outside')
-- 			end		

-- 			if modifyingTable["clothing"]["x"] ~= 0.0 then
-- 				DrawText3Ds( modifyingTable["clothing"]["x"],modifyingTable["clothing"]["y"],modifyingTable["clothing"]["z"] , 'Clothing Point' )
-- 			end

-- 			if modifyingTable["storage"]["x"] ~= 0.0 then
-- 				DrawText3Ds( modifyingTable["storage"]["x"],modifyingTable["storage"]["y"],modifyingTable["storage"]["z"] , 'Storage Point')
-- 			end		

-- 		end
		
-- 		if myhouseid == 0 then
-- 			if not modifying then
-- 				Citizen.Wait(1000)
-- 			end
-- 		else
-- 			local plyId = PlayerPedId()
-- 			local playerCoords = GetEntityCoords(plyId)
-- 			local plySpeed = GetEntitySpeed(plyId)
	
-- 			if entryType == 1 then
-- 				NetworkOverrideClockTime( 22, 0, 0 )
-- 				local crafting = false
-- 				if crafthouses[myhouseid] ~= nil then
-- 					crafting = true
-- 		            if IsControlJustReleased(1,Controlkey["generalUse"][1]) then
-- 		                TriggerEvent("craft:freeCraft",crafthouses[myhouseid])
-- 		            end
-- 		        end
-- 		        if moneyhouses[myhouseid] ~= nil then
-- 		        	crafting = true
-- 		            if IsControlJustReleased(1,Controlkey["generalUse"][1]) then
-- 		                TriggerEvent("secondaryjobs:attemptClean",moneyhouses[myhouseid])
-- 		            end
-- 		        end

-- 		        if not crafting then

-- 					local generator = { x = curHouseCoords["x"] , y = curHouseCoords["y"], z = curHouseCoords["z"] - 24.0}
-- 					local roblist = {}
-- 					if mansion then 
-- 						generator = { x = curHouseCoords["x"] , y = curHouseCoords["y"], z = curHouseCoords["z"] - 34.0}
-- 						roblist = robbablesMansion 
-- 					elseif shopshit then
-- 						roblist = shoprobbales
-- 					else
-- 						roblist = robbables2 
-- 					end


-- 					for i=1,#roblist do
-- 						if (GetDistanceBetweenCoords(generator.x + roblist[i]["x"],generator.y + roblist[i]["y"],generator.z + roblist[i]["z"], playerCoords) < 1.4 ) then
-- 							DrawText3Ds( generator.x + roblist[i]["x"], generator.y + roblist[i]["y"], generator.z + roblist[i]["z"], '~g~'..Controlkey["housingMain"][2]..'~s~ to search ' .. roblist[i]["name"] )

-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								local distance, pedcount = closestNPC()
-- 								local distadd = 0.1
-- 								if pedcount > 0 then
-- 									distadd = distadd + (pedcount / 70)
-- 									local distancealter = (8.0 - distance) / 70
-- 									distadd = distadd + distancealter
-- 								end
-- 								if mansion then
-- 									disturbance = disturbance + math.random(35)
-- 								end
-- 								distadd = distadd * 100
-- 								disturbance = disturbance + distadd
-- 								if math.random(100) > 95 then
-- 									disturbance = disturbance + 25
-- 									TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 9.0, 'robberyglass', 1.0)
-- 								else
-- 									TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'robberydraw', 0.5)
-- 								end
								
-- 								local finished = exports["srp-taskbar"]:taskBar(15000,"Browsing " ..roblist[i]["name"])
-- 								if finished == 100 then
-- 									TriggerEvent("client:newStress",true,math.random(200))
-- 									TriggerServerEvent("houserobberies:rob",myhouseid,i,mansion)
-- 								end

-- 							end

-- 						end
-- 					end

-- 					if robbing then

-- 						TriggerEvent("robbery:guiupdate",math.ceil(disturbance))
-- 					end
-- 					if disturbance > 70 then

-- 						local myJob = exports["isPed"]:isPed("myJob")
						
-- 						if myJob == "police" or myJob == "judge" or myJob == "ems" then
-- 							calledin = true
-- 						end
-- 						-- shit hit the fan chance
-- 						if not calledin then
-- 							local num = 150 - disturbance
-- 							if num < 3 and GetEntitySpeed(PlayerPedId()) > 0.8 then
-- 								calledin = true
-- 								TriggerEvent("agronpcs")
-- 								if mansion then
-- 									TriggerEvent("civilian:alertPolice",8.0,"robberyhouseMansion",0)
-- 								else
-- 									TriggerEvent("civilian:alertPolice",8.0,"robberyhouse",0)
-- 								end
-- 							end
-- 						end
-- 					end

-- 					if plySpeed > 1.4 then

-- 						local distance, pedcount = closestNPC()
-- 						local alteredsound = 0.1
-- 						if pedcount > 0 then
-- 							alteredsound = alteredsound + (pedcount / 100)
-- 							local distancealter = (8.0 - distance) / 100
-- 							alteredsound = alteredsound + distancealter
-- 						end

-- 						disturbance = disturbance + alteredsound
-- 						if plySpeed > 2.0 then
-- 							disturbance = disturbance + alteredsound
						
-- 						elseif plySpeed > 3.0 then
-- 							disturbance = disturbance + alteredsound
-- 						end
-- 					else
-- 						disturbance = disturbance - 0.01
-- 						if disturbance < 0 then
-- 							disturbance = 0
-- 						end
-- 					end
-- 				end

-- 				if myhouseid ~= 0 then
-- 					if (#(vector3(curHouseCoords["x"] , curHouseCoords["y"], curHouseCoords["z"]) - playerCoords) < 1.2 ) then
-- 						TriggerServerEvent("houserobberies:exit",myhouseid,mansion)
-- 						Citizen.Wait(5000)
-- 					end
-- 				end

-- 				if myhouseid ~= 0 then

-- 					if mansion then

-- 						if (#(vector3(curHouseCoords["x"]-5.5793,curHouseCoords["y"]+5.100,curHouseCoords["z"]-32.42) - playerCoords) < 1.2 ) then
-- 							DrawText3Ds( curHouseCoords["x"]-5.5793,curHouseCoords["y"]+5.100,curHouseCoords["z"]-32.82, '~g~'..Controlkey["housingMain"][2]..'~s~ front door' )
-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								TriggerServerEvent("houserobberies:exit",myhouseid,mansion,false)
-- 								Citizen.Wait(5000)
-- 							end
-- 						end

						
-- 						---522.51, 438.29 --- -502.49, 434.4
-- 						if robberyExitCoordsMansions[myhouseid] then
-- 							if robberyExitCoordsMansions[myhouseid]["x"] ~= 0.0 then
-- 								if (#(vector3(curHouseCoords["x"]+14.1793,curHouseCoords["y"]+1.900,curHouseCoords["z"]-32.42) - playerCoords) < 1.2 ) then
-- 									DrawText3Ds( curHouseCoords["x"]+14.1793,curHouseCoords["y"]+1.900,curHouseCoords["z"]-32.82, '~g~'..Controlkey["housingMain"][2]..'~s~ back door' )
-- 									if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 										TriggerServerEvent("houserobberies:exit",myhouseid,mansion,true)
-- 										Citizen.Wait(5000)
-- 									end
-- 								end
-- 							end
-- 						end
-- 					elseif mansion2 then

-- 						if (#(vector3(curHouseCoords["x"]+7.5793,curHouseCoords["y"]+6.400,curHouseCoords["z"]-19.42) - playerCoords) < 1.2 ) then
-- 							DrawText3Ds( curHouseCoords["x"]+7.5793,curHouseCoords["y"]+6.400,curHouseCoords["z"]-19.42, '~g~'..Controlkey["housingMain"][2]..'~s~ front door' )
-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								TriggerServerEvent("houserobberies:exit",myhouseid,mansion,false)
-- 								Citizen.Wait(5000)
-- 							end
-- 						end	
-- 					elseif shopshit then

-- 						if (#(vector3(curHouseCoords["x"] - 0.03, curHouseCoords["y"] - 7.86, curHouseCoords["z"] - 122) - playerCoords) < 1.2 ) then
-- 							DrawText3Ds( curHouseCoords["x"] - 0.03, curHouseCoords["y"] - 7.86, curHouseCoords["z"] - 122, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' )
-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								ExitHouse()
-- 								Citizen.Wait(5000)
-- 							end
-- 						end

-- 					elseif trailer then
-- 						if (#(vector3((curHouseCoords["x"]-1.443),(curHouseCoords["y"]-1.892),(curHouseCoords["z"]-74.0)) - playerCoords) < 100.2 ) then
-- 							DrawText3Ds( (curHouseCoords["x"]-1.443),(curHouseCoords["y"]-1.892),(curHouseCoords["z"]-74.0), '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' )
-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								ExitHouse()
-- 								Citizen.Wait(5000)
-- 							end
-- 						end
-- 					else
-- 						if (#(vector3(curHouseCoords["x"] + 4.3,curHouseCoords["y"] - 15.95,curHouseCoords["z"]-21.42) - playerCoords) < 1.2 ) then
-- 							DrawText3Ds( (curHouseCoords["x"] + 4.3),(curHouseCoords["y"] - 15.95),(curHouseCoords["z"]-21.42), '~g~'..Controlkey["housingMain"][2]..'~s~ front door' )
-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								TriggerServerEvent("houserobberies:exit",myhouseid,mansion,false)
-- 								Citizen.Wait(5000)
-- 							end
-- 						end

-- 						if robberyExitCoords[myhouseid] then
-- 							if robberyExitCoords[myhouseid]["x"] ~= 0.0 then
-- 								if (#(vector3(curHouseCoords["x"] -3.8,curHouseCoords["y"] + 5.25,curHouseCoords["z"]-21.42) - playerCoords) < 1.2 ) then
-- 									DrawText3Ds( (curHouseCoords["x"] - 3.8),(curHouseCoords["y"] + 5.25),(curHouseCoords["z"]-21.42), '~g~'..Controlkey["housingMain"][2]..'~s~ back door' )
-- 									if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 										TriggerServerEvent("houserobberies:exit",myhouseid,mansion,true)
-- 										Citizen.Wait(5000)
-- 									end
-- 								end
-- 							end
-- 						end
-- 					end
-- 				end
-- 			else
-- 				if mansion then
-- 					if (#(vector3(curHouseCoords["x"]-5.5793,curHouseCoords["y"]+5.100,curHouseCoords["z"]-32.42) - playerCoords) < 1.2 ) then
-- 						DrawText3Ds( curHouseCoords["x"]-5.5793,curHouseCoords["y"]+5.100,curHouseCoords["z"]-32.82, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' )
-- 						if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 							ExitHouse()
-- 							Citizen.Wait(5000)
-- 						end
-- 					end
-- 				elseif rentedShop then
-- 					if (#(vector3(curHouseCoords["x"]-1.4,curHouseCoords["y"]-4.47,curHouseCoords["z"]-32.2) - playerCoords) < 2.2 ) then
-- 						DrawText3Ds( curHouseCoords["x"]-1.4,curHouseCoords["y"]-4.47,curHouseCoords["z"]-32.2, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' )
-- 						if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 							ExitHouse()
-- 							Citizen.Wait(5000)
-- 						end
-- 					end

-- 					if (#(vector3(curHouseCoords["x"]-1.4,curHouseCoords["y"]-1.47,curHouseCoords["z"]-32.2) - playerCoords) < 2.2 ) then

-- 						if ( not rentedOffices[myhouseid]["trap"]) then

-- 							DrawText3Ds( curHouseCoords["x"]-1.4,curHouseCoords["y"]-1.47,curHouseCoords["z"]-32.2, '~g~'..Controlkey["housingMain"][2]..'~s~ to Browse' )
-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								TriggerEvent("server-inventory-open", "1", PlayerStoreIdentifier)
-- 								Citizen.Wait(5000)
-- 							end
-- 							DrawText3Ds( curHouseCoords["x"]-1.4,curHouseCoords["y"]-1.47,curHouseCoords["z"]-32.8, '~g~F~s~ to see reputation' )
-- 							if IsControlJustReleased(1, 23) then
-- 								TriggerEvent("DoShortHudText","Reputation: " .. rentedOffices[myhouseid]["reputation"])
-- 								Citizen.Wait(5000)
-- 							end
-- 						else

-- 							local mycid = exports["isPed"]:isPed("cid")

-- 							if (rentedOffices[myhouseid]["owner"] ~= mycid) then
-- 								DrawText3Ds( curHouseCoords["x"]-1.4,curHouseCoords["y"]-1.47,curHouseCoords["z"]-32.5, '~g~'..Controlkey["generalUse"][2]..'~s~ Take Over ($5000)' )
-- 								if IsControlJustReleased(1, Controlkey["generalUse"][1]) then
-- 									local finished = exports["srp-taskbar"]:taskBar(300000,"Doing Takeover")
-- 									if finished == 100 then
-- 										TriggerServerEvent("traps:take",myhouseid,mycid)
-- 									end
-- 									Citizen.Wait(5000)
-- 								end
-- 							else
-- 								DrawText3Ds( curHouseCoords["x"]-1.4,curHouseCoords["y"]-1.47,curHouseCoords["z"]-32.5, '~g~'..Controlkey["generalUse"][2]..'~s~ Take Cash' )
-- 								if IsControlJustReleased(1, Controlkey["generalUse"][1]) then
-- 									local finished = exports["srp-taskbar"]:taskBar(10000,"Taking Cash")
-- 									if finished == 100 then
-- 										TriggerServerEvent("traps:cashout",myhouseid)
-- 									end
-- 									Citizen.Wait(5000)
-- 								end
-- 							end

-- 							DrawText3Ds( curHouseCoords["x"]-1.4,curHouseCoords["y"]-1.47,curHouseCoords["z"]-32.8, '~g~F~s~ to see pincode/reputation' )
-- 							if IsControlJustReleased(1, 23) then
-- 								TriggerEvent("DoShortHudText","Pincode: " .. rentedOffices[myhouseid]["pincode"] .. " | Reputation: " .. rentedOffices[myhouseid]["reputation"])
-- 								Citizen.Wait(5000)
-- 							end

-- 							DrawText3Ds( curHouseCoords["x"]-1.4,curHouseCoords["y"]-1.47,curHouseCoords["z"]-32.2, '~g~'..Controlkey["housingMain"][2]..'~s~ to Browse' )
-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								TriggerEvent("server-inventory-open", "1", PlayerStoreIdentifier)
-- 								Citizen.Wait(5000)
-- 							end

-- 						end
-- 					end

-- 				elseif rentedOffice then
-- 					if (#(vector3(curHouseCoords["x"]+9,curHouseCoords["y"]+0.52,curHouseCoords["z"]-33.99) - playerCoords) < 3.2 ) then
-- 						DrawText3Ds( curHouseCoords["x"]+9,curHouseCoords["y"]+0.52,curHouseCoords["z"]-33.99, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' )
-- 						if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 							ExitHouse()
-- 							Citizen.Wait(5000)
-- 						end
-- 					end
-- 				elseif mansion2 then
-- 						if (#(vector3(curHouseCoords["x"]+11.5,curHouseCoords["y"]+5.2,curHouseCoords["z"]-19.42) - playerCoords) < 1.2 ) then
-- 							DrawText3Ds( curHouseCoords["x"]+11.5,curHouseCoords["y"]+5.2,curHouseCoords["z"]-19.42, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' )
-- 						if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 							ExitHouse()
-- 							Citizen.Wait(5000)
-- 						end
-- 					end
-- 				elseif mansion3 then
-- 						if (#(vector3(curHouseCoords["x"] - 1.6,curHouseCoords["y"]+9.2,curHouseCoords["z"]-19.1) - playerCoords) < 1.2 ) then
-- 							DrawText3Ds( curHouseCoords["x"] - 1.6,curHouseCoords["y"]+9.2,curHouseCoords["z"]-19.1, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' )
-- 						if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 							ExitHouse()
-- 							Citizen.Wait(5000)
-- 						end
-- 					end
-- 				elseif office then
-- 					if (#(vector3(curHouseCoords["x"]-3.5793,curHouseCoords["y"]+3.100,curHouseCoords["z"]-22.42) - playerCoords) < 1.2 ) then
-- 						DrawText3Ds( curHouseCoords["x"]-3.5793,curHouseCoords["y"]+3.100,curHouseCoords["z"]-22.82, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' )
-- 						if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 							ExitHouse()
-- 							Citizen.Wait(5000)
-- 						end
-- 					end
-- 				elseif trailer then
-- 					if (#(vector3((curHouseCoords["x"]-1.343),(curHouseCoords["y"]-2.292),(curHouseCoords["z"]-71.75)) - playerCoords) < 1.2 ) then
-- 						DrawText3Ds( (curHouseCoords["x"]-1.343),(curHouseCoords["y"]-2.292),(curHouseCoords["z"]-71.75), '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' )
-- 						if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 							ExitHouse()
-- 							Citizen.Wait(5000)
-- 						end
-- 					end
-- 				else
-- 					if apartment then
-- 						if (#(vector3(curHouseCoords["x"] + 4.67,curHouseCoords["y"] - 6.56,curHouseCoords["z"] - 26.97) - playerCoords) < 1.2 ) then
-- 							DrawText3Ds(curHouseCoords["x"] + 5.25,curHouseCoords["y"] - 6.76,curHouseCoords["z"] - 26.97, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave')
-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								ExitHouse()
-- 								Citizen.Wait(5000)
-- 							end
-- 						end
-- 					elseif shithouse then
-- 						if (#(vector3(curHouseCoords["x"] + 0.15,curHouseCoords["y"] - 9.71,curHouseCoords["z"] - 25.60) - playerCoords) < 1.2 ) then
-- 							DrawText3Ds( curHouseCoords["x"] + 0.15,curHouseCoords["y"] - 9.71,curHouseCoords["z"] - 25.60, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' )
-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								ExitHouse()
-- 								Citizen.Wait(5000)
-- 							end
-- 						end					
-- 					elseif beachhouse then

-- 						if (#(vector3(curHouseCoords["x"],curHouseCoords["y"] - 4.3,curHouseCoords["z"]-31.08) - playerCoords) < 1.2 ) then
-- 							DrawText3Ds( (curHouseCoords["x"]),(curHouseCoords["y"] - 4.3),(curHouseCoords["z"]-31.08), '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' )
-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								ExitHouse()
-- 								Citizen.Wait(5000)
-- 							end
-- 						end
-- 					elseif shopshit then
-- 						if (#(vector3(curHouseCoords["x"] + 0.5, curHouseCoords["y"] - 8.26, curHouseCoords["z"] - 121.9) - playerCoords) < 1.2 ) then
-- 							DrawText3Ds( curHouseCoords["x"] + 0.5, curHouseCoords["y"] - 8.26, curHouseCoords["z"] - 121.9, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' )
-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								ExitHouse()
-- 								Citizen.Wait(5000)
-- 							end
-- 						end
-- 					elseif IntegrityHouse then
-- 						if (#(vector3(curHouseCoords["x"] + 2,curHouseCoords["y"] - 14.5,curHouseCoords["z"] - 26.7) - playerCoords) < 1.2) then
-- 							DrawText3Ds(curHouseCoords["x"] + 2,curHouseCoords["y"] - 14.5,curHouseCoords["z"] - 26.7, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave' ) 
-- 							if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
-- 								ExitHouse()
-- 								Citizen.Wait(5000)
-- 							end
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end)


function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
 
isCop = false
 
RegisterNetEvent('nowCopSpawn')
AddEventHandler('nowCopSpawn', function()
    isCop = true
end)

RegisterNetEvent('nowCopSpawnOff')
AddEventHandler('nowCopSpawnOff', function()
    isCop = false
end)

isJudge = false
RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)
RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent("apart:giveKey")
AddEventHandler("apart:giveKey", function()
    t, distance = GetClosestPlayer()
    if t ~= nil then
        local thename = GrabApartment(10)
        if thename ~= "none" then
            TriggerServerEvent("Appartment:giveKey",thename,GetPlayerServerId(t))
        else
            TriggerEvent("DoLongHudText","Could not find property.",2)
        end
    end
end)

RegisterNetEvent('houses:GiveKey')
AddEventHandler('houses:GiveKey', function()

	local houseinfo = GetHouseInformation()
	if houseinfo == nil then
		return
	end

	local house_model = houseinfo[2]
	local house_id = houseinfo[1]
	house_id = tonumber(house_id)

	local house_name = ""

	if house_model == 1 or house_model == 5 then
		house_name = robberycoords[house_id]["info"]
	end

	if house_model == 2 then
		house_name = robberycoordsMansions[house_id]["info"]
	end
	
	if house_model == 3 then
		house_name = rentedOffices[tonumber(house_id)]["name"]
	end

	t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 5) then
		TriggerServerEvent("house:givekey",house_id,house_model,house_name,GetPlayerServerId(t))
		TriggerEvent("DoLongHudText","Attempting to give key to house " .. house_name,1)
		return
	end	

	TriggerEvent("DoLongHudText","Failed to find near person.",2)

end)

RegisterNetEvent('houses:retrieveHouseKeys')
AddEventHandler('houses:retrieveHouseKeys', function()
	local houseinfo = GetHouseInformation()
	if houseinfo == nil then
		return
	end

	local house_model = houseinfo[2]
	local house_id = houseinfo[1]

	if house_model == 1 or house_model == 5 then
		house_name = robberycoords[house_id]["info"]
	end

	if house_model == 2 then
		house_name = robberycoordsMansions[house_id]["info"]
	end
	
	if house_model == 3 then
		house_name = rentedOffices[house_id]["name"]
	end

	TriggerServerEvent("house:retrieveKeys",house_id,house_model)	
end)

RegisterNetEvent('houses:removeHouseKey')
AddEventHandler('houses:removeHouseKey', function(target)
	local houseinfo = GetHouseInformation()
	if houseinfo == nil then
		return
	end

	local house_model = houseinfo[2]
	local house_id = houseinfo[1]

	if house_model == 1 or house_model == 5 then
		house_name = robberycoords[house_id]["info"]
	end

	if house_model == 2 then
		house_name = robberycoordsMansions[house_id]["info"]
	end
	
	if house_model == 3 then
		house_name = rentedOffices[house_id]["name"]
	end
	
	TriggerServerEvent("house:removeKey",house_id, house_model, target)		
end)

function checkDist(distance,t)
    if t ~= -1 then
        if distance > 5 then
            return true
        else
            return false
        end
    else
        return true
    end
end

currentApartment = false
function MenuAppartement()
    ped = PlayerPedId();
    MenuTitle = "Apartement"
    ClearMenu()
 
    for i,v in pairs(interiors) do
        if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xe,interiors[i].ye,interiors[i].ze)) < 52 then
            DrawMarker(27,interiors[i].xe,interiors[i].ye,interiors[i].ze, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 212, 189, 0, 30, 0, 0, 2, 0, 0, 0, 0)
            if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xe,interiors[i].ye,interiors[i].ze)) < 1.599 then
                 t, distance = GetClosestPlayer()
                if checkDist(distance,t) then
                    TriggerServerEvent("apart:getAppart", interiors[i].name,interiors[i].TypeOfProperty)
                    GetPropertyType(i)
                    Wait(1000)

                    if IsHudComponentActive(19) then return end

                    TriggerEvent("chatMessage", "Info: ", {255, 0, 0}, "You are visiting the " .. interiors[i].name .. " property. " .. interiors[i].price .. "$USD")
                    
                    currentApartment = i
                    
                    TriggerEvent("openApartmentMenu",Store,isBuy,lockStatus,false)

                    SetEntityCoords(PlayerPedId(),interiors[i].xe,interiors[i].ye,interiors[i].ze)
                    FreezeEntityPosition(PlayerPedId(),true)
                    Citizen.Wait(2000)
                    FreezeEntityPosition(PlayerPedId(),false)
                else
                    TriggerEvent("DoLongHudText","Already someone here.",2)
                end
            end
        end

    end
end


function MenuAppartement2()
    ped = PlayerPedId();
    MenuTitle = "Apartement"
    ClearMenu()
    for i,v in pairs(interiors) do
        if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xo,interiors[i].yo,interiors[i].zo)) < 52 then
            DrawMarker(27,interiors[i].xo,interiors[i].yo,interiors[i].zo, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 212, 189, 0, 30, 0, 0, 2, 0, 0, 0, 0)
            if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xo,interiors[i].yo,interiors[i].zo)) < 1.599 then
                t, distance = GetClosestPlayer()
                if  checkDist(distance,t) then
                    TriggerServerEvent("apart:getAppart", interiors[i].name,interiors[i].TypeOfProperty)
                    GetPropertyType(i)
                    Wait(800)

                    if IsHudComponentActive(19) then return end

                    TriggerEvent("chatMessage", "Info: ", {255, 0, 0}, "You are visiting the " .. interiors[i].name .. " property. " .. interiors[i].price .. "$USD")

                    currentApartment = i
                    
                    TriggerEvent("openApartmentMenu",Store,isBuy,lockStatus,true)
                end
            end
        end
    end
end



function GetPropertyType(i)
    Store = false
    propertyType = interiors[i].TypeOfProperty
    if propertyType ~= 1 then  
        Store = true 
    end
end


function CloseMenu()
    Menu.hidden = true    
end

function Sonner()
    drawNotification(txt[lang]['You do not own this!'])
end

RegisterNetEvent('Appartment:StashCash')
RegisterNetEvent('Appartment:StashDM')
RegisterNetEvent('Appartment:TakeCash')
RegisterNetEvent('Appartment:TakeDM')

function GrabApartmentPrice()
    appartmentName = 0
    for i,v in pairs(interiors) do

        if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xe,interiors[i].ye,interiors[i].ze)) < 5 then
            appartmentName = interiors[i].price
        end

        if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xo,interiors[i].yo,interiors[i].zo)) < 5 then
            appartmentName = interiors[i].price
        end


    end
    return appartmentName
end



function GrabApartment(distancec)
    appartmentName = "none"
    startdistance = 100
    for i,v in pairs(interiors) do
        if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xe,interiors[i].ye,interiors[i].ze)) < distancec then
            if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xe,interiors[i].ye,interiors[i].ze)) > 100 and interiors[i].TypeOfProperty ~= 10 then
                --too far from store.
            else
                DISTANCECHECKED = #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xe,interiors[i].ye,interiors[i].ze))
                if DISTANCECHECKED < startdistance then
                    startdistance = DISTANCECHECKED
                    appartmentName = interiors[i].name
                end
            end
        end

        if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xo,interiors[i].yo,interiors[i].zo)) < distancec then
            if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xo,interiors[i].yo,interiors[i].zo)) > 100 and interiors[i].TypeOfProperty ~= 10 then
                --too far from store.
            else
                DISTANCECHECKED = #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xo,interiors[i].yo,interiors[i].zo))
                if DISTANCECHECKED < startdistance then
                    startdistance = DISTANCECHECKED
                    appartmentName = interiors[i].name
                end
            end
        end
    end
    return appartmentName
end

function GrabApartmentDrug(distancec)
    appartmentName = "none"
    for i,v in pairs(interiors) do
        if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xe,interiors[i].ye,interiors[i].ze)) < distancec then
            if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xe,interiors[i].ye,interiors[i].ze)) > distancec and interiors[i].TypeOfProperty ~= 10 then
                --too far from store.
            else
                propertyType = interiors[i].TypeOfProperty                
                if appartmentName == "none" and propertyType == 10 then
                    appartmentName = interiors[i].name
                end
            end
        end
    end
    return appartmentName
end

-- UPV = update property value

RegisterNetEvent('DrugsUPV')
AddEventHandler('DrugsUPV', function(amount)   
    TriggerEvent("DoLongHudText","Checking for bonuses..",1)
    local thename = GrabApartmentDrug(200)
    if thename ~= "none" then
        TriggerServerEvent("Appartment:ServerUpdateValueWithReturn",thename, amount)
        TriggerEvent("DoLongHudText",thename,1)
    end
end)

RegisterNetEvent('UPVBank')
AddEventHandler('UPVBank', function(amount)   
    local thename = "Maze Banking"
    if thename ~= "none" then
        TriggerServerEvent("Appartment:ServerUpdateValue",thename, amount)
    end
end)

RegisterNetEvent('PropertyCashAdjust')
AddEventHandler('PropertyCashAdjust', function(giveAmount, cashtype, dirty)
    local thename = GrabApartment(5)
    if thename ~= "none" then
        TriggerServerEvent("PropertyCashAdjust", giveAmount, cashtype, thename, dirty)
    end
end)

RegisterNetEvent('UPV')
AddEventHandler('UPV', function(amount)
    local thename = GrabApartment(100)
    if thename ~= "none" then
        TriggerServerEvent("Appartment:ServerUpdateValue",thename, amount)
    end
end)

RegisterNetEvent('UPVWood')
AddEventHandler('UPVWood', function(amount,name)   
    if name ~= "none" then
        TriggerServerEvent("Appartment:ServerUpdateValue",name, amount)
    end
end)

RegisterNetEvent('Appartment:PayRent')
AddEventHandler('Appartment:PayRent', function()
    TriggerServerEvent("apart:payRent",GrabApartment(22), GrabApartmentPrice())
end)

RegisterNetEvent('Appartment:CheckRent')
AddEventHandler('Appartment:CheckRent', function()
    TriggerServerEvent("apart:checkRent",GrabApartment(22), GrabApartmentPrice())
end)

AddEventHandler('Appartment:StashCash', function()
    TriggerEvent("DoLongHudText","Stored Cash.",1)
    TriggerEvent("civcashtype",1, false )
end)

AddEventHandler('Appartment:StashDM', function()
    TriggerEvent("DoLongHudText","Stored Marked Bills.",1)
    TriggerEvent("civcashtype",1, true )
end)

AddEventHandler('Appartment:TakeCash', function()
    TriggerEvent("DoLongHudText","Took Cash.",1)
    TriggerEvent("civcashtype",2, false )
end)

AddEventHandler('Appartment:TakeDM', function()
    TriggerEvent("DoLongHudText","Took Marked Bills.",1)
    TriggerEvent("civcashtype",2, true )

end)
RegisterNetEvent('Appartment:SeizeAllTEXT')
AddEventHandler('Appartment:SeizeAllTEXT', function()
  -- TriggerEvent("DoLongHudText","Seizure Completed on ID #" .. target)
    TriggerServerEvent("apart:SeizeAllTEXT")
end)
RegisterNetEvent('Appartment:SeizeAll')
AddEventHandler('Appartment:SeizeAll', function()
    TriggerEvent("DoLongHudText","Seizure Completed.",1)
    TriggerServerEvent("apart:SeizeAll",GrabApartment(5))
end)


RegisterNetEvent('Appartment:CheckOwner')
AddEventHandler('Appartment:CheckOwner', function()
    TriggerEvent("DoLongHudText","Checking Ownership.",1)
    TriggerServerEvent("apart:returnOwner",GrabApartment(5))
end)



RegisterNetEvent('Appartment:lock')
AddEventHandler('Appartment:lock', function()
    TriggerServerEvent("apart:lockAppart", GrabApartment(22), 1)
end)

RegisterNetEvent('Appartment:unlock')
AddEventHandler('Appartment:unlock', function()
    TriggerServerEvent("apart:lockAppart", GrabApartment(22), 0)
end)

RegisterNetEvent('Appartment:Vendre')
AddEventHandler('Appartment:Vendre', function()
    TriggerServerEvent("apart:sellAppart", GrabApartment(22), GrabApartmentPrice())
    TriggerEvent("fistpump")
end)

RegisterNetEvent('Appartment:Acheter')
AddEventHandler('Appartment:Acheter', function()
    TriggerServerEvent("apart:buyAppart", GrabApartment(22), GrabApartmentPrice())
    TriggerEvent("fistpump")
end)

RegisterNetEvent('Appartment:Visiter2')
AddEventHandler('Appartment:Visiter2', function()
    i = currentApartment
    if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xo,interiors[i].yo,interiors[i].zo)) < 15 then
        DrawMarker(27,interiors[i].xo,interiors[i].yo,interiors[i].ze-1.0001, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 212, 189, 0, 30, 0, 0, 2, 0, 0, 0, 0)
        if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xo,interiors[i].yo,interiors[i].zo)) < 1.599 then
            DoScreenFadeOut(50)
            timer = 20
            while IsScreenFadingOut() do Citizen.Wait(0) end
            --NetworkFadeOutEntity(PlayerPedId(), true, false)
            Wait(50)
            SetEntityCoords(PlayerPedId(), interiors[currentApartment].xe,interiors[currentApartment].ye,interiors[currentApartment].ze)
            SetEntityHeading(PlayerPedId(), interiors[currentApartment].ho)
            TriggerServerEvent("appartments:testCrafting",apartmentCraft[i],false)
            TriggerServerEvent("apart:returnIsOwner",interiors[i].name)
            TriggerEvent('craft:updateOwnerShip',false,"") 
            --NetworkFadeInEntity(PlayerPedId(), 0)
            Wait(50)
            current_int = i
            SimulatePlayerInputGait(PlayerId(), 1.0, 100, 1.0, 1, 0)
            DoScreenFadeIn(50)
            while IsScreenFadingIn() do Citizen.Wait(0) end
        end
    end
end)

 RegisterNetEvent('Appartment:Visiter')
AddEventHandler('Appartment:Visiter', function()
    i = currentApartment
    if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xe,interiors[i].ye,interiors[i].ze)) < 15 then
        DrawMarker(27,interiors[i].xe,interiors[i].ye,interiors[i].ze-1.0001, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 212, 189, 0, 30, 0, 0, 2, 0, 0, 0, 0)
        if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xe,interiors[i].ye,interiors[i].ze)) < 1.599  then
            DoScreenFadeOut(50)
            timer = 20
            while IsScreenFadingOut() do Citizen.Wait(0) end
            --NetworkFadeOutEntity(PlayerPedId(), true, false)
            Wait(50)
            SetEntityCoords(PlayerPedId(), interiors[currentApartment].xo,interiors[currentApartment].yo,interiors[currentApartment].zo)
            SetEntityHeading(PlayerPedId(), interiors[currentApartment].ho)
            TriggerServerEvent("appartments:testCrafting",apartmentCraft[i],true)
            TriggerServerEvent("apart:returnIsOwner",interiors[i].name) 
           -- NetworkFadeInEntity(PlayerPedId(), 0)
            Wait(50)
            current_int = i
            SimulatePlayerInputGait(PlayerId(), 1.0, 100, 1.0, 1, 0)
            DoScreenFadeIn(50)
            while IsScreenFadingIn() do Citizen.Wait(0) end
        end
    end
end)

function ExitHouse()
	TriggerEvent('InteractSound_CL:PlayOnOne','DoorClose', 0.7)
	DeleteSpawnedHouse(0,false)
	TriggerEvent("dooranim")
	Citizen.Wait(100)
	SetEntityCoords(PlayerPedId(),curHouseCoords["x"],curHouseCoords["y"],curHouseCoords["z"])
	TriggerEvent("inhouse",false)
	TriggerEvent("robbing",false)
	insidehouse = false
	myhouseid = 0
	myhousetype = 0
	entryType = 0
	-- clothingcoords = {x = 0, y = 0, z = 0, h = 0}
	-- storagecoords = {x = 0, y = 0, z = 0, h = 0}
end

function DeleteSpawnedHouse(id,owner)

	TriggerEvent("inhouse",false)
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(vector3(curHouseCoords["x"], curHouseCoords["y"], (curHouseCoords["z"] - 24.0)) - pos)
        if distance < 35.0 and ObjectFound ~= playerped then
        	if IsEntityAPed(ObjectFound) then
        		if IsPedAPlayer(ObjectFound) then
        		else
        			DeleteObject(ObjectFound)
        		end
        	else
        		DeleteObject(ObjectFound)
        	end            
        end
        success, ObjectFound = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    if owner then
    	RemoveNPC(id)
    end
end
 

local apartmentEntries = {
    [1] = { ["x"] = 312.96966552734,["y"] = -218.2705078125, ["z"] = 54.221797943115, ["name"] = "Hotel 1-1" },
    [2] = { ["x"] = -1440.0783691406, ["y"] = -549.49505615234, ["z"] = 34.741863250732, ["name"] = "Del Perro Apartments" },
    [3] = { ['x'] = -1472.38,['y'] = -657.84,['z'] = 29.27, ["name"] = "Hotel 1-2" },
    [4] = { ['x'] = 505.4,['y'] = 215.07,['z'] = 102.9, ["name"] = "Hotel 1-3" },
}

local showMainAppartment = false

RegisterNetEvent('Appartment:ToggleHouses')
AddEventHandler('Appartment:ToggleHouses', function()
    showMainAppartment = not showMainAppartment
   for _, item in pairs(interiors) do
        if item.TypeOfProperty == 1 then 
            if not showMainAppartment then
                if item.blip ~= nil then
                    RemoveBlip(item.blip)
                end
            else
                item.blip = AddBlipForCoord(item.xe, item.ye, item.ze)
                SetBlipSprite(item.blip, 375)
                SetBlipAsShortRange(item.blip, true)
                BeginTextCommandSetBlipName("STRING")
                SetBlipColour(item.blip, 3)
                SetBlipScale(item.blip, 0.9)
                AddTextComponentString("Housing")
                EndTextCommandSetBlipName(item.blip)
            end
        end
    end
end)

Citizen.CreateThread(function()

    if displayApartBlips == true then
        showMainAppartment = true
        TriggerEvent('Appartment:ToggleHouses')

        for i = 1, #apartmentEntries do
              local blip = AddBlipForCoord(apartmentEntries[i]["x"], apartmentEntries[i]["y"], apartmentEntries[i]["z"])
              SetBlipSprite(blip, 350)
              SetBlipAsShortRange(blip, true)
              BeginTextCommandSetBlipName("STRING")
              SetBlipColour(blip, i+8)
              SetBlipScale(blip, 0.8)
              AddTextComponentString(apartmentEntries[i]["name"])
              EndTextCommandSetBlipName(blip)
        end

    end


end)

RegisterNetEvent('srp-weapons:stashitem')
AddEventHandler('srp-weapons:stashitem', function(itemnumber,amount,meta)


        thename1 = "none"
        thename1 = GrabApartment(2)

        if thename1 ~= "none" then

            TriggerServerEvent("srp-weapons:stashweapon", thename1, itemnumber, amount, 1,1,meta)


        else
            TriggerEvent("DoLongHudText", "Error finding property.",2)
        end

end)


decimalToName = {
["2725352035"] = "WEAPON_UNARMED",
["4194021054"] = "WEAPON_ANIMAL",
["148160082"] = "WEAPON_COUGAR",
["2578778090"] = "WEAPON_KNIFE",
["1737195953"] = "WEAPON_NIGHTSTICK",
["1317494643"] = "WEAPON_HAMMER",
["2508868239"] = "WEAPON_BAT",
["1141786504"] = "WEAPON_GOLFCLUB",
["2227010557"] = "WEAPON_CROWBAR",
["453432689"] = "WEAPON_PISTOL",
["1593441988"] = "WEAPON_COMBATPISTOL",
["584646201"] = "WEAPON_APPISTOL",
["2578377531"] = "WEAPON_PISTOL50",
["432421536"] = "WEAPON_MICROSMG",
["736523883"] = "WEAPON_SMG",
["4024951519"] = "WEAPON_ASSAULTSMG",
["3220176749"] = "WEAPON_ASSAULTRIFLE",
["2210333304"] = "WEAPON_CARBINERIFLE",
["2937143193"] = "WEAPON_ADVANCEDRIFLE",
["2634544996"] = "WEAPON_MG",
["2144741730"] = "WEAPON_COMBATMG",
["487013001"] = "WEAPON_PUMPSHOTGUN",
["2017895192"] = "WEAPON_SAWNOFFSHOTGUN",
["3800352039"] = "WEAPON_ASSAULTSHOTGUN",
["2640438543"] = "WEAPON_BULLPUPSHOTGUN",
["911657153"] = "WEAPON_STUNGUN",
["100416529"] = "WEAPON_SNIPERRIFLE",
["205991906"] = "WEAPON_HEAVYSNIPER",
["856002082"] = "WEAPON_REMOTESNIPER",
["2726580491"] = "WEAPON_GRENADELAUNCHER",
["1305664598"] = "WEAPON_GRENADELAUNCHER_SMOKE",
["2982836145"] = "WEAPON_RPG",
["375527679"] = "WEAPON_PASSENGER_ROCKET",
["324506233"] = "WEAPON_AIRSTRIKE_ROCKET",
["1752584910"] = "WEAPON_STINGER",
["1119849093"] = "WEAPON_MINIGUN",
["2481070269"] = "WEAPON_GRENADE",
["741814745"] = "WEAPON_STICKYBOMB",
["4256991824"] = "WEAPON_SMOKEGRENADE",
["2694266206"] = "WEAPON_BZGAS",
["615608432"] = "WEAPON_MOLOTOV",
["101631238"] = "WEAPON_FIREEXTINGUISHER",
["883325847"] = "WEAPON_PETROLCAN",
["4256881901"] = "WEAPON_DIGISCANNER",
["2294779575"] = "WEAPON_BRIEFCASE",
["28811031"] = "WEAPON_BRIEFCASE_02",
["600439132"] = "WEAPON_BALL",
["1233104067"] = "WEAPON_FLARE",
["3204302209"] = "WEAPON_VEHICLE_ROCKET",
["1223143800"] = "WEAPON_BARBED_WIRE",
["4284007675"] = "WEAPON_DROWNING",
["1936677264"] = "WEAPON_DROWNING_IN_VEHICLE",
["2339582971"] = "WEAPON_BLEEDING",
["2461879995"] = "WEAPON_ELECTRIC_FENCE",
["539292904"] = "WEAPON_EXPLOSION",
["3452007600"] = "WEAPON_FALL",
["910830060"] = "WEAPON_EXHAUSTION",
["3425972830"] = "WEAPON_HIT_BY_WATER_CANNON",
["133987706"] = "WEAPON_RAMMED_BY_CAR",
["2741846334"] = "WEAPON_RUN_OVER_BY_CAR",
["341774354"] = "WEAPON_HELI_CRASH",
["3750660587"] = "WEAPON_FIRE",
["3218215474"] = "WEAPON_SNSPISTOL",
["4192643659"] = "WEAPON_BOTTLE",
["1627465347"] = "WEAPON_GUSENBERG",
["3231910285"] = "WEAPON_SPECIALCARBINE",
["3523564046"] = "WEAPON_HEAVYPISTOL",
["2132975508"] = "WEAPON_BULLPUPRIFLE",
["2460120199"] = "WEAPON_DAGGER",
["137902532"] = "WEAPON_VINTAGEPISTOL",
["2138347493"] = "WEAPON_FIREWORK",
["2828843422"] = "WEAPON_MUSKET",
["984333226"] = "WEAPON_HEAVYSHOTGUN",
["3342088282"] = "WEAPON_MARKSMANRIFLE",
["1672152130"] = "WEAPON_HOMINGLAUNCHER",
["2874559379"] = "WEAPON_PROXMINE",
["126349499"] = "WEAPON_SNOWBALL",
["1198879012"] = "WEAPON_FLAREGUN",
["3794977420"] = "WEAPON_GARBAGEBAG",
["3494679629"] = "WEAPON_HANDCUFFS",
["171789620"] = "WEAPON_COMBATPDW",
["3696079510"] = "WEAPON_MARKSMANPISTOL",
["3638508604"] = "WEAPON_KNUCKLE",
["4191993645"] = "WEAPON_HATCHET",
["1834241177"] = "WEAPON_RAILGUN",
["3713923289"] = "WEAPON_MACHETE",
["3675956304"] = "WEAPON_MACHINEPISTOL",
["738733437"] = "WEAPON_AIR_DEFENCE_GUN",
["3756226112"] = "WEAPON_SWITCHBLADE",
["3249783761"] = "WEAPON_REVOLVER",
["4019527611"] = "WEAPON_DBSHOTGUN",
["1649403952"] = "WEAPON_COMPACTRIFLE",
["317205821"] = "WEAPON_AUTOSHOTGUN",
["3441901897"] = "WEAPON_BATTLEAXE",
["125959754"] = "WEAPON_COMPACTLAUNCHER",
["3173288789"] = "WEAPON_MINISMG",
["3125143736"] = "WEAPON_PIPEBOMB",
["2484171525"] = "WEAPON_POOLCUE",
["419712736"] = "WEAPON_WRENCH"
}

hashGun = {
    '883325847',
    '1233104067',
    '-1716189206',
    '1317494643',
    '-1786099057',
    '-2067956739',
    '1141786504',
    '-102323637',
    '-1834847097',
    '-102973651',
    '-656458692',
    '-581044007',
    '-1951375401',
    '-538741184',
    '-1810795771',
    '419712736',
    '453432689',
    '1593441988',
    '137902532',
    '911657153',
    '324215364',
    '736523883',
    '-270015777',
    '1627465347',
    '2017895192',
    '-1654528753',
    '-494615257',
    '984333226',
    '317205821',
    '-1074790547',
    '-2084633992' ,
    '-1357824103',
    '-1063057011' , --CARBINE S
    '2132975508',
    '100416529',
    '205991906',
    '-952879014',
    '2138347493',
    '101631238'
}
function D2N(info)
    info = decimalToName[info]
    return info
end

RegisterNetEvent('srp-weapons:giveweaponfromproperty')
AddEventHandler('srp-weapons:giveweaponfromproperty', function(result)
    local ped = PlayerPedId()
    GiveWeaponToPed(ped, tonumber(result), 150, 0, false)
    TriggerEvent("attachWeapons")
    TriggerEvent("fistpump")
end)





RegisterNetEvent('srp-weapons:checkinventory')
AddEventHandler('srp-weapons:checkinventory', function()

    if not IsPedInAnyVehicle(PlayerPedId(),true) then
        thename1 = "none"
        thename1 = GrabApartment(2)

        if thename1 ~= "none" then

            TriggerServerEvent("srp-weapons:checkinventory", thename1)

        else
            TriggerEvent("DoLongHudText", "Error finding property.",2)
        end

    else
        TriggerEvent("DoLongHudText", "Can not do in a vehicle.",2)
    end

end)



RegisterNetEvent('srp-weapons:takefromstash')
AddEventHandler('srp-weapons:takefromstash', function(itemname, quantity, itemtype, item, askedAmount,meta)
    thename1 = GrabApartment(2)
    if thename1 ~= "none" then
        TriggerServerEvent("srp-weapons:takefromstash",itemname, quantity, itemtype, item, askedAmount,thename1,meta)
    else
        TriggerEvent("DoLongHudText", "Error finding property.",2)
    end
end)


RegisterNetEvent('srp-weapons:stashweapon')
AddEventHandler('srp-weapons:stashweapon', function()

    if not IsPedInAnyVehicle(PlayerPedId(),true) then
        thename1 = "none"
        thename1 = GrabApartment(2)

        if thename1 ~= "none" then
            local weaponname = GetSelectedPedWeapon(PlayerPedId())
            local weaponHash = GetHashKey(weaponname)
            local ammo = GetAmmoInPedWeapon(PlayerPedId(),weaponname)
            for i,v in ipairs(hashGunToText) do
                if v == weaponname then
                    weaponname = hashGun[i]
                end
            end

            -- Note From Sin , For some reason setPedDrop wont work with 0 ammo but removeWeapon will ?
            RemoveWeaponFromPed(PlayerPedId(),weaponname)
            --SetPedDropsWeapon(PlayerPedId())                 
            GiveWeaponToPed(PlayerPedId(), 0xA2719263, 0, 0, 1)
            TriggerEvent("attachWeapons")
            TriggerServerEvent("srp-weapons:stashweapon", thename1, weaponname, 1, 0,ammo)
            TriggerServerEvent("weaponshop:removeSingleWeapon",weaponname)
        else
            TriggerEvent("DoLongHudText", "Error finding property.",2)
        end

    else
        TriggerEvent("DoLongHudText", "Can not do in a vehicle.",2)
    end

end)


function D2N(info)
    info = tostring(info)
    info = decimalToName[info]
    return info
end

hashGunToText = {
['-102973651'] = "Hatchet",
['-1834847097'] = "Dagger",
['-102323637'] = "Glass Bottle",
['-2067956739'] = "Crowbar",
['-656458692'] = "Knuckle Dusters",
['-1786099057'] = "Baseball Bat",

['-102973651'] = "Hatchet",
['-1834847097'] = "Dagger",
['-102323637'] = "Glass Bottle",
['-2067956739'] = "Crowbar",
['-656458692'] = "Knuckle Dusters",
['-1786099057'] = "Baseball Bat",
['-1716189206'] = "Combat Knife",
['-2066285827'] = "Assault SMG",
['-270015777'] = "Bullpup Rifle",
['-1654528753'] = "Bullpup Shotgun",
['-494615257'] = "Auto Shotgun",
['-619010992'] = "Tec 9",
['-2009644972'] = "SNS Pistol",
['-1121678507'] = "Mini SMG",
['2725352035'] = "Unarmed",
['4194021054'] = "Animal",
['148160082'] = "Cougar",
['2578778090'] = "Knife",
['1737195953'] = "Nightstick",
['1317494643'] = "Hammer",
['2508868239'] = "Bat",
['1141786504'] = "Golfclub",
['2227010557'] = "Crowbar",
['453432689'] = "Pistol",
['1593441988'] = "Combat Pistol",
['584646201'] = "AP Pistol",
['2578377531'] = "Deagle",
['324215364'] = "Micro SMG",
['736523883'] = "SMG",
['4024951519'] = "Assault SMG",
['3220176749'] = "Assault Rifle",
['2210333304'] = "Carbine",
['2937143193'] = "Adv Rifle",
['2634544996'] = "MG",
['2144741730'] = "Combat MG",
['487013001'] = "Pump Action",
['2017895192'] = "Sawnoff",
['3800352039'] = "Assault Shotgun",
['2640438543'] = "Bullpup Shotgun",
['911657153'] = "Stun Gun",
['100416529'] = "Sniper",
['205991906'] = "Heavy Sniper",
['856002082'] = "Remote Sniper",
['2726580491'] = "GND Launcher",
['1305664598'] = "GND Launcher SMK",
['2982836145'] = "RPG",
['375527679'] = "Passenger Rocket",
['324506233'] = "Air Rocket",
['1752584910'] = "Stinger",
['1119849093'] = "Minigun",
['2481070269'] = "Grenade",
['741814745'] = "Sticky Bomb",
['4256991824'] = "Smoke Grenade",
['2694266206'] = "Bz Gas",
['615608432'] = "Molotov",
['101631238'] = "Fire Ext",
['883325847'] = "Petrol Can",
['4256881901'] = "Digi Scanner",
['2294779575'] = "Briefcase",
['28811031'] = "Briefcase",
['600439132'] = "Ball",
['1233104067'] = "Flare",
['3204302209'] = "Veh Rocket",
['1223143800'] = "Barbed Wire",
['4284007675'] = "Drown",
['1936677264'] = "Drown Vehicle",
['2339582971'] = "Bleeding",
['2461879995'] = "Electric Fence",
['539292904'] = "Explosion",
['3452007600'] = "Fall",
['910830060'] = "Exhaustion",
['3425972830'] = "Water Cannon",
['133987706'] = "Rammed",
['2741846334'] = "Run Over",
['341774354'] = "Heli Crash",
['3750660587'] = "Fire",

----------------DLC Weapons----------------

------------------------------------
['3218215474'] = "SNS Pistol",
['4192643659'] = "Bottle",

------------------------------------
['1627465347'] = "Gusenberg",

------------------------------------
['3231910285'] = "Special Carbine",
['3523564046'] = "Heavy Pistol",

------------------------------------
['2132975508'] = "Bullpup",


------------------------------------
['2460120199'] = "Dagger",
['137902532'] = "Vintage Pistol",


------------------------------------
['2138347493'] = "Firework",
['2828843422'] = "Musket",


------------------------------------
['984333226'] = "Heavy Shotgun",
['3342088282'] = "Mark Rifle",


------------------------------------
['1672152130'] = "Homing Launcher",
['2874559379'] = "Proximity Mine",
['126349499'] = "Snowball",

------------------------------------
['1198879012'] = "Flaregun",
['3794977420'] = "Garbage Bag",
['3494679629'] = "Handcuffs",


------------------------------------
['171789620'] = "Combat PDW",


------------------------------------
['3696079510'] = "Mrk Pistol",
['3638508604'] = "Knuckle",


------------------------------------
['4191993645'] = "Hatchet",
['1834241177'] = "Railgun",


------------------------------------
['3713923289'] = "Machete",
['3675956304'] = "Mac Pistol",


------------------------------------
['738733437'] = "Air Defence",
['3756226112'] = "Switchblade",
['3249783761'] = "Revolver",


------------------------------------
['4019527611'] = "DB Shotgun",
['1649403952'] = "Cmp Rifle",


------------------------------------
['317205821'] = "Auto Shotgun",
['3441901897'] = "Battle Axe",
['125959754'] = "Cmp Launcher",
['3173288789'] = "SMG Mini",
['3125143736'] = "Pipebomb",
['2484171525'] = "Cue",
['419712736'] = "Wrench",
["-581044007"] = "Machete",
}

weaponNameToHash = { 
    ["WEAPON_UNARMED"] = 0xA2719263,
    ["WEAPON_ANIMAL"] = 0xF9FBAEBE,
    ["WEAPON_COUGAR"] = 0x08D4BE52,
    ["WEAPON_KNIFE"] = 0x99B507EA,
    ["WEAPON_NIGHTSTICK"] = 0x678B81B1,
    ["WEAPON_HAMMER"] = 0x4E875F73,
    ["WEAPON_BAT"] =    0x958A4A8F,
    ["WEAPON_GOLFCLUB"] =   0x440E4788,
    ["WEAPON_CROWBAR"] = 0x84BD7BFD,
    ["WEAPON_PISTOL"] = 0x1B06D571,
    ["WEAPON_COMBATPISTOL"] = 0x5EF9FEC4,
    ["WEAPON_APPISTOL"] = 0x22D8FE39,
    ["WEAPON_PISTOL50"] = 0x99AEEB3B,
    ["WEAPON_MICROSMG"] = 0x13532244,
    ["WEAPON_SMG"] = 0x2BE6766B,
    ["WEAPON_ASSAULTSMG"] = 0xEFE7E2DF,
    ["WEAPON_ASSAULTRIFLE"] = 0xBFEFFF6D,
    ["WEAPON_CARBINERIFLE"] = 0x83BF0278,
    ["WEAPON_ADVANCEDRIFLE"] = 0xAF113F99,
    ["WEAPON_MG"] = 0x9D07F764,
    ["WEAPON_COMBATMG"] = 0x7FD62962,
    ["WEAPON_PUMPSHOTGUN"] = 0x1D073A89,
    ["WEAPON_SAWNOFFSHOTGUN"] = 0x7846A318,
    ["WEAPON_ASSAULTSHOTGUN"] = 0xE284C527,
    ["WEAPON_BULLPUPSHOTGUN"] = 0x9D61E50F,
    ["WEAPON_STUNGUN"] = 0x3656C8C1,
    ["WEAPON_SNIPERRIFLE"] = 0x05FC3C11,
    ["WEAPON_HEAVYSNIPER"] = 0x0C472FE2,
    ["WEAPON_REMOTESNIPER"] = 0x33058E22,
    ["WEAPON_GRENADELAUNCHER"] = 0xA284510B,
    ["WEAPON_GRENADELAUNCHER_SMOKE"] = 0x4DD2DC56,
    ["WEAPON_RPG"] = 0xB1CA77B1,
    ["WEAPON_PASSENGER_ROCKET"] = 0x166218FF,
    ["WEAPON_AIRSTRIKE_ROCKET"] = 0x13579279,
    ["WEAPON_STINGER"] = 0x687652CE,
    ["WEAPON_MINIGUN"] = 0x42BF8A85,
    ["WEAPON_GRENADE"] = 0x93E220BD,
    ["WEAPON_STICKYBOMB"] = 0x2C3731D9,
    ["WEAPON_SMOKEGRENADE"] = 0xFDBC8A50,
    ["WEAPON_BZGAS"] = 0xA0973D5E,
    ["WEAPON_MOLOTOV"] = 0x24B17070,
    ["WEAPON_FIREEXTINGUISHER"] = 0x060EC506,
    ["WEAPON_PETROLCAN"] = 0x34A67B97,
    ["WEAPON_DIGISCANNER"] = 0xFDBADCED,
    ["WEAPON_BRIEFCASE"] = 0x88C78EB7,
    ["WEAPON_BRIEFCASE_02"] = 0x01B79F17,
    ["WEAPON_BALL"] = 0x23C9F95C,
    ["WEAPON_FLARE"] = 0x497FACC3,
    ["WEAPON_VEHICLE_ROCKET"] = 0xBEFDC581,
    ["WEAPON_BARBED_WIRE"] = 0x48E7B178,
    ["WEAPON_DROWNING"] = 0xFF58C4FB,
    ["WEAPON_DROWNING_IN_VEHICLE"] = 0x736F5990,
    ["WEAPON_BLEEDING"] = 0x8B7333FB,
    ["WEAPON_ELECTRIC_FENCE"] = 0x92BD4EBB,
    ["WEAPON_EXPLOSION"] = 0x2024F4E8,
    ["WEAPON_FALL"] = 0xCDC174B0,
    ["WEAPON_EXHAUSTION"] = 0x364A29EC,
    ["WEAPON_HIT_BY_WATER_CANNON"] = 0xCC34325E,
    ["WEAPON_RAMMED_BY_CAR"] = 0x07FC7D7A,
    ["WEAPON_RUN_OVER_BY_CAR"] = 0xA36D413E,
    ["WEAPON_HELI_CRASH"] = 0x145F1012,
    ["WEAPON_FIRE"] = 0xDF8E89EB,
    ["WEAPON_SNSPISTOL"] = 0xBFD21232,
    ["WEAPON_BOTTLE"] = 0xF9E6AA4B,
    ["WEAPON_GUSENBERG"] = 0x61012683,
    ["WEAPON_SPECIALCARBINE"] = 0xC0A3098D,
    ["WEAPON_HEAVYPISTOL"] = 0xD205520E,
    ["WEAPON_BULLPUPRIFLE"] = 0x7F229F94,
    ["WEAPON_DAGGER"] = 0x92A27487,
    ["WEAPON_VINTAGEPISTOL"] = 0x083839C4,
    ["WEAPON_FIREWORK"] = 0x7F7497E5,
    ["WEAPON_MUSKET"] = 0xA89CB99E,
    ["WEAPON_HEAVYSHOTGUN"] = 0x3AABBBAA,
    ["WEAPON_MARKSMANRIFLE"] = 0xC734385A,
    ["WEAPON_HOMINGLAUNCHER"] = 0x63AB0442,
    ["WEAPON_PROXMINE"] = 0xAB564B93,
    ["WEAPON_SNOWBALL"] = 0x787F0BB,
    ["WEAPON_FLAREGUN"] = 0x47757124,
    ["WEAPON_GARBAGEBAG"] = 0xE232C28C,
    ["WEAPON_HANDCUFFS"] = 0xD04C944D,
    ["WEAPON_COMBATPDW"] = 0x0A3D4D34,
    ["WEAPON_MARKSMANPISTOL"] = 0xDC4DB296,
    ["WEAPON_KNUCKLE"] = 0xD8DF3C3C,
    ["WEAPON_HATCHET"] = 0xF9DCBF2D,
    ["WEAPON_RAILGUN"] = 0x6D544C99,
    ["WEAPON_MACHETE"] = 0xDD5DF8D9,
    ["WEAPON_MACHINEPISTOL"] = 0xDB1AA450,
    ["WEAPON_AIR_DEFENCE_GUN"] = 0x2C082D7D,
    ["WEAPON_SWITCHBLADE"] = 0xDFE37640,
    ["WEAPON_REVOLVER"] = 0xC1B3C3D1,
    ["WEAPON_DBSHOTGUN"] = 0xEF951FBB ,
    ["WEAPON_COMPACTRIFLE"] = 0x624FE830,
    ["WEAPON_AUTOSHOTGUN"] = 0x12E82D3D,
    ["WEAPON_BATTLEAXE"] = 0xCD274149,
    ["WEAPON_COMPACTLAUNCHER"] = 0x0781FE4A,
    ["WEAPON_MINISMG"] = 0xBD248B55,
    ["WEAPON_PIPEBOMB"] = 0xBA45E8B8,
    ["WEAPON_POOLCUE"] = 0x94117305,
    ["WEAPON_WRENCH"] = 0x19044EE0  
}








decimalToName = {
["2725352035"] = "WEAPON_UNARMED",
["4194021054"] = "WEAPON_ANIMAL",
["148160082"] = "WEAPON_COUGAR",
["2578778090"] = "WEAPON_KNIFE",
["1737195953"] = "WEAPON_NIGHTSTICK",
["1317494643"] = "WEAPON_HAMMER",
["2508868239"] = "WEAPON_BAT",
["1141786504"] = "WEAPON_GOLFCLUB",
["2227010557"] = "WEAPON_CROWBAR",
["453432689"] = "WEAPON_PISTOL",
["1593441988"] = "WEAPON_COMBATPISTOL",
["584646201"] = "WEAPON_APPISTOL",
["2578377531"] = "WEAPON_PISTOL50",
["432421536"] = "WEAPON_MICROSMG",
["736523883"] = "WEAPON_SMG",
["4024951519"] = "WEAPON_ASSAULTSMG",
["3220176749"] = "WEAPON_ASSAULTRIFLE",
["2210333304"] = "WEAPON_CARBINERIFLE",
["2937143193"] = "WEAPON_ADVANCEDRIFLE",
["2634544996"] = "WEAPON_MG",
["2144741730"] = "WEAPON_COMBATMG",
["487013001"] = "WEAPON_PUMPSHOTGUN",
["2017895192"] = "WEAPON_SAWNOFFSHOTGUN",
["3800352039"] = "WEAPON_ASSAULTSHOTGUN",
["2640438543"] = "WEAPON_BULLPUPSHOTGUN",
["911657153"] = "WEAPON_STUNGUN",
["100416529"] = "WEAPON_SNIPERRIFLE",
["205991906"] = "WEAPON_HEAVYSNIPER",
["856002082"] = "WEAPON_REMOTESNIPER",
["2726580491"] = "WEAPON_GRENADELAUNCHER",
["1305664598"] = "WEAPON_GRENADELAUNCHER_SMOKE",
["2982836145"] = "WEAPON_RPG",
["375527679"] = "WEAPON_PASSENGER_ROCKET",
["324506233"] = "WEAPON_AIRSTRIKE_ROCKET",
["1752584910"] = "WEAPON_STINGER",
["1119849093"] = "WEAPON_MINIGUN",
["2481070269"] = "WEAPON_GRENADE",
["741814745"] = "WEAPON_STICKYBOMB",
["4256991824"] = "WEAPON_SMOKEGRENADE",
["2694266206"] = "WEAPON_BZGAS",
["615608432"] = "WEAPON_MOLOTOV",
["101631238"] = "WEAPON_FIREEXTINGUISHER",
["883325847"] = "WEAPON_PETROLCAN",
["4256881901"] = "WEAPON_DIGISCANNER",
["2294779575"] = "WEAPON_BRIEFCASE",
["28811031"] = "WEAPON_BRIEFCASE_02",
["600439132"] = "WEAPON_BALL",
["1233104067"] = "WEAPON_FLARE",
["3204302209"] = "WEAPON_VEHICLE_ROCKET",
["1223143800"] = "WEAPON_BARBED_WIRE",
["4284007675"] = "WEAPON_DROWNING",
["1936677264"] = "WEAPON_DROWNING_IN_VEHICLE",
["2339582971"] = "WEAPON_BLEEDING",
["2461879995"] = "WEAPON_ELECTRIC_FENCE",
["539292904"] = "WEAPON_EXPLOSION",
["3452007600"] = "WEAPON_FALL",
["910830060"] = "WEAPON_EXHAUSTION",
["3425972830"] = "WEAPON_HIT_BY_WATER_CANNON",
["133987706"] = "WEAPON_RAMMED_BY_CAR",
["2741846334"] = "WEAPON_RUN_OVER_BY_CAR",
["341774354"] = "WEAPON_HELI_CRASH",
["3750660587"] = "WEAPON_FIRE",
["3218215474"] = "WEAPON_SNSPISTOL",
["4192643659"] = "WEAPON_BOTTLE",
["1627465347"] = "WEAPON_GUSENBERG",
["3231910285"] = "WEAPON_SPECIALCARBINE",
["3523564046"] = "WEAPON_HEAVYPISTOL",
["2132975508"] = "WEAPON_BULLPUPRIFLE",
["2460120199"] = "WEAPON_DAGGER",
["137902532"] = "WEAPON_VINTAGEPISTOL",
["2138347493"] = "WEAPON_FIREWORK",
["2828843422"] = "WEAPON_MUSKET",
["984333226"] = "WEAPON_HEAVYSHOTGUN",
["3342088282"] = "WEAPON_MARKSMANRIFLE",
["1672152130"] = "WEAPON_HOMINGLAUNCHER",
["2874559379"] = "WEAPON_PROXMINE",
["126349499"] = "WEAPON_SNOWBALL",
["1198879012"] = "WEAPON_FLAREGUN",
["3794977420"] = "WEAPON_GARBAGEBAG",
["3494679629"] = "WEAPON_HANDCUFFS",
["171789620"] = "WEAPON_COMBATPDW",
["3696079510"] = "WEAPON_MARKSMANPISTOL",
["3638508604"] = "WEAPON_KNUCKLE",
["4191993645"] = "WEAPON_HATCHET",
["1834241177"] = "WEAPON_RAILGUN",
["3713923289"] = "WEAPON_MACHETE",
["3675956304"] = "WEAPON_MACHINEPISTOL",
["738733437"] = "WEAPON_AIR_DEFENCE_GUN",
["3756226112"] = "WEAPON_SWITCHBLADE",
["3249783761"] = "WEAPON_REVOLVER",
["4019527611"] = "WEAPON_DBSHOTGUN",
["1649403952"] = "WEAPON_COMPACTRIFLE",
["317205821"] = "WEAPON_AUTOSHOTGUN",
["3441901897"] = "WEAPON_BATTLEAXE",
["125959754"] = "WEAPON_COMPACTLAUNCHER",
["3173288789"] = "WEAPON_MINISMG",
["3125143736"] = "WEAPON_PIPEBOMB",
["2484171525"] = "WEAPON_POOLCUE",
["419712736"] = "WEAPON_WRENCH"
}


local currentlyrobbing = {}
local store = ""
local secondsRemaining = 0

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function DrawText3DTest(text)
    local x,y,z=table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.5, 0.0))
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
    local factor = 60 / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end


local storetype = 0
RegisterNetEvent('AppRobberies:currentlyrobbing')
AddEventHandler('AppRobberies:currentlyrobbing', function()
    if exports["srp-inventory"]:hasEnoughOfItem("lockpick",1) then
        checkRobbedStore()
        Citizen.Wait(1500)
        TriggerServerEvent("AppRobberies:rob",store,currentlyrobbing.xe, currentlyrobbing.ye, currentlyrobbing.ze,storetype)
    end
end)

RegisterNetEvent("weed:startcropInsideCheck")
AddEventHandler("weed:startcropInsideCheck", function(weedType)
	if entryType == 2 then
		TriggerEvent("weed:startcrop",weedType)
	end
end)

RegisterNetEvent('AppRobberies:startRobbery')
AddEventHandler('AppRobberies:startRobbery', function()
     for i,v in pairs(interiors) do
        if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xe,interiors[i].ye,interiors[i].ze)) < 2 then
            TriggerEvent("robbery:appartmentName",interiors[i].name)
            -- this event no longer exist's 
            TriggerServerEvent("robbery:startRobberyForClient",{interiors[i].xe,interiors[i].ye,interiors[i].ze},1,21,"appartments",0,{1,8,3,3},{1,3,6,6},10)
        end
    end
end)
RegisterNetEvent('AppRobberies:StockChange')
AddEventHandler('AppRobberies:StockChange', function()
    if storetype == 2 or storetype == 4 or storetype == 5 or storetype == 6 or storetype == 1 then
        if math.random(100) > 80 then
            local amount = math.random(10) / 10
            TriggerServerEvent("stocks:reducestock",storetype,amount)
        end
    end
    storetype = 0
end)

function checkRobbedStore()
     for i,v in pairs(interiors) do
        if #(GetEntityCoords(PlayerPedId()) - vector3(interiors[i].xe,interiors[i].ye,interiors[i].ze)) < 2 then
            currentlyrobbing = interiors[i]
            store = interiors[i].name
            storeType = interiors[i].TypeOfProperty
        end
    end
end

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

drugspots = {
	[1] =  { ['x'] = 49.22,['y'] = -1893.67,['z'] = 21.79,['h'] = 201.41, ['info'] = ' drug spot 1' },
	[2] =  { ['x'] = -125.16,['y'] = -1535.4,['z'] = 34.14,['h'] = 200.84, ['info'] = ' drug spot 2' },
	[3] =  { ['x'] = 1242.16,['y'] = -1613.26,['z'] = 52.6,['h'] = 200.34, ['info'] = ' drug spot 3' },
}

robberycoordsMansions = {
	[1] =  { ['x'] = -7.22,['y'] = 409.2,['z'] = 120.13,['h'] = 76.61, ['info'] = ' Didion Drive 1', ["office"] = 2 },
	[2] =  { ['x'] = -73.12,['y'] = 427.51,['z'] = 113.04,['h'] = 157.75, ['info'] = ' Didion Drive 2', ["office"] = 2 },
	[3] =  { ['x'] = -166.83,['y'] = 425.11,['z'] = 111.8,['h'] = 15.34, ['info'] = ' Didion Drive 3', ["office"] = 2 },
	[4] =  { ['x'] = 38.08,['y'] = 365.11,['z'] = 116.05,['h'] = 221.39, ['info'] = ' Didion Drive 4', ["office"] = 2 },
	[5] =  { ['x'] = -214.09,['y'] = 399.86,['z'] = 111.31,['h'] = 13.43, ['info'] = ' Didion Drive 5', ["office"] = 2 },
	[6] =  { ['x'] = -239.04,['y'] = 381.64,['z'] = 112.62,['h'] = 111.63, ['info'] = ' Didion Drive 6', ["office"] = 2 },
	[7] =  { ['x'] = -297.74,['y'] = 380.3,['z'] = 112.1,['h'] = 11.17, ['info'] = ' Didion Drive 7', ["office"] = 2 },
	[8] =  { ['x'] = -328.28,['y'] = 369.99,['z'] = 110.01,['h'] = 20.95, ['info'] = ' Didion Drive 8', ["office"] = 2 },
	[9] =  { ['x'] = -371.8,['y'] = 344.28,['z'] = 109.95,['h'] = 3.39, ['info'] = ' Didion Drive 9', ["office"] = 2 },
	[10] =  { ['x'] = -408.92,['y'] = 341.67,['z'] = 108.91,['h'] = 274.84, ['info'] = ' Didion Drive 10', ["office"] = 2 },
	[11] =  { ['x'] = -444.27,['y'] = 343.86,['z'] = 105.39,['h'] = 184.95, ['info'] = ' Didion Drive 11', ["office"] = 2 },
	[12] =  { ['x'] = -468.94,['y'] = 329.99,['z'] = 104.49,['h'] = 241.99, ['info'] = ' Didion Drive 12', ["office"] = 2 },
	[13] =  { ['x'] = -305.22,['y'] = 431.56,['z'] = 110.31,['h'] = 10.16, ['info'] = ' Cox Way 1', ["office"] = 0 },
	[14] =  { ['x'] = -371.86,['y'] = 408.06,['z'] = 110.6,['h'] = 115.71, ['info'] = ' Cox Way 2', ["office"] = 0 },
	[15] =  { ['x'] = -400.54,['y'] = 427.2,['z'] = 112.35,['h'] = 246.04, ['info'] = ' Cox Way 3', ["office"] = 0 },
	[16] =  { ['x'] = -451.53,['y'] = 395.61,['z'] = 104.78,['h'] = 85.78, ['info'] = ' Cox Way 4', ["office"] = 0 },
	[17] =  { ['x'] = -477.33,['y'] = 413.03,['z'] = 103.13,['h'] = 185.61, ['info'] = ' Cox Way 5', ["office"] = 0 },
	[18] =  { ['x'] = -500.49,['y'] = 398.66,['z'] = 98.15,['h'] = 54.31, ['info'] = ' Cox Way 6', ["office"] = 0 },
	[19] =  { ['x'] = -516.95,['y'] = 433.19,['z'] = 97.81,['h'] = 130.67, ['info'] = ' Cox Way 7', ["office"] = 0 },
	[20] =  { ['x'] = -561.08,['y'] = 403.19,['z'] = 101.81,['h'] = 17.43, ['info'] = ' Milton Road 1', ["office"] = 2 },
	[21] =  { ['x'] = -595.7,['y'] = 393.54,['z'] = 101.89,['h'] = 3.1, ['info'] = ' Milton Road 2', ["office"] = 2 },
	[22] =  { ['x'] = -615.57,['y'] = 399.15,['z'] = 101.24,['h'] = 5.39, ['info'] = ' Milton Road 3', ["office"] = 2 },
	[23] =  { ['x'] = 223.17,['y'] = 514.43,['z'] = 140.77,['h'] = 38.98, ['info'] = ' Wild Oats Drive 1', ["office"] = 2 },
	[24] =  { ['x'] = -500.27,['y'] = 552.37,['z'] = 120.43,['h'] = 326.56, ['info'] = ' Didion Drive 21', ["office"] = 2 },
	[25] =  { ['x'] = 118.82,['y'] = 494.01,['z'] = 147.35,['h'] = 106.07, ['info'] = ' Wild Oats Drive 3', ["office"] = 2 },
	[26] =  { ['x'] = 106.9,['y'] = 467.73,['z'] = 147.38,['h'] = 2.1, ['info'] = ' Wild Oats Drive 4', ["office"] = 2 },
	[27] =  { ['x'] = 80.21,['y'] = 485.85,['z'] = 148.21,['h'] = 208.96, ['info'] = ' Wild Oats Drive 5', ["office"] = 2 },
	[28] =  { ['x'] = 57.84,['y'] = 450.05,['z'] = 147.04,['h'] = 328.16, ['info'] = ' Wild Oats Drive 6', ["office"] = 2 },
	[29] =  { ['x'] = 42.98,['y'] = 468.72,['z'] = 148.1,['h'] = 169.75, ['info'] = ' Wild Oats Drive 7', ["office"] = 2 },
	[30] =  { ['x'] = -7.79,['y'] = 468.12,['z'] = 145.86,['h'] = 341.41, ['info'] = ' Wild Oats Drive 8', ["office"] = 2 },
	[31] =  { ['x'] = -66.83,['y'] = 490.18,['z'] = 144.89,['h'] = 338.4, ['info'] = ' Wild Oats Drive 9', ["office"] = 2 },
	[32] =  { ['x'] = -109.87,['y'] = 502.01,['z'] = 143.48,['h'] = 347.61, ['info'] = ' Wild Oats Drive 10', ["office"] = 2 },
	[33] =  { ['x'] = -174.76,['y'] = 502.6,['z'] = 137.43,['h'] = 91.98, ['info'] = ' Wild Oats Drive 11', ["office"] = 2 },
	[34] =  { ['x'] = -230.26,['y'] = 488.43,['z'] = 128.77,['h'] = 1.71, ['info'] = ' Wild Oats Drive 12', ["office"] = 2 },
	[36] =  { ['x'] = 232.01,['y'] = 672.55,['z'] = 189.95,['h'] = 38.31, ['info'] = ' Whispymound Drive 1', ["office"] = 2 },
	[37] =  { ['x'] = 216.04,['y'] = 620.57,['z'] = 187.64,['h'] = 71.57, ['info'] = ' Whispymound Drive 2', ["office"] = 2 },
	[38] =  { ['x'] = 184.86,['y'] = 571.73,['z'] = 183.34,['h'] = 284.56, ['info'] = ' Whispymound Drive 3', ["office"] = 2 },
	[39] =  { ['x'] = 128.18,['y'] = 566.05,['z'] = 183.96,['h'] = 3.58, ['info'] = ' Whispymound Drive 4', ["office"] = 2 },
	[40] =  { ['x'] = 84.89,['y'] = 561.77,['z'] = 182.78,['h'] = 1.88, ['info'] = ' Whispymound Drive 5', ["office"] = 2 },
	[41] =  { ['x'] = 45.75,['y'] = 556.64,['z'] = 180.09,['h'] = 18.32, ['info'] = ' Whispymound Drive 6', ["office"] = 2 },
	[42] =  { ['x'] = 8.41,['y'] = 540.01,['z'] = 176.03,['h'] = 332.48, ['info'] = ' Whispymound Drive 7', ["office"] = 2 },
	[43] =  { ['x'] = 228.52,['y'] = 765.89,['z'] = 204.79,['h'] = 59.33, ['info'] = ' Kimble Hill Drive 1', ["office"] = 2 },
	[44] =  { ['x'] = -126.46,['y'] = 588.54,['z'] = 204.72,['h'] = 359.66, ['info'] = ' Kimble Hill Drive 2', ["office"] = 2 },
	[45] =  { ['x'] = -185.28,['y'] = 591.2,['z'] = 197.83,['h'] = 357.1, ['info'] = ' Kimble Hill Drive 3', ["office"] = 2 },
	[46] =  { ['x'] = -189.57,['y'] = 617.86,['z'] = 199.67,['h'] = 190.04, ['info'] = ' Kimble Hill Drive 4', ["office"] = 2 },
	[47] =  { ['x'] = -232.61,['y'] = 589.02,['z'] = 190.54,['h'] = 353.79, ['info'] = ' Kimble Hill Drive 5', ["office"] = 2 },
	[48] =  { ['x'] = -256.67,['y'] = 632.44,['z'] = 187.81,['h'] = 75.18, ['info'] = ' Kimble Hill Drive 6', ["office"] = 2 },
	[49] =  { ['x'] = -293.54,['y'] = 600.83,['z'] = 181.58,['h'] = 348.16, ['info'] = ' Kimble Hill Drive 7', ["office"] = 2 },
	[50] =  { ['x'] = -299.18,['y'] = 635.27,['z'] = 175.69,['h'] = 118.75, ['info'] = ' Kimble Hill Drive 8', ["office"] = 2 },
	[51] =  { ['x'] = -339.79,['y'] = 668.58,['z'] = 172.79,['h'] = 254.73, ['info'] = ' Kimble Hill Drive 9', ["office"] = 2 },
	[52] =  { ['x'] = -340.03,['y'] = 625.84,['z'] = 171.36,['h'] = 57.48, ['info'] = ' Kimble Hill Drive 10', ["office"] = 2 },
	[53] =  { ['x'] = -400.12,['y'] = 664.99,['z'] = 163.84,['h'] = 352.99, ['info'] = ' Kimble Hill Drive 11', ["office"] = 2 },
	[54] =  { ['x'] = -445.88,['y'] = 685.71,['z'] = 152.96,['h'] = 202.25, ['info'] = ' Kimble Hill Drive 12', ["office"] = 2 },
	[55] =  { ['x'] = -476.73,['y'] = 648.15,['z'] = 144.39,['h'] = 14.58, ['info'] = ' Kimble Hill Drive 13', ["office"] = 2 },
	[56] =  { ['x'] = -595.47,['y'] = 530.13,['z'] = 107.76,['h'] = 196.13, ['info'] = ' Picture Perfect Drive 1', ["office"] = 2 },
	[57] =  { ['x'] = -580.6,['y'] = 492.09,['z'] = 108.91,['h'] = 10.17, ['info'] = ' Picture Perfect Drive 2', ["office"] = 2 },
	[58] =  { ['x'] = -622.94,['y'] = 489.34,['z'] = 108.85,['h'] = 5.51, ['info'] = ' Picture Perfect Drive 3', ["office"] = 2 },
	[59] =  { ['x'] = -640.95,['y'] = 519.88,['z'] = 109.69,['h'] = 182.77, ['info'] = ' Picture Perfect Drive 4', ["office"] = 2 },
	[60] =  { ['x'] = -667.47,['y'] = 472.42,['z'] = 114.14,['h'] = 13.3, ['info'] = ' Picture Perfect Drive 5', ["office"] = 2 },
	[61] =  { ['x'] = -679.0,['y'] = 512.16,['z'] = 113.53,['h'] = 197.35, ['info'] = ' Picture Perfect Drive 6', ["office"] = 2 },
	[62] =  { ['x'] = -721.23,['y'] = 490.13,['z'] = 109.39,['h'] = 208.02, ['info'] = ' Picture Perfect Drive 7', ["office"] = 2 },
	[63] =  { ['x'] = -718.16,['y'] = 449.2,['z'] = 106.91,['h'] = 20.93, ['info'] = ' Picture Perfect Drive 8', ["office"] = 2 },
	[64] =  { ['x'] = -784.21,['y'] = 459.01,['z'] = 100.18,['h'] = 212.24, ['info'] = ' Picture Perfect Drive 9', ["office"] = 2 },
	[65] =  { ['x'] = -762.31,['y'] = 431.49,['z'] = 100.2,['h'] = 15.68, ['info'] = ' Picture Perfect Drive 10', ["office"] = 2 },
	[66] =  { ['x'] = -824.95,['y'] = 422.82,['z'] = 92.13,['h'] = 6.05, ['info'] = ' Picture Perfect Drive 11', ["office"] = 2 },
	[67] =  { ['x'] = -559.45,['y'] = 663.99,['z'] = 145.49,['h'] = 337.57, ['info'] = ' Normandy Drive 1', ["office"] = 2 },
	[68] =  { ['x'] = -564.36,['y'] = 684.27,['z'] = 146.42,['h'] = 203.91, ['info'] = ' Normandy Drive 2', ["office"] = 2 },
	[69] =  { ['x'] = -605.93,['y'] = 672.75,['z'] = 151.6,['h'] = 345.9, ['info'] = ' Normandy Drive 3', ["office"] = 2 },
	[70] =  { ['x'] = -708.57,['y'] = 712.76,['z'] = 162.21,['h'] = 272.94, ['info'] = ' Normandy Drive 4', ["office"] = 2 },
	[71] =  { ['x'] = -646.4,['y'] = 740.98,['z'] = 174.29,['h'] = 38.54, ['info'] = ' Normandy Drive 5', ["office"] = 2 },
	[72] =  { ['x'] = -579.87,['y'] = 733.37,['z'] = 184.22,['h'] = 7.9, ['info'] = ' Normandy Drive 6', ["office"] = 2 },
	[73] =  { ['x'] = -597.52,['y'] = 763.76,['z'] = 189.13,['h'] = 210.93, ['info'] = ' Normandy Drive 7', ["office"] = 2 },
	[74] =  { ['x'] = -595.54,['y'] = 780.72,['z'] = 189.12,['h'] = 296.9, ['info'] = ' Normandy Drive 8', ["office"] = 2 },
	[75] =  { ['x'] = -600.0,['y'] = 807.57,['z'] = 191.53,['h'] = 191.89, ['info'] = ' Normandy Drive 9', ["office"] = 2 },
	[76] =  { ['x'] = -655.22,['y'] = 803.0,['z'] = 199.0,['h'] = 357.23, ['info'] = ' Normandy Drive 10', ["office"] = 2 },
	[77] =  { ['x'] = -747.0,['y'] = 808.49,['z'] = 215.04,['h'] = 288.83, ['info'] = ' Normandy Drive 11', ["office"] = 2 },
	[78] =  { ['x'] = -824.35,['y'] = 806.44,['z'] = 202.79,['h'] = 15.32, ['info'] = ' North Sheldon Ave 1', ["office"] = 2 },
	[79] =  { ['x'] = -867.25,['y'] = 785.09,['z'] = 191.94,['h'] = 3.26, ['info'] = ' North Sheldon Ave 2', ["office"] = 2 },
	[80] =  { ['x'] = -912.39,['y'] = 778.25,['z'] = 187.02,['h'] = 2.82, ['info'] = ' North Sheldon Ave 3', ["office"] = 2 },
	[81] =  { ['x'] = -931.8,['y'] = 808.57,['z'] = 184.79,['h'] = 181.85, ['info'] = ' North Sheldon Ave 4', ["office"] = 2 },
	[82] =  { ['x'] = -962.78,['y'] = 813.66,['z'] = 177.57,['h'] = 183.43, ['info'] = ' North Sheldon Ave 5', ["office"] = 2 },
	[83] =  { ['x'] = -998.42,['y'] = 815.67,['z'] = 173.05,['h'] = 224.1, ['info'] = ' North Sheldon Ave 6', ["office"] = 2 },
	[84] =  { ['x'] = -972.8,['y'] = 752.81,['z'] = 176.39,['h'] = 43.1, ['info'] = ' North Sheldon Ave 7', ["office"] = 2 },
	[85] =  { ['x'] = -1067.57,['y'] = 795.05,['z'] = 166.93,['h'] = 183.88, ['info'] = ' North Sheldon Ave 8', ["office"] = 2 },
	[86] =  { ['x'] = -1100.53,['y'] = 797.36,['z'] = 167.26,['h'] = 184.42, ['info'] = ' North Sheldon Ave 9', ["office"] = 2 },
	[87] =  { ['x'] = -1117.75,['y'] = 761.5,['z'] = 164.29,['h'] = 22.96, ['info'] = ' North Sheldon Ave 10', ["office"] = 2 },
	[88] =  { ['x'] = -1165.36,['y'] = 727.02,['z'] = 155.61,['h'] = 320.97, ['info'] = ' North Sheldon Ave 11', ["office"] = 2 },
	[89] =  { ['x'] = -1197.14,['y'] = 693.54,['z'] = 147.43,['h'] = 58.55, ['info'] = ' North Sheldon Ave 12', ["office"] = 2 },
	[90] =  { ['x'] = -1218.75,['y'] = 665.49,['z'] = 144.54,['h'] = 36.9, ['info'] = ' North Sheldon Ave 13', ["office"] = 2 },
	[91] =  { ['x'] = -1241.58,['y'] = 674.09,['z'] = 142.82,['h'] = 163.44, ['info'] = ' North Sheldon Ave 14', ["office"] = 2 },
	[92] =  { ['x'] = -1248.57,['y'] = 643.07,['z'] = 142.7,['h'] = 298.47, ['info'] = ' North Sheldon Ave 15', ["office"] = 2 },
	[93] =  { ['x'] = -1291.69,['y'] = 649.68,['z'] = 141.51,['h'] = 195.36, ['info'] = ' North Sheldon Ave 16', ["office"] = 2 },
	[94] =  { ['x'] = -1277.65,['y'] = 630.03,['z'] = 143.19,['h'] = 126.27, ['info'] = ' North Sheldon Ave 17', ["office"] = 2 },
	[95] =  { ['x'] = -1405.62,['y'] = 526.89,['z'] = 123.84,['h'] = 89.48, ['info'] = ' North Sheldon Ave 18', ["office"] = 2 },
	[96] =  { ['x'] = -1413.54,['y'] = 462.68,['z'] = 109.21,['h'] = 343.64, ['info'] = ' North Sheldon Ave 19', ["office"] = 2 },
	[97] =  { ['x'] = -1371.72,['y'] = 444.01,['z'] = 105.86,['h'] = 77.97, ['info'] = ' North Sheldon Ave 20', ["office"] = 2 },
	[98] =  { ['x'] = -1339.34,['y'] = 471.13,['z'] = 106.41,['h'] = 177.88, ['info'] = ' North Sheldon Ave 21', ["office"] = 2 },
	[99] =  { ['x'] = -1308.17,['y'] = 449.21,['z'] = 100.97,['h'] = 3.49, ['info'] = ' North Sheldon Ave 22', ["office"] = 2 },
	[100] =  { ['x'] = -1258.6,['y'] = 447.05,['z'] = 94.74,['h'] = 311.7, ['info'] = ' North Sheldon Ave 23', ["office"] = 2 },
	[101] =  { ['x'] = -1215.87,['y'] = 458.05,['z'] = 92.07,['h'] = 4.39, ['info'] = ' North Sheldon Ave 24', ["office"] = 2 },
	[102] =  { ['x'] = -1174.82,['y'] = 440.32,['z'] = 86.85,['h'] = 81.56, ['info'] = ' North Sheldon Ave 25', ["office"] = 2 },
	[103] =  { ['x'] = -1158.66,['y'] = 480.9,['z'] = 86.1,['h'] = 183.19, ['info'] = ' North Sheldon Ave 26', ["office"] = 2 },
	[104] =  { ['x'] = -1122.64,['y'] = 485.93,['z'] = 82.17,['h'] = 155.84, ['info'] = ' North Sheldon Ave 27', ["office"] = 2 },
	[105] =  { ['x'] = -1062.21,['y'] = 475.61,['z'] = 81.33,['h'] = 230.89, ['info'] = ' North Sheldon Ave 28', ["office"] = 2 },
	[106] =  { ['x'] = -1094.54,['y'] = 427.26,['z'] = 75.89,['h'] = 264.53, ['info'] = ' North Sheldon Ave 29', ["office"] = 2 },
	[107] =  { ['x'] = -1052.06,['y'] = 432.39,['z'] = 77.21,['h'] = 7.15, ['info'] = ' North Sheldon Ave 30', ["office"] = 2 },
	[108] =  { ['x'] = -1040.23,['y'] = 507.84,['z'] = 84.39,['h'] = 218.27, ['info'] = ' Cockingend Drive 1', ["office"] = 2 },
	[109] =  { ['x'] = -1009.28,['y'] = 479.67,['z'] = 79.42,['h'] = 325.07, ['info'] = ' Cockingend Drive 2', ["office"] = 2 },
	[110] =  { ['x'] = -1007.1,['y'] = 513.14,['z'] = 79.6,['h'] = 192.26, ['info'] = ' Cockingend Drive 3', ["office"] = 2 },
	[111] =  { ['x'] = -987.16,['y'] = 487.53,['z'] = 82.47,['h'] = 12.96, ['info'] = ' Cockingend Drive 4', ["office"] = 2 },
	[112] =  { ['x'] = -967.77,['y'] = 509.88,['z'] = 81.87,['h'] = 147.25, ['info'] = ' Cockingend Drive 5', ["office"] = 2 },
	[113] =  { ['x'] = -968.3,['y'] = 436.62,['z'] = 80.58,['h'] = 243.25, ['info'] = ' Cockingend Drive 6', ["office"] = 2 },
	[114] =  { ['x'] = -951.21,['y'] = 465.01,['z'] = 80.81,['h'] = 103.16, ['info'] = ' Cockingend Drive 7', ["office"] = 2 },
	[115] =  { ['x'] = -881.89,['y'] = 364.08,['z'] = 85.37,['h'] = 47.53, ['info'] = ' South Milton Drive 1', ["office"] = 2 },
	[116] =  { ['x'] = -877.38,['y'] = 306.49,['z'] = 84.16,['h'] = 239.34, ['info'] = ' South Milton Drive 2', ["office"] = 2 },
	[117] =  { ['x'] = -819.44,['y'] = 267.78,['z'] = 86.4,['h'] = 71.66, ['info'] = ' South Milton Drive 3', ["office"] = 2 },
	[118] =  { ['x'] = -1673.21,['y'] = 385.62,['z'] = 89.35,['h'] = 348.67, ['info'] = ' Ace Jones Drive 1', ["office"] = 2 },
	[119] =  { ['x'] = -1733.29,['y'] = 379.28,['z'] = 89.73,['h'] = 26.89, ['info'] = ' Ace Jones Drive 2', ["office"] = 2 },
	[120] =  { ['x'] = -1807.89,['y'] = 333.46,['z'] = 89.57,['h'] = 18.15, ['info'] = ' Ace Jones Drive 3', ["office"] = 2 },
	[121] =  { ['x'] = -1840.12,['y'] = 314.21,['z'] = 90.92,['h'] = 97.64, ['info'] = ' Ace Jones Drive 4', ["office"] = 2 },
	[122] =  { ['x'] = -1896.51,['y'] = 642.31,['z'] = 130.21,['h'] = 136.27, ['info'] = ' North Rockford Drive 1', ["office"] = 0 },
	[123] =  { ['x'] = -1974.69,['y'] = 630.97,['z'] = 122.56,['h'] = 244.46, ['info'] = ' North Rockford Drive 2', ["office"] = 0 },
	[124] =  { ['x'] = -1928.92,['y'] = 595.29,['z'] = 122.48,['h'] = 70.38, ['info'] = ' North Rockford Drive 3', ["office"] = 0 },
	[125] =  { ['x'] = -1995.83,['y'] = 591.1,['z'] = 117.91,['h'] = 255.27, ['info'] = ' North Rockford Drive 4', ["office"] = 0 },
	[126] =  { ['x'] = -1938.06,['y'] = 551.39,['z'] = 114.83,['h'] = 71.14, ['info'] = ' North Rockford Drive 5', ["office"] = 0 },
	[127] =  { ['x'] = -2014.74,['y'] = 499.75,['z'] = 107.18,['h'] = 254.8, ['info'] = ' North Rockford Drive 6', ["office"] = 0 },
	[128] =  { ['x'] = -2010.5,['y'] = 445.16,['z'] = 103.02,['h'] = 287.53, ['info'] = ' North Rockford Drive 7', ["office"] = 0 },
	[129] =  { ['x'] = -1943.04,['y'] = 449.65,['z'] = 102.93,['h'] = 94.15, ['info'] = ' North Rockford Drive 8', ["office"] = 0 },
	[130] =  { ['x'] = -1940.6,['y'] = 387.59,['z'] = 96.51,['h'] = 180.44, ['info'] = ' North Rockford Drive 9', ["office"] = 0 },
	[131] =  { ['x'] = -2008.4,['y'] = 367.49,['z'] = 94.82,['h'] = 271.42, ['info'] = ' North Rockford Drive 10', ["office"] = 0 },
	[132] =  { ['x'] = -1931.9,['y'] = 362.4,['z'] = 93.79,['h'] = 100.74, ['info'] = ' North Rockford Drive 11', ["office"] = 0 },
	[133] =  { ['x'] = -1922.71,['y'] = 298.25,['z'] = 89.29,['h'] = 101.68, ['info'] = ' North Rockford Drive 12', ["office"] = 0 },
	[134] =  { ['x'] = -1995.39,['y'] = 300.71,['z'] = 91.97,['h'] = 194.4, ['info'] = ' North Rockford Drive 13', ["office"] = 0 },
	[135] =  { ['x'] = -1970.35,['y'] = 246.02,['z'] = 87.82,['h'] = 288.31, ['info'] = ' North Rockford Drive 14', ["office"] = 0 },
	[136] =  { ['x'] = -1905.85,['y'] = 252.77,['z'] = 86.46,['h'] = 118.33, ['info'] = ' North Rockford Drive 15', ["office"] = 0 },
	[137] =  { ['x'] = -1960.68,['y'] = 212.18,['z'] = 86.81,['h'] = 292.54, ['info'] = ' North Rockford Drive 16', ["office"] = 0 },
	[138] =  { ['x'] = -1931.54,['y'] = 163.05,['z'] = 84.66,['h'] = 306.94, ['info'] = ' North Rockford Drive 17', ["office"] = 0 },
	[139] =  { ['x'] = -1874.07,['y'] = 201.7,['z'] = 84.3,['h'] = 126.1, ['info'] = ' North Rockford Drive 18', ["office"] = 0 },
	[35] =  { ['x'] = -1898.8,['y'] = 132.56,['z'] = 81.99,['h'] = 304.26, ['info'] = ' North Rockford Drive 19', ["office"] = 0 },
	[140] =  { ['x'] = -1277.93,['y'] = 496.96,['z'] = 97.9,['h'] = 267.14, ['info'] = ' South Milton Drive 4', ["office"] = 2 },
	[141] =  { ['x'] = -1217.77,['y'] = 506.28,['z'] = 95.67,['h'] = 183.16, ['info'] = ' South Milton Drive 5', ["office"] = 2 },
	[142] =  { ['x'] = -1193.24,['y'] = 563.98,['z'] = 100.34,['h'] = 177.86, ['info'] = ' South Milton Drive 6', ["office"] = 2 },
	[143] =  { ['x'] = -1167.09,['y'] = 568.39,['z'] = 101.83,['h'] = 185.02, ['info'] = ' South Milton Drive 7', ["office"] = 2 },
	[144] =  { ['x'] = -1146.44,['y'] = 545.9,['z'] = 101.91,['h'] = 8.29, ['info'] = ' South Milton Drive 8', ["office"] = 2 },
	[145] =  { ['x'] = -1125.53,['y'] = 548.84,['z'] = 102.58,['h'] = 15.51, ['info'] = ' South Milton Drive 9', ["office"] = 2 },
	[146] =  { ['x'] = -1107.35,['y'] = 593.97,['z'] = 104.46,['h'] = 201.56, ['info'] = ' South Milton Drive 10', ["office"] = 2 },
	[147] =  { ['x'] = -1090.59,['y'] = 547.98,['z'] = 103.64,['h'] = 118.25, ['info'] = ' South Milton Drive 11', ["office"] = 2 },
	[148] =  { ['x'] = -1022.79,['y'] = 586.92,['z'] = 103.43,['h'] = 1.01, ['info'] = ' South Milton Drive 12', ["office"] = 2 },
	[149] =  { ['x'] = -974.35,['y'] = 582.06,['z'] = 102.93,['h'] = 348.81, ['info'] = ' South Milton Drive 13', ["office"] = 2 },
	[150] =  { ['x'] = -958.18,['y'] = 606.44,['z'] = 106.06,['h'] = 351.99, ['info'] = ' South Milton Drive 14', ["office"] = 2 },
	[151] =  { ['x'] = -947.7,['y'] = 567.89,['z'] = 101.5,['h'] = 338.32, ['info'] = ' South Milton Drive 15', ["office"] = 2 },
	[152] =  { ['x'] = -924.9,['y'] = 561.31,['z'] = 100.16,['h'] = 336.51, ['info'] = ' South Milton Drive 16', ["office"] = 2 },
	[153] =  { ['x'] = -904.82,['y'] = 587.84,['z'] = 101.19,['h'] = 147.44, ['info'] = ' South Milton Drive 17', ["office"] = 2 },
	[154] =  { ['x'] = -907.28,['y'] = 545.09,['z'] = 100.21,['h'] = 315.89, ['info'] = ' South Milton Drive 18', ["office"] = 2 },
	[155] =  { ['x'] = -873.79,['y'] = 562.75,['z'] = 96.62,['h'] = 128.14, ['info'] = ' South Milton Drive 19', ["office"] = 2 },
	[156] =  { ['x'] = -884.33,['y'] = 517.9,['z'] = 92.45,['h'] = 285.97, ['info'] = ' South Milton Drive 20', ["office"] = 2 },
	[157] =  { ['x'] = -848.74,['y'] = 508.88,['z'] = 90.82,['h'] = 14.95, ['info'] = ' South Milton Drive 21', ["office"] = 2 },
	[158] =  { ['x'] = -875.67,['y'] = 486.18,['z'] = 87.82,['h'] = 9.53, ['info'] = ' South Milton Drive 22', ["office"] = 2 },
	[159] =  { ['x'] = -843.25,['y'] = 466.64,['z'] = 87.6,['h'] = 278.4, ['info'] = ' South Milton Drive 23', ["office"] = 2 },
	[160] =  { ['x'] = -686.06,['y'] = 596.22,['z'] = 143.65,['h'] = 38.28, ['info'] = ' Hillcrest Avenue 1', ["office"] = 2 },
	[161] =  { ['x'] = -704.22,['y'] = 588.97,['z'] = 141.94,['h'] = 0.48, ['info'] = ' Hillcrest Avenue 2', ["office"] = 2 },
	[162] =  { ['x'] = -732.89,['y'] = 593.9,['z'] = 142.24,['h'] = 330.96, ['info'] = ' Hillcrest Avenue 3', ["office"] = 2 },
	[163] =  { ['x'] = -752.6,['y'] = 620.49,['z'] = 142.5,['h'] = 286.32, ['info'] = ' Hillcrest Avenue 4', ["office"] = 2 },
	[164] =  { ['x'] = -765.26,['y'] = 650.61,['z'] = 145.51,['h'] = 290.11, ['info'] = ' Hillcrest Avenue 5', ["office"] = 2 },
	[165] =  { ['x'] = -819.35,['y'] = 696.63,['z'] = 148.11,['h'] = 17.47, ['info'] = ' Hillcrest Avenue 6', ["office"] = 2 },
	[166] =  { ['x'] = -852.97,['y'] = 695.64,['z'] = 148.79,['h'] = 1.41, ['info'] = ' Hillcrest Avenue 7', ["office"] = 2 },
	[167] =  { ['x'] = -884.72,['y'] = 699.56,['z'] = 151.28,['h'] = 67.64, ['info'] = ' Hillcrest Avenue 8', ["office"] = 2 },
	[168] =  { ['x'] = -908.78,['y'] = 693.66,['z'] = 151.44,['h'] = 359.17, ['info'] = ' Hillcrest Avenue 9', ["office"] = 2 },
	[169] =  { ['x'] = -931.55,['y'] = 691.14,['z'] = 153.47,['h'] = 357.54, ['info'] = ' Hillcrest Avenue 10', ["office"] = 2 },
	[170] =  { ['x'] = -973.89,['y'] = 684.48,['z'] = 158.04,['h'] = 171.97, ['info'] = ' Hillcrest Avenue 11', ["office"] = 2 },
	[171] =  { ['x'] = -1032.72,['y'] = 686.05,['z'] = 161.31,['h'] = 88.24, ['info'] = ' Hillcrest Avenue 12', ["office"] = 2 },
	[172] =  { ['x'] = -1065.09,['y'] = 727.52,['z'] = 165.48,['h'] = 2.2, ['info'] = ' Hillcrest Avenue 13', ["office"] = 2 },
	[173] =  { ['x'] = -1056.3,['y'] = 761.4,['z'] = 167.32,['h'] = 261.94, ['info'] = ' Hillcrest Avenue 14', ["office"] = 2 },
	[174] =  { ['x'] = -658.48,['y'] = 886.73,['z'] = 229.25,['h'] = 2.13, ['info'] = ' Milton Road 4', ["office"] = 2 },
	[175] =  { ['x'] = -596.99,['y'] = 851.56,['z'] = 211.47,['h'] = 42.36, ['info'] = ' Milton Road 5', ["office"] = 2 },
	[176] =  { ['x'] = -536.75,['y'] = 818.37,['z'] = 197.52,['h'] = 339.07, ['info'] = ' Milton Road 6', ["office"] = 2 },
	[177] =  { ['x'] = -493.97,['y'] = 795.97,['z'] = 184.34,['h'] = 51.78, ['info'] = ' Milton Road 7', ["office"] = 2 },
	[178] =  { ['x'] = -495.43,['y'] = 738.69,['z'] = 163.04,['h'] = 313.52, ['info'] = ' Milton Road 8', ["office"] = 2 },
	[179] =  { ['x'] = -533.09,['y'] = 709.41,['z'] = 153.16,['h'] = 191.95, ['info'] = ' Milton Road 9', ["office"] = 2 },
	[180] =  { ['x'] = -499.07,['y'] = 682.71,['z'] = 151.57,['h'] = 357.59, ['info'] = ' Milton Road 10', ["office"] = 2 },
	[181] =  { ['x'] = -523.01,['y'] = 628.17,['z'] = 137.98,['h'] = 285.12, ['info'] = ' Milton Road 11', ["office"] = 2 },
	[182] =  { ['x'] = -474.55,['y'] = 586.04,['z'] = 128.69,['h'] = 90.31, ['info'] = ' Milton Road 12', ["office"] = 2 },
	[183] =  { ['x'] = -520.33,['y'] = 594.28,['z'] = 120.84,['h'] = 275.76, ['info'] = ' Milton Road 13', ["office"] = 2 },
	[184] =  { ['x'] = -554.62,['y'] = 540.83,['z'] = 110.71,['h'] = 165.83, ['info'] = ' Milton Road 14', ["office"] = 2 },
	[185] =  { ['x'] = -526.72,['y'] = 517.48,['z'] = 112.94,['h'] = 40.68, ['info'] = ' Milton Road 15', ["office"] = 2 },
	[186] =  { ['x'] = -537.25,['y'] = 477.7,['z'] = 103.2,['h'] = 45.23, ['info'] = ' Milton Road 16', ["office"] = 2 },
	[187] =  { ['x'] = 362.99,['y'] = -711.79,['z'] = 29.28,['h'] = 72.84, ['info'] = ' Office Strawberry Ave 1', ["office"] = 1 },
	[188] =  { ['x'] = 286.51,['y'] = -790.46,['z'] = 29.44,['h'] = 248.43, ['info'] = ' Office Strawberry Ave 2', ["office"] = 1 },
	[189] =  { ['x'] = 253.7,['y'] = -1012.84,['z'] = 29.27,['h'] = 69.39, ['info'] = ' Office Strawberry Ave 3', ["office"] = 1 },
	[190] =  { ['x'] = 243.38,['y'] = -1073.33,['z'] = 29.29,['h'] = 358.96, ['info'] = ' Office Strawberry Ave 4', ["office"] = 1 },
	[191] =  { ['x'] = 185.86,['y'] = -1078.38,['z'] = 29.28,['h'] = 260.31, ['info'] = ' Office Strawberry Ave 5', ["office"] = 1 },
	[192] =  { ['x'] = 113.47,['y'] = -1038.24,['z'] = 29.32,['h'] = 69.47, ['info'] = ' Office Elgin Ave 1', ["office"] = 1 },
	[193] =  { ['x'] = 134.54,['y'] = -859.39,['z'] = 30.78,['h'] = 250.49, ['info'] = ' Office Elgin Ave 2', ["office"] = 1 },
	[194] =  { ['x'] = 143.29,['y'] = -832.4,['z'] = 31.18,['h'] = 293.49, ['info'] = ' Office Elgin Ave 3', ["office"] = 1 },
	[195] =  { ['x'] = 212.58,['y'] = -593.98,['z'] = 43.87,['h'] = 156.54, ['info'] = ' Office Elgin Ave 4', ["office"] = 1 },
	[196] =  { ['x'] = 192.92,['y'] = -584.91,['z'] = 43.87,['h'] = 159.22, ['info'] = ' Office Elgin Ave 5', ["office"] = 1 },
	[197] =  { ['x'] = 213.97,['y'] = -568.45,['z'] = 43.87,['h'] = 326.78, ['info'] = ' Office Elgin Ave 6', ["office"] = 1 },
	[198] =  { ['x'] = 270.54,['y'] = -433.34,['z'] = 45.25,['h'] = 249.71, ['info'] = ' Office Elgin Ave 7', ["office"] = 1 },
	[199] =  { ['x'] = 224.58,['y'] = -441.82,['z'] = 45.25,['h'] = 158.33, ['info'] = ' Office Elgin Ave 8', ["office"] = 1 },
	[200] =  { ['x'] = 195.48,['y'] = -406.31,['z'] = 45.26,['h'] = 68.25, ['info'] = ' Office Elgin Ave 9', ["office"] = 1 },
	[201] =  { ['x'] = 389.19,['y'] = -75.43,['z'] = 68.19,['h'] = 159.97, ['info'] = ' Office Elgin Ave 10', ["office"] = 1 },
	[202] =  { ['x'] = 554.9,['y'] = 151.45,['z'] = 99.26,['h'] = 71.95, ['info'] = ' Office Elgin Ave 11', ["office"] = 1 },
	[203] =  { ['x'] = -286.08,['y'] = 280.58,['z'] = 89.89,['h'] = 176.35, ['info'] = ' Office Eclipse Blvd 1', ["office"] = 1 },
	[204] =  { ['x'] = -354.76,['y'] = 213.25,['z'] = 86.71,['h'] = 340.74, ['info'] = ' Office Eclipse Blvd 2', ["office"] = 1 },
	[205] =  { ['x'] = -640.22,['y'] = 296.87,['z'] = 82.46,['h'] = 173.53, ['info'] = ' Office Eclipse Blvd 3', ["office"] = 1 },
	[206] =  { ['x'] = -680.36,['y'] = 314.17,['z'] = 83.09,['h'] = 175.93, ['info'] = ' Office Eclipse Blvd 4', ["office"] = 1 },
	[207] =  { ['x'] = -715.76,['y'] = 303.66,['z'] = 85.31,['h'] = 162.59, ['info'] = ' Office Eclipse Blvd 5', ["office"] = 1 },
	[208] =  { ['x'] = -773.74,['y'] = 312.33,['z'] = 85.7,['h'] = 255.87, ['info'] = ' Office Eclipse Blvd 6', ["office"] = 1 },
	[209] =  { ['x'] = -742.72,['y'] = 246.4,['z'] = 77.34,['h'] = 203.17, ['info'] = ' Office Eclipse Blvd 7', ["office"] = 1 },
	[210] =  { ['x'] = -686.4,['y'] = 224.09,['z'] = 81.96,['h'] = 19.57, ['info'] = ' Office Eclipse Blvd 8', ["office"] = 1 },
	[211] =  { ['x'] = -312.37,['y'] = 474.56,['z'] = 111.83,['h'] = 121.53, ['info'] = ' Didion Drive 13', ["office"] = 2 },
	[212] =  { ['x'] = -355.63,['y'] = 458.57,['z'] = 117.23,['h'] = 166.56, ['info'] = ' Didion Drive 14', ["office"] = 2 },
	[213] =  { ['x'] = -348.73,['y'] = 514.73,['z'] = 120.63,['h'] = 136.56, ['info'] = ' Didion Drive 15', ["office"] = 2 },
	[214] =  { ['x'] = -386.72,['y'] = 504.36,['z'] = 120.63,['h'] = 336.56, ['info'] = ' Didion Drive 16', ["office"] = 2 },
	[215] =  { ['x'] = -377.98,['y'] = 548.42,['z'] = 124.43,['h'] = 196.56, ['info'] = ' Didion Drive 17', ["office"] = 2 },
	[216] =  { ['x'] = -425.69,['y'] = 535.67,['z'] = 122.83,['h'] = 351.56, ['info'] = ' Didion Drive 18', ["office"] = 2 },
	[217] =  { ['x'] = -406.66,['y'] = 567.19,['z'] = 124.53,['h'] = 171.56, ['info'] = ' Didion Drive 19', ["office"] = 2 },
	[218] =  { ['x'] = -459.33,['y'] = 537.41,['z'] = 121.73,['h'] = 354.06, ['info'] = ' Didion Drive 20', ["office"] = 2 },
	[219] =  { ['x'] = 960.54,['y'] = -669.38,['z'] = 58.45,['h'] = 122.8, ['info'] = ' West Mirror Drive 18', ['office'] = 0 },
	[220] =  { ['x'] = 903.47,['y'] = -615.87,['z'] = 58.46,['h'] = 48.6, ['info'] = ' West Mirror Drive 15', ['office'] = 0 },
	[221] =  { ['x'] = 979.92,['y'] = -627.24,['z'] = 59.24,['h'] = 215.31, ['info'] = ' West Mirror Drive 22', ['apt'] = 0 },
	[222] =  { ['x'] = 1302.79,['y'] = -528.61,['z'] = 71.47,['h'] = 339.7, ['info'] = ' Nikola Place 1', ['office'] = 0 },
	[223] =  { ['x'] = 1372.97,['y'] = -555.69,['z'] = 74.69,['h'] = 244.2, ['info'] = ' Nikola Place 4', ['office'] = 0 },
	[224] =  { ['x'] = 1388.3,['y'] = -569.93,['z'] = 74.5,['h'] = 293.08, ['info'] = ' Nikola Place 5', ['office'] = 0 },
	[225] =  { ['x'] = 1385.47,['y'] = -592.93,['z'] = 74.49,['h'] = 231.77, ['info'] = ' Nikola Place 6', ['office'] = 0 },
	[226] =  { ['x'] = 1367.30,['y'] = -606.59,['z'] = 74.72,['h'] = 169.15, ['info'] = ' Nikola Place 7', ['office'] = 0 },
	[227] =  { ['x'] = 1341.63,['y'] = -597.5,['z'] = 74.71,['h'] = 50.55, ['info'] = ' Nikola Place 8', ['office'] = 0 },
	[228] =  { ['x'] = 1323.76,['y'] = -582.45,['z'] = 73.25,['h'] = 154.05, ['info'] = ' Nikola Place 9', ['office'] = 0 }, 
	[229] =  { ['x'] = 1301.24,['y'] = -573.21,['z'] = 71.74,['h'] = 160.82, ['info'] = ' Nikola Place 10', ['office'] = 0 },
	[230] =  { ['x'] = 1348.13,['y'] = -547.07,['z'] = 73.9,['h'] = 336.0, ['info'] = ' Nikola Place 3', ['office'] = 0 },
	[231] =  { ['x'] = 1327.76,['y'] = -535.86,['z'] = 72.45,['h'] = 255.65, ['info'] = ' Nikola Place 2', ['office'] = 0 },
	[232] =  { ['x'] = -604.72,['y'] = -802.51,['z'] = 25.2,['h'] = 271.79, ['info'] = ' Mansion Little Seoul 1' , ['office'] = 0 },
	[233] =  { ['x'] = -603.97,['y'] = -783.37,['z'] = 25.41,['h'] = 186.1, ['info'] = ' Mansion Little Seoul 2' , ['office'] = 0 },
	[234] =  { ['x'] = -604.03,['y'] = -773.97,['z'] = 25.41,['h'] = 0.84, ['info'] = ' Mansion Little Seoul 3' , ['office'] = 0 },
	[235] =  { ['x'] = -580.07,['y'] = -778.66,['z'] = 25.02,['h'] = 273.73, ['info'] = ' Mansion Little Seoul 4' , ['office'] = 0 },
	[236] =  { ['x'] = -70.99,['y'] = -800.66,['z'] = 44.23,['h'] = 164.99, ['info'] = ' Payne & Associates' , ['office'] = 1 },
	[237] =  { ['x'] = -244.64,['y'] = -814.51,['z'] = 30.72,['h'] = 209.61, ['info'] = ' Office Peaceful Street 1', ["office"] = 1 },
	[238] =  { ['x'] = -266.18,['y'] = -735.32,['z'] = 34.42,['h'] = 69.17, ['info'] = ' Office Peaceful Street 2', ["office"] = 1 },
	[239] =  { ['x'] = 101.79,['y'] = -819.41,['z'] = 31.32,['h'] = 155.57, ['info'] = ' Office Elgin Avenue 12', ["office"] = 1 },
	[240] =  { ['x'] = 296.29,['y'] = -1027.42,['z'] = 29.22,['h'] = 352.14, ['info'] = ' Office Strawberry Avenue 6', ["office"] = 1 },
	[241] =  { ['x'] = 561.63,['y'] = 93.55,['z'] = 96.11,['h'] = 339.54, ['info'] = ' Office Vinewood Blvd 1', ["office"] = 1 },
	[242] =  { ['x'] = 359.48,['y'] = 88.7,['z'] = 100.43,['h'] = 250.02, ['info'] = ' Office Vinewood Blvd 2', ["office"] = 1 },
	[243] =  { ['x'] = -1016.09,['y'] = -265.7,['z'] = 39.05,['h'] = 240.41, ['info'] = ' Office South Blvd Del Perro 1', ["office"] = 1 },
	[244] =  { ['x'] = -769.01,['y'] = -355.94,['z'] = 37.34,['h'] = 155.54, ['info'] = ' Office Dorset Dr 1', ["office"] = 1 },
	[245] =  { ['x'] = -1366.01,['y'] = 56.62,['z'] = 54.1,['h'] = 271.73, ['info'] = ' Richman Meadows Golf', ["office"] = 1 },
	[246] =  { ['x'] = -188.82,['y'] = 978.75,['z'] = 236.14,['h'] = 267.51, ['info'] = ' Vinewood Hills 1' , ['office'] = 2 },
	[247] =  { ['x'] = -112.98,['y'] = 986.14,['z'] = 235.76,['h'] = 288.75, ['info'] = ' Vinewood Hills 2' , ['office'] = 2 },
	[248] =  { ['x'] = -151.76,['y'] = 910.59,['z'] = 235.66,['h'] = 228.29, ['info'] = ' Vinewood Hills 3' , ['office'] = 2 },
	[249] =  { ['x'] = -85.6,['y'] = 834.8,['z'] = 235.93,['h'] = 275.3, ['info'] = ' Vinewood Hills 4' , ['office'] = 2 },
	[250] =  { ['x'] = 201.87,['y'] = -239.06,['z'] = 53.97,['h'] = 118.21, ['info'] = ' White Widow', ['office'] = 1 },
	[251] =  { ['x'] = 443.67,['y'] = -1900.2,['z'] = 31.74,['h'] = 43.19, ['info'] = ' Little Bighorn Ave 1', ['office'] = 1 },
	[252] =  { ['x'] = -1804.93,['y'] = 437.09,['z'] = 128.71,['h'] = 178.84, ['info'] = ' Payne Manor', ["office"] = 0 },
	[253] =  { ['x'] = -2587.8,['y'] = 1910.86,['z'] = 167.5,['h'] = 187.73, ['info'] = ' Buen Vino Rd 1', ['office'] = 2 },
	[254] =  { ['x'] = -1155.84,['y'] = -1543.05,['z'] = 4.45,['h'] = 36.8, ['info'] = ' Los Santos Wrestling Federation HQ' , ['office'] = 1 },
	[255] =  { ['x'] = -767.73,['y'] = -751.83,['z'] = 27.88,['h'] = 80.93, ['info'] = ' Dream Tower 1', ['office'] = 0 },
	[256] =  { ['x'] = -780.29,['y'] = -753.82,['z'] = 27.88,['h'] = 263.71, ['info'] = ' Dream Tower 2', ['office'] = 0 },
	[257] =  { ['x'] = -780.27,['y'] = -784.25,['z'] = 27.88,['h'] = 269.11, ['info'] = ' Dream Tower 3', ['office'] = 0 },
	[258] =  { ['x'] = -809.55,['y'] = -978.32,['z'] = 14.23,['h'] = 307.74, ['info'] = ' Ginger St South 1', ['office'] = 0 },
	[259] =  { ['x'] = -715.32,['y'] = -996.49,['z'] = 18.34,['h'] = 296.68, ['info'] = ' Ginger St South 3', ['office'] = 0 },
	[260] =  { ['x'] = -98.33,['y'] = 367.49,['z'] = 113.28,['h'] = 337.13, ['info'] = ' Gentry Ln Office #1' , ['office'] = 1 },
	[261] =  { ['x'] = -1465.30,['y'] = -34.30,['z'] = 55.05,['h'] = 136.19, ['info'] = 'Kyles Kingdom' , ['office'] = 2 }, --Kyle's House
	[262] =  { ['x'] = -143.76,['y'] = 229.72,['z'] = 94.94,['h'] = 178.75, ['info'] = ' Office Eclipse Blvd 9', ['office'] = 1 },
	[263] =  { ['x'] = -1356.6,['y'] = -791.17,['z'] = 20.25,['h'] = 311.43, ['info'] = ' Office Bay City Ave #1 ', ['office'] = 1 },
	[264] =  { ['x'] = 288.13,['y'] = -1095.02,['z'] = 29.42,['h'] = 85.8, ['info'] = 'Office Fantastic Place #1' , ['office'] = 1 },
}







robberycoords = {
	[1] =  { ['x'] = 1061.04,['y'] = -378.61,['z'] = 68.24,['h'] = 37.87, ['info'] = ' West Mirror Drive 1', ['apt'] = 2 },
	[2] =  { ['x'] = 1029.42,['y'] = -408.96,['z'] = 65.95,['h'] = 38.91, ['info'] = ' West Mirror Drive 2', ['apt'] = 2 },
	[3] =  { ['x'] = 1011.27,['y'] = -422.89,['z'] = 64.96,['h'] = 121.8, ['info'] = ' West Mirror Drive 3', ['apt'] = 2 },
	[4] =  { ['x'] = 988.2,['y'] = -433.74,['z'] = 63.9,['h'] = 34.72, ['info'] = ' West Mirror Drive 4', ['apt'] = 2 },
	[5] =  { ['x'] = 967.9,['y'] = -452.62,['z'] = 62.41,['h'] = 32.83, ['info'] = ' West Mirror Drive 5', ['apt'] = 2 },
	[6] =  { ['x'] = 943.26,['y'] = -463.9,['z'] = 61.4,['h'] = 299.36, ['info'] = ' West Mirror Drive 6', ['apt'] = 2 },
	[7] =  { ['x'] = 922.18,['y'] = -478.69,['z'] = 61.09,['h'] = 22.83, ['info'] = ' West Mirror Drive 7', ['apt'] = 2 },
	[8] =  { ['x'] = 906.58,['y'] = -489.69,['z'] = 59.44,['h'] = 29.93, ['info'] = ' West Mirror Drive 8', ['apt'] = 2 },
	[9] =  { ['x'] = 878.99,['y'] = -498.51,['z'] = 57.88,['h'] = 46.17, ['info'] = ' West Mirror Drive 9', ['apt'] = 2 },
	[10] =  { ['x'] = 862.28,['y'] = -509.58,['z'] = 57.33,['h'] = 48.03, ['info'] = ' West Mirror Drive 10', ['apt'] = 2 },
	[11] =  { ['x'] = 851.09,['y'] = -532.73,['z'] = 57.93,['h'] = 84.22, ['info'] = ' West Mirror Drive 11', ['apt'] = 2 },
	[12] =  { ['x'] = 844.37,['y'] = -563.77,['z'] = 57.84,['h'] = 15.0, ['info'] = ' West Mirror Drive 12', ['apt'] = 2 },
	[13] =  { ['x'] = 861.92,['y'] = -582.26,['z'] = 58.16,['h'] = 170.48, ['info'] = ' West Mirror Drive 13', ['apt'] = 2 },
	[14] =  { ['x'] = 887.43,['y'] = -607.54,['z'] = 58.22,['h'] = 133.7, ['info'] = ' West Mirror Drive 14', ['apt'] = 2 },
	[15] =  { ['x'] = 11.5,['y'] = 6578.22,['z'] = 33.08,['h'] = 223.29, ['info'] = ' Paleto Blvd 2', ['apt'] = 2 },
	[16] =  { ['x'] = 929.51,['y'] = -639.12,['z'] = 58.25,['h'] = 139.34, ['info'] = ' West Mirror Drive 16', ['apt'] = 2 },
	[17] =  { ['x'] = 943.4,['y'] = -653.71,['z'] = 58.43,['h'] = 36.32, ['info'] = ' West Mirror Drive 17', ['apt'] = 2 },
	[18] =  { ['x'] = -14.72,['y'] = 6557.54,['z'] = 33.25,['h'] = 311.79, ['info'] = ' Paleto Blvd 3', ['apt'] = 2 },
	[19] =  { ['x'] = 970.9,['y'] = -701.41,['z'] = 58.49,['h'] = 168.31, ['info'] = ' West Mirror Drive 19', ['apt'] = 2 },
	[20] =  { ['x'] = 979.49,['y'] = -715.95,['z'] = 58.22,['h'] = 131.16, ['info'] = ' West Mirror Drive 20', ['apt'] = 2 },
	[21] =  { ['x'] = 997.52,['y'] = -729.0,['z'] = 57.82,['h'] = 128.93, ['info'] = ' West Mirror Drive 21', ['apt'] = 2 },
	[22] =  { ['x'] = -374.77,['y'] = 6190.77,['z'] = 31.73,['h'] = 223.2, ['info'] = ' Paleto Blvd 5', ['apt'] = 2 },
	[23] =  { ['x'] = 892.79,['y'] = -540.7,['z'] = 58.51,['h'] = 295.06, ['info'] = ' West Mirror Drive 23', ['apt'] = 2 },
	[24] =  { ['x'] = 924.02,['y'] = -525.3,['z'] = 59.58,['h'] = 208.51, ['info'] = ' West Mirror Drive 24', ['apt'] = 2 },
	[25] =  { ['x'] = 946.26,['y'] = -518.79,['z'] = 60.63,['h'] = 122.26, ['info'] = ' West Mirror Drive 25', ['apt'] = 2 },
	[26] =  { ['x'] = 969.57,['y'] = -502.1,['z'] = 62.15,['h'] = 253.28, ['info'] = ' West Mirror Drive 26', ['apt'] = 2 },
	[27] =  { ['x'] = 1014.14,['y'] = -468.72,['z'] = 64.29,['h'] = 214.9, ['info'] = ' West Mirror Drive 27', ['apt'] = 2 },
	[28] =  { ['x'] = 1112.37,['y'] = -390.29,['z'] = 68.74,['h'] = 244.07, ['info'] = ' West Mirror Drive 28', ['apt'] = 2 },
	[29] =  { ['x'] = 1263.96,['y'] = -429.2,['z'] = 69.81,['h'] = 111.8, ['info'] = ' East Mirror Drive 1', ['apt'] = 2 },
	[30] =  { ['x'] = 1266.76,['y'] = -457.85,['z'] = 70.52,['h'] = 97.77, ['info'] = ' East Mirror Drive 2', ['apt'] = 2 },
	[31] =  { ['x'] = 1260.28,['y'] = -479.9,['z'] = 70.19,['h'] = 112.32, ['info'] = ' East Mirror Drive 3', ['apt'] = 2 },
	[32] =  { ['x'] = 1251.86,['y'] = -494.2,['z'] = 69.91,['h'] = 78.13, ['info'] = ' East Mirror Drive 4', ['apt'] = 2 },
	[33] =  { ['x'] = 1251.5,['y'] = -515.63,['z'] = 69.35,['h'] = 75.67, ['info'] = ' East Mirror Drive 5', ['apt'] = 2 },
	[34] =  { ['x'] = 1242.17,['y'] = -565.88,['z'] = 69.66,['h'] = 125.6, ['info'] = ' East Mirror Drive 6', ['apt'] = 2 },
	[35] =  { ['x'] = 1241.1,['y'] = -601.67,['z'] = 69.59,['h'] = 92.86, ['info'] = ' East Mirror Drive 7', ['apt'] = 2 },
	[36] =  { ['x'] = 1251.6,['y'] = -621.98,['z'] = 69.41,['h'] = 26.0, ['info'] = ' East Mirror Drive 8', ['apt'] = 2 },
	[37] =  { ['x'] = 1265.41,['y'] = -647.89,['z'] = 67.93,['h'] = 199.31, ['info'] = ' East Mirror Drive 9', ['apt'] = 2 },
	[38] =  { ['x'] = 1271.13,['y'] = -683.04,['z'] = 66.04,['h'] = 178.05, ['info'] = ' East Mirror Drive 10', ['apt'] = 2 },
	[39] =  { ['x'] = 1265.94,['y'] = -703.52,['z'] = 64.56,['h'] = 61.26, ['info'] = ' East Mirror Drive 11', ['apt'] = 2 },
	[40] =  { ['x'] = -157.31,['y'] = 6409.99,['z'] = 31.92,['h'] = 33.16, ['info'] = ' Procopio Drive 20 / Apt 5', ['apt'] = 1 },
	[41] =  { ['x'] = -105.49,['y'] = 6528.7,['z'] = 30.17,['h'] = 313.4, ['info'] = ' Procopio Drive 21', ['apt'] = 1 },
	[42] =  { ['x'] = -44.43,['y'] = 6582.55,['z'] = 32.18,['h'] = 45.65, ['info'] = ' Procopio Drive 22', ['apt'] = 1 },
	[43] =  { ['x'] = -27.44,['y'] = 6597.89,['z'] = 31.87,['h'] = 47.34, ['info'] = ' Procopio Drive 23', ['apt'] = 1 },
	[44] =  { ['x'] = 1.36,['y'] = 6613.18,['z'] = 31.89,['h'] = 26.34, ['info'] = ' Procopio Drive 24', ['apt'] = 1 },
	[45] =  { ['x'] = 31.22,['y'] = 6596.67,['z'] = 32.83,['h'] = 223.03, ['info'] = ' Paleto Blvd 1', ['apt'] = 1 },
	[46] =  { ['x'] = -167.23,['y'] = 6439.25,['z'] = 31.92,['h'] = 131.66, ['info'] = ' Procopio Drive 20 / Apt 1', ['apt'] = 1 },
	[47] =  { ['x'] = -160.3,['y'] = 6432.18,['z'] = 31.92,['h'] = 130.17, ['info'] = ' Procopio Drive 20 / Apt 2', ['apt'] = 1 },
	[48] =  { ['x'] = -150.38,['y'] = 6422.38,['z'] = 31.92,['h'] = 133.68, ['info'] = ' Procopio Drive 20 / Apt 3', ['apt'] = 1 },
	[49] =  { ['x'] = -150.38,['y'] = 6416.99,['z'] = 31.92,['h'] = 41.43, ['info'] = ' Procopio Drive 20 / Apt 4', ['apt'] = 1 },
	[50] =  { ['x'] = 1437.15,['y'] = -1492.97,['z'] = 63.44,['h'] = 340.13, ['info'] = ' Fudge Lane 1', ['apt'] = 0 },
	[51] =  { ['x'] = 1379.49,['y'] = -1515.41,['z'] = 58.04,['h'] = 28.29, ['info'] = ' Fudge Lane 2', ['apt'] = 0 },
	[52] =  { ['x'] = 1338.24,['y'] = -1524.22,['z'] = 54.59,['h'] = 354.77, ['info'] = ' Fudge Lane 3', ['apt'] = 0 },
	[53] =  { ['x'] = 1316.2,['y'] = -1528.01,['z'] = 51.42,['h'] = 13.96, ['info'] = ' Fudge Lane 4', ['apt'] = 0 },
	[54] =  { ['x'] = 1231.17,['y'] = -1591.76,['z'] = 53.56,['h'] = 31.72, ['info'] = ' Fudge Lane 5', ['apt'] = 0 },
	[55] =  { ['x'] = 1205.91,['y'] = -1607.85,['z'] = 50.54,['h'] = 29.31, ['info'] = ' Fudge Lane 6', ['apt'] = 0 },
	[56] =  { ['x'] = 1192.94,['y'] = -1622.69,['z'] = 45.23,['h'] = 304.06, ['info'] = ' Fudge Lane 7', ['apt'] = 0 },
	[57] =  { ['x'] = 1192.82,['y'] = -1655.06,['z'] = 43.03,['h'] = 211.63, ['info'] = ' Fudge Lane 8', ['apt'] = 0 },
	[58] =  { ['x'] = 1214.11,['y'] = -1643.33,['z'] = 48.65,['h'] = 207.97, ['info'] = ' Fudge Lane 9', ['apt'] = 0 },
	[59] =  { ['x'] = 1244.78,['y'] = -1625.69,['z'] = 53.29,['h'] = 210.54, ['info'] = ' Fudge Lane 10', ['apt'] = 0 },
	[60] =  { ['x'] = 1261.31,['y'] = -1616.26,['z'] = 54.75,['h'] = 210.56, ['info'] = ' Fudge Lane 11', ['apt'] = 0 },
	[61] =  { ['x'] = 1286.4,['y'] = -1603.31,['z'] = 54.83,['h'] = 193.95, ['info'] = ' Fudge Lane 12', ['apt'] = 0 },
	[62] =  { ['x'] = 1327.22,['y'] = -1552.61,['z'] = 54.06,['h'] = 228.68, ['info'] = ' Fudge Lane 13', ['apt'] = 0 },
	[63] =  { ['x'] = 1360.39,['y'] = -1554.92,['z'] = 55.95,['h'] = 190.45, ['info'] = ' Fudge Lane 14', ['apt'] = 0 },
	[64] =  { ['x'] = 1382.68,['y'] = -1544.46,['z'] = 57.11,['h'] = 124.25, ['info'] = ' Fudge Lane 15', ['apt'] = 0 },
	[65] =  { ['x'] = 1365.25,['y'] = -1720.38,['z'] = 65.64,['h'] = 193.47, ['info'] = ' Amarillo Vista 1', ['apt'] = 0 },
	[66] =  { ['x'] = 1315.17,['y'] = -1732.63,['z'] = 54.71,['h'] = 115.0, ['info'] = ' Amarillo Vista 2', ['apt'] = 0 },
	[67] =  { ['x'] = 1295.86,['y'] = -1739.44,['z'] = 54.28,['h'] = 109.9, ['info'] = ' Amarillo Vista 3', ['apt'] = 0 },
	[68] =  { ['x'] = 1258.81,['y'] = -1761.27,['z'] = 49.67,['h'] = 202.25, ['info'] = ' Amarillo Vista 4', ['apt'] = 0 },
	[69] =  { ['x'] = 1251.01,['y'] = -1735.07,['z'] = 52.03,['h'] = 21.33, ['info'] = ' Amarillo Vista 5', ['apt'] = 0 },
	[70] =  { ['x'] = 1289.66,['y'] = -1711.45,['z'] = 55.28,['h'] = 21.9, ['info'] = ' Amarillo Vista 7', ['apt'] = 0 },
	[71] =  { ['x'] = 1316.97,['y'] = -1699.67,['z'] = 57.84,['h'] = 9.87, ['info'] = ' Amarillo Vista 8', ['apt'] = 0 },
	[72] =  { ['x'] = 1355.45,['y'] = -1690.85,['z'] = 60.5,['h'] = 79.86, ['info'] = ' Amarillo Vista 9', ['apt'] = 0 },
	[73] =  { ['x'] = -51.01,['y'] = -1783.87,['z'] = 28.31,['h'] = 314.06, ['info'] = ' Grove Street 1', ['apt'] = 0 },
	[74] =  { ['x'] = -42.56,['y'] = -1792.78,['z'] = 27.83,['h'] = 313.07, ['info'] = ' Grove Street 2', ['apt'] = 0 },
	[75] =  { ['x'] = 20.57,['y'] = -1844.12,['z'] = 24.61,['h'] = 227.62, ['info'] = ' Grove Street 3', ['apt'] = 0 },
	[76] =  { ['x'] = 29.32,['y'] = -1853.94,['z'] = 24.07,['h'] = 226.91, ['info'] = ' Grove Street 4', ['apt'] = 0 },
	[77] =  { ['x'] = 45.32,['y'] = -1864.99,['z'] = 23.28,['h'] = 314.88, ['info'] = ' Grove Street 5', ['apt'] = 0 },
	[78] =  { ['x'] = 54.44,['y'] = -1873.17,['z'] = 22.81,['h'] = 313.76, ['info'] = ' Grove Street 6', ['apt'] = 0 },
	[79] =  { ['x'] = 100.48,['y'] = -1913.0,['z'] = 21.21,['h'] = 331.75, ['info'] = ' Grove Street 7', ['apt'] = 0 },
	[80] =  { ['x'] = 117.81,['y'] = -1920.55,['z'] = 21.33,['h'] = 237.12, ['info'] = ' Grove Street 8', ['apt'] = 0 },
	[81] =  { ['x'] = 126.4,['y'] = -1929.47,['z'] = 21.39,['h'] = 208.24, ['info'] = ' Grove Street 9', ['apt'] = 0 },
	[82] =  { ['x'] = 114.05,['y'] = -1960.69,['z'] = 21.34,['h'] = 201.85, ['info'] = ' Grove Street 10', ['apt'] = 0 },
	[83] =  { ['x'] = 85.31,['y'] = -1959.0,['z'] = 21.13,['h'] = 231.11, ['info'] = ' Grove Street 11', ['apt'] = 0 },
	[84] =  { ['x'] = 76.92,['y'] = -1948.61,['z'] = 21.18,['h'] = 47.14, ['info'] = ' Grove Street 12', ['apt'] = 0 },
	[85] =  { ['x'] = 72.94,['y'] = -1938.5,['z'] = 21.17,['h'] = 134.56, ['info'] = ' Grove Street 13', ['apt'] = 0 },
	[86] =  { ['x'] = 57.03,['y'] = -1922.37,['z'] = 21.92,['h'] = 138.82, ['info'] = ' Grove Street 14', ['apt'] = 0 },
	[87] =  { ['x'] = 39.59,['y'] = -1911.99,['z'] = 21.96,['h'] = 48.9, ['info'] = ' Grove Street 15', ['apt'] = 0 },
	[88] =  { ['x'] = 23.75,['y'] = -1895.77,['z'] = 22.78,['h'] = 138.51, ['info'] = ' Grove Street 16', ['apt'] = 0 },
	[89] =  { ['x'] = 4.58,['y'] = -1883.77,['z'] = 23.7,['h'] = 230.16, ['info'] = ' Grove Street 17', ['apt'] = 0 },
	[90] =  { ['x'] = -5.8,['y'] = -1871.52,['z'] = 24.16,['h'] = 231.79, ['info'] = ' Grove Street 18', ['apt'] = 0 },
	[91] =  { ['x'] = -21.18,['y'] = -1858.15,['z'] = 25.4,['h'] = 231.24, ['info'] = ' Grove Street 19', ['apt'] = 0 },
	[92] =  { ['x'] = -33.71,['y'] = -1847.46,['z'] = 26.2,['h'] = 50.24, ['info'] = ' Grove Street 20', ['apt'] = 0 },
	[93] =  { ['x'] = -157.6,['y'] = -1680.11,['z'] = 33.44,['h'] = 48.52, ['info'] = ' Forum Drive 1/Apt1', ['apt'] = 1 },
	[94] =  { ['x'] = -148.39,['y'] = -1688.04,['z'] = 32.88,['h'] = 318.72, ['info'] = ' Forum Drive 1/Apt2', ['apt'] = 1 },
	[95] =  { ['x'] = -147.3,['y'] = -1688.99,['z'] = 32.88,['h'] = 318.81, ['info'] = ' Forum Drive 1/Apt3', ['apt'] = 1 },
	[96] =  { ['x'] = -143.08,['y'] = -1692.38,['z'] = 32.88,['h'] = 277.39, ['info'] = ' Forum Drive 1/Apt4', ['apt'] = 1 },
	[97] =  { ['x'] = -141.89,['y'] = -1693.43,['z'] = 32.88,['h'] = 225.74, ['info'] = ' Forum Drive 1/Apt5', ['apt'] = 1 },
	[98] =  { ['x'] = -141.79,['y'] = -1693.55,['z'] = 36.17,['h'] = 229.58, ['info'] = ' Forum Drive 1/Apt6', ['apt'] = 1 },
	[99] =  { ['x'] = -142.19,['y'] = -1692.69,['z'] = 36.17,['h'] = 321.38, ['info'] = ' Forum Drive 1/Apt7', ['apt'] = 1 },
	[100] =  { ['x'] = -147.39,['y'] = -1688.39,['z'] = 36.17,['h'] = 318.94, ['info'] = ' Forum Drive 1/Apt8', ['apt'] = 1 },
	[101] =  { ['x'] = -148.69,['y'] = -1687.35,['z'] = 36.17,['h'] = 313.56, ['info'] = ' Forum Drive 1/Apt9', ['apt'] = 1 },
	[102] =  { ['x'] = -157.54,['y'] = -1679.61,['z'] = 36.97,['h'] = 354.25, ['info'] = ' Forum Drive 1/Apt10', ['apt'] = 1 },
	[103] =  { ['x'] = -158.86,['y'] = -1680.02,['z'] = 36.97,['h'] = 38.57, ['info'] = ' Forum Drive 1/Apt11', ['apt'] = 1 },
	[104] =  { ['x'] = -160.83,['y'] = -1637.93,['z'] = 34.03,['h'] = 157.6, ['info'] = ' Forum Drive 2/Apt1', ['apt'] = 1 },
	[105] =  { ['x'] = -160.0,['y'] = -1636.41,['z'] = 34.03,['h'] = 324.29, ['info'] = ' Forum Drive 2/Apt2', ['apt'] = 1 },
	[106] =  { ['x'] = -153.87,['y'] = -1641.77,['z'] = 36.86,['h'] = 331.14, ['info'] = ' Forum Drive 2/Apt3', ['apt'] = 1 },
	[107] =  { ['x'] = -159.85,['y'] = -1636.42,['z'] = 37.25,['h'] = 321.05, ['info'] = ' Forum Drive 2/Apt4', ['apt'] = 1 },
	[108] =  { ['x'] = -161.31,['y'] = -1638.13,['z'] = 37.25,['h'] = 142.21, ['info'] = ' Forum Drive 2/Apt5', ['apt'] = 1 },
	[109] =  { ['x'] = -150.79,['y'] = -1625.26,['z'] = 33.66,['h'] = 233.56, ['info'] = ' Forum Drive 2/Apt6', ['apt'] = 1 },
	[110] =  { ['x'] = -150.74,['y'] = -1622.68,['z'] = 33.66,['h'] = 57.73, ['info'] = ' Forum Drive 2/Apt7', ['apt'] = 1 },
	[111] =  { ['x'] = -145.59,['y'] = -1617.88,['z'] = 36.05,['h'] = 222.51, ['info'] = ' Forum Drive 2/Apt8', ['apt'] = 1 },
	[112] =  { ['x'] = -145.84,['y'] = -1614.71,['z'] = 36.05,['h'] = 67.64, ['info'] = ' Forum Drive 2/Apt9', ['apt'] = 1 },
	[113] =  { ['x'] = -152.23,['y'] = -1624.37,['z'] = 36.85,['h'] = 52.69, ['info'] = ' Forum Drive 2/Apt10', ['apt'] = 1 },
	[114] =  { ['x'] = -150.38,['y'] = -1625.5,['z'] = 36.85,['h'] = 233.14, ['info'] = ' Forum Drive 2/Apt11', ['apt'] = 1 },
	[115] =  { ['x'] = -120.58,['y'] = -1575.04,['z'] = 34.18,['h'] = 323.0, ['info'] = ' Forum Drive 3/Apt1', ['apt'] = 1 },
	[116] =  { ['x'] = -114.73,['y'] = -1579.95,['z'] = 34.18,['h'] = 318.74, ['info'] = ' Forum Drive 3/Apt2', ['apt'] = 1 },
	[117] =  { ['x'] = -119.6,['y'] = -1585.41,['z'] = 34.22,['h'] = 231.94, ['info'] = ' Forum Drive 3/Apt3', ['apt'] = 1 },
	[118] =  { ['x'] = -123.81,['y'] = -1590.67,['z'] = 34.21,['h'] = 234.7, ['info'] = ' Forum Drive 3/Apt4', ['apt'] = 1 },
	[119] =  { ['x'] = -139.85,['y'] = -1598.7,['z'] = 34.84,['h'] = 158.58, ['info'] = ' Forum Drive 3/Apt6', ['apt'] = 1 },
	[120] =  { ['x'] = -146.85,['y'] = -1596.64,['z'] = 34.84,['h'] = 69.8, ['info'] = ' Forum Drive 3/Apt7', ['apt'] = 1 },
	[121] =  { ['x'] = -139.49,['y'] = -1588.39,['z'] = 34.25,['h'] = 47.69, ['info'] = ' Forum Drive 3/Apt8', ['apt'] = 1 },
	[122] =  { ['x'] = -133.47,['y'] = -1581.2,['z'] = 34.21,['h'] = 49.62, ['info'] = ' Forum Drive 3/Apt9', ['apt'] = 1 },
	[123] =  { ['x'] = -120.63,['y'] = -1575.05,['z'] = 37.41,['h'] = 320.29, ['info'] = ' Forum Drive 3/Apt10', ['apt'] = 1 },
	[124] =  { ['x'] = -114.71,['y'] = -1580.4,['z'] = 37.41,['h'] = 322.64, ['info'] = ' Forum Drive 3/Apt11', ['apt'] = 1 },
	[125] =  { ['x'] = -119.53,['y'] = -1585.26,['z'] = 37.41,['h'] = 228.33, ['info'] = ' Forum Drive 3/Apt12', ['apt'] = 1 },
	[126] =  { ['x'] = -123.67,['y'] = -1590.39,['z'] = 37.41,['h'] = 223.58, ['info'] = ' Forum Drive 3/Apt13', ['apt'] = 1 },
	[127] =  { ['x'] = -140.08,['y'] = -1598.75,['z'] = 38.22,['h'] = 157.57, ['info'] = ' Forum Drive 3/Apt15', ['apt'] = 1 },
	[128] =  { ['x'] = -145.81,['y'] = -1597.55,['z'] = 38.22,['h'] = 99.24, ['info'] = ' Forum Drive 3/Apt16', ['apt'] = 1 },
	[129] =  { ['x'] = -147.47,['y'] = -1596.26,['z'] = 38.22,['h'] = 55.87, ['info'] = ' Forum Drive 3/Apt17', ['apt'] = 1 },
	[130] =  { ['x'] = -139.77,['y'] = -1587.8,['z'] = 37.41,['h'] = 50.77, ['info'] = ' Forum Drive 3/Apt18', ['apt'] = 1 },
	[131] =  { ['x'] = -133.78,['y'] = -1580.56,['z'] = 37.41,['h'] = 54.61, ['info'] = ' Forum Drive 3/Apt19', ['apt'] = 1 },
	[132] =  { ['x'] = 16.5,['y'] = -1443.77,['z'] = 30.95,['h'] = 336.17, ['info'] = ' Forum Drive 4', ['apt'] = 0 },
	[133] =  { ['x'] = -1.98,['y'] = -1442.55,['z'] = 30.97,['h'] = 1.65, ['info'] = ' Forum Drive 5', ['apt'] = 0 },
	[134] =  { ['x'] = -32.87,['y'] = -1446.34,['z'] = 31.9,['h'] = 269.71, ['info'] = ' Forum Drive 7', ['apt'] = 0 },
	[135] =  { ['x'] = -45.73,['y'] = -1445.58,['z'] = 32.43,['h'] = 274.72, ['info'] = ' Forum Drive 8', ['apt'] = 0 },
	[136] =  { ['x'] = -64.48,['y'] = -1449.57,['z'] = 32.53,['h'] = 99.6, ['info'] = ' Forum Drive 9', ['apt'] = 0 },
	[137] =  { ['x'] = -167.71,['y'] = -1534.71,['z'] = 35.1,['h'] = 320.29, ['info'] = ' Forum Drive 10/Apt1', ['apt'] = 1 },
	[138] =  { ['x'] = -180.71,['y'] = -1553.51,['z'] = 35.13,['h'] = 227.11, ['info'] = ' Forum Drive 10/Apt2', ['apt'] = 1 },
	[139] =  { ['x'] = -187.47,['y'] = -1562.96,['z'] = 35.76,['h'] = 220.56, ['info'] = ' Forum Drive 10/Apt3', ['apt'] = 1 },
	[140] =  { ['x'] = -191.86,['y'] = -1559.4,['z'] = 34.96,['h'] = 124.57, ['info'] = ' Forum Drive 10/Apt4', ['apt'] = 1 },
	[141] =  { ['x'] = -195.55,['y'] = -1556.06,['z'] = 34.96,['h'] = 45.83, ['info'] = ' Forum Drive 10/Apt5', ['apt'] = 1 },
	[142] =  { ['x'] = -183.81,['y'] = -1540.59,['z'] = 34.36,['h'] = 41.2, ['info'] = ' Forum Drive 10/Apt6', ['apt'] = 1 },
	[143] =  { ['x'] = -179.69,['y'] = -1534.66,['z'] = 34.36,['h'] = 44.71, ['info'] = ' Forum Drive 10/Apt7', ['apt'] = 1 },
	[144] =  { ['x'] = -175.06,['y'] = -1529.53,['z'] = 34.36,['h'] = 321.99, ['info'] = ' Forum Drive 10/Apt8', ['apt'] = 1 },
	[145] =  { ['x'] = -167.62,['y'] = -1534.9,['z'] = 38.33,['h'] = 320.46, ['info'] = ' Forum Drive 10/Apt10', ['apt'] = 1 },
	[146] =  { ['x'] = -180.19,['y'] = -1553.89,['z'] = 38.34,['h'] = 232.72, ['info'] = ' Forum Drive 10/Apt11', ['apt'] = 1 },
	[147] =  { ['x'] = -186.63,['y'] = -1562.32,['z'] = 39.14,['h'] = 198.53, ['info'] = ' Forum Drive 10/Apt12', ['apt'] = 1 },
	[148] =  { ['x'] = -188.32,['y'] = -1562.5,['z'] = 39.14,['h'] = 136.16, ['info'] = ' Forum Drive 10/Apt13', ['apt'] = 1 },
	[149] =  { ['x'] = -192.14,['y'] = -1559.64,['z'] = 38.34,['h'] = 136.93, ['info'] = ' Forum Drive 10/Apt14', ['apt'] = 1 },
	[150] =  { ['x'] = -195.77,['y'] = -1555.92,['z'] = 38.34,['h'] = 48.33, ['info'] = ' Forum Drive 10/Apt15', ['apt'] = 1 },
	[151] =  { ['x'] = -184.06,['y'] = -1539.83,['z'] = 37.54,['h'] = 47.47, ['info'] = ' Forum Drive 10/Apt16', ['apt'] = 1 },
	[152] =  { ['x'] = -179.58,['y'] = -1534.93,['z'] = 37.54,['h'] = 48.0, ['info'] = ' Forum Drive 10/Apt17', ['apt'] = 1 },
	[153] =  { ['x'] = -174.87,['y'] = -1529.18,['z'] = 37.54,['h'] = 321.05, ['info'] = ' Forum Drive 10/Apt18', ['apt'] = 1 },
	[154] =  { ['x'] = -208.75,['y'] = -1600.32,['z'] = 34.87,['h'] = 259.54, ['info'] = ' Forum Drive 11/Apt1', ['apt'] = 1 },
	[155] =  { ['x'] = -210.05,['y'] = -1607.17,['z'] = 34.87,['h'] = 259.85, ['info'] = ' Forum Drive 11/Apt2', ['apt'] = 1 },
	[156] =  { ['x'] = -212.05,['y'] = -1616.86,['z'] = 34.87,['h'] = 244.26, ['info'] = ' Forum Drive 11/Apt3', ['apt'] = 1 },
	[157] =  { ['x'] = -213.8,['y'] = -1618.07,['z'] = 34.87,['h'] = 180.98, ['info'] = ' Forum Drive 11/Apt4', ['apt'] = 1 },
	[158] =  { ['x'] = -221.82,['y'] = -1617.45,['z'] = 34.87,['h'] = 88.95, ['info'] = ' Forum Drive 11/Apt5', ['apt'] = 1 },
	[159] =  { ['x'] = -223.06,['y'] = -1601.38,['z'] = 34.89,['h'] = 97.48, ['info'] = ' Forum Drive 11/Apt6', ['apt'] = 1 },
	[160] =  { ['x'] = -222.52,['y'] = -1585.71,['z'] = 34.87,['h'] = 84.43, ['info'] = ' Forum Drive 11/Apt7', ['apt'] = 1 },
	[161] =  { ['x'] = -218.91,['y'] = -1580.06,['z'] = 34.87,['h'] = 47.27, ['info'] = ' Forum Drive 11/Apt8', ['apt'] = 1 },
	[162] =  { ['x'] = -216.48,['y'] = -1577.45,['z'] = 34.87,['h'] = 321.55, ['info'] = ' Forum Drive 11/Apt9', ['apt'] = 1 },
	[163] =  { ['x'] = -206.23,['y'] = -1585.55,['z'] = 34.87,['h'] = 260.2, ['info'] = ' Forum Drive 11/Apt10', ['apt'] = 1 },
	[164] =  { ['x'] = -206.63,['y'] = -1585.8,['z'] = 38.06,['h'] = 275.39, ['info'] = ' Forum Drive 11/Apt12', ['apt'] = 1 },
	[165] =  { ['x'] = -216.05,['y'] = -1576.86,['z'] = 38.06,['h'] = 319.06, ['info'] = ' Forum Drive 11/Apt13', ['apt'] = 1 },
	[166] =  { ['x'] = -218.37,['y'] = -1579.89,['z'] = 38.06,['h'] = 67.83, ['info'] = ' Forum Drive 11/Apt14', ['apt'] = 1 },
	[167] =  { ['x'] = -222.25,['y'] = -1585.37,['z'] = 38.06,['h'] = 96.11, ['info'] = ' Forum Drive 11/Apt15', ['apt'] = 1 },
	[168] =  { ['x'] = -222.26,['y'] = -1600.93,['z'] = 38.06,['h'] = 90.9, ['info'] = ' Forum Drive 11/Apt16', ['apt'] = 1 },
	[169] =  { ['x'] = -222.21,['y'] = -1617.39,['z'] = 38.06,['h'] = 93.88, ['info'] = ' Forum Drive 11/Apt17', ['apt'] = 1 },
	[170] =  { ['x'] = -214.12,['y'] = -1617.62,['z'] = 38.06,['h'] = 218.57, ['info'] = ' Forum Drive 11/Apt18', ['apt'] = 1 },
	[171] =  { ['x'] = -212.29,['y'] = -1617.34,['z'] = 38.06,['h'] = 253.87, ['info'] = ' Forum Drive 11/Apt19', ['apt'] = 1 },
	[172] =  { ['x'] = -210.46,['y'] = -1607.36,['z'] = 38.05,['h'] = 263.82, ['info'] = ' Forum Drive 11/Apt20', ['apt'] = 1 },
	[173] =  { ['x'] = -209.45,['y'] = -1600.57,['z'] = 38.05,['h'] = 269.99, ['info'] = ' Forum Drive 11/Apt21', ['apt'] = 1 },
	[174] =  { ['x'] = -216.64,['y'] = -1673.73,['z'] = 34.47,['h'] = 179.38, ['info'] = ' Forum Drive 12/Apt1', ['apt'] = 1 },
	[175] =  { ['x'] = -224.15,['y'] = -1673.67,['z'] = 34.47,['h'] = 169.52, ['info'] = ' Forum Drive 12/Apt2', ['apt'] = 1 },
	[176] =  { ['x'] = -224.17,['y'] = -1666.14,['z'] = 34.47,['h'] = 82.29, ['info'] = ' Forum Drive 12/Apt3', ['apt'] = 1 },
	[177] =  { ['x'] = -224.32,['y'] = -1649.0,['z'] = 34.86,['h'] = 85.83, ['info'] = ' Forum Drive 12/Apt4', ['apt'] = 1 },
	[178] =  { ['x'] = -216.34,['y'] = -1648.94,['z'] = 34.47,['h'] = 356.29, ['info'] = ' Forum Drive 12/Apt5', ['apt'] = 1 },
	[179] =  { ['x'] = -212.92,['y'] = -1660.54,['z'] = 34.47,['h'] = 256.79, ['info'] = ' Forum Drive 12/Apt6', ['apt'] = 1 },
	[180] =  { ['x'] = -212.95,['y'] = -1667.96,['z'] = 34.47,['h'] = 264.8, ['info'] = ' Forum Drive 12/Apt7', ['apt'] = 1 },
	[181] =  { ['x'] = -216.55,['y'] = -1673.88,['z'] = 37.64,['h'] = 175.17, ['info'] = ' Forum Drive 12/Apt8', ['apt'] = 1 },
	[182] =  { ['x'] = -224.34,['y'] = -1673.79,['z'] = 37.64,['h'] = 175.13, ['info'] = ' Forum Drive 12/Apt9', ['apt'] = 1 },
	[183] =  { ['x'] = -223.99,['y'] = -1666.29,['z'] = 37.64,['h'] = 86.27, ['info'] = ' Forum Drive 12/Apt10', ['apt'] = 1 },
	[184] =  { ['x'] = -224.44,['y'] = -1653.99,['z'] = 37.64,['h'] = 87.81, ['info'] = ' Forum Drive 12/Apt11', ['apt'] = 1 },
	[185] =  { ['x'] = -223.96,['y'] = -1649.16,['z'] = 38.45,['h'] = 353.99, ['info'] = ' Forum Drive 12/Apt12', ['apt'] = 1 },
	[186] =  { ['x'] = -216.44,['y'] = -1649.13,['z'] = 37.64,['h'] = 352.36, ['info'] = ' Forum Drive 12/Apt13', ['apt'] = 1 },
	[187] =  { ['x'] = -212.85,['y'] = -1660.74,['z'] = 37.64,['h'] = 269.04, ['info'] = ' Forum Drive 12/Apt14', ['apt'] = 1 },
	[188] =  { ['x'] = -212.72,['y'] = -1668.23,['z'] = 37.64,['h'] = 272.59, ['info'] = ' Forum Drive 12/Apt15', ['apt'] = 1 },
	[189] =  { ['x'] = 207.81,['y'] = -1894.66,['z'] = 24.82,['h'] = 226.76, ['info'] = ' Covenant Avenue 1', ['apt'] = 0 },
	[190] =  { ['x'] = 192.27,['y'] = -1884.01,['z'] = 24.86,['h'] = 333.42, ['info'] = ' Covenant Avenue 2', ['apt'] = 0 },
	[191] =  { ['x'] = 170.9,['y'] = -1871.29,['z'] = 24.41,['h'] = 238.08, ['info'] = ' Covenant Avenue 3', ['apt'] = 0 },
	[192] =  { ['x'] = 149.69,['y'] = -1865.39,['z'] = 24.6,['h'] = 339.99, ['info'] = ' Covenant Avenue 4', ['apt'] = 0 },
	[193] =  { ['x'] = 130.2,['y'] = -1854.03,['z'] = 25.06,['h'] = 331.31, ['info'] = ' Covenant Avenue 5', ['apt'] = 0 },
	[194] =  { ['x'] = 104.32,['y'] = -1884.78,['z'] = 24.32,['h'] = 143.76, ['info'] = ' Covenant Avenue 6', ['apt'] = 0 },
	[195] =  { ['x'] = 114.95,['y'] = -1887.7,['z'] = 23.93,['h'] = 241.36, ['info'] = ' Covenant Avenue 7', ['apt'] = 0 },
	[196] =  { ['x'] = 127.69,['y'] = -1896.79,['z'] = 23.68,['h'] = 248.34, ['info'] = ' Covenant Avenue 8', ['apt'] = 0 },
	[197] =  { ['x'] = 148.81,['y'] = -1904.41,['z'] = 23.54,['h'] = 155.7, ['info'] = ' Covenant Avenue 9', ['apt'] = 0 },
	[198] =  { ['x'] = -1071.77,['y'] = -1566.08,['z'] = 4.39,['h'] = 99.92, ['info'] = ' Beachside Court 13', ['apt'] = 0 },
	[199] =  { ['x'] = -1073.94,['y'] = -1562.36,['z'] = 4.46,['h'] = 300.25, ['info'] = ' Beachside Court 14', ['apt'] = 0 },
	[200] =  { ['x'] = -1066.23,['y'] = -1545.34,['z'] = 4.91,['h'] = 208.82, ['info'] = ' Beachside Court 15', ['apt'] = 0 },
	[201] =  { ['x'] = -113.52,['y'] = -1478.46,['z'] = 33.83,['h'] = 226.49, ['info'] = ' Carson Avenue 1/Apt1', ['apt'] = 1 },
	[202] =  { ['x'] = -108.04,['y'] = -1473.11,['z'] = 33.83,['h'] = 225.6, ['info'] = ' Carson Avenue 1/Apt2', ['apt'] = 1 },
	[203] =  { ['x'] = -113.89,['y'] = -1468.64,['z'] = 33.83,['h'] = 321.96, ['info'] = ' Carson Avenue 1/Apt3', ['apt'] = 1 },
	[204] =  { ['x'] = -123.05,['y'] = -1460.05,['z'] = 33.83,['h'] = 317.58, ['info'] = ' Carson Avenue 1/Apt4', ['apt'] = 1 },
	[205] =  { ['x'] = -126.68,['y'] = -1456.71,['z'] = 34.57,['h'] = 320.2, ['info'] = ' Carson Avenue 1/Apt5', ['apt'] = 1 },
	[206] =  { ['x'] = -131.8,['y'] = -1463.15,['z'] = 33.83,['h'] = 49.07, ['info'] = ' Carson Avenue 1/Apt6', ['apt'] = 1 },
	[207] =  { ['x'] = -125.47,['y'] = -1473.1,['z'] = 33.83,['h'] = 142.11, ['info'] = ' Carson Avenue 1/Apt7', ['apt'] = 1 },
	[208] =  { ['x'] = -119.61,['y'] = -1478.11,['z'] = 33.83,['h'] = 135.81, ['info'] = ' Carson Avenue 1/Apt8', ['apt'] = 1 },
	[209] =  { ['x'] = -122.98,['y'] = -1460.25,['z'] = 37.0,['h'] = 320.71, ['info'] = ' Carson Avenue 1/Apt9', ['apt'] = 1 },
	[210] =  { ['x'] = -127.02,['y'] = -1457.18,['z'] = 37.8,['h'] = 52.77, ['info'] = ' Carson Avenue 1/Apt10', ['apt'] = 1 },
	[211] =  { ['x'] = -131.92,['y'] = -1463.16,['z'] = 37.0,['h'] = 49.86, ['info'] = ' Carson Avenue 1/Apt11', ['apt'] = 1 },
	[212] =  { ['x'] = -138.15,['y'] = -1470.49,['z'] = 37.0,['h'] = 139.34, ['info'] = ' Carson Avenue 1/Apt12', ['apt'] = 1 },
	[213] =  { ['x'] = -125.48,['y'] = -1473.39,['z'] = 37.0,['h'] = 144.5, ['info'] = ' Carson Avenue 1/Apt13', ['apt'] = 1 },
	[214] =  { ['x'] = -119.87,['y'] = -1477.81,['z'] = 37.0,['h'] = 143.58, ['info'] = ' Carson Avenue 1/Apt14', ['apt'] = 1 },
	[215] =  { ['x'] = -77.1,['y'] = -1515.61,['z'] = 34.25,['h'] = 44.81, ['info'] = ' Carson Avenue 2/Apt1', ['apt'] = 1 },
	[216] =  { ['x'] = -71.74,['y'] = -1508.33,['z'] = 33.44,['h'] = 40.4, ['info'] = ' Carson Avenue 2/Apt2', ['apt'] = 1 },
	[217] =  { ['x'] = -65.73,['y'] = -1513.55,['z'] = 33.44,['h'] = 318.02, ['info'] = ' Carson Avenue 2/Apt3', ['apt'] = 1 },
	[218] =  { ['x'] = -60.39,['y'] = -1517.48,['z'] = 33.44,['h'] = 319.04, ['info'] = ' Carson Avenue 2/Apt4', ['apt'] = 1 },
	[219] =  { ['x'] = -54.1,['y'] = -1523.19,['z'] = 33.44,['h'] = 235.48, ['info'] = ' Carson Avenue 2/Apt5', ['apt'] = 1 },
	[220] =  { ['x'] = -59.84,['y'] = -1530.35,['z'] = 34.24,['h'] = 231.22, ['info'] = ' Carson Avenue 2/Apt6', ['apt'] = 1 },
	[221] =  { ['x'] = -62.18,['y'] = -1532.27,['z'] = 34.24,['h'] = 136.83, ['info'] = ' Carson Avenue 2/Apt7', ['apt'] = 1 },
	[222] =  { ['x'] = -68.86,['y'] = -1526.34,['z'] = 34.24,['h'] = 132.44, ['info'] = ' Carson Avenue 2/Apt8', ['apt'] = 1 },
	[223] =  { ['x'] = -77.3,['y'] = -1515.62,['z'] = 37.42,['h'] = 48.47, ['info'] = ' Carson Avenue 2/Apt9', ['apt'] = 1 },
	[224] =  { ['x'] = -71.37,['y'] = -1508.76,['z'] = 36.63,['h'] = 42.69, ['info'] = ' Carson Avenue 2/Apt10', ['apt'] = 1 },
	[225] =  { ['x'] = -65.85,['y'] = -1513.39,['z'] = 36.63,['h'] = 319.16, ['info'] = ' Carson Avenue 2/Apt11', ['apt'] = 1 },
	[226] =  { ['x'] = -61.03,['y'] = -1517.82,['z'] = 36.63,['h'] = 316.66, ['info'] = ' Carson Avenue 2/Apt12', ['apt'] = 1 },
	[227] =  { ['x'] = -54.23,['y'] = -1523.33,['z'] = 36.63,['h'] = 229.97, ['info'] = ' Carson Avenue 2/Apt13', ['apt'] = 1 },
	[228] =  { ['x'] = -60.03,['y'] = -1530.35,['z'] = 37.42,['h'] = 226.15, ['info'] = ' Carson Avenue 2/Apt14', ['apt'] = 1 },
	[229] =  { ['x'] = -61.53,['y'] = -1532.14,['z'] = 37.42,['h'] = 136.13, ['info'] = ' Carson Avenue 2/Apt15', ['apt'] = 1 },
	[230] =  { ['x'] = -68.59,['y'] = -1526.2,['z'] = 37.42,['h'] = 137.9, ['info'] = ' Carson Avenue 2/Apt16', ['apt'] = 1 },
	[231] =  { ['x'] = -35.11,['y'] = -1554.6,['z'] = 30.68,['h'] = 129.72, ['info'] = ' Strawberry Avenue 1/Apt1', ['apt'] = 1 },
	[232] =  { ['x'] = -44.33,['y'] = -1547.29,['z'] = 31.27,['h'] = 51.34, ['info'] = ' Strawberry Avenue 1/Apt2', ['apt'] = 1 },
	[233] =  { ['x'] = -36.07,['y'] = -1537.29,['z'] = 31.25,['h'] = 47.34, ['info'] = ' Strawberry Avenue 1/Apt3', ['apt'] = 1 },
	[234] =  { ['x'] = -26.48,['y'] = -1544.33,['z'] = 30.68,['h'] = 310.44, ['info'] = ' Strawberry Avenue 1/Apt4', ['apt'] = 1 },
	[235] =  { ['x'] = -20.54,['y'] = -1550.16,['z'] = 30.68,['h'] = 230.04, ['info'] = ' Strawberry Avenue 1/Apt5', ['apt'] = 1 },
	[236] =  { ['x'] = -25.49,['y'] = -1556.28,['z'] = 30.69,['h'] = 224.38, ['info'] = ' Strawberry Avenue 1/Apt6', ['apt'] = 1 },
	[237] =  { ['x'] = -34.37,['y'] = -1566.55,['z'] = 33.03,['h'] = 227.02, ['info'] = ' Strawberry Avenue 1/Apt7', ['apt'] = 1 },
	[238] =  { ['x'] = -35.36,['y'] = -1555.08,['z'] = 33.83,['h'] = 138.59, ['info'] = ' Strawberry Avenue 1/Apt8', ['apt'] = 1 },
	[239] =  { ['x'] = -43.9,['y'] = -1547.83,['z'] = 34.63,['h'] = 50.27, ['info'] = ' Strawberry Avenue 1/Apt9', ['apt'] = 1 },
	[240] =  { ['x'] = -28.52,['y'] = -1560.41,['z'] = 33.83,['h'] = 234.04, ['info'] = ' Strawberry Avenue 1/Apt14', ['apt'] = 1 },
	[241] =  { ['x'] = -14.63,['y'] = -1543.73,['z'] = 33.03,['h'] = 222.98, ['info'] = ' Strawberry Avenue 1/Apt12', ['apt'] = 1 },
	[242] =  { ['x'] = -20.69,['y'] = -1550.0,['z'] = 33.83,['h'] = 225.08, ['info'] = ' Strawberry Avenue 1/Apt13', ['apt'] = 1 },
	[243] =  { ['x'] = -26.96,['y'] = -1544.93,['z'] = 33.83,['h'] = 320.18, ['info'] = ' Strawberry Avenue 1/Apt11', ['apt'] = 1 },
	[244] =  { ['x'] = -35.82,['y'] = -1537.25,['z'] = 34.63,['h'] = 48.69, ['info'] = ' Strawberry Avenue 1/Apt10', ['apt'] = 1 },
	[245] =  { ['x'] = -84.12,['y'] = -1622.47,['z'] = 31.48,['h'] = 230.69, ['info'] = ' Strawberry Avenue 2/Apt1', ['apt'] = 1 },
	[246] =  { ['x'] = -90.44,['y'] = -1629.08,['z'] = 31.51,['h'] = 226.67, ['info'] = ' Strawberry Avenue 2/Apt2', ['apt'] = 1 },
	[247] =  { ['x'] = -97.46,['y'] = -1638.56,['z'] = 32.11,['h'] = 225.22, ['info'] = ' Strawberry Avenue 2/Apt3', ['apt'] = 1 },
	[248] =  { ['x'] = -105.34,['y'] = -1632.48,['z'] = 32.91,['h'] = 137.22, ['info'] = ' Strawberry Avenue 2/Apt4', ['apt'] = 1 },
	[249] =  { ['x'] = -108.73,['y'] = -1629.04,['z'] = 32.91,['h'] = 45.99, ['info'] = ' Strawberry Avenue 2/Apt5', ['apt'] = 1 },
	[250] =  { ['x'] = -96.87,['y'] = -1613.02,['z'] = 32.32,['h'] = 52.37, ['info'] = ' Strawberry Avenue 2/Apt6', ['apt'] = 1 },
	[251] =  { ['x'] = -92.45,['y'] = -1608.14,['z'] = 32.32,['h'] = 47.32, ['info'] = ' Strawberry Avenue 2/Apt7', ['apt'] = 1 },
	[252] =  { ['x'] = -88.5,['y'] = -1602.39,['z'] = 32.32,['h'] = 323.29, ['info'] = ' Strawberry Avenue 2/Apt8', ['apt'] = 1 },
	[253] =  { ['x'] = -81.05,['y'] = -1608.75,['z'] = 31.49,['h'] = 322.94, ['info'] = ' Strawberry Avenue 2/Apt9', ['apt'] = 1 },
	[254] =  { ['x'] = -84.11,['y'] = -1622.43,['z'] = 34.69,['h'] = 229.53, ['info'] = ' Strawberry Avenue 2/Apt10', ['apt'] = 1 },
	[255] =  { ['x'] = -90.11,['y'] = -1629.4,['z'] = 34.69,['h'] = 227.58, ['info'] = ' Strawberry Avenue 2/Apt11', ['apt'] = 1 },
	[256] =  { ['x'] = -96.25,['y'] = -1637.41,['z'] = 35.49,['h'] = 164.78, ['info'] = ' Strawberry Avenue 2/Apt12', ['apt'] = 1 },
	[257] =  { ['x'] = -98.24,['y'] = -1638.72,['z'] = 35.49,['h'] = 139.02, ['info'] = ' Strawberry Avenue 2/Apt13', ['apt'] = 1 },
	[258] =  { ['x'] = -104.94,['y'] = -1632.23,['z'] = 36.29,['h'] = 135.05, ['info'] = ' Strawberry Avenue 2/Apt14', ['apt'] = 1 },
	[259] =  { ['x'] = -108.73,['y'] = -1628.99,['z'] = 36.29,['h'] = 50.81, ['info'] = ' Strawberry Avenue 2/Apt15', ['apt'] = 1 },
	[260] =  { ['x'] = -97.08,['y'] = -1612.9,['z'] = 35.49,['h'] = 50.06, ['info'] = ' Strawberry Avenue 2/Apt16', ['apt'] = 1 },
	[261] =  { ['x'] = -92.88,['y'] = -1607.79,['z'] = 35.49,['h'] = 47.31, ['info'] = ' Strawberry Avenue 2/Apt17', ['apt'] = 1 },
	[262] =  { ['x'] = -88.13,['y'] = -1602.14,['z'] = 35.49,['h'] = 318.46, ['info'] = ' Strawberry Avenue 2/Apt18', ['apt'] = 1 },
	[263] =  { ['x'] = -80.67,['y'] = -1608.63,['z'] = 34.69,['h'] = 317.01, ['info'] = ' Strawberry Avenue 2/Apt19', ['apt'] = 1 },
	[264] =  { ['x'] = 252.35,['y'] = -1671.55,['z'] = 29.67,['h'] = 321.56, ['info'] = ' Brouge Avenue 1', ['apt'] = 0 },
	[265] =  { ['x'] = 241.38,['y'] = -1688.28,['z'] = 29.52,['h'] = 51.92, ['info'] = ' Brouge Avenue 2', ['apt'] = 0 },
	[266] =  { ['x'] = 223.35,['y'] = -1703.33,['z'] = 29.49,['h'] = 37.67, ['info'] = ' Brouge Avenue 3', ['apt'] = 0 },
	[267] =  { ['x'] = 216.83,['y'] = -1717.15,['z'] = 29.48,['h'] = 123.44, ['info'] = ' Brouge Avenue 4', ['apt'] = 0 },
	[268] =  { ['x'] = 198.59,['y'] = -1725.5,['z'] = 29.67,['h'] = 115.99, ['info'] = ' Brouge Avenue 5', ['apt'] = 0 },
	[269] =  { ['x'] = 152.28,['y'] = -1823.45,['z'] = 27.87,['h'] = 234.41, ['info'] = ' Brouge Avenue 6', ['apt'] = 0 },
	[270] =  { ['x'] = 249.48,['y'] = -1730.38,['z'] = 29.67,['h'] = 229.2, ['info'] = ' Brouge Avenue 7', ['apt'] = 0 },
	[271] =  { ['x'] = 257.05,['y'] = -1723.09,['z'] = 29.66,['h'] = 313.23, ['info'] = ' Brouge Avenue 8', ['apt'] = 0 },
	[272] =  { ['x'] = 269.23,['y'] = -1713.34,['z'] = 29.67,['h'] = 318.18, ['info'] = ' Brouge Avenue 9', ['apt'] = 0 },
	[273] =  { ['x'] = 281.13,['y'] = -1694.16,['z'] = 29.26,['h'] = 232.69, ['info'] = ' Brouge Avenue 10', ['apt'] = 0 },
	[274] =  { ['x'] = 332.58,['y'] = -1741.63,['z'] = 29.74,['h'] = 319.91, ['info'] = ' Roy Lowenstein Blvd 1', ['apt'] = 0 },
	[275] =  { ['x'] = 320.66,['y'] = -1759.78,['z'] = 29.64,['h'] = 60.41, ['info'] = ' Roy Lowenstein Blvd 2', ['apt'] = 0 },
	[276] =  { ['x'] = 305.15,['y'] = -1775.86,['z'] = 29.1,['h'] = 49.68, ['info'] = ' Roy Lowenstein Blvd 3', ['apt'] = 0 },
	[277] =  { ['x'] = 299.84,['y'] = -1784.04,['z'] = 28.44,['h'] = 324.93, ['info'] = ' Roy Lowenstein Blvd 4', ['apt'] = 0 },
	[278] =  { ['x'] = 289.25,['y'] = -1791.99,['z'] = 28.09,['h'] = 141.95, ['info'] = ' Roy Lowenstein Blvd 5', ['apt'] = 0 },
	[279] =  { ['x'] = 179.23,['y'] = -1923.86,['z'] = 21.38,['h'] = 322.58, ['info'] = ' Roy Lowenstein Blvd 6', ['apt'] = 0 },
	[280] =  { ['x'] = 165.55,['y'] = -1945.18,['z'] = 20.24,['h'] = 48.7, ['info'] = ' Roy Lowenstein Blvd 7', ['apt'] = 0 },
	[281] =  { ['x'] = 149.99,['y'] = -1961.59,['z'] = 19.08,['h'] = 43.72, ['info'] = ' Roy Lowenstein Blvd 8', ['apt'] = 0 },
	[282] =  { ['x'] = 144.14,['y'] = -1969.72,['z'] = 18.86,['h'] = 332.82, ['info'] = ' Roy Lowenstein Blvd 9', ['apt'] = 0 },
	[283] =  { ['x'] = 140.98,['y'] = -1983.14,['z'] = 18.33,['h'] = 57.43, ['info'] = ' Roy Lowenstein Blvd 10', ['apt'] = 0 },
	[284] =  { ['x'] = 250.07,['y'] = -1934.4,['z'] = 24.51,['h'] = 231.59, ['info'] = ' Roy Lowenstein Blvd 11', ['apt'] = 0 },
	[285] =  { ['x'] = 257.39,['y'] = -1927.69,['z'] = 25.45,['h'] = 312.69, ['info'] = ' Roy Lowenstein Blvd 12', ['apt'] = 0 },
	[286] =  { ['x'] = 269.71,['y'] = -1917.57,['z'] = 26.19,['h'] = 317.5, ['info'] = ' Roy Lowenstein Blvd 13', ['apt'] = 0 },
	[287] =  { ['x'] = 281.88,['y'] = -1898.45,['z'] = 26.88,['h'] = 230.17, ['info'] = ' Roy Lowenstein Blvd 14', ['apt'] = 0 },
	[288] =  { ['x'] = 319.74,['y'] = -1853.49,['z'] = 27.53,['h'] = 227.79, ['info'] = ' Roy Lowenstein Blvd 15', ['apt'] = 0 },
	[289] =  { ['x'] = 328.0,['y'] = -1844.52,['z'] = 27.76,['h'] = 225.99, ['info'] = ' Roy Lowenstein Blvd 16', ['apt'] = 0 },
	[290] =  { ['x'] = 339.22,['y'] = -1829.24,['z'] = 28.34,['h'] = 136.63, ['info'] = ' Roy Lowenstein Blvd 17', ['apt'] = 0 },
	[291] =  { ['x'] = 348.85,['y'] = -1820.62,['z'] = 28.9,['h'] = 142.65, ['info'] = ' Roy Lowenstein Blvd 18', ['apt'] = 0 },
	[292] =  { ['x'] = 405.64,['y'] = -1751.29,['z'] = 29.72,['h'] = 324.51, ['info'] = ' Roy Lowenstein Blvd 19', ['apt'] = 0 },
	[293] =  { ['x'] = 418.53,['y'] = -1735.9,['z'] = 29.61,['h'] = 315.07, ['info'] = ' Roy Lowenstein Blvd 20', ['apt'] = 0 },
	[294] =  { ['x'] = 430.99,['y'] = -1725.5,['z'] = 29.61,['h'] = 310.19, ['info'] = ' Roy Lowenstein Blvd 21', ['apt'] = 0 },
	[295] =  { ['x'] = 442.72,['y'] = -1706.93,['z'] = 29.49,['h'] = 231.07, ['info'] = ' Roy Lowenstein Blvd 22', ['apt'] = 0 },
	[296] =  { ['x'] = 471.16,['y'] = -1561.47,['z'] = 32.8,['h'] = 50.68, ['info'] = ' Roy Lowenstein Blvd 23/Apt1', ['apt'] = 1 },
	[297] =  { ['x'] = 465.83,['y'] = -1567.54,['z'] = 32.8,['h'] = 54.01, ['info'] = ' Roy Lowenstein Blvd 23/Apt2', ['apt'] = 1 },
	[298] =  { ['x'] = 461.39,['y'] = -1573.95,['z'] = 32.8,['h'] = 49.46, ['info'] = ' Roy Lowenstein Blvd 23/Apt3', ['apt'] = 1 },
	[299] =  { ['x'] = 455.53,['y'] = -1579.34,['z'] = 32.8,['h'] = 141.19, ['info'] = ' Roy Lowenstein Blvd 23/Apt4', ['apt'] = 1 },
	[300] =  { ['x'] = 442.13,['y'] = -1569.43,['z'] = 32.8,['h'] = 134.84, ['info'] = ' Roy Lowenstein Blvd 23/Apt5', ['apt'] = 1 },
	[301] =  { ['x'] = 436.5,['y'] = -1563.9,['z'] = 32.8,['h'] = 136.21, ['info'] = ' Roy Lowenstein Blvd 23/Apt6', ['apt'] = 1 },
	[302] =  { ['x'] = 431.15,['y'] = -1558.66,['z'] = 32.8,['h'] = 136.11, ['info'] = ' Roy Lowenstein Blvd 23/Apt7', ['apt'] = 1 },
	[303] =  { ['x'] = 500.25,['y'] = -1697.49,['z'] = 29.79,['h'] = 322.98, ['info'] = ' Jamestown Street 1', ['apt'] = 0 },
	[304] =  { ['x'] = 490.6,['y'] = -1714.39,['z'] = 29.5,['h'] = 70.57, ['info'] = ' Jamestown Street 2', ['apt'] = 0 },
	[305] =  { ['x'] = 479.51,['y'] = -1736.71,['z'] = 29.16,['h'] = 344.06, ['info'] = ' Jamestown Street 3', ['apt'] = 0 },
	[306] =  { ['x'] = 475.44,['y'] = -1757.74,['z'] = 28.9,['h'] = 79.05, ['info'] = ' Jamestown Street 4', ['apt'] = 0 },
	[307] =  { ['x'] = 472.88,['y'] = -1775.22,['z'] = 29.07,['h'] = 86.89, ['info'] = ' Jamestown Street 5', ['apt'] = 0 },
	[308] =  { ['x'] = 440.01,['y'] = -1830.31,['z'] = 28.37,['h'] = 328.16, ['info'] = ' Jamestown Street 6', ['apt'] = 0 },
	[309] =  { ['x'] = 428.12,['y'] = -1841.33,['z'] = 28.47,['h'] = 135.91, ['info'] = ' Jamestown Street 7', ['apt'] = 0 },
	[310] =  { ['x'] = 412.58,['y'] = -1856.23,['z'] = 27.33,['h'] = 137.19, ['info'] = ' Jamestown Street 8', ['apt'] = 0 },
	[311] =  { ['x'] = 399.67,['y'] = -1864.78,['z'] = 26.72,['h'] = 132.43, ['info'] = ' Jamestown Street 9', ['apt'] = 0 },
	[312] =  { ['x'] = 386.04,['y'] = -1882.27,['z'] = 25.79,['h'] = 47.42, ['info'] = ' Jamestown Street 10', ['apt'] = 0 },
	[313] =  { ['x'] = 368.05,['y'] = -1896.76,['z'] = 25.18,['h'] = 317.81, ['info'] = ' Jamestown Street 11', ['apt'] = 0 },
	[314] =  { ['x'] = 324.15,['y'] = -1937.81,['z'] = 25.02,['h'] = 327.68, ['info'] = ' Jamestown Street 12', ['apt'] = 0 },
	[315] =  { ['x'] = 312.81,['y'] = -1956.66,['z'] = 24.43,['h'] = 44.18, ['info'] = ' Jamestown Street 13', ['apt'] = 0 },
	[316] =  { ['x'] = 296.54,['y'] = -1972.44,['z'] = 22.7,['h'] = 43.25, ['info'] = ' Jamestown Street 14', ['apt'] = 0 },
	[317] =  { ['x'] = 291.23,['y'] = -1980.74,['z'] = 21.61,['h'] = 323.31, ['info'] = ' Jamestown Street 15', ['apt'] = 0 },
	[318] =  { ['x'] = 280.23,['y'] = -1993.25,['z'] = 20.81,['h'] = 139.93, ['info'] = ' Jamestown Street 16', ['apt'] = 0 },
	[319] =  { ['x'] = 257.12,['y'] = -2023.84,['z'] = 19.27,['h'] = 55.76, ['info'] = ' Jamestown Street 17', ['apt'] = 0 },
	[320] =  { ['x'] = 251.39,['y'] = -2029.73,['z'] = 18.51,['h'] = 137.79, ['info'] = ' Jamestown Street 18', ['apt'] = 0 },
	[321] =  { ['x'] = 236.5,['y'] = -2045.73,['z'] = 18.38,['h'] = 134.85, ['info'] = ' Jamestown Street 19', ['apt'] = 0 },
	[322] =  { ['x'] = 296.87,['y'] = -2097.86,['z'] = 17.67,['h'] = 285.59, ['info'] = ' Jamestown Street 20/Apt1', ['apt'] = 1 },
	[323] =  { ['x'] = 295.78,['y'] = -2093.31,['z'] = 17.67,['h'] = 291.54, ['info'] = ' Jamestown Street 20/Apt2', ['apt'] = 1 },
	[324] =  { ['x'] = 293.68,['y'] = -2087.92,['z'] = 17.67,['h'] = 287.12, ['info'] = ' Jamestown Street 20/Apt3', ['apt'] = 1 },
	[325] =  { ['x'] = 292.59,['y'] = -2086.38,['z'] = 17.67,['h'] = 290.15, ['info'] = ' Jamestown Street 20/Apt4', ['apt'] = 1 },
	[326] =  { ['x'] = 289.53,['y'] = -2077.1,['z'] = 17.67,['h'] = 291.26, ['info'] = ' Jamestown Street 20/Apt5', ['apt'] = 1 },
	[327] =  { ['x'] = 288.21,['y'] = -2072.75,['z'] = 17.67,['h'] = 288.69, ['info'] = ' Jamestown Street 20/Apt6', ['apt'] = 1 },
	[328] =  { ['x'] = 279.29,['y'] = -2043.26,['z'] = 19.77,['h'] = 232.08, ['info'] = ' Jamestown Street 20/Apt7', ['apt'] = 1 },
	[329] =  { ['x'] = 280.6,['y'] = -2041.64,['z'] = 19.77,['h'] = 224.82, ['info'] = ' Jamestown Street 20/Apt8', ['apt'] = 1 },
	[330] =  { ['x'] = 286.69,['y'] = -2034.4,['z'] = 19.77,['h'] = 231.33, ['info'] = ' Jamestown Street 20/Apt9', ['apt'] = 1 },
	[331] =  { ['x'] = 289.76,['y'] = -2030.74,['z'] = 19.77,['h'] = 231.61, ['info'] = ' Jamestown Street 20/Apt10', ['apt'] = 1 },
	[332] =  { ['x'] = 323.53,['y'] = -1990.66,['z'] = 24.17,['h'] = 229.59, ['info'] = ' Jamestown Street 20/Apt11', ['apt'] = 1 },
	[333] =  { ['x'] = 324.82,['y'] = -1988.95,['z'] = 24.17,['h'] = 226.72, ['info'] = ' Jamestown Street 20/Apt12', ['apt'] = 1 },
	[334] =  { ['x'] = 331.63,['y'] = -1982.15,['z'] = 24.17,['h'] = 233.06, ['info'] = ' Jamestown Street 20/Apt13', ['apt'] = 1 },
	[335] =  { ['x'] = 333.9,['y'] = -1978.33,['z'] = 24.17,['h'] = 241.31, ['info'] = ' Jamestown Street 20/Apt14', ['apt'] = 1 },
	[336] =  { ['x'] = 362.6,['y'] = -1986.24,['z'] = 24.13,['h'] = 159.57, ['info'] = ' Jamestown Street 20/Apt15', ['apt'] = 1 },
	[337] =  { ['x'] = 364.17,['y'] = -1986.78,['z'] = 24.14,['h'] = 160.3, ['info'] = ' Jamestown Street 20/Apt16', ['apt'] = 1 },
	[338] =  { ['x'] = 375.15,['y'] = -1990.66,['z'] = 24.13,['h'] = 157.46, ['info'] = ' Jamestown Street 20/Apt18', ['apt'] = 1 },
	[339] =  { ['x'] = 384.27,['y'] = -1994.33,['z'] = 24.24,['h'] = 162.11, ['info'] = ' Jamestown Street 20/Apt19', ['apt'] = 1 },
	[340] =  { ['x'] = 385.74,['y'] = -1995.01,['z'] = 24.24,['h'] = 162.4, ['info'] = ' Jamestown Street 20/Apt20', ['apt'] = 1 },
	[341] =  { ['x'] = 405.02,['y'] = -2018.35,['z'] = 23.33,['h'] = 67.11, ['info'] = ' Jamestown Street 20/Apt21', ['apt'] = 1 },
	[342] =  { ['x'] = 402.43,['y'] = -2024.68,['z'] = 23.25,['h'] = 64.89, ['info'] = ' Jamestown Street 20/Apt22', ['apt'] = 1 },
	[343] =  { ['x'] = 400.7,['y'] = -2028.47,['z'] = 23.25,['h'] = 64.86, ['info'] = ' Jamestown Street 20/Apt23', ['apt'] = 1 },
	[344] =  { ['x'] = 397.38,['y'] = -2034.67,['z'] = 23.21,['h'] = 62.87, ['info'] = ' Jamestown Street 20/Apt24', ['apt'] = 1 },
	[345] =  { ['x'] = 396.04,['y'] = -2037.9,['z'] = 23.04,['h'] = 66.18, ['info'] = ' Jamestown Street 20/Apt25', ['apt'] = 1 },
	[346] =  { ['x'] = 392.7,['y'] = -2044.32,['z'] = 22.93,['h'] = 64.93, ['info'] = ' Jamestown Street 20/Apt26', ['apt'] = 1 },
	[347] =  { ['x'] = 382.56,['y'] = -2061.38,['z'] = 21.78,['h'] = 52.06, ['info'] = ' Jamestown Street 20/Apt27', ['apt'] = 1 },
	[348] =  { ['x'] = 378.73,['y'] = -2067.02,['z'] = 21.38,['h'] = 52.18, ['info'] = ' Jamestown Street 20/Apt28', ['apt'] = 1 },
	[349] =  { ['x'] = 375.83,['y'] = -2069.96,['z'] = 21.55,['h'] = 52.97, ['info'] = ' Jamestown Street 20/Apt29', ['apt'] = 1 },
	[350] =  { ['x'] = 371.63,['y'] = -2074.86,['z'] = 21.56,['h'] = 47.53, ['info'] = ' Jamestown Street 20/Apt30', ['apt'] = 1 },
	[351] =  { ['x'] = 368.99,['y'] = -2078.37,['z'] = 21.38,['h'] = 49.85, ['info'] = ' Jamestown Street 20/Apt31', ['apt'] = 1 },
	[352] =  { ['x'] = 364.48,['y'] = -2083.31,['z'] = 21.57,['h'] = 55.19, ['info'] = ' Jamestown Street 20/Apt32', ['apt'] = 1 },
	[353] =  { ['x'] = 341.08,['y'] = -2098.49,['z'] = 18.21,['h'] = 110.37, ['info'] = ' Jamestown Street 20/Apt33', ['apt'] = 1 },
	[354] =  { ['x'] = 333.01,['y'] = -2106.72,['z'] = 18.02,['h'] = 38.79, ['info'] = ' Jamestown Street 20/Apt34', ['apt'] = 1 },
	[355] =  { ['x'] = 329.57,['y'] = -2108.85,['z'] = 17.91,['h'] = 31.98, ['info'] = ' Jamestown Street 20/Apt35', ['apt'] = 1 },
	[356] =  { ['x'] = 324.18,['y'] = -2112.44,['z'] = 17.76,['h'] = 46.63, ['info'] = ' Jamestown Street 20/Apt36', ['apt'] = 1 },
	[357] =  { ['x'] = 306.34,['y'] = -2098.09,['z'] = 17.53,['h'] = 17.58, ['info'] = ' Jamestown Street 20/Apt37', ['apt'] = 1 },
	[358] =  { ['x'] = 306.07,['y'] = -2086.4,['z'] = 17.61,['h'] = 103.49, ['info'] = ' Jamestown Street 20/Apt38', ['apt'] = 1 },
	[359] =  { ['x'] = 303.8,['y'] = -2079.71,['z'] = 17.66,['h'] = 108.49, ['info'] = ' Jamestown Street 20/Apt39', ['apt'] = 1 },
	[360] =  { ['x'] = 302.18,['y'] = -2076.06,['z'] = 17.69,['h'] = 99.21, ['info'] = ' Jamestown Street 20/Apt40', ['apt'] = 1 },
	[361] =  { ['x'] = 295.03,['y'] = -2067.07,['z'] = 17.66,['h'] = 190.42, ['info'] = ' Jamestown Street 20/Apt41', ['apt'] = 1 },
	[362] =  { ['x'] = 286.77,['y'] = -2053.13,['z'] = 19.43,['h'] = 52.79, ['info'] = ' Jamestown Street 20/Apt42', ['apt'] = 1 },
	[363] =  { ['x'] = 291.13,['y'] = -2047.6,['z'] = 19.66,['h'] = 44.61, ['info'] = ' Jamestown Street 20/Apt43', ['apt'] = 1 },
	[364] =  { ['x'] = 293.65,['y'] = -2044.56,['z'] = 19.64,['h'] = 39.9, ['info'] = ' Jamestown Street 20/Apt44', ['apt'] = 1 },
	[365] =  { ['x'] = 331.18,['y'] = -2000.79,['z'] = 23.81,['h'] = 47.06, ['info'] = ' Jamestown Street 20/Apt45', ['apt'] = 1 },
	[366] =  { ['x'] = 335.45,['y'] = -1995.13,['z'] = 24.05,['h'] = 47.08, ['info'] = ' Jamestown Street 20/Apt46', ['apt'] = 1 },
	[367] =  { ['x'] = 338.11,['y'] = -1992.45,['z'] = 23.61,['h'] = 40.95, ['info'] = ' Jamestown Street 20/Apt47', ['apt'] = 1 },
	[368] =  { ['x'] = 356.72,['y'] = -1997.29,['z'] = 24.07,['h'] = 336.83, ['info'] = ' Jamestown Street 20/Apt48', ['apt'] = 1 },
	[369] =  { ['x'] = 363.17,['y'] = -1999.61,['z'] = 24.05,['h'] = 336.99, ['info'] = ' Jamestown Street 20/Apt49', ['apt'] = 1 },
	[370] =  { ['x'] = 366.89,['y'] = -2000.92,['z'] = 24.24,['h'] = 334.73, ['info'] = ' Jamestown Street 20/Apt50', ['apt'] = 1 },
	[371] =  { ['x'] = 373.56,['y'] = -2003.08,['z'] = 24.27,['h'] = 340.6, ['info'] = ' Jamestown Street 20/Apt51', ['apt'] = 1 },
	[372] =  { ['x'] = 376.97,['y'] = -2004.75,['z'] = 24.05,['h'] = 334.25, ['info'] = ' Jamestown Street 20/Apt52', ['apt'] = 1 },
	[373] =  { ['x'] = 383.31,['y'] = -2007.28,['z'] = 23.88,['h'] = 331.42, ['info'] = ' Jamestown Street 20/Apt53', ['apt'] = 1 },
	[374] =  { ['x'] = 393.38,['y'] = -2015.4,['z'] = 23.41,['h'] = 241.2, ['info'] = ' Jamestown Street 20/Apt54', ['apt'] = 1 },
	[375] =  { ['x'] = 391.99,['y'] = -2016.96,['z'] = 23.41,['h'] = 242.17, ['info'] = ' Jamestown Street 20/Apt55', ['apt'] = 1 },
	[376] =  { ['x'] = 388.18,['y'] = -2025.47,['z'] = 23.41,['h'] = 236.34, ['info'] = ' Jamestown Street 20/Apt56', ['apt'] = 1 },
	[377] =  { ['x'] = 383.87,['y'] = -2036.12,['z'] = 23.41,['h'] = 243.42, ['info'] = ' Jamestown Street 20/Apt58', ['apt'] = 1 },
	[378] =  { ['x'] = 382.6,['y'] = -2037.41,['z'] = 23.41,['h'] = 243.12, ['info'] = ' Jamestown Street 20/Apt59', ['apt'] = 1 },
	[379] =  { ['x'] = 372.04,['y'] = -2055.52,['z'] = 21.75,['h'] = 221.27, ['info'] = ' Jamestown Street 20/Apt60', ['apt'] = 1 },
	[380] =  { ['x'] = 370.9,['y'] = -2056.9,['z'] = 21.75,['h'] = 226.86, ['info'] = ' Jamestown Street 20/Apt61', ['apt'] = 1 },
	[381] =  { ['x'] = 364.62,['y'] = -2064.18,['z'] = 21.75,['h'] = 226.55, ['info'] = ' Jamestown Street 20/Apt62', ['apt'] = 1 },
	[382] =  { ['x'] = 357.72,['y'] = -2073.24,['z'] = 21.75,['h'] = 231.66, ['info'] = ' Jamestown Street 20/Apt64', ['apt'] = 1 },
	[383] =  { ['x'] = 356.57,['y'] = -2074.62,['z'] = 21.75,['h'] = 227.21, ['info'] = ' Jamestown Street 20/Apt65', ['apt'] = 1 },
	[384] =  { ['x'] = 334.14,['y'] = -2092.86,['z'] = 18.25,['h'] = 209.74, ['info'] = ' Jamestown Street 20/Apt66', ['apt'] = 1 },
	[385] =  { ['x'] = 329.88,['y'] = -2094.65,['z'] = 18.25,['h'] = 208.97, ['info'] = ' Jamestown Street 20/Apt67', ['apt'] = 1 },
	[386] =  { ['x'] = 321.57,['y'] = -2099.85,['z'] = 18.25,['h'] = 208.4, ['info'] = ' Jamestown Street 20/Apt68', ['apt'] = 1 },
	[387] =  { ['x'] = 319.72,['y'] = -2100.29,['z'] = 18.25,['h'] = 207.21, ['info'] = ' Jamestown Street 20/Apt69', ['apt'] = 1 },
	[388] =  { ['x'] = 332.15,['y'] = -2070.86,['z'] = 20.95,['h'] = 321.11, ['info'] = ' Jamestown Street 20/Apt70', ['apt'] = 1 },
	[389] =  { ['x'] = 324.11,['y'] = -2063.77,['z'] = 20.72,['h'] = 327.76, ['info'] = ' Jamestown Street 20/Apt72', ['apt'] = 1 },
	[390] =  { ['x'] = 321.03,['y'] = -2061.05,['z'] = 20.74,['h'] = 319.9, ['info'] = ' Jamestown Street 20/Apt73', ['apt'] = 1 },
	[391] =  { ['x'] = 315.26,['y'] = -2056.94,['z'] = 20.72,['h'] = 321.74, ['info'] = ' Jamestown Street 20/Apt74', ['apt'] = 1 },
	[392] =  { ['x'] = 312.31,['y'] = -2054.58,['z'] = 20.72,['h'] = 320.28, ['info'] = ' Jamestown Street 20/Apt75', ['apt'] = 1 },
	[393] =  { ['x'] = 305.98,['y'] = -2044.77,['z'] = 20.9,['h'] = 229.17, ['info'] = ' Jamestown Street 20/Apt76', ['apt'] = 1 },
	[394] =  { ['x'] = 313.74,['y'] = -2040.53,['z'] = 20.94,['h'] = 140.85, ['info'] = ' Jamestown Street 20/Apt77', ['apt'] = 1 },
	[395] =  { ['x'] = 317.47,['y'] = -2043.3,['z'] = 20.94,['h'] = 139.1, ['info'] = ' Jamestown Street 20/Apt78', ['apt'] = 1 },
	[396] =  { ['x'] = 324.69,['y'] = -2049.25,['z'] = 20.94,['h'] = 139.12, ['info'] = ' Jamestown Street 20/Apt79', ['apt'] = 1 },
	[397] =  { ['x'] = 326.2,['y'] = -2050.54,['z'] = 20.94,['h'] = 139.05, ['info'] = ' Jamestown Street 20/Apt80', ['apt'] = 1 },
	[398] =  { ['x'] = 333.56,['y'] = -2056.94,['z'] = 20.94,['h'] = 136.48, ['info'] = ' Jamestown Street 20/Apt81', ['apt'] = 1 },
	[399] =  { ['x'] = 334.57,['y'] = -2058.3,['z'] = 20.94,['h'] = 143.73, ['info'] = ' Jamestown Street 20/Apt82', ['apt'] = 1 },
	[400] =  { ['x'] = 341.86,['y'] = -2064.11,['z'] = 20.95,['h'] = 143.43, ['info'] = ' Jamestown Street 20/Apt83', ['apt'] = 1 },
	[401] =  { ['x'] = 345.23,['y'] = -2067.37,['z'] = 20.94,['h'] = 139.82, ['info'] = ' Jamestown Street 20/Apt84', ['apt'] = 1 },
	[402] =  { ['x'] = 363.43,['y'] = -2046.13,['z'] = 22.2,['h'] = 318.31, ['info'] = ' Jamestown Street 20/Apt85', ['apt'] = 1 },
	[403] =  { ['x'] = 359.88,['y'] = -2043.38,['z'] = 22.2,['h'] = 320.76, ['info'] = ' Jamestown Street 20/Apt86', ['apt'] = 1 },
	[404] =  { ['x'] = 352.51,['y'] = -2037.24,['z'] = 22.09,['h'] = 318.37, ['info'] = ' Jamestown Street 20/Apt87', ['apt'] = 1 },
	[405] =  { ['x'] = 352.15,['y'] = -2034.96,['z'] = 22.36,['h'] = 318.55, ['info'] = ' Jamestown Street 20/Apt88', ['apt'] = 1 },
	[406] =  { ['x'] = 344.83,['y'] = -2028.81,['z'] = 22.36,['h'] = 319.14, ['info'] = ' Jamestown Street 20/Apt89', ['apt'] = 1 },
	[407] =  { ['x'] = 343.63,['y'] = -2027.94,['z'] = 22.36,['h'] = 320.6, ['info'] = ' Jamestown Street 20/Apt90', ['apt'] = 1 },
	[408] =  { ['x'] = 336.17,['y'] = -2021.61,['z'] = 22.36,['h'] = 318.01, ['info'] = ' Jamestown Street 20/Apt91', ['apt'] = 1 },
	[409] =  { ['x'] = 331.93,['y'] = -2019.28,['z'] = 22.35,['h'] = 332.68, ['info'] = ' Jamestown Street 20/Apt92', ['apt'] = 1 },
	[410] =  { ['x'] = 335.78,['y'] = -2010.93,['z'] = 22.32,['h'] = 219.48, ['info'] = ' Jamestown Street 20/Apt93', ['apt'] = 1 },
	[411] =  { ['x'] = 345.65,['y'] = -2014.72,['z'] = 22.4,['h'] = 156.47, ['info'] = ' Jamestown Street 20/Apt94', ['apt'] = 1 },
	[412] =  { ['x'] = 354.15,['y'] = -2021.71,['z'] = 22.31,['h'] = 161.59, ['info'] = ' Jamestown Street 20/Apt96', ['apt'] = 1 },
	[413] =  { ['x'] = 357.26,['y'] = -2024.55,['z'] = 22.3,['h'] = 138.06, ['info'] = ' Jamestown Street 20/Apt97', ['apt'] = 1 },
	[414] =  { ['x'] = 362.71,['y'] = -2028.26,['z'] = 22.25,['h'] = 146.16, ['info'] = ' Jamestown Street 20/Apt98', ['apt'] = 1 },
	[415] =  { ['x'] = 365.22,['y'] = -2031.53,['z'] = 22.4,['h'] = 229.42, ['info'] = ' Jamestown Street 20/Apt99', ['apt'] = 1 },
	[416] =  { ['x'] = 371.47,['y'] = -2040.7,['z'] = 22.2,['h'] = 48.81, ['info'] = ' Jamestown Street 20/Apt100', ['apt'] = 1 },
	[417] =  { ['x'] = -903.43,['y'] = -1005.12,['z'] = 2.16,['h'] = 210.68, ['info'] = ' Coopenmartha Court 1', ['apt'] = 2 },
	[418] =  { ['x'] = -902.68,['y'] = -997.07,['z'] = 2.16,['h'] = 28.56, ['info'] = ' Coopenmartha Court 2', ['apt'] = 2 },
	[419] =  { ['x'] = -900.17,['y'] = -981.97,['z'] = 2.17,['h'] = 122.33, ['info'] = ' Coopenmartha Court 3', ['apt'] = 2 },
	[420] =  { ['x'] = -913.66,['y'] = -989.39,['z'] = 2.16,['h'] = 206.18, ['info'] = ' Coopenmartha Court 4', ['apt'] = 2 },
	[421] =  { ['x'] = -908.07,['y'] = -976.76,['z'] = 2.16,['h'] = 32.27, ['info'] = ' Coopenmartha Court 5', ['apt'] = 2 },
	[422] =  { ['x'] = -922.48,['y'] = -983.07,['z'] = 2.16,['h'] = 117.2, ['info'] = ' Coopenmartha Court 6', ['apt'] = 2 },
	[423] =  { ['x'] = -927.84,['y'] = -973.27,['z'] = 2.16,['h'] = 215.49, ['info'] = ' Coopenmartha Court 6', ['apt'] = 2 },
	[424] =  { ['x'] = -927.7,['y'] = -949.4,['z'] = 2.75,['h'] = 129.72, ['info'] = ' Coopenmartha Court 8', ['apt'] = 2 },
	[425] =  { ['x'] = -934.92,['y'] = -938.93,['z'] = 2.15,['h'] = 119.33, ['info'] = ' Coopenmartha Court 9', ['apt'] = 2 },
	[426] =  { ['x'] = -947.13,['y'] = -927.75,['z'] = 2.15,['h'] = 118.67, ['info'] = ' Coopenmartha Court 10', ['apt'] = 2 },
	[427] =  { ['x'] = -947.68,['y'] = -910.11,['z'] = 2.35,['h'] = 122.31, ['info'] = ' Coopenmartha Court 11', ['apt'] = 2 },
	[428] =  { ['x'] = -950.41,['y'] = -905.28,['z'] = 2.35,['h'] = 118.74, ['info'] = ' Coopenmartha Court 12', ['apt'] = 2 },
	[429] =  { ['x'] = -986.43,['y'] = -866.38,['z'] = 2.2,['h'] = 208.66, ['info'] = ' Coopenmartha Court 13', ['apt'] = 2 },
	[430] =  { ['x'] = -996.44,['y'] = -875.87,['z'] = 2.16,['h'] = 196.75, ['info'] = ' Coopenmartha Court 14', ['apt'] = 2 },
	[431] =  { ['x'] = -1011.47,['y'] = -880.83,['z'] = 2.16,['h'] = 208.65, ['info'] = ' Coopenmartha Court 15', ['apt'] = 2 },
	[432] =  { ['x'] = -1005.53,['y'] = -897.67,['z'] = 2.55,['h'] = 296.35, ['info'] = ' Coopenmartha Court 16', ['apt'] = 2 },
	[433] =  { ['x'] = -975.57,['y'] = -909.16,['z'] = 2.16,['h'] = 222.04, ['info'] = ' Coopenmartha Court 17', ['apt'] = 2 },
	[434] =  { ['x'] = -1010.99,['y'] = -909.64,['z'] = 2.14,['h'] = 33.62, ['info'] = ' Coopenmartha Court 18', ['apt'] = 2 },
	[435] =  { ['x'] = -1022.89,['y'] = -896.58,['z'] = 5.42,['h'] = 207.75, ['info'] = ' Coopenmartha Court 19', ['apt'] = 2 },
	[436] =  { ['x'] = -1031.35,['y'] = -903.04,['z'] = 3.7,['h'] = 208.79, ['info'] = ' Coopenmartha Court 20', ['apt'] = 2 },
	[437] =  { ['x'] = -1027.9,['y'] = -919.72,['z'] = 5.05,['h'] = 22.53, ['info'] = ' Coopenmartha Court 21', ['apt'] = 2 },
	[438] =  { ['x'] = -1024.41,['y'] = -912.11,['z'] = 6.97,['h'] = 126.42, ['info'] = ' Coopenmartha Court 22', ['apt'] = 2 },
	[439] =  { ['x'] = -1043.03,['y'] = -924.86,['z'] = 3.16,['h'] = 28.04, ['info'] = ' Coopenmartha Court 23', ['apt'] = 2 },
	[440] =  { ['x'] = -1053.82,['y'] = -933.09,['z'] = 3.36,['h'] = 23.91, ['info'] = ' Coopenmartha Court 24', ['apt'] = 2 },
	[441] =  { ['x'] = -1090.89,['y'] = -926.24,['z'] = 3.14,['h'] = 204.58, ['info'] = ' Coopenmartha Court 25', ['apt'] = 2 },
	[442] =  { ['x'] = -1085.1,['y'] = -934.97,['z'] = 3.09,['h'] = 121.56, ['info'] = ' Coopenmartha Court 26', ['apt'] = 2 },
	[443] =  { ['x'] = -1075.69,['y'] = -939.49,['z'] = 2.36,['h'] = 303.99, ['info'] = ' Coopenmartha Court 27', ['apt'] = 2 },
	[444] =  { ['x'] = -1084.41,['y'] = -951.81,['z'] = 2.37,['h'] = 310.7, ['info'] = ' Coopenmartha Court 28', ['apt'] = 2 },
	[445] =  { ['x'] = -989.35,['y'] = -975.21,['z'] = 4.23,['h'] = 117.27, ['info'] = ' Imagination Court 1', ['apt'] = 2 },
	[446] =  { ['x'] = -994.98,['y'] = -966.47,['z'] = 2.55,['h'] = 116.74, ['info'] = ' Imagination Court 2', ['apt'] = 2 },
	[447] =  { ['x'] = -978.21,['y'] = -990.68,['z'] = 4.55,['h'] = 121.89, ['info'] = ' Imagination Court 3', ['apt'] = 2 },
	[448] =  { ['x'] = -1019.04,['y'] = -963.69,['z'] = 2.16,['h'] = 201.18, ['info'] = ' Imagination Court 4', ['apt'] = 2 },
	[449] =  { ['x'] = -1028.21,['y'] = -968.02,['z'] = 2.16,['h'] = 204.49, ['info'] = ' Imagination Court 5', ['apt'] = 2 },
	[450] =  { ['x'] = -1032.18,['y'] = -982.48,['z'] = 2.16,['h'] = 202.74, ['info'] = ' Imagination Court 6', ['apt'] = 2 },
	[451] =  { ['x'] = -1056.67,['y'] = -1001.26,['z'] = 2.16,['h'] = 277.45, ['info'] = ' Imagination Court 7', ['apt'] = 2 },
	[452] =  { ['x'] = -1054.81,['y'] = -1000.95,['z'] = 6.42,['h'] = 307.44, ['info'] = ' Imagination Court 8', ['apt'] = 2 },
	[453] =  { ['x'] = -1055.75,['y'] = -998.78,['z'] = 6.42,['h'] = 305.55, ['info'] = ' Imagination Court 9', ['apt'] = 2 },
	[454] =  { ['x'] = -1042.39,['y'] = -1024.61,['z'] = 2.16,['h'] = 211.23, ['info'] = ' Imagination Court 10', ['apt'] = 2 },
	[455] =  { ['x'] = -1022.48,['y'] = -1022.42,['z'] = 2.16,['h'] = 205.65, ['info'] = ' Imagination Court 11', ['apt'] = 2 },
	[456] =  { ['x'] = -1008.47,['y'] = -1015.29,['z'] = 2.16,['h'] = 208.97, ['info'] = ' Imagination Court 12', ['apt'] = 2 },
	[457] =  { ['x'] = -997.35,['y'] = -1012.6,['z'] = 2.16,['h'] = 302.07, ['info'] = ' Imagination Court 13', ['apt'] = 2 },
	[458] =  { ['x'] = -967.46,['y'] = -1008.5,['z'] = 2.16,['h'] = 218.76, ['info'] = ' Imagination Court 14', ['apt'] = 2 },
	[459] =  { ['x'] = -942.71,['y'] = -1076.35,['z'] = 2.54,['h'] = 29.74, ['info'] = ' Invention Court 1', ['apt'] = 2 },
	[460] =  { ['x'] = -951.94,['y'] = -1078.52,['z'] = 2.16,['h'] = 29.92, ['info'] = ' Invention Court 2', ['apt'] = 2 },
	[461] =  { ['x'] = -982.64,['y'] = -1066.94,['z'] = 2.55,['h'] = 207.21, ['info'] = ' Invention Court 3', ['apt'] = 2 },
	[462] =  { ['x'] = -977.79,['y'] = -1091.85,['z'] = 4.23,['h'] = 132.57, ['info'] = ' Invention Court 4', ['apt'] = 2 },
	[463] =  { ['x'] = -982.64,['y'] = -1083.86,['z'] = 2.55,['h'] = 121.26, ['info'] = ' Invention Court 5', ['apt'] = 2 },
	[464] =  { ['x'] = -991.11,['y'] = -1103.85,['z'] = 2.16,['h'] = 38.51, ['info'] = ' Invention Court 6', ['apt'] = 2 },
	[465] =  { ['x'] = -986.66,['y'] = -1122.15,['z'] = 4.55,['h'] = 301.76, ['info'] = ' Invention Court 7', ['apt'] = 2 },
	[466] =  { ['x'] = -976.25,['y'] = -1140.3,['z'] = 2.18,['h'] = 296.42, ['info'] = ' Invention Court 8', ['apt'] = 2 },
	[467] =  { ['x'] = -978.06,['y'] = -1108.25,['z'] = 2.16,['h'] = 199.34, ['info'] = ' Invention Court 9', ['apt'] = 2 },
	[468] =  { ['x'] = -960.05,['y'] = -1109.07,['z'] = 2.16,['h'] = 202.32, ['info'] = ' Invention Court 11', ['apt'] = 2 },
	[469] =  { ['x'] = -963.15,['y'] = -1110.02,['z'] = 2.18,['h'] = 117.39, ['info'] = ' Invention Court 10', ['apt'] = 2 },
	[470] =  { ['x'] = -948.72,['y'] = -1107.7,['z'] = 2.18,['h'] = 299.33, ['info'] = ' Invention Court 12', ['apt'] = 2 },
	[471] =  { ['x'] = -939.32,['y'] = -1088.27,['z'] = 2.16,['h'] = 273.12, ['info'] = ' Invention Court 13', ['apt'] = 2 },
	[472] =  { ['x'] = -931.12,['y'] = -1100.18,['z'] = 2.18,['h'] = 215.78, ['info'] = ' Invention Court 14', ['apt'] = 2 },
	[473] =  { ['x'] = -921.36,['y'] = -1095.44,['z'] = 2.16,['h'] = 118.76, ['info'] = ' Invention Court 15', ['apt'] = 2 },
	[474] =  { ['x'] = -1176.2,['y'] = -1072.88,['z'] = 5.91,['h'] = 115.96, ['info'] = ' Imagination Court 15', ['apt'] = 2 },
	[475] =  { ['x'] = -1180.93,['y'] = -1056.36,['z'] = 2.16,['h'] = 209.3, ['info'] = ' Imagination Court 16', ['apt'] = 2 },
	[476] =  { ['x'] = -1183.71,['y'] = -1044.88,['z'] = 2.16,['h'] = 125.29, ['info'] = ' Imagination Court 17', ['apt'] = 2 },
	[477] =  { ['x'] = -1188.65,['y'] = -1041.64,['z'] = 2.3,['h'] = 27.41, ['info'] = ' Imagination Court 18', ['apt'] = 2 },
	[478] =  { ['x'] = -1198.67,['y'] = -1023.73,['z'] = 2.16,['h'] = 202.18, ['info'] = ' Imagination Court 19', ['apt'] = 2 },
	[479] =  { ['x'] = -1203.28,['y'] = -1021.27,['z'] = 5.96,['h'] = 121.76, ['info'] = ' Imagination Court 20', ['apt'] = 2 },
	[480] =  { ['x'] = -1098.74,['y'] = -1679.17,['z'] = 4.37,['h'] = 300.45, ['info'] = ' Beachside Avenue 1', ['apt'] = 2 },
	[481] =  { ['x'] = -1097.58,['y'] = -1673.07,['z'] = 8.4,['h'] = 303.36, ['info'] = ' Beachside Avenue 2', ['apt'] = 2 },
	[482] =  { ['x'] = -1349.59,['y'] = -1187.7,['z'] = 4.57,['h'] = 271.19, ['info'] = ' Beachside Avenue 3', ['apt'] = 2 },
	[483] =  { ['x'] = -1347.14,['y'] = -1167.87,['z'] = 4.58,['h'] = 326.75, ['info'] = ' Beachside Avenue 4', ['apt'] = 2 },
	[484] =  { ['x'] = -1350.2,['y'] = -1161.41,['z'] = 4.51,['h'] = 268.7, ['info'] = ' Beachside Avenue 5', ['apt'] = 2 },
	[485] =  { ['x'] = -1347.23,['y'] = -1145.91,['z'] = 4.34,['h'] = 236.95, ['info'] = ' Beachside Avenue 6', ['apt'] = 2 },
	[486] =  { ['x'] = -1336.27,['y'] = -1145.51,['z'] = 6.74,['h'] = 177.62, ['info'] = ' Beachside Avenue 7', ['apt'] = 2 },
	[487] =  { ['x'] = -1374.53,['y'] = -1074.28,['z'] = 4.32,['h'] = 300.62, ['info'] = ' Beachside Avenue 8', ['apt'] = 2 },
	[488] =  { ['x'] = -1376.91,['y'] = -1070.31,['z'] = 4.35,['h'] = 300.36, ['info'] = ' Beachside Avenue 9', ['apt'] = 2 },
	[489] =  { ['x'] = -1379.84,['y'] = -1066.37,['z'] = 4.35,['h'] = 300.43, ['info'] = ' Beachside Avenue 10', ['apt'] = 2 },
	[490] =  { ['x'] = -1381.87,['y'] = -1062.06,['z'] = 4.35,['h'] = 299.36, ['info'] = ' Beachside Avenue 11', ['apt'] = 2 },
	[491] =  { ['x'] = -1384.78,['y'] = -1058.38,['z'] = 4.36,['h'] = 301.37, ['info'] = ' Beachside Avenue 12', ['apt'] = 2 },
	[492] =  { ['x'] = -1386.93,['y'] = -1054.22,['z'] = 4.34,['h'] = 303.25, ['info'] = ' Beachside Avenue 13', ['apt'] = 2 },
	[493] =  { ['x'] = -1370.18,['y'] = -1042.84,['z'] = 4.26,['h'] = 212.96, ['info'] = ' Beachside Avenue 14', ['apt'] = 2 },
	[494] =  { ['x'] = -1366.28,['y'] = -1039.9,['z'] = 4.26,['h'] = 207.39, ['info'] = ' Beachside Avenue 15', ['apt'] = 2 },
	[495] =  { ['x'] = -1362.4,['y'] = -1037.3,['z'] = 4.25,['h'] = 208.56, ['info'] = ' Beachside Avenue 16', ['apt'] = 2 },
	[496] =  { ['x'] = -1358.3,['y'] = -1035.08,['z'] = 4.24,['h'] = 206.68, ['info'] = ' Beachside Avenue 17', ['apt'] = 2 },
	[497] =  { ['x'] = -1754.06,['y'] = -725.21,['z'] = 10.29,['h'] = 315.01, ['info'] = ' Beachside Avenue 18', ['apt'] = 2 },
	[498] =  { ['x'] = -1754.74,['y'] = -708.34,['z'] = 10.4,['h'] = 228.16, ['info'] = ' Beachside Avenue 19', ['apt'] = 2 },
	[499] =  { ['x'] = -1764.34,['y'] = -708.4,['z'] = 10.62,['h'] = 330.2, ['info'] = ' Beachside Avenue 20', ['apt'] = 2 },
	[500] =  { ['x'] = -1777.02,['y'] = -701.53,['z'] = 10.53,['h'] = 321.14, ['info'] = ' Beachside Avenue 21', ['apt'] = 2 },
	[501] =  { ['x'] = -1770.67,['y'] = -677.27,['z'] = 10.38,['h'] = 132.13, ['info'] = ' Beachside Avenue 22', ['apt'] = 2 },
	[502] =  { ['x'] = -1765.69,['y'] = -681.05,['z'] = 10.29,['h'] = 141.89, ['info'] = ' Beachside Avenue 23', ['apt'] = 2 },
	[503] =  { ['x'] = -1791.69,['y'] = -683.89,['z'] = 10.65,['h'] = 322.32, ['info'] = ' Beachside Avenue 24', ['apt'] = 2 },
	[504] =  { ['x'] = -1793.69,['y'] = -663.88,['z'] = 10.6,['h'] = 313.3, ['info'] = ' Beachside Avenue 25', ['apt'] = 2 },
	[505] =  { ['x'] = -1803.64,['y'] = -662.45,['z'] = 10.73,['h'] = 10.28, ['info'] = ' Beachside Avenue 26', ['apt'] = 2 },
	[506] =  { ['x'] = -1813.82,['y'] = -657.05,['z'] = 10.89,['h'] = 57.95, ['info'] = ' Beachside Avenue 27', ['apt'] = 2 },
	[507] =  { ['x'] = -1819.73,['y'] = -650.15,['z'] = 10.98,['h'] = 36.31, ['info'] = ' Beachside Avenue 28', ['apt'] = 2 },
	[508] =  { ['x'] = -1834.74,['y'] = -642.54,['z'] = 11.48,['h'] = 288.8, ['info'] = ' Beachside Avenue 29', ['apt'] = 2 },
	[509] =  { ['x'] = -1836.49,['y'] = -631.61,['z'] = 10.76,['h'] = 260.79, ['info'] = ' Beachside Avenue 30', ['apt'] = 2 },
	[510] =  { ['x'] = -1838.56,['y'] = -629.2,['z'] = 11.25,['h'] = 76.98, ['info'] = ' Beachside Avenue 31', ['apt'] = 2 },
	[511] =  { ['x'] = -1872.51,['y'] = -604.06,['z'] = 11.89,['h'] = 50.69, ['info'] = ' Beachside Avenue 32', ['apt'] = 2 },
	[512] =  { ['x'] = -1874.66,['y'] = -593.01,['z'] = 11.89,['h'] = 50.96, ['info'] = ' Beachside Avenue 33', ['apt'] = 2 },
	[513] =  { ['x'] = -1883.28,['y'] = -578.94,['z'] = 11.82,['h'] = 138.0, ['info'] = ' Beachside Avenue 34', ['apt'] = 2 },
	[514] =  { ['x'] = -1901.72,['y'] = -586.55,['z'] = 11.88,['h'] = 300.26, ['info'] = ' Beachside Avenue 35', ['apt'] = 2 },
	[515] =  { ['x'] = -1913.45,['y'] = -574.22,['z'] = 11.44,['h'] = 317.93, ['info'] = ' Beachside Avenue 36', ['apt'] = 2 },
	[516] =  { ['x'] = -1917.79,['y'] = -558.82,['z'] = 11.85,['h'] = 274.38, ['info'] = ' Beachside Avenue 37', ['apt'] = 2 },
	[517] =  { ['x'] = -1924.05,['y'] = -559.33,['z'] = 12.07,['h'] = 45.74, ['info'] = ' Beachside Avenue 38', ['apt'] = 2 },
	[518] =  { ['x'] = -1918.64,['y'] = -542.55,['z'] = 11.83,['h'] = 145.81, ['info'] = ' Beachside Avenue 39', ['apt'] = 2 },
	[519] =  { ['x'] = -1947.03,['y'] = -544.07,['z'] = 11.87,['h'] = 54.28, ['info'] = ' Beachside Avenue 40', ['apt'] = 2 },
	[520] =  { ['x'] = -1947.95,['y'] = -531.65,['z'] = 11.83,['h'] = 44.17, ['info'] = ' Beachside Avenue 41', ['apt'] = 2 },
	[521] =  { ['x'] = -1968.27,['y'] = -532.39,['z'] = 12.18,['h'] = 317.83, ['info'] = ' Beachside Avenue 42', ['apt'] = 2 },
	[522] =  { ['x'] = -1968.36,['y'] = -523.33,['z'] = 11.85,['h'] = 52.01, ['info'] = ' Beachside Avenue 43', ['apt'] = 2 },
	[523] =  { ['x'] = -1980.0,['y'] = -520.54,['z'] = 11.9,['h'] = 316.92, ['info'] = ' Beachside Avenue 44', ['apt'] = 2 },
	[524] =  { ['x'] = -1070.57,['y'] = -1653.81,['z'] = 4.41,['h'] = 306.97, ['info'] = ' Beachside Court 1', ['apt'] = 2 },
	[525] =  { ['x'] = -1076.09,['y'] = -1645.79,['z'] = 4.51,['h'] = 313.53, ['info'] = ' Beachside Court 2', ['apt'] = 2 },
	[526] =  { ['x'] = -1082.93,['y'] = -1631.47,['z'] = 4.74,['h'] = 303.72, ['info'] = ' Beachside Court 3', ['apt'] = 2 },
	[527] =  { ['x'] = -1088.77,['y'] = -1623.08,['z'] = 4.74,['h'] = 299.0, ['info'] = ' Beachside Court 4', ['apt'] = 2 },
	[528] =  { ['x'] = -1092.39,['y'] = -1607.42,['z'] = 8.47,['h'] = 124.17, ['info'] = ' Beachside Court 5', ['apt'] = 2 },
	[529] =  { ['x'] = -1106.29,['y'] = -1596.34,['z'] = 4.6,['h'] = 228.18, ['info'] = ' Beachside Court 6', ['apt'] = 2 },
	[530] =  { ['x'] = -1038.86,['y'] = -1609.53,['z'] = 5.0,['h'] = 152.83, ['info'] = ' Beachside Court 7', ['apt'] = 2 },
	[531] =  { ['x'] = -1029.29,['y'] = -1603.62,['z'] = 4.97,['h'] = 129.41, ['info'] = ' Beachside Court 8', ['apt'] = 2 },
	[532] =  { ['x'] = -1032.69,['y'] = -1582.77,['z'] = 5.14,['h'] = 24.53, ['info'] = ' Beachside Court 9', ['apt'] = 2 },
	[533] =  { ['x'] = -1043.47,['y'] = -1580.43,['z'] = 5.04,['h'] = 235.83, ['info'] = ' Beachside Court 10', ['apt'] = 2 },
	[534] =  { ['x'] = -1041.27,['y'] = -1591.25,['z'] = 4.99,['h'] = 31.37, ['info'] = ' Beachside Court 11', ['apt'] = 2 },
	[535] =  { ['x'] = -1057.06,['y'] = -1587.44,['z'] = 4.61,['h'] = 40.1, ['info'] = ' Beachside Court 12', ['apt'] = 2 },
	[536] =  { ['x'] = -1058.16,['y'] = -1540.21,['z'] = 5.05,['h'] = 217.14, ['info'] = ' Beachside Court 16', ['apt'] = 2 },

	[537] =  { ['x'] = 35.27,['y'] = 6662.8,['z'] = 32.2,['h'] = 160.32, ['info'] = ' Procopio Drive 1', ['apt'] = 2 },
	[538] =  { ['x'] = -9.75,['y'] = 6654.15,['z'] = 31.7,['h'] = 201.74, ['info'] = ' Procopio Drive 2', ['apt'] = 2 },
	[539] =  { ['x'] = -41.3,['y'] = 6636.99,['z'] = 31.09,['h'] = 209.76, ['info'] = ' Procopio Drive 3', ['apt'] = 2 },
	[540] =  { ['x'] = -130.1,['y'] = 6551.49,['z'] = 29.53,['h'] = 220.17, ['info'] = ' Procopio Drive 4', ['apt'] = 2 },
	[541] =  { ['x'] = -229.77,['y'] = 6445.18,['z'] = 31.2,['h'] = 139.3, ['info'] = ' Procopio Drive 5', ['apt'] = 2 },
	[542] =  { ['x'] = -238.37,['y'] = 6423.4,['z'] = 31.46,['h'] = 215.07, ['info'] = ' Procopio Drive 6', ['apt'] = 2 },
	[543] =  { ['x'] = -272.14,['y'] = 6400.61,['z'] = 31.51,['h'] = 207.46, ['info'] = ' Procopio Drive 7', ['apt'] = 2 },
	[544] =  { ['x'] = -359.51,['y'] = 6334.64,['z'] = 29.85,['h'] = 218.99, ['info'] = ' Procopio Drive 8', ['apt'] = 2 },
	[545] =  { ['x'] = -407.22,['y'] = 6314.12,['z'] = 28.95,['h'] = 215.74, ['info'] = ' Procopio Drive 9', ['apt'] = 2 },
	[546] =  { ['x'] = -438.0412,['y'] = 6272.133,['z'] = 30.17161,['h'] = 178.88, ['info'] = 'Procopio Drive 10', ['apt'] = 2 },
	[547] =  { ['x'] = -467.97,['y'] = 6206.18,['z'] = 29.56,['h'] = 358.01, ['info'] = ' Procopio Drive 11', ['apt'] = 2 },
	[548] =  { ['x'] = -379.73,['y'] = 6253.05,['z'] = 31.86,['h'] = 310.69, ['info'] = ' Procopio Drive 12', ['apt'] = 1 },
	[549] =  { ['x'] = -370.91,['y'] = 6267.2,['z'] = 31.88,['h'] = 35.56, ['info'] = ' Procopio Drive 13', ['apt'] = 2 },
	[550] =  { ['x'] = -302.07,['y'] = 6327.4,['z'] = 32.89,['h'] = 36.31, ['info'] = ' Procopio Drive 14', ['apt'] = 2 },
	[551] =  { ['x'] = -280.62,['y'] = 6350.84,['z'] = 32.61,['h'] = 42.88, ['info'] = ' Procopio Drive 15', ['apt'] = 2 },
	[552] =  { ['x'] = -247.88,['y'] = 6369.98,['z'] = 31.85,['h'] = 45.41, ['info'] = ' Procopio Drive 16', ['apt'] = 2 },
	[553] =  { ['x'] = -227.7,['y'] = 6377.93,['z'] = 31.76,['h'] = 44.42, ['info'] = ' Procopio Drive 17', ['apt'] = 2 },
	[554] =  { ['x'] = -213.86,['y'] = 6396.5,['z'] = 33.09,['h'] = 42.81, ['info'] = ' Procopio Drive 18', ['apt'] = 2 },
	[555] =  { ['x'] = -189.07,['y'] = 6409.72,['z'] = 32.3,['h'] = 41.25, ['info'] = ' Procopio Drive 19', ['apt'] = 2 },

	[556] =  { ['x'] = 1535.30,['y'] = 2231.90,['z'] = 77.7,['h'] = 133.7, ['info'] = ' Grand Senora Path 1', ['apt'] = 2 },

	[557] =  { ['x'] = 248.3,['y'] = -1489.9,['z'] = 29.3,['h'] = 224.51, ['info'] = ' Strawberry Shop 1' , ['apt'] = 4 },
	[558] =  { ['x'] = 243.9,['y'] = -1492.9,['z'] = 29.3,['h'] = 45.95, ['info'] = ' Strawberry Shop 2' , ['apt'] = 4 },
	[559] =  { ['x'] = 224.62,['y'] = -1510.77,['z'] = 29.3,['h'] = 235.2, ['info'] = ' Strawberry Shop 3' , ['apt'] = 4 },
	[560] =  { ['x'] = 216.01,['y'] = -1523.44,['z'] = 29.3,['h'] = 142.05, ['info'] = 'Strawberry Shop 4' , ['apt'] = 4 },
	[561] =  { ['x'] = 218.7,['y'] = -1530.97,['z'] = 29.3,['h'] = 9.86, ['info'] = ' Strawberry Shop 5' , ['apt'] = 4 },
	[562] =  { ['x'] = 225.64,['y'] = -1539.46,['z'] = 29.32,['h'] = 311.3, ['info'] = ' Strawberry Shop 6' , ['apt'] = 4 },
	[563] =  { ['x'] = 168.19,['y'] = -1506.32,['z'] = 29.26,['h'] = 317.63, ['info'] = ' Strawberry Shop 7' , ['apt'] = 4 },
	[564] =  { ['x'] = 84.11,['y'] = -1551.83,['z'] = 29.6,['h'] = 218.89, ['info'] = ' Strawberry Shop 8' , ['apt'] = 4 },
	[565] =  { ['x'] = 68.14,['y'] = -1569.61,['z'] = 29.6,['h'] = 233.82, ['info'] = ' Strawberry Shop 9' , ['apt'] = 4 },
	[566] =  { ['x'] = 60.41,['y'] = -1579.4,['z'] = 29.6,['h'] = 214.56, ['info'] = ' Strawberry Shop 10' , ['apt'] = 4 },
	[567] =  { ['x'] = 47.73,['y'] = -1593.67,['z'] = 29.6,['h'] = 230.48, ['info'] = ' Strawberry Shop 11' , ['apt'] = 4 },
	[568] =  { ['x'] = 86.88,['y'] = -1670.51,['z'] = 29.17,['h'] = 262.58, ['info'] = ' Strawberry Shop 12' , ['apt'] = 4 },
	[569] =  { ['x'] = 95.75,['y'] = -1682.63,['z'] = 29.26,['h'] = 306.06, ['info'] = ' Strawberry Shop 13' , ['apt'] = 4 },
	[570] =  { ['x'] = 105.27,['y'] = -1689.97,['z'] = 29.3,['h'] = 323.28, ['info'] = ' Strawberry Shop 14' , ['apt'] = 4 },
	[571] =  { ['x'] = 100.21,['y'] = -1661.96,['z'] = 29.3,['h'] = 217.67, ['info'] = ' Strawberry Shop 15' , ['apt'] = 4 },
	[572] =  { ['x'] = 107.2,['y'] = -1657.47,['z'] = 29.3,['h'] = 220.76, ['info'] = ' Strawberry Shop 16' , ['apt'] = 4 },
	[573] =  { ['x'] = 106.22,['y'] = -1658.4,['z'] = 29.3,['h'] = 269.44, ['info'] = ' Strawberry Shop 17' , ['apt'] = 4 },
	[574] =  { ['x'] = 118.34,['y'] = -1649.77,['z'] = 29.3,['h'] = 226.06, ['info'] = ' Strawberry Shop 18' , ['apt'] = 4 },
	[575] =  { ['x'] = 121.92,['y'] = -1647.5,['z'] = 29.3,['h'] = 215.09, ['info'] = ' Strawberry Shop 19' , ['apt'] = 4 },
	[576] =  { ['x'] = 129.64,['y'] = -1642.64,['z'] = 29.3,['h'] = 116.08, ['info'] = ' Strawberry Shop 20' , ['apt'] = 4 },
	[577] =  { ['x'] = 138.0,['y'] = -1639.45,['z'] = 29.31,['h'] = 219.64, ['info'] = ' Strawberry Shop 21' , ['apt'] = 4 },
	[578] =  { ['x'] = 53.3,['y'] = -1478.84,['z'] = 29.29,['h'] = 7.7, ['info'] = ' Strawberry Shop 22' , ['apt'] = 4 },
	[579] =  { ['x'] = 65.74,['y'] = -1467.38,['z'] = 29.3,['h'] = 203.15, ['info'] = ' Strawberry Shop 23' , ['apt'] = 4 },
	[580] =  { ['x'] = 76.03,['y'] = -1455.81,['z'] = 29.3,['h'] = 38.31, ['info'] = ' Strawberry Shop 24' , ['apt'] = 4 },
	[581] =  { ['x'] = 99.55,['y'] = -1419.21,['z'] = 29.43,['h'] = 63.13, ['info'] = ' Strawberry Shop 25' , ['apt'] = 4 },
	[582] =  { ['x'] = 89.92,['y'] = -1411.31,['z'] = 29.43,['h'] = 125.59, ['info'] = ' Strawberry Shop 26' , ['apt'] = 4 },
	[583] =  { ['x'] = 84.87,['y'] = -1404.89,['z'] = 29.42,['h'] = 68.34, ['info'] = ' Strawberry Shop 27' , ['apt'] = 4 },
	[584] =  { ['x'] = 122.82,['y'] = -1347.74,['z'] = 29.3,['h'] = 306.79, ['info'] = ' Strawberry Shop 28' , ['apt'] = 4 },
	[585] =  { ['x'] = 170.37,['y'] = -1336.82,['z'] = 29.3,['h'] = 357.49, ['info'] = ' Strawberry Shop 29' , ['apt'] = 4 },
	[586] =  { ['x'] = 186.94,['y'] = -1310.53,['z'] = 29.33,['h'] = 45.29, ['info'] = ' Strawberry Shop 30' , ['apt'] = 4 },
	[587] =  { ['x'] = 195.63,['y'] = -1291.18,['z'] = 29.33,['h'] = 167.31, ['info'] = ' Strawberry Shop 31' , ['apt'] = 4 },
	[588] =  { ['x'] = 198.27,['y'] = -1276.41,['z'] = 29.33,['h'] = 26.43, ['info'] = ' Strawberry Shop 32' , ['apt'] = 4 },
	[589] =  { ['x'] = 199.61,['y'] = -1269.29,['z'] = 29.18,['h'] = 55.9, ['info'] = ' Strawberry Shop 33' , ['apt'] = 4 },
	[590] =  { ['x'] = 98.58,['y'] = -1308.83,['z'] = 29.28,['h'] = 122.82, ['info'] = ' Strawberry Shop 34' , ['apt'] = 4 },
	[591] =  { ['x'] = 87.92,['y'] = -1294.48,['z'] = 29.21,['h'] = 122.01, ['info'] = ' Strawberry Shop 35' , ['apt'] = 4 },
	[592] =  { ['x'] = 51.76,['y'] = -1317.47,['z'] = 29.29,['h'] = 124.75, ['info'] = ' Strawberry Shop 36' , ['apt'] = 4 },
	[593] =  { ['x'] = -39.17,['y'] = -1387.48,['z'] = 30.3,['h'] = 183.53, ['info'] = ' Strawberry Shop 37' , ['apt'] = 4 },
	[594] =  { ['x'] = -47.99,['y'] = -1385.35,['z'] = 29.5,['h'] = 355.74, ['info'] = ' Strawberry Shop 38' , ['apt'] = 4 },
	[595] =  { ['x'] = -82.25,['y'] = -1385.8,['z'] = 29.5,['h'] = 184.22, ['info'] = ' Strawberry Shop 39' , ['apt'] = 4 },
	[596] =  { ['x'] = -128.09,['y'] = -1394.33,['z'] = 29.55,['h'] = 182.09, ['info'] = ' Strawberry Shop 40' , ['apt'] = 4 },
	[597] =  { ['x'] = -160.18,['y'] = -1432.03,['z'] = 31.28,['h'] = 186.3, ['info'] = ' Strawberry Shop 41' , ['apt'] = 4 },
	[598] =  { ['x'] = -163.55,['y'] = -1439.71,['z'] = 31.43,['h'] = 142.48, ['info'] = ' Strawberry Shop 42' , ['apt'] = 4 },
	[599] =  { ['x'] = -171.21,['y'] = -1449.62,['z'] = 31.64,['h'] = 326.49, ['info'] = ' Strawberry Shop 43' , ['apt'] = 4 },

	[600] =  { ['x'] = -1489.69,['y'] = -671.15,['z'] = 33.39,['h'] = 134.21, ['info'] = ' Bay City Ave / App 69' , ['apt'] = 1 },
	[601] =  { ['x'] = -1493.46,['y'] = -668.06,['z'] = 33.39,['h'] = 141.4, ['info'] = ' Bay City Ave / App 37' , ['apt'] = 1 },
	[602] =  { ['x'] = -1497.83,['y'] = -664.47,['z'] = 29.03,['h'] = 137.35, ['info'] = ' Bay City Ave / App 2' , ['apt'] = 1 },
	[603] =  { ['x'] = -1495.04,['y'] = -661.92,['z'] = 29.03,['h'] = 30.17, ['info'] = ' Bay City Ave / App 3' , ['apt'] = 1 },
	[604] =  { ['x'] = -1490.48,['y'] = -658.73,['z'] = 29.03,['h'] = 29.52, ['info'] = ' Bay City Ave / App 4' , ['apt'] = 1 },
	[605] =  { ['x'] = -1486.45,['y'] = -655.88,['z'] = 29.59,['h'] = 37.15, ['info'] = ' Bay City Ave / App 5' , ['apt'] = 1 },
	[606] =  { ['x'] = -1481.97,['y'] = -652.46,['z'] = 29.59,['h'] = 31.19, ['info'] = ' Bay City Ave / App 6' , ['apt'] = 1 },
	[607] =  { ['x'] = -1477.95,['y'] = -649.54,['z'] = 29.59,['h'] = 32.3, ['info'] = ' Bay City Ave / App 7' , ['apt'] = 1 },
	[608] =  { ['x'] = -1473.36,['y'] = -646.2,['z'] = 29.59,['h'] = 26.38, ['info'] = ' Bay City Ave / App 8' , ['apt'] = 1 },
	[609] =  { ['x'] = -1469.31,['y'] = -643.41,['z'] = 29.59,['h'] = 29.38, ['info'] = ' Bay City Ave / App 8' , ['apt'] = 1 },
	[610] =  { ['x'] = -1464.75,['y'] = -640.1,['z'] = 29.59,['h'] = 33.84, ['info'] = ' Bay City Ave / App 10' , ['apt'] = 1 },
	[611] =  { ['x'] = -1461.78,['y'] = -641.4,['z'] = 29.59,['h'] = 303.51, ['info'] = ' Bay City Ave / App 11' , ['apt'] = 1 },
	[612] =  { ['x'] = -1452.58,['y'] = -653.29,['z'] = 29.59,['h'] = 300.87, ['info'] = ' Bay City Ave / App 12' , ['apt'] = 1 },
	[613] =  { ['x'] = -1454.68,['y'] = -655.64,['z'] = 29.59,['h'] = 213.03, ['info'] = ' Bay City Ave / App 13' , ['apt'] = 1 },
	[614] =  { ['x'] = -1459.3,['y'] = -658.86,['z'] = 29.59,['h'] = 228.02, ['info'] = ' Bay City Ave / App 14' , ['apt'] = 1 },
	[615] =  { ['x'] = -1463.37,['y'] = -661.72,['z'] = 29.59,['h'] = 214.95, ['info'] = ' Bay City Ave / App 15' , ['apt'] = 1 },
	[616] =  { ['x'] = -1468.05,['y'] = -664.9,['z'] = 29.59,['h'] = 214.39, ['info'] = ' Bay City Ave / App 16' , ['apt'] = 1 },
	[617] =  { ['x'] = -1471.96,['y'] = -667.82,['z'] = 29.59,['h'] = 213.94, ['info'] = ' Bay City Ave / App 17' , ['apt'] = 1 },
	[618] =  { ['x'] = -1461.53,['y'] = -641.04,['z'] = 33.39,['h'] = 304.53, ['info'] = ' Bay City Ave / App 18' , ['apt'] = 1 },
	[619] =  { ['x'] = -1458.35,['y'] = -645.91,['z'] = 33.39,['h'] = 308.11, ['info'] = ' Bay City Ave / App 19' , ['apt'] = 1 },
	[620] =  { ['x'] = -1456.04,['y'] = -648.95,['z'] = 33.39,['h'] = 306.76, ['info'] = ' Bay City Ave / App 20' , ['apt'] = 1 },
	[621] =  { ['x'] = -1452.73,['y'] = -653.47,['z'] = 33.39,['h'] = 301.36, ['info'] = ' Bay City Ave / App 21' , ['apt'] = 1 },
	[622] =  { ['x'] = -1454.63,['y'] = -655.6,['z'] = 33.39,['h'] = 215.46, ['info'] = ' Bay City Ave / App 22' , ['apt'] = 1 },
	[623] =  { ['x'] = -1459.41,['y'] = -658.81,['z'] = 33.39,['h'] = 213.78, ['info'] = ' Bay City Ave / App 23' , ['apt'] = 1 },
	[624] =  { ['x'] = -1463.32,['y'] = -661.53,['z'] = 33.39,['h'] = 210.0, ['info'] = ' Bay City Ave / App 24' , ['apt'] = 1 },
	[625] =  { ['x'] = -1467.84,['y'] = -665.24,['z'] = 33.39,['h'] = 189.07, ['info'] = ' Bay City Ave / App 25' , ['apt'] = 1 },
	[626] =  { ['x'] = -1471.78,['y'] = -668.02,['z'] = 33.39,['h'] = 214.32, ['info'] = ' Bay City Ave / App 26' , ['apt'] = 1 },
	[627] =  { ['x'] = -1476.37,['y'] = -671.31,['z'] = 33.39,['h'] = 216.08, ['info'] = ' Bay City Ave / App 27' , ['apt'] = 1 },
	[628] =  { ['x'] = -1464.99,['y'] = -639.7,['z'] = 33.39,['h'] = 35.06, ['info'] = ' Bay City Ave / App 28' , ['apt'] = 1 },
	[629] =  { ['x'] = -1469.15,['y'] = -643.43,['z'] = 33.39,['h'] = 35.14, ['info'] = ' Bay City Ave / App 29' , ['apt'] = 1 },
	[630] =  { ['x'] = -1473.23,['y'] = -646.27,['z'] = 33.39,['h'] = 32.85, ['info'] = ' Bay City Ave / App 30' , ['apt'] = 1 },
	[631] =  { ['x'] = -1477.85,['y'] = -649.78,['z'] = 33.39,['h'] = 32.61, ['info'] = ' Bay City Ave / App 31' , ['apt'] = 1 },
	[632] =  { ['x'] = -1481.81,['y'] = -652.67,['z'] = 33.39,['h'] = 33.91, ['info'] = ' Bay City Ave / App 32' , ['apt'] = 1 },
	[633] =  { ['x'] = -1486.47,['y'] = -655.77,['z'] = 33.39,['h'] = 36.38, ['info'] = ' Bay City Ave / App 33' , ['apt'] = 1 },
	[634] =  { ['x'] = -1490.7,['y'] = -658.4,['z'] = 33.39,['h'] = 33.02, ['info'] = ' Bay City Ave / App 34' , ['apt'] = 1 },
	[635] =  { ['x'] = -1495.22,['y'] = -661.82,['z'] = 33.39,['h'] = 38.31, ['info'] = ' Bay City Ave / App 35' , ['apt'] = 1 },
	[636] =  { ['x'] = -1498.02,['y'] = -664.59,['z'] = 33.39,['h'] = 128.87, ['info'] = ' Bay City Ave / App 36' , ['apt'] = 1 },

	[637] =  { ['x'] = -668.34,['y'] = -971.1,['z'] = 22.35,['h'] = 3.05, ['info'] = ' Lindsay Circus Apartment 1' , ['apt'] = 2 },
	[638] =  { ['x'] = -672.99,['y'] = -981.21,['z'] = 22.35,['h'] = 0.87, ['info'] = ' Lindsay Circus Apartment 2' , ['apt'] = 2 },
	[639] =  { ['x'] = -673.83,['y'] = -999.55,['z'] = 18.24,['h'] = 107.35, ['info'] = ' Lindsay Circus Apartment 3' , ['apt'] = 2 },
	[640] =  { ['x'] = -699.55,['y'] = -1032.33,['z'] = 16.22,['h'] = 293.78, ['info'] = ' Lindsay Circus Apartment 4' , ['apt'] = 2 },
	[641] =  { ['x'] = -702.95,['y'] = -1023.57,['z'] = 16.23,['h'] = 310.37, ['info'] = ' Lindsay Circus Apartment 5' , ['apt'] = 2 },
	[642] =  { ['x'] = -712.02,['y'] = -1028.62,['z'] = 16.43,['h'] = 136.07, ['info'] = ' Lindsay Circus Apartment 6' , ['apt'] = 2 },
	[643] =  { ['x'] = -705.84,['y'] = -1036.18,['z'] = 16.3,['h'] = 117.55, ['info'] = ' Little Seoul Apartment 1' , ['apt'] = 1 },
	[644] =  { ['x'] = -670.55,['y'] = -888.9,['z'] = 24.5,['h'] = 1.22, ['info'] = ' Little Seoul Apartment 2' , ['apt'] = 1 },
	[645] =  { ['x'] = -690.52,['y'] = -893.1,['z'] = 24.71,['h'] = 92.39, ['info'] = ' Little Seoul Apartment 3' , ['apt'] = 1 },
	[646] =  { ['x'] = -683.56,['y'] = -876.24,['z'] = 24.5,['h'] = 1.54, ['info'] = ' Little Seoul Apartment 4' , ['apt'] = 1 },
	[647] =  { ['x'] = -676.0,['y'] = -884.98,['z'] = 24.46,['h'] = 273.5, ['info'] = ' Little Seoul Apartment 5' , ['apt'] = 1 },

	[648] =  { ['x'] = -1253.91,['y'] = -1140.81,['z'] = 8.57,['h'] = 17.5, ['info'] = ' Bay City Ave Upper 1' , ['apt'] = 2 },
	[649] =  { ['x'] = -1252.75,['y'] = -1144.26,['z'] = 8.52,['h'] = 194.39, ['info'] = ' Bay City Ave Upper 2', ['apt'] = 2 },
	[650] =  { ['x'] = -1221.37,['y'] = -1232.13,['z'] = 11.03,['h'] = 199.21, ['info'] = ' Bay City Ave Lower 1', ['apt'] = 1 },
	[651] =   { ['x'] = -1229.69,['y'] = -1235.39,['z'] = 11.03,['h'] = 198.65, ['info'] = ' Bay City Ave Lower 2', ['apt'] = 1 },
	[652] =  { ['x'] = -1237.59,['y'] = -1238.56,['z'] = 11.03,['h'] = 199.9, ['info'] = ' Bay City Ave Lower 3', ['apt'] = 1 },
	[653] =  { ['x'] = -1244.02,['y'] = -1240.64,['z'] = 11.03,['h'] = 202.08, ['info'] = ' Bay City Ave Lower 4', ['apt'] = 1 },
	[654] =  { ['x'] = -1226.14,['y'] = -1207.35,['z'] = 8.28,['h'] = 103.63, ['info'] = ' Bay City Ave Upper 4', ['apt'] = 2 },
	[655] =  { ['x'] = -1232.89,['y'] = -1191.83,['z'] = 11.26,['h'] = 16.83, ['info'] = ' Bay City Ave Average 1', ['apt'] = 1 },
	[656] =  { ['x'] = -35.69,['y'] = 2871.22,['z'] = 59.6,['h'] = 250.51, ['info'] = ' Shitville', ['apt'] = 1 },
	[657] =  { ['x'] = -766.11,['y'] = -916.99,['z'] = 21.08,['h'] = 90.73, ['info'] = ' Ginger St 1', ['apt'] = 0 },
	[658] =  { ['x'] = 2.24,['y'] = -241.06,['z'] = 47.67,['h'] = 342.2, ['info'] = ' Occupation Ave 1 / Apt 1', ['apt'] = 1 },
	[659] =  { ['x'] = 8.78,['y'] = -243.28,['z'] = 47.67,['h'] = 337.63, ['info'] = ' Occupation Ave 1 / Apt 2', ['apt'] = 1 },
	[660] =  { ['x'] = 2.35,['y'] = -241.02,['z'] = 51.87,['h'] = 339.63, ['info'] = ' Occupation Ave 1 / Apt 3', ['apt'] = 1 },
	[661] =  { ['x'] = 8.81,['y'] = -243.33,['z'] = 51.87,['h'] = 339.04, ['info'] = ' Occupation Ave 1 / Apt 4', ['apt'] = 1 },
	[662] =  { ['x'] = 2.28,['y'] = -240.88,['z'] = 55.87,['h'] = 336.6, ['info'] = ' Occupation Ave 1 / Apt 5', ['apt'] = 1 },
	[663] =  { ['x'] = 8.79,['y'] = -243.66,['z'] = 55.87,['h'] = 340.11, ['info'] = ' Occupation Ave 1 / Apt 6', ['apt'] = 1 },
	[664] =  { ['x'] = 352.86,['y'] = -142.13,['z'] = 66.69,['h'] = 162.06, ['info'] = ' Spanish Ave 1', ['apt'] = 2 },
	[665] =  { ['x'] = 216.15,['y'] = -147.07,['z'] = 59.16,['h'] = 259.15, ['info'] = ' Power Street 1', ['apt'] = 1 },
	[666] =  { ['x'] = 213.47,['y'] = -154.84,['z'] = 59.16,['h'] = 250.24, ['info'] = ' Power Street 2', ['apt'] = 1 },
	[667] =  { ['x'] = 280.21,['y'] = 32.47,['z'] = 88.61,['h'] = 337.36, ['info'] = ' Power Street 10', ['apt'] = 1 },
	[668] =  { ['x'] = 283.99,['y'] = 31.14,['z'] = 88.61,['h'] = 340.55, ['info'] = ' Power Street 11', ['apt'] = 1 },
	[669] =  { ['x'] = 283.83,['y'] = 47.66,['z'] = 92.67,['h'] = 65.03, ['info'] = ' Power Street 12', ['apt'] = 0 },
	[670] =  { ['x'] = 283.83,['y'] = 47.31,['z'] = 96.69,['h'] = 51.9, ['info'] = ' Power Street 13', ['apt'] = 0 },
	[671] =  { ['x'] = -1363.31,['y'] = -137.24,['z'] = 49.58,['h'] = 357.94, ['info'] = ' Cougar Ave 1', ['apt'] = 0 },
	[672] =  { ['x'] = -1359.18,['y'] = -138.06,['z'] = 49.58,['h'] = 356.25, ['info'] = ' Cougar Ave 2', ['apt'] = 0 },
	[673] =  { ['x'] = -1348.59,['y'] = -140.0,['z'] = 49.58,['h'] = 352.37, ['info'] = ' Cougar Ave 3', ['apt'] = 0 },
	[674] =  { ['x'] = -1344.6,['y'] = -140.8,['z'] = 49.58,['h'] = 348.0, ['info'] = ' Cougar Ave 4', ['apt'] = 0 },
	[675] =  { ['x'] = -1342.67,['y'] = -130.66,['z'] = 49.91,['h'] = 174.54, ['info'] = ' Cougar Ave 5', ['apt'] = 1 },
	[676] =  { ['x'] = -1346.72,['y'] = -129.88,['z'] = 49.99,['h'] = 174.31, ['info'] = ' Cougar Ave 6', ['apt'] = 1 },
	[677] =  { ['x'] = -1357.28,['y'] = -128.07,['z'] = 49.85,['h'] = 168.92, ['info'] = ' Cougar Ave 7', ['apt'] = 1 },
	[678] =  { ['x'] = -1361.52,['y'] = -127.29,['z'] = 49.85,['h'] = 175.05, ['info'] = ' Cougar Ave 8', ['apt'] = 1 },

	[679] =  { ['x'] = 798.39,['y'] = -158.81,['z'] = 74.9,['h'] = 57.07, ['info'] = ' Bridge Street 1', ['apt'] = 2 },
	[680] =  { ['x'] = 808.69,['y'] = -163.68,['z'] = 75.88,['h'] = 327.28, ['info'] = ' Bridge Street 2', ['apt'] = 0 },
	[681] =  { ['x'] = 820.7,['y'] = -156.28,['z'] = 80.76,['h'] = 62.13, ['info'] = ' Bridge Street 3', ['apt'] = 2 },
	[682] =  { ['x'] = 840.78,['y'] = -182.27,['z'] = 74.59,['h'] = 235.74, ['info'] = ' Bridge Street 4', ['apt'] = 2 },
	[683] =  { ['x'] = 846.1,['y'] = -173.19,['z'] = 78.47,['h'] = 237.25, ['info'] = ' Bridge Street 5', ['apt'] = 2 },
	[684] =  { ['x'] = 2727.85,['y'] = 4142.37,['z'] = 44.29,['h'] = 245.38, ['info'] = ' East Joshua Rd 3', ['trailer'] = 1, ['apt'] = 0 },
	[685] =  { ['x'] = 1880.43,['y'] = 3920.61,['z'] = 33.22,['h'] = 285.0, ['info'] = ' Niland Ave 1', ['apt'] = 0 },
	[686] =  { ['x'] = 1845.76,['y'] = 3914.55,['z'] = 33.47,['h'] = 101.96, ['info'] = ' Niland Ave 2', ['apt'] = 1 },
	[687] =  { ['x'] = 1661.35,['y'] = 3819.93,['z'] = 35.47,['h'] = 124.13, ['info'] = ' Mountain View Drive 1', ['trailer'] = 1, ['apt'] = 0 },
	[688] =  { ['x'] = 1859.47,['y'] = 3865.11,['z'] = 33.06,['h'] = 102.35, ['info'] = ' Niland Ave 3', ['apt'] = 1 },
	[689] =  { ['x'] = 1902.37,['y'] = 3866.89,['z'] = 33.07,['h'] = 26.71, ['info'] = ' Algonquin Blvd 1', ['trailer'] = 1, ['apt'] = 0  },
	[690] =  { ['x'] = 1925.05,['y'] = 3824.73,['z'] = 32.44,['h'] = 26.06, ['info'] = ' Niland Ave 4', ['apt'] = 0  },
	[691] =  { ['x'] = 1880.63,['y'] = 3810.42,['z'] = 32.78,['h'] = 116.47, ['info'] = ' Niland Ave 5', ['trailer'] = 1, ['apt'] = 0 },
	[692] =  { ['x'] = 1781.64,['y'] = 3911.24,['z'] = 34.92,['h'] = 200.61, ['info'] = ' Marina Drive 1', ['trailer'] = 1, ['apt'] = 0 },
	[693] =  { ['x'] = 1915.83,['y'] = 3909.24,['z'] = 33.45,['h'] = 57.4, ['info'] = ' Marina Drive 2', ['trailer'] = 1, ['apt'] = 0 },
	[694] =  { ['x'] = 1777.52,['y'] = 3799.98,['z'] = 34.53,['h'] = 300.82, ['info'] = ' Armadillo Ave 1', ['trailer'] = 1, ['apt'] = 0 },
	[695] =  { ['x'] = 115.67,['y'] = -1685.63,['z'] = 33.5,['h'] = 48.01, ['info'] = ' Carson Ave/ Apt 1', ['apt'] = 1 },
	[696] =  { ['x'] = 1425.71,['y'] = 3669.59,['z'] = 34.83,['h'] = 197.82, ['info'] = ' Marina Dr 12', ['trailer'] = 1 },
	[697] =  { ['x'] = 1809.93,['y'] = 3907.17,['z'] = 33.81,['h'] = 299.31, ['info'] = ' Cholla Springs Ave 1', ['apt'] = 1 },
	[698] =  { ['x'] = 1936.66,['y'] = 3891.56,['z'] = 32.75,['h'] = 35.61, ['info'] = ' Algonquin Blvd 2', ['trailer'] = 1 },
	[699] =  { ['x'] = 1832.66,['y'] = 3868.5,['z'] = 34.3,['h'] = 294.36, ['info'] = ' Cholla Springs Ave 2', ['trailer'] = 1 },
	[700] =  { ['x'] = 1813.66,['y'] = 3854.0,['z'] = 34.36,['h'] = 202.61, ['info'] = ' Cholla Springs Ave 3', ['trailer'] = 1 },
	[701] =  { ['x'] = 1763.76,['y'] = 3823.56,['z'] = 34.77,['h'] = 213.05, ['info'] = ' Cholla Springs Ave 4', ['trailer'] = 1 },
	[702] =  { ['x'] = 1728.46,['y'] = 3851.8,['z'] = 34.79,['h'] = 39.05, ['info'] = ' Cholla Springs Ave 5', ['apt'] = 2 },
	[703] =  { ['x'] = 1733.6,['y'] = 3808.7,['z'] = 35.12,['h'] = 211.81, ['info'] = ' Cholla Springs Ave 6', ['apt'] = 2 },
	[704] =  { ['x'] = 98.15,['y'] = -1307.23,['z'] = 35.39,['h'] = 300.53, ['info'] = ' VU Pimphouse', ['apt'] = 1 },
	[705] =  { ['x'] = -728.48,['y'] = -879.92,['z'] = 22.72,['h'] = 268.36, ['info'] = ' Ginger St 2', ['apt'] = 1  },
	[706] =  { ['x'] = -719.15,['y'] = -897.76,['z'] = 20.68,['h'] = 92.46, ['info'] = ' Ginger St 3', ['apt'] = 1  },
	[707] =  { ['x'] = -716.42,['y'] = -864.73,['z'] = 23.21,['h'] = 82.5, ['info'] = ' Ginger St 4', ['apt'] = 1  },
	[708] =  { ['x'] = -731.71,['y'] = -693.62,['z'] = 30.38,['h'] = 266.73, ['info'] = ' Ginger St 5', ['apt'] = 1 },
	[709] =  { ['x'] = -714.65,['y'] = -676.31,['z'] = 30.63,['h'] = 179.89, ['info'] = ' Ginger St 6', ['apt'] = 1 },
	[710] =  { ['x'] = -710.91,['y'] = -724.23,['z'] = 28.8,['h'] = 66.07, ['info'] = ' Ginger St 7', ['apt'] = 1 },
	[711] =  { ['x'] = -691.48,['y'] = -722.75,['z'] = 33.93,['h'] = 356.44, ['info'] = ' Ginger St 6B', ['apt'] = 1 },
	[712] =  { ['x'] = -714.95,['y'] = -712.73,['z'] = 29.28,['h'] = 1.12, ['info'] = ' Ginger St 5B', ['apt'] = 1 },
	[713] =  { ['x'] = 3310.85,['y'] = 5176.43,['z'] = 19.62,['h'] = 53.41, ['info'] = ' La Casa De Jubilación #1',['apt'] = 1 },
	[714] =  { ['x'] = -1354.14,['y'] = -777.16,['z'] = 20.68,['h'] = 218.44, ['info'] = ' Bay City Ave #1',['apt'] = 0 },

	[715] =  { ['x'] = 1203.24,['y'] = -1670.67,['z'] = 42.99,['h'] = 37.37, ['info'] = ' Innocence Blvd #1' ,['apt'] = 0 },
	[716] =  { ['x'] = 1220.24,['y'] = -1658.75,['z'] = 48.65,['h'] = 31.29, ['info'] = ' Innocence Blvd #2' ,['apt'] = 0 },
	[717] =  { ['x'] = 1252.8,['y'] = -1638.49,['z'] = 53.18,['h'] = 31.61, ['info'] = ' Innocence Blvd #3' ,['apt'] = 0 },
	[718] =  { ['x'] = 1276.43,['y'] = -1628.83,['z'] = 54.74,['h'] = 35.35, ['info'] = ' Innocence Blvd #4' ,['apt'] = 0 },
	[719] =  { ['x'] = 1297.21,['y'] = -1618.03,['z'] = 54.58,['h'] = 19.41, ['info'] = ' Innocence Blvd #5' ,['apt'] = 0 },
}


robbablesMansion = {
	[1] = { ["x"] = -5.67645700, ["y"] = 9.23738900, ["z"] = 4.58609800, ["name"] = "bed table" },
	[2] = { ["x"] = -1.28456500, ["y"] = -1.86961300, ["z"] = 0.92229600, ["name"] = "jewel box" },
	[3] = { ["x"] = -0.82748790, ["y"] = -0.20085050, ["z"] = 5.66071400, ["name"] = "jewel box" },
	[4] = { ["x"] = 2.19403800, ["y"] = 6.81445700, ["z"] = 0.98931310, ["name"] = "jewel box" },
	[5] = { ["x"] = 14.36221000, ["y"] = 6.14473800, ["z"] = 1.44332300, ["name"] = "cupboard" },
	[6] = { ["x"] = -2.89582400, ["y"] = 9.22972300, ["z"] = 4.58609800, ["name"] = "bed table" },
	[7] = { ["x"] = 13.48880000, ["y"] = 9.39807700, ["z"] = 1.50317400, ["name"] = "cupboard" },
	[8] = { ["x"] = 9.14163700, ["y"] = 9.39807700, ["z"] = 1.50319300, ["name"] = "cupboard" },
	[9] = { ["x"] = 5.60166200, ["y"] = -7.84856600, ["z"] = 5.57709100, ["name"] = "jewel box" },
	[10] = { ["x"] = 6.33438800, ["y"] = -7.96820100, ["z"] = 4.57700000, ["name"] = "drawers" },
	[11] = { ["x"] = 3.50600100, ["y"] = -3.73348200, ["z"] = 4.57736500, ["name"] = "bed table" },	
	[12] = { ["x"] = 0.53466320, ["y"] = -7.69714400,["z"] = 5.40757800, ["name"] = "table" },	
	[13] = { ["x"] = -2.72426300, ["y"] = -4.61612700,["z"] = 4.70186500, ["name"] = "clutter" },	
	[14] = { ["x"] = -1.77334100, ["y"] = -3.80492700,["z"] = 4.60178600, ["name"] = "under bed" },		
}
robbables2 = {
	[1] = { ["x"] = 1.90339700, ["y"] = -3.80026800, ["z"] = 1.29917900, ["name"] = "fridge" },
	[2] = { ["x"] = -3.50363200, ["y"] = -6.55289400, ["z"] = 1.30625800, ["name"] = "drawers" },
	[3] = { ["x"] = -3.50712600, ["y"] = -4.13621600, ["z"] = 1.29625800, ["name"] = "table" },
	[4] = { ["x"] = 8.47819500, ["y"] = -2.50979300, ["z"] = 1.19712300, ["name"] = "storage" },
	[5] = { ["x"] = 9.75982700, ["y"] = -1.35874100, ["z"] = 1.29625800, ["name"] = "storage" },
	[6] = { ["x"] = 8.46626300, ["y"] = 4.53223600, ["z"] = 1.19425800, ["name"] = "wardrobe" },
	[7] = { ["x"] = 5.84416200, ["y"] = 2.57377400, ["z"] = 1.22089100, ["name"] = "table" },
	[8] = { ["x"] = 3.04164100, ["y"] = 0.31671810, ["z"] = 3.58363900, ["name"] = "jewelry" },
	[9] = { ["x"] = 6.86376900, ["y"] = 1.20651200, ["z"] = 1.36589100, ["name"] = "under bed" },
	[10] = { ["x"] = 2.03442400, ["y"] = -5.61585100, ["z"] = 3.30395600, ["name"] = "cupboards" },
	[11] = { ["x"] = -5.53120400, ["y"] = 0.76299670, ["z"] = 1.77236000, ["name"] = "cabinet" },
	[12] = { ["x"] = -1.24716200, ["y"] = 1.07820500, ["z"] = 1.69089300, ["name"] = "coffee table" },
	[13] = { ["x"] = 2.91325400, ["y"] = -4.2783510, ["z"] = 1.82746400, ["name"] = "table" },
}

-- 1-7 rare, 42-44 very rare
itemdrops = {
	[1] = { ["id"] = 1, ["info"] = {"Weed Ounce",350,0.25,"i",false,false} },
	[2] = { ["id"] = 38, ["info"] = {"Gun Part",1800,4.4,"i",false,false} },
	[3] = { ["id"] = 7, ["info"]= {"Cocaine Bag",350,0.25,"i",false,false} },
	[4] = { ["id"] = 9, ["info"]= {"Money Ink Set",350,0.25,"i",false,false} },
	[5] = { ["id"] = 22, ["info"] = {"Hand Cuffs",250,1,"i",false,false} },
	[6] = { ["id"] = 24, ["info"] = {"Oxygen Tank",300,1,"i",false,false} },
    -- White pearl used as Money trade in , cannot find another use as of yet
	[7] = { ["id"] = 25, ["info"] = {"White Pearl",0,1,"m",false,true} },
    -- All Meterials Currently 
	[8] = { ["id"] = 4, ["info"]= {"Gold Bar",21,2,"m",false,true} },
	[9] = { ["id"] = 5, ["info"]= {"Wood",15,2,"m",false,true} },
	[10] = { ["id"] = 26, ["info"] = {"Scrap Metal",250,2,"m",false,true} },
	[11] = { ["id"] = 27, ["info"] = {"Plastic",11,1,"m",false,true} },
	[12] = { ["id"] = 28, ["info"] = {"Glass",12,1,"m",false,true} },
	[13] = { ["id"] = 30, ["info"] = {"Steel",45,5.5,"m",false,true} },
	[14] = { ["id"] = 31, ["info"] = {"Aluminium",50,2.0,"m",false,true} },
	[15] = { ["id"] = 32, ["info"] = {"Dye",20,0.6,"m",false,true} },
	[16] = { ["id"] = 33, ["info"] = {"Rubber",20,1.2,"m",false,true} },
	[17] = { ["id"] = 34, ["info"] = {"Copper",25,1.6,"m",false,true} },
	[18] = { ["id"] = 35, ["info"] = {"Electronics",25,0.8,"m",false,true} },
	[19] = { ["id"] = 70, ["info"] = {"Cleaning goods",500,3.0,"i",false,true} },
	[20] = { ["id"] = 72, ["info"] = {"Pistol Ammo x30",25,3.0,"i",false,true} },
	[21] = { ["id"] = 73, ["info"] = {"Rifle Ammo x30",100,7.0,"i",false,false} },
	[22] = { ["id"] = 74, ["info"] = {"Shotgun Ammo x30",100,7.0,"i",false,false} },
	[23] = { ["id"] = 45, ["info"] = {"Oil",300,1.3,"i",false,false} }, -- Shop
	[24] = { ["id"] = 46, ["info"] = {"Nitrous Oxide",300,10.0,"i",false,false} },
	[25] = { ["id"] = 47, ["info"] = {"Iron Oxide",200,3.5,"m",false,false} }, -- Gang task A / 10% chance of spawn
	[26] = { ["id"] = 48, ["info"] = {"Aluminium Oxide",200,1.5,"m",false,false} }, -- Gang task B / 14% chance of spawn
	[27] = { ["id"] = 49, ["info"] = {"Fuse",30,0.1,"i",false,false} }, -- Crafting
	[28] = { ["id"] = 50, ["info"] = {"Clutch",350,5.0,"i",false,false} }, -- Gang task A / 35% chance of spawn
	[29] = { ["id"] = 51, ["info"] = {"Drill Bit",100,2.0,"i",false,false} }, -- Gang task C / 40% chance of spawn
	[30] = { ["id"] = 52, ["info"] = {"Battery",10,1.0,"i",false,false} },    -- Gang Task B / 60% chance of spawn
	[31] = { ["id"] = 53, ["info"] = {"Breadboard",60,0.6,"i",false,false} }, -- Gang Task B / 60% chance of spawn
	[32] = { ["id"] = 69, ["info"] = {"Food goods",500,3.0,"i",false,true} },
	[33] = { ["id"] = 57, ["info"] = {"Green Cow Energy Drink",1200,3.0,"i",false,true} },
	[34] = { ["id"] = 58, ["info"] = {"Chest Armor",1200,30.0,"i",false,true} },
	[35] = { ["id"] = 59, ["info"] = {"Radio Scanner",1500,15.0,"i",false,true} },
	[36] = { ["id"] = 60, ["info"] = {"Advanced Lock Pick",500,3.0,"i",false,false} }, -- crafted
	[37] = { ["id"] = 62, ["info"] = {"Cigarette",10,0.2,"i",false,true} },
	[38] = { ["id"] = 75, ["info"] = {"Sub-Machinegun Ammo x30",100,5.0,"i",false,false} },
	[39] = { ["id"] = 66, ["info"] = {"Mobile Phone",1000,1.0,"i",false,true} },
	[40] = { ["id"] = 67, ["info"] = {"Radio",1000,3.0,"i",false,true} },
	[41] = { ["id"] = 68, ["info"] = {"Umbrella",500,3.0,"i",false,true} },
	[42] = { ["id"] = 76, ["info"] = {"Unknown USB Device",300,1.0,"i",false,true} },
	[43] = { ["id"] = 78, ["info"] = {"Decrypter MK 1",300,3.0,"i",false,true} },
	[44] = { ["id"] = 79, ["info"] = {"Decrypter MK 2",300,3.0,"i",false,true} },
}  


robberyExitCoordsMansions = {
	[1] = { ['x'] = 9.24863, ['y'] = 396.906, ['z'] = 120.289, ['h'] = 214.0 },
	[2] = { ['x'] = -102.626, ['y'] = 452.67, ['z'] = 117.883, ['h'] = 346.0 },
	[3] = { ['x'] = -163.974, ['y'] = 404.316, ['z'] = 111.423, ['h'] = 190.0 },
	[4] = { ['x'] = 33.3112, ['y'] = 382.784, ['z'] = 116.509, ['h'] = 38.0 },
	[5] = { ['x'] = -200.356, ['y'] = 382.65, ['z'] = 109.492, ['h'] = 191.0 },
	[6] = { ['x'] = -238.975, ['y'] = 364.382, ['z'] = 110.832, ['h'] = 133.0 },
	[7] = { ['x'] = -296.969, ['y'] = 360.887, ['z'] = 109.746, ['h'] = 187.0 },
	[8] = { ['x'] = -320.307, ['y'] = 354.927, ['z'] = 110.016, ['h'] = 197.0 },
	[9] = { ['x'] = -369.133, ['y'] = 330.685, ['z'] = 109.943, ['h'] = 178.0 },
	[10] = { ['x'] = -407.714, ['y'] = 324.684, ['z'] = 108.718, ['h'] = 182.0 },
	[11] = { ['x'] = -446.425, ['y'] = 328.708, ['z'] = 104.823, ['h'] = 198.0 },
	[12] = { ['x'] = -484.874, ['y'] = 345.783, ['z'] = 104.146, ['h'] = 66.0 },
	[13] = { ['x'] = -310.648, ['y'] = 420.123, ['z'] = 109.883, ['h'] = 189.0 },
	[14] = { ['x'] = -344.39, ['y'] = 400.142, ['z'] = 110.593, ['h'] = 208.0 },
	[15] = { ['x'] = -412.903, ['y'] = 437.12, ['z'] = 112.406, ['h'] = 154.0 },
	[16] = { ['x'] = -447.822, ['y'] = 378.629, ['z'] = 108.869, ['h'] = 184.0 },
	[17] = { ['x'] = -477.176, ['y'] = 424.709, ['z'] = 103.122, ['h'] = 8.0 },
	[18] = { ['x'] = -504.334, ['y'] = 388.046, ['z'] = 97.4062, ['h'] = 61.0 },
	[19] = { ['x'] = -498.749, ['y'] = 437.544, ['z'] = 97.2872, ['h'] = 316.0 },
	[20] = { ['x'] = -561.359, ['y'] = 386.162, ['z'] = 101.289, ['h'] = 193.0 },
	[21] = { ['x'] = -597.38, ['y'] = 375.935, ['z'] = 97.8495, ['h'] = 180.0 },
	[22] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[23] = { ['x'] = 219.274, ['y'] = 491.756, ['z'] = 140.697, ['h'] = 263.0 },
	[24] = { ['x'] = -497.476, ['y'] = 524.18, ['z'] = 116.763, ['h'] = 165.0 },
	[25] = { ['x'] = 119.764, ['y'] = 504.062, ['z'] = 155.148, ['h'] = 319.0 },
	[26] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[27] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[28] = { ['x'] = 39.6699, ['y'] = 435.325, ['z'] = 146.775, ['h'] = 155.0 },
	[29] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[30] = { ['x'] = -26.6184, ['y'] = 455.283, ['z'] = 141.731, ['h'] = 162.0 },
	[31] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[32] = { ['x'] = -106.436, ['y'] = 491.2, ['z'] = 137.031, ['h'] = 169.0 },
	[33] = { ['x'] = -166.133, ['y'] = 477.207, ['z'] = 133.878, ['h'] = 195.0 },
	[34] = { ['x'] = -225.175, ['y'] = 477.398, ['z'] = 128.427, ['h'] = 205.0 },
	[35] = { ['x'] = -1908.72, ['y'] = 129.682, ['z'] = 82.4507, ['h'] = 125.0 },
	[36] = { ['x'] = 233.686, ['y'] = 643.62, ['z'] = 186.399, ['h'] = 226.0 },
	[37] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[38] = { ['x'] = 163.086, ['y'] = 552.949, ['z'] = 182.342, ['h'] = 183.0 },
	[39] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[40] = { ['x'] = 99.6028, ['y'] = 550.055, ['z'] = 181.498, ['h'] = 190.0 },
	[41] = { ['x'] = 52.7842, ['y'] = 544.641, ['z'] = 175.853, ['h'] = 195.0 },
	[42] = { ['x'] = 21.9587, ['y'] = 535.863, ['z'] = 170.628, ['h'] = 114.0 },
	[43] = { ['x'] = 232.407, ['y'] = 747.157, ['z'] = 203.702, ['h'] = 230.0 },
	[44] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[45] = { ['x'] = -186.877, ['y'] = 570.392, ['z'] = 189.77, ['h'] = 179.0 },
	[46] = { ['x'] = -199.5, ['y'] = 636.61, ['z'] = 199.639, ['h'] = 1.0 },
	[47] = { ['x'] = -231.478, ['y'] = 574.81, ['z'] = 185.658, ['h'] = 178.0 },
	[48] = { ['x'] = -233.508, ['y'] = 621.67, ['z'] = 187.81, ['h'] = 316.0 },
	[49] = { ['x'] = -281.694, ['y'] = 580.345, ['z'] = 177.738, ['h'] = 173.0 },
	[50] = { ['x'] = -293.924, ['y'] = 650.211, ['z'] = 175.694, ['h'] = 285.0 },
	[51] = { ['x'] = -346.269, ['y'] = 687.07, ['z'] = 172.539, ['h'] = 350.0 },
	[52] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[53] = { ['x'] = -400.021, ['y'] = 640.22, ['z'] = 159.466, ['h'] = 182.0 },
	[54] = { ['x'] = -443.234, ['y'] = 696.243, ['z'] = 153.229, ['h'] = 297.0 },
	[55] = { ['x'] = -483.217, ['y'] = 633.964, ['z'] = 144.384, ['h'] = 193.0 },
	[56] = { ['x'] = -609.038, ['y'] = 540.864, ['z'] = 111.321, ['h'] = 15.0 },
	[57] = { ['x'] = -599.729, ['y'] = 481.132, ['z'] = 109.014, ['h'] = 101.0 },
	[58] = { ['x'] = -624.838, ['y'] = 470.603, ['z'] = 108.858, ['h'] = 186.0 },
	[59] = { ['x'] = -638.839, ['y'] = 540.722, ['z'] = 109.716, ['h'] = 8.0 },
	[60] = { ['x'] = -657.619, ['y'] = 462.883, ['z'] = 110.39, ['h'] = 193.0 },
	[61] = { ['x'] = -677.575, ['y'] = 522.413, ['z'] = 110.316, ['h'] = 16.0 },
	[62] = { ['x'] = -741.65, ['y'] = 506.696, ['z'] = 110.182, ['h'] = 22.0 },
	[63] = { ['x'] = -710.481, ['y'] = 440.604, ['z'] = 107.049, ['h'] = 202.0 },
	[64] = { ['x'] = -788.291, ['y'] = 465.12, ['z'] = 100.172, ['h'] = 30.0 },
	[65] = { ['x'] = -747.262, ['y'] = 410.115, ['z'] = 96.0174, ['h'] = 197.0 },
	[66] = { ['x'] = -833.23, ['y'] = 406.064, ['z'] = 91.5597, ['h'] = 187.0 },
	[67] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[68] = { ['x'] = -545.023, ['y'] = 694.791, ['z'] = 146.074, ['h'] = 305.0 },
	[69] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[70] = { ['x'] = -714.705, ['y'] = 696.683, ['z'] = 158.031, ['h'] = 186.0 },
	[71] = { ['x'] = -657.472, ['y'] = 728.777, ['z'] = 174.285, ['h'] = 191.0 },
	[72] = { ['x'] = -601.678, ['y'] = 712.455, ['z'] = 180.007, ['h'] = 177.0 },
	[73] = { ['x'] = -609.017, ['y'] = 771.849, ['z'] = 188.51, ['h'] = 164.0 },
	[74] = { ['x'] = -608.857, ['y'] = 771.678, ['z'] = 188.51, ['h'] = 166.0 },
	[75] = { ['x'] = -578.085, ['y'] = 812.272, ['z'] = 191.547, ['h'] = 283.0 },
	[76] = { ['x'] = -668.206, ['y'] = 797.354, ['z'] = 198.998, ['h'] = 91.0 },
	[77] = { ['x'] = -746.083, ['y'] = 796.373, ['z'] = 214.571, ['h'] = 188.0 },
	[78] = { ['x'] = -818.364, ['y'] = 796.103, ['z'] = 202.586, ['h'] = 200.0 },
	[79] = { ['x'] = -859.517, ['y'] = 767.31, ['z'] = 191.822, ['h'] = 182.0 },
	[80] = { ['x'] = -907.07, ['y'] = 753.177, ['z'] = 182.161, ['h'] = 184.0 },
	[81] = { ['x'] = -931.321, ['y'] = 826.367, ['z'] = 184.337, ['h'] = 354.0 },
	[82] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[83] = { ['x'] = -1008.68, ['y'] = 831.368, ['z'] = 172.451, ['h'] = 43.0 },
	[84] = { ['x'] = -954.28, ['y'] = 736.54, ['z'] = 175.559, ['h'] = 222.0 },
	[85] = { ['x'] = -1052.7, ['y'] = 818.676, ['z'] = 166.991, ['h'] = 4.0 },
	[86] = { ['x'] = -1097.35, ['y'] = 823.841, ['z'] = 168.638, ['h'] = 12.0 },
	[87] = { ['x'] = -1107.22, ['y'] = 738.891, ['z'] = 159.916, ['h'] = 201.0 },
	[88] = { ['x'] = -1144.9, ['y'] = 719.063, ['z'] = 155.671, ['h'] = 226.0 },
	[89] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[90] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[91] = { ['x'] = -1255.31, ['y'] = 667.106, ['z'] = 142.822, ['h'] = 203.0 },
	[92] = { ['x'] = -1233.95, ['y'] = 636.047, ['z'] = 142.745, ['h'] = 202.0 },
	[93] = { ['x'] = -1283.25, ['y'] = 663.324, ['z'] = 144.849, ['h'] = 285.0 },
	[94] = { ['x'] = -1271.38, ['y'] = 628.783, ['z'] = 143.23, ['h'] = 305.0 },
	[95] = { ['x'] = -1381.39, ['y'] = 528.401, ['z'] = 123.017, ['h'] = 248.0 },
	[96] = { ['x'] = -1409.06, ['y'] = 446.177, ['z'] = 112.22, ['h'] = 166.0 },
	[97] = { ['x'] = -1347.08, ['y'] = 442.319, ['z'] = 100.994, ['h'] = 260.0 },
	[98] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[99] = { ['x'] = -1332.54, ['y'] = 490.902, ['z'] = 102.448, ['h'] = 357.0 },
	[100] = { ['x'] = -1253.12, ['y'] = 433.049, ['z'] = 95.1852, ['h'] = 219.0 },
	[101] = { ['x'] = -1224.66, ['y'] = 439.9, ['z'] = 85.6166, ['h'] = 177.0 },
	[102] = { ['x'] = -1161.01, ['y'] = 435.339, ['z'] = 86.6364, ['h'] = 265.0 },
	[103] = { ['x'] = -1161.58, ['y'] = 499.77, ['z'] = 86.0938, ['h'] = 1.0 },
	[104] = { ['x'] = -1113.44, ['y'] = 504.418, ['z'] = 82.2875, ['h'] = 345.0 },
	[105] = { ['x'] = -1066.33, ['y'] = 482.486, ['z'] = 85.3016, ['h'] = 59.0 },
	[106] = { ['x'] = -1105.3, ['y'] = 429.796, ['z'] = 75.88, ['h'] = 84.0 },
	[107] = { ['x'] = -1036.75, ['y'] = 443.469, ['z'] = 72.8639, ['h'] = 278.0 },
	[108] = { ['x'] = -1059.73, ['y'] = 515.632, ['z'] = 84.3811, ['h'] = 38.0 },
	[109] = { ['x'] = -1013.72, ['y'] = 457.103, ['z'] = 79.3645, ['h'] = 239.0 },
	[110] = { ['x'] = -1007.25, ['y'] = 531.34, ['z'] = 79.7712, ['h'] = 68.0 },
	[111] = { ['x'] = -984.774, ['y'] = 476.088, ['z'] = 82.4608, ['h'] = 184.0 },
	[112] = { ['x'] = -956.359, ['y'] = 526.95, ['z'] = 81.6716, ['h'] = 322.0 },
	[113] = { ['x'] = -983.267, ['y'] = 442.307, ['z'] = 79.9715, ['h'] = 108.0 },
	[114] = { ['x'] = -933.096, ['y'] = 472.269, ['z'] = 85.1206, ['h'] = 284.0 },
	[115] = { ['x'] = -873.866, ['y'] = 353.771, ['z'] = 85.2853, ['h'] = 180.0 },
	[116] = { ['x'] = -889.402, ['y'] = 310.611, ['z'] = 84.1299, ['h'] = 55.0 },
	[117] = { ['x'] = -806.847, ['y'] = 253.298, ['z'] = 82.7961, ['h'] = 274.0 },
	[118] = { ['x'] = -1673.47, ['y'] = 372.078, ['z'] = 85.119, ['h'] = 166.0 },
	[119] = { ['x'] = -1742.07, ['y'] = 365.231, ['z'] = 88.7283, ['h'] = 125.0 },
	[120] = { ['x'] = -1771.36, ['y'] = 342.321, ['z'] = 89.3714, ['h'] = 205.0 },
	[121] = { ['x'] = -1861.27, ['y'] = 310.455, ['z'] = 89.1144, ['h'] = 104.0 },
	[122] = { ['x'] = -1878.02, ['y'] = 652.328, ['z'] = 130.0, ['h'] = 310.0 },
	[123] = { ['x'] = -1994.22, ['y'] = 639.763, ['z'] = 122.536, ['h'] = 61.0 },
	[124] = { ['x'] = -1917.27, ['y'] = 592.333, ['z'] = 122.125, ['h'] = 243.0 },
	[125] = { ['x'] = -2009.59, ['y'] = 591.366, ['z'] = 118.102, ['h'] = 72.0 },
	[126] = { ['x'] = -1923.6, ['y'] = 544.192, ['z'] = 114.82, ['h'] = 248.0 },
	[127] = { ['x'] = -2036.74, ['y'] = 496.19, ['z'] = 107.012, ['h'] = 69.0 },
	[128] = { ['x'] = -2018.15, ['y'] = 434.141, ['z'] = 102.674, ['h'] = 191.0 },
	[129] = { ['x'] = -1932.08, ['y'] = 452.521, ['z'] = 102.703, ['h'] = 269.0 },
	[130] = { ['x'] = -1931.59, ['y'] = 398.633, ['z'] = 96.5071, ['h'] = 275.0 },
	[131] = { ['x'] = -2020.42, ['y'] = 370.051, ['z'] = 94.5785, ['h'] = 56.0 },
	[132] = { ['x'] = -1918.7, ['y'] = 367.626, ['z'] = 93.9763, ['h'] = 266.0 },
	[133] = { ['x'] = -1907.1, ['y'] = 294.036, ['z'] = 88.6077, ['h'] = 175.0 },
	[134] = { ['x'] = -1998.72, ['y'] = 313.762, ['z'] = 91.5606, ['h'] = 10.0 },
	[135] = { ['x'] = -1981.31, ['y'] = 244.1, ['z'] = 87.6132, ['h'] = 105.0 },
	[136] = { ['x'] = -1895.16, ['y'] = 261.188, ['z'] = 86.4532, ['h'] = 294.0 },
	[137] = { ['x'] = -1974.5, ['y'] = 198.575, ['z'] = 86.5972, ['h'] = 113.0 },
	[138] = { ['x'] = -1944.15, ['y'] = 150.87, ['z'] = 84.6527, ['h'] = 127.0 },
	[139] = { ['x'] = -1846.05, ['y'] = 203.009, ['z'] = 84.4393, ['h'] = 123.0 },
	[140] = { ['x'] = -1289.04, ['y'] = 500.734, ['z'] = 97.5598, ['h'] = 69.0 },
	[141] = { ['x'] = -1201.08, ['y'] = 503.266, ['z'] = 98.9964, ['h'] = 229.0 },
	[142] = { ['x'] = -1201.09, ['y'] = 581.729, ['z'] = 100.13, ['h'] = 359.0 },
	[143] = { ['x'] = -1164.33, ['y'] = 588.457, ['z'] = 101.833, ['h'] = 9.0 },
	[144] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[145] = { ['x'] = -1124.08, ['y'] = 531.423, ['z'] = 98.3818, ['h'] = 195.0 },
	[146] = { ['x'] = -1123.09, ['y'] = 600.907, ['z'] = 104.36, ['h'] = 23.0 },
	[147] = { ['x'] = -1069.0, ['y'] = 561.994, ['z'] = 102.73, ['h'] = 294.0 },
	[148] = { ['x'] = -1032.63, ['y'] = 565.741, ['z'] = 100.515, ['h'] = 183.0 },
	[149] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[150] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[151] = { ['x'] = -957.953, ['y'] = 549.023, ['z'] = 101.701, ['h'] = 154.0 },
	[152] = { ['x'] = -940.313, ['y'] = 540.878, ['z'] = 103.581, ['h'] = 147.0 },
	[153] = { ['x'] = -887.68, ['y'] = 584.497, ['z'] = 101.192, ['h'] = 232.0 },
	[154] = { ['x'] = -921.383, ['y'] = 535.617, ['z'] = 96.014, ['h'] = 136.0 },
	[155] = { ['x'] = -856.906, ['y'] = 563.557, ['z'] = 96.6216, ['h'] = 312.0 },
	[156] = { ['x'] = -898.491, ['y'] = 518.151, ['z'] = 92.2289, ['h'] = 103.0 },
	[157] = { ['x'] = -832.574, ['y'] = 512.656, ['z'] = 94.6172, ['h'] = 280.0 },
	[158] = { ['x'] = -866.953, ['y'] = 457.584, ['z'] = 88.2811, ['h'] = 190.0 },
	[159] = { ['x'] = -829.663, ['y'] = 477.961, ['z'] = 90.1653, ['h'] = 273.0 },
	[160] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[161] = { ['x'] = -717.107, ['y'] = 564.141, ['z'] = 142.386, ['h'] = 173.0 },
	[162] = { ['x'] = -745.863, ['y'] = 589.555, ['z'] = 142.615, ['h'] = 60.0 },
	[163] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[164] = { ['x'] = -789.09, ['y'] = 650.316, ['z'] = 139.264, ['h'] = 125.0 },
	[165] = { ['x'] = -809.564, ['y'] = 674.579, ['z'] = 147.29, ['h'] = 199.0 },
	[166] = { ['x'] = -855.745, ['y'] = 669.56, ['z'] = 152.451, ['h'] = 178.0 },
	[167] = { ['x'] = -886.418, ['y'] = 672.841, ['z'] = 151.101, ['h'] = 175.0 },
	[168] = { ['x'] = -914.792, ['y'] = 669.017, ['z'] = 155.282, ['h'] = 183.0 },
	[169] = { ['x'] = -944.247, ['y'] = 666.458, ['z'] = 153.573, ['h'] = 173.0 },
	[170] = { ['x'] = -970.132, ['y'] = 663.949, ['z'] = 158.228, ['h'] = 89.0 },
	[171] = { ['x'] = -1021.61, ['y'] = 664.754, ['z'] = 161.294, ['h'] = 182.0 },
	[172] = { ['x'] = -1058.51, ['y'] = 712.582, ['z'] = 165.594, ['h'] = 111.0 },
	[173] = { ['x'] = -1069.84, ['y'] = 749.546, ['z'] = 168.047, ['h'] = 87.0 },
	[174] = { ['x'] = -643.332, ['y'] = 874.418, ['z'] = 224.594, ['h'] = 307.0 },
	[175] = { ['x'] = -611.887, ['y'] = 847.493, ['z'] = 211.502, ['h'] = 139.0 },
	[176] = { ['x'] = -539.926, ['y'] = 801.903, ['z'] = 197.51, ['h'] = 151.0 },
	[177] = { ['x'] = -489.479, ['y'] = 783.344, ['z'] = 180.535, ['h'] = 169.0 },
	[178] = { ['x'] = -498.507, ['y'] = 753.593, ['z'] = 170.835, ['h'] = 14.0 },
	[179] = { ['x'] = -525.429, ['y'] = 722.415, ['z'] = 161.594, ['h'] = 1.0 },
	[180] = { ['x'] = -498.978, ['y'] = 700.691, ['z'] = 151.259, ['h'] = 3.0 },
	[181] = { ['x'] = -542.253, ['y'] = 627.312, ['z'] = 137.855, ['h'] = 118.0 },
	[182] = { ['x'] = -450.872, ['y'] = 587.372, ['z'] = 128.069, ['h'] = 268.0 },
	[183] = { ['x'] = -542.395, ['y'] = 577.358, ['z'] = 117.316, ['h'] = 89.0 },
	[184] = { ['x'] = -556.578, ['y'] = 552.617, ['z'] = 110.522, ['h'] = 348.0 },
	[185] = { ['x'] = -510.427, ['y'] = 503.413, ['z'] = 112.439, ['h'] = 220.0 },
	[186] = { ['x'] = -532.621, ['y'] = 464.72, ['z'] = 103.194, ['h'] = 149.0 },
	[187] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[188] = { ['x'] = 259.575, ['y'] = -782.76, ['z'] = 30.518, ['h'] = 53.0 },
	[189] = { ['x'] = 260.99, ['y'] = -1004.99, ['z'] = 61.6346, ['h'] = 153.0 },
	[190] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[191] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[192] = { ['x'] = 123.852, ['y'] = -1039.64, ['z'] = 29.2118, ['h'] = 161.0 },
	[193] = { ['x'] = 83.8308, ['y'] = -855.085, ['z'] = 30.7698, ['h'] = 69.0 },
	[194] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[195] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[196] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[197] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[198] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[199] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[200] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[201] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[202] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[203] = { ['x'] = -289.411, ['y'] = 303.25, ['z'] = 90.7184, ['h'] = 358.0 },
	[204] = { ['x'] = -348.406, ['y'] = 179.068, ['z'] = 87.918, ['h'] = 178.0 },
	[205] = { ['x'] = -623.207, ['y'] = 311.88, ['z'] = 83.9285, ['h'] = 255.0 },
	[206] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[207] = { ['x'] = -729.856, ['y'] = 321.271, ['z'] = 86.78, ['h'] = 84.0 },
	[208] = { ['x'] = -784.225, ['y'] = 351.657, ['z'] = 87.9982, ['h'] = 359.0 },
	[209] = { ['x'] = -753.214, ['y'] = 275.973, ['z'] = 85.7562, ['h'] = 96.0 },
	[210] = { ['x'] = -669.732, ['y'] = 214.22, ['z'] = 81.9552, ['h'] = 289.0 },
	[211] = { ['x'] = -286.839, ['y'] = 482.213, ['z'] = 113.201, ['h'] = 299.0 },
	[212] = { ['x'] = -369.282, ['y'] = 468.074, ['z'] = 112.462, ['h'] = 100.0 },
	[213] = { ['x'] = -337.886, ['y'] = 529.252, ['z'] = 120.149, ['h'] = 316.0 },
	[214] = { ['x'] = -401.036, ['y'] = 491.448, ['z'] = 120.299, ['h'] = 151.0 },
	[215] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[216] = { ['x'] = -440.16, ['y'] = 519.96, ['z'] = 122.159, ['h'] = 131.0 },
	[217] = { ['x'] = -408.427, ['y'] = 583.4, ['z'] = 124.627, ['h'] = 330.0 },
	[218] = { ['x'] = -471.6, ['y'] = 524.021, ['z'] = 125.728, ['h'] = 175.0 }
}




robberyExitCoords = {
	[1] = { ['x'] = 1050.16, ['y'] = -369.431, ['z'] = 68.2395, ['h'] = 36.0 },
	[2] = { ['x'] = 1021.07, ['y'] = -414.099, ['z'] = 66.1394, ['h'] = 127.0 },
	[3] = { ['x'] = 1003.1, ['y'] = -423.892, ['z'] = 65.3468, ['h'] = 135.0 },
	[4] = { ['x'] = 976.419, ['y'] = -436.9, ['z'] = 63.7452, ['h'] = 32.0 },
	[5] = { ['x'] = 962.334, ['y'] = -445.739, ['z'] = 62.6005, ['h'] = 302.0 },
	[6] = { ['x'] = 940.967, ['y'] = -452.002, ['z'] = 61.2523, ['h'] = 301.0 },
	[7] = { ['x'] = 918.33, ['y'] = -464.81, ['z'] = 61.0837, ['h'] = 14.0 },
	[8] = { ['x'] = 899.699, ['y'] = -474.118, ['z'] = 59.4362, ['h'] = 17.0 },
	[9] = { ['x'] = 869.233, ['y'] = -496.407, ['z'] = 57.6431, ['h'] = 39.0 },
	[10] = { ['x'] = 854.784, ['y'] = -516.325, ['z'] = 57.3284, ['h'] = 135.0 },
	[11] = { ['x'] = 834.426, ['y'] = -534.352, ['z'] = 57.5249, ['h'] = 87.0 },
	[12] = { ['x'] = 832.439, ['y'] = -561.425, ['z'] = 57.7079, ['h'] = 7.0 },
	[13] = { ['x'] = 850.473, ['y'] = -588.86, ['z'] = 57.9599, ['h'] = 138.0 },
	[14] = { ['x'] = 879.462, ['y'] = -609.731, ['z'] = 58.4422, ['h'] = 130.0 },
	[15] = { ['x'] = 891.181, ['y'] = -625.312, ['z'] = 58.2605, ['h'] = 133.0 },
	[16] = { ['x'] = 918.145, ['y'] = -648.733, ['z'] = 58.0587, ['h'] = 137.0 },
	[17] = { ['x'] = 939.002, ['y'] = -661.203, ['z'] = 58.014, ['h'] = 128.0 },
	[18] = { ['x'] = 944.432, ['y'] = -678.173, ['z'] = 58.4498, ['h'] = 115.0 },
	[19] = { ['x'] = 959.017, ['y'] = -704.345, ['z'] = 58.477, ['h'] = 121.0 },
	[20] = { ['x'] = 982.211, ['y'] = -726.873, ['z'] = 58.0258, ['h'] = 220.0 },
	[21] = { ['x'] = 987.213, ['y'] = -734.519, ['z'] = 57.8157, ['h'] = 126.0 },
	[22] = { ['x'] = 993.753, ['y'] = -620.756, ['z'] = 59.0431, ['h'] = 305.0 },
	[23] = { ['x'] = 906.134, ['y'] = -536.564, ['z'] = 58.5069, ['h'] = 285.0 },
	[24] = { ['x'] = 932.317, ['y'] = -530.707, ['z'] = 59.3417, ['h'] = 199.0 },
	[25] = { ['x'] = 952.696, ['y'] = -524.033, ['z'] = 60.6436, ['h'] = 212.0 },
	[26] = { ['x'] = 972.118, ['y'] = -514.475, ['z'] = 62.1361, ['h'] = 212.0 },
	[27] = { ['x'] = 1023.54, ['y'] = -472.679, ['z'] = 64.0556, ['h'] = 218.0 },
	[28] = { ['x'] = 1123.57, ['y'] = -390.138, ['z'] = 68.5005, ['h'] = 240.0 },
	[29] = { ['x'] = 1257.39, ['y'] = -437.555, ['z'] = 69.5674, ['h'] = 108.0 },
	[30] = { ['x'] = 1250.28, ['y'] = -461.362, ['z'] = 70.2796, ['h'] = 91.0 },
	[31] = { ['x'] = 1249.19, ['y'] = -473.534, ['z'] = 70.183, ['h'] = 85.0 },
	[32] = { ['x'] = 1244.66, ['y'] = -502.716, ['z'] = 69.7121, ['h'] = 166.0 },
	[33] = { ['x'] = 1241.05, ['y'] = -510.333, ['z'] = 69.3491, ['h'] = 69.0 },
	[34] = { ['x'] = 1230.21, ['y'] = -561.59, ['z'] = 69.6558, ['h'] = 86.0 },
	[35] = { ['x'] = 1234.31, ['y'] = -597.905, ['z'] = 69.7801, ['h'] = 88.0 },
	[36] = { ['x'] = 1239.3, ['y'] = -623.331, ['z'] = 69.3586, ['h'] = 27.0 },
	[37] = { ['x'] = 1257.57, ['y'] = -660.436, ['z'] = 67.9229, ['h'] = 214.0 },
	[38] = { ['x'] = 1259.65, ['y'] = -687.33, ['z'] = 66.0316, ['h'] = 87.0 },
	[39] = { ['x'] = 1259.6, ['y'] = -711.274, ['z'] = 64.5067, ['h'] = 146.0 },
	[40] = { ['x'] = 1309.37, ['y'] = -511.344, ['z'] = 71.4607, ['h'] = 333.0 },
	[41] = { ['x'] = 1335.48, ['y'] = -522.574, ['z'] = 72.2481, ['h'] = 343.0 },
	[42] = { ['x'] = 1355.02, ['y'] = -531.362, ['z'] = 73.8917, ['h'] = 343.0 },
	[43] = { ['x'] = 1380.56, ['y'] = -542.445, ['z'] = 74.493, ['h'] = 336.0 },
	[44] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[45] = { ['x'] = 1399.29, ['y'] = -603.883, ['z'] = 74.4855, ['h'] = 234.0 },
	[46] = { ['x'] = 1367.04, ['y'] = -623.296, ['z'] = 74.7109, ['h'] = 180.0 },
	[47] = { ['x'] = 1330.79, ['y'] = -608.409, ['z'] = 74.5081, ['h'] = 144.0 },
	[48] = { ['x'] = 1315.91, ['y'] = -598.107, ['z'] = 73.2464, ['h'] = 153.0 },
	[49] = { ['x'] = 1295.77, ['y'] = -590.212, ['z'] = 71.7323, ['h'] = 164.0 },
	[50] = { ['x'] = 1446.63, ['y'] = -1482.28, ['z'] = 63.6212, ['h'] = 338.0 },
	[51] = { ['x'] = 1391.01, ['y'] = -1508.39, ['z'] = 58.4358, ['h'] = 33.0 },
	[52] = { ['x'] = 1344.81, ['y'] = -1513.26, ['z'] = 54.5857, ['h'] = 357.0 },
	[53] = { ['x'] = 1311.69, ['y'] = -1515.27, ['z'] = 51.8117, ['h'] = 4.0 },
	[54] = { ['x'] = 1228.41, ['y'] = -1577.24, ['z'] = 53.5565, ['h'] = 30.0 },
	[55] = { ['x'] = 1203.95, ['y'] = -1594.63, ['z'] = 50.7435, ['h'] = 26.0 },
	[56] = { ['x'] = 1184.0, ['y'] = -1611.2, ['z'] = 45.2209, ['h'] = 36.0 },
	[57] = { ['x'] = 1203.27, ['y'] = -1670.63, ['z'] = 42.9817, ['h'] = 215.0 },
	[58] = { ['x'] = 1220.14, ['y'] = -1658.76, ['z'] = 48.6416, ['h'] = 208.0 },
	[59] = { ['x'] = 1252.63, ['y'] = -1638.55, ['z'] = 53.2072, ['h'] = 207.0 },
	[60] = { ['x'] = 1276.36, ['y'] = -1628.96, ['z'] = 54.543, ['h'] = 212.0 },
	[61] = { ['x'] = 1297.1, ['y'] = -1618.03, ['z'] = 54.5775, ['h'] = 192.0 },
	[62] = { ['x'] = 1330.81, ['y'] = -1559.66, ['z'] = 54.0515, ['h'] = 223.0 },
	[63] = { ['x'] = 1361.84, ['y'] = -1568.36, ['z'] = 56.3538, ['h'] = 193.0 },
	[64] = { ['x'] = 1389.98, ['y'] = -1546.35, ['z'] = 57.1072, ['h'] = 34.0 },
	[65] = { ['x'] = 1369.06, ['y'] = -1735.37, ['z'] = 65.6303, ['h'] = 188.0 },
	[66] = { ['x'] = 1321.22, ['y'] = -1745.97, ['z'] = 54.7014, ['h'] = 197.0 },
	[67] = { ['x'] = 1300.47, ['y'] = -1752.43, ['z'] = 54.2713, ['h'] = 104.0 },
	[68] = { ['x'] = 1263.03, ['y'] = -1773.29, ['z'] = 49.6573, ['h'] = 201.0 },
	[69] = { ['x'] = 1244.19, ['y'] = -1722.22, ['z'] = 52.0243, ['h'] = 24.0 },
	[70] = { ['x'] = 1283.76, ['y'] = -1699.89, ['z'] = 55.4751, ['h'] = 25.0 },
	[71] = { ['x'] = 1315.03, ['y'] = -1684.94, ['z'] = 58.2329, ['h'] = 15.0 },
	[72] = { ['x'] = 1337.64, ['y'] = -1688.8, ['z'] = 60.5184, ['h'] = 81.0 },
	[73] = { ['x'] = -46.3021, ['y'] = -1771.48, ['z'] = 28.0876, ['h'] = 48.0 },
	[74] = { ['x'] = -29.7425, ['y'] = -1787.78, ['z'] = 27.8203, ['h'] = 300.0 },
	[75] = { ['x'] = 29.7196, ['y'] = -1832.62, ['z'] = 24.6007, ['h'] = 323.0 },
	[76] = { ['x'] = 39.525, ['y'] = -1845.02, ['z'] = 24.0588, ['h'] = 218.0 },
	[77] = { ['x'] = 56.9605, ['y'] = -1853.58, ['z'] = 23.2871, ['h'] = 315.0 },
	[78] = { ['x'] = 64.8814, ['y'] = -1864.15, ['z'] = 22.7985, ['h'] = 306.0 },
	[79] = { ['x'] = 105.383, ['y'] = -1900.98, ['z'] = 21.4066, ['h'] = 332.0 },
	[80] = { ['x'] = 122.743, ['y'] = -1910.01, ['z'] = 21.3163, ['h'] = 324.0 },
	[81] = { ['x'] = 138.976, ['y'] = -1921.69, ['z'] = 21.3808, ['h'] = 292.0 },
	[82] = { ['x'] = 118.249, ['y'] = -1974.3, ['z'] = 21.3223, ['h'] = 204.0 },
	[83] = { ['x'] = 75.7193, ['y'] = -1970.01, ['z'] = 21.1252, ['h'] = 128.0 },
	[84] = { ['x'] = 67.9144, ['y'] = -1960.05, ['z'] = 21.1675, ['h'] = 136.0 },
	[85] = { ['x'] = 64.0576, ['y'] = -1948.15, ['z'] = 21.3685, ['h'] = 126.0 },
	[86] = { ['x'] = 47.1782, ['y'] = -1932.79, ['z'] = 21.9035, ['h'] = 141.0 },
	[87] = { ['x'] = 30.4997, ['y'] = -1923.88, ['z'] = 21.9569, ['h'] = 139.0 },
	[88] = { ['x'] = 16.3038, ['y'] = -1906.7, ['z'] = 22.9652, ['h'] = 138.0 },
	[89] = { ['x'] = 3.05277, ['y'] = -1893.08, ['z'] = 23.6959, ['h'] = 210.0 },
	[90] = { ['x'] = -10.4963, ['y'] = -1883.65, ['z'] = 24.1416, ['h'] = 230.0 },
	[91] = { ['x'] = -29.2414, ['y'] = -1869.56, ['z'] = 25.3351, ['h'] = 231.0 },
	[92] = { ['x'] = -42.6142, ['y'] = -1859.04, ['z'] = 26.1948, ['h'] = 132.0 },
	[93] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[94] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[95] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[96] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[97] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[98] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[99] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[100] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[101] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[102] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[103] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[104] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[105] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[106] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[107] = { ['x'] = -158.121, ['y'] = -1629.52, ['z'] = 37.4674, ['h'] = 48.0 },
	[108] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[109] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[110] = { ['x'] = -165.35, ['y'] = -1614.55, ['z'] = 34.0912, ['h'] = 55.0 },
	[111] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[112] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[113] = { ['x'] = -165.686, ['y'] = -1615.24, ['z'] = 37.382, ['h'] = 65.0 },
	[114] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[115] = { ['x'] = -118.701, ['y'] = -1564.27, ['z'] = 34.5801, ['h'] = 321.0 },
	[116] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[117] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[118] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[119] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[120] = { ['x'] = -157.778, ['y'] = -1595.88, ['z'] = 34.9205, ['h'] = 52.0 },
	[121] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[122] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[123] = { ['x'] = -119.017, ['y'] = -1563.91, ['z'] = 37.4142, ['h'] = 329.0 },
	[124] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[125] = { ['x'] = -103.274, ['y'] = -1577.19, ['z'] = 37.4142, ['h'] = 327.0 },
	[126] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[127] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[128] = { ['x'] = -157.547, ['y'] = -1595.3, ['z'] = 37.8084, ['h'] = 58.0 },
	[129] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[130] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[131] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[132] = { ['x'] = 21.0753, ['y'] = -1432.44, ['z'] = 30.9509, ['h'] = 335.0 },
	[133] = { ['x'] = 3.37753, ['y'] = -1430.26, ['z'] = 30.9557, ['h'] = 352.0 },
	[134] = { ['x'] = -32.3522, ['y'] = -1432.79, ['z'] = 31.8826, ['h'] = 266.0 },
	[135] = { ['x'] = -48.0192, ['y'] = -1430.98, ['z'] = 32.4209, ['h'] = 4.0 },
	[136] = { ['x'] = -66.8769, ['y'] = -1436.29, ['z'] = 32.526, ['h'] = 96.0 },
	[137] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[138] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[139] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[140] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[141] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[142] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[143] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[144] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[145] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[146] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[147] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[148] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[149] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[150] = { ['x'] = -204.159, ['y'] = -1549.78, ['z'] = 37.9307, ['h'] = 52.0 },
	[151] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[152] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[153] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[154] = { ['x'] = -198.45, ['y'] = -1598.19, ['z'] = 34.9031, ['h'] = 263.0 },
	[155] = { ['x'] = -201.04, ['y'] = -1612.09, ['z'] = 34.9031, ['h'] = 250.0 },
	[156] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[157] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[158] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[159] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[160] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[161] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[162] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[163] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[164] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[165] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[166] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[167] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[168] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[169] = { ['x'] = -232.055, ['y'] = -1620.07, ['z'] = 38.1289, ['h'] = 97.0 },
	[170] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[171] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[172] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[173] = { ['x'] = -200.6, ['y'] = -1605.18, ['z'] = 38.3317, ['h'] = 258.0 },
	[174] = { ['x'] = -212.476, ['y'] = -1683.01, ['z'] = 34.8503, ['h'] = 174.0 },
	[175] = { ['x'] = -231.161, ['y'] = -1683.01, ['z'] = 34.8503, ['h'] = 173.0 },
	[176] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[177] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[178] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[179] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[180] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[181] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[182] = { ['x'] = -231.232, ['y'] = -1683.02, ['z'] = 37.6224, ['h'] = 179.0 },
	[183] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[184] = { ['x'] = -233.191, ['y'] = -1649.58, ['z'] = 38.002, ['h'] = 76.0 },
	[185] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[186] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[187] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[188] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[189] = { ['x'] = 213.806, ['y'] = -1884.49, ['z'] = 24.813, ['h'] = 323.0 },
	[190] = { ['x'] = 197.061, ['y'] = -1871.88, ['z'] = 25.057, ['h'] = 335.0 },
	[191] = { ['x'] = 176.333, ['y'] = -1857.69, ['z'] = 24.3915, ['h'] = 331.0 },
	[192] = { ['x'] = 156.55, ['y'] = -1852.71, ['z'] = 24.5839, ['h'] = 338.0 },
	[193] = { ['x'] = 135.818, ['y'] = -1842.49, ['z'] = 25.2339, ['h'] = 333.0 },
	[194] = { ['x'] = 94.7125, ['y'] = -1895.32, ['z'] = 24.3114, ['h'] = 141.0 },
	[195] = { ['x'] = 112.932, ['y'] = -1900.37, ['z'] = 23.9315, ['h'] = 233.0 },
	[196] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 233.0 },
	[197] = { ['x'] = 128.334, ['y'] = -1906.1, ['z'] = 23.6723, ['h'] = 242.0 },
	[198] = { ['x'] = -1084.46, ['y'] = -1559.07, ['z'] = 4.78279, ['h'] = 31.0 },
	[199] = { ['x'] = -1076.89, ['y'] = -1554.03, ['z'] = 4.6303, ['h'] = 46.0 },
	[200] = { ['x'] = -1063.67, ['y'] = -1557.76, ['z'] = 5.14176, ['h'] = 126.0 },
	[201] = { ['x'] = -108.55, ['y'] = -1488.05, ['z'] = 34.1594, ['h'] = 229.0 },
	[202] = { ['x'] = -96.661, ['y'] = -1473.85, ['z'] = 34.1594, ['h'] = 217.0 },
	[203] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[204] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[205] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[206] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[207] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[208] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[209] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[210] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[211] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[212] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[213] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[214] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[215] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[216] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[217] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[218] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[219] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[220] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[221] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[222] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[223] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[224] = { ['x'] = 1404.48, ['y'] = -563.109, ['z'] = 74.4965, ['h'] = 294.0 },
	[225] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[226] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[227] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[228] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[229] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[230] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[231] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[232] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[233] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[234] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[235] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[236] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[237] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[238] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[239] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[240] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[241] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[242] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[243] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[244] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[245] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[246] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[247] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[248] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[249] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[250] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[251] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[252] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[253] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[254] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[255] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[256] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[257] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[258] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[259] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[260] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[261] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[262] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[263] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[264] = { ['x'] = 240.807, ['y'] = -1662.47, ['z'] = 29.6646, ['h'] = 45.0 },
	[265] = { ['x'] = 230.935, ['y'] = -1678.15, ['z'] = 29.6922, ['h'] = 48.0 },
	[266] = { ['x'] = 220.447, ['y'] = -1689.27, ['z'] = 29.6923, ['h'] = 39.0 },
	[267] = { ['x'] = 208.595, ['y'] = -1706.14, ['z'] = 29.678, ['h'] = 131.0 },
	[268] = { ['x'] = 192.676, ['y'] = -1711.92, ['z'] = 29.6651, ['h'] = 20.0 },
	[269] = { ['x'] = 158.095, ['y'] = -1835.94, ['z'] = 27.8559, ['h'] = 229.0 },
	[270] = { ['x'] = 259.607, ['y'] = -1740.49, ['z'] = 29.6612, ['h'] = 228.0 },
	[271] = { ['x'] = 269.065, ['y'] = -1728.61, ['z'] = 29.6455, ['h'] = 317.0 },
	[272] = { ['x'] = 278.521, ['y'] = -1715.2, ['z'] = 29.6664, ['h'] = 321.0 },
	[273] = { ['x'] = 291.901, ['y'] = -1701.82, ['z'] = 29.6479, ['h'] = 221.0 },
	[274] = { ['x'] = 320.765, ['y'] = -1732.7, ['z'] = 29.7216, ['h'] = 54.0 },
	[275] = { ['x'] = 310.893, ['y'] = -1750.29, ['z'] = 29.6304, ['h'] = 45.0 },
	[276] = { ['x'] = 295.449, ['y'] = -1767.43, ['z'] = 29.1026, ['h'] = 35.0 },
	[277] = { ['x'] = 288.206, ['y'] = -1775.43, ['z'] = 28.4192, ['h'] = 54.0 },
	[278] = { ['x'] = 285.535, ['y'] = -1783.77, ['z'] = 28.086, ['h'] = 323.0 },
	[279] = { ['x'] = 170.703, ['y'] = -1924.1, ['z'] = 21.1857, ['h'] = 143.0 },
	[280] = { ['x'] = 155.193, ['y'] = -1935.35, ['z'] = 20.23, ['h'] = 57.0 },
	[281] = { ['x'] = 139.872, ['y'] = -1952.64, ['z'] = 19.4581, ['h'] = 44.0 },
	[282] = { ['x'] = 131.66, ['y'] = -1961.68, ['z'] = 18.859, ['h'] = 58.0 },
	[283] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[284] = { ['x'] = 260.212, ['y'] = -1945.14, ['z'] = 24.7021, ['h'] = 226.0 },
	[285] = { ['x'] = 269.755, ['y'] = -1932.84, ['z'] = 25.4362, ['h'] = 323.0 },
	[286] = { ['x'] = 279.145, ['y'] = -1919.32, ['z'] = 26.1697, ['h'] = 320.0 },
	[287] = { ['x'] = 292.825, ['y'] = -1906.21, ['z'] = 27.2702, ['h'] = 232.0 },
	[288] = { ['x'] = 329.382, ['y'] = -1864.37, ['z'] = 27.5042, ['h'] = 230.0 },
	[289] = { ['x'] = 340.672, ['y'] = -1849.81, ['z'] = 27.7638, ['h'] = 328.0 },
	[290] = { ['x'] = 348.393, ['y'] = -1839.2, ['z'] = 28.3365, ['h'] = 134.0 },
	[291] = { ['x'] = 360.685, ['y'] = -1829.24, ['z'] = 28.8903, ['h'] = 230.0 },
	[292] = { ['x'] = 416.187, ['y'] = -1759.95, ['z'] = 29.7091, ['h'] = 321.0 },
	[293] = { ['x'] = 430.605, ['y'] = -1741.27, ['z'] = 29.604, ['h'] = 307.0 },
	[294] = { ['x'] = 440.203, ['y'] = -1728.01, ['z'] = 29.6002, ['h'] = 314.0 },
	[295] = { ['x'] = 453.512, ['y'] = -1714.6, ['z'] = 29.7097, ['h'] = 225.0 },
	[296] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[297] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[298] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[299] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[300] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[301] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[302] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[303] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[304] = { ['x'] = 478.025, ['y'] = -1710.32, ['z'] = 29.7062, ['h'] = 72.0 },
	[305] = { ['x'] = 465.601, ['y'] = -1731.92, ['z'] = 29.1523, ['h'] = 71.0 },
	[306] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 233.0 },
	[307] = { ['x'] = 465.432, ['y'] = -1748.54, ['z'] = 29.0851, ['h'] = 67.0 },
	[308] = { ['x'] = 429.443, ['y'] = -1820.18, ['z'] = 28.3583, ['h'] = 43.0 },
	[309] = { ['x'] = 417.937, ['y'] = -1832.31, ['z'] = 28.4631, ['h'] = 134.0 },
	[310] = { ['x'] = 401.66, ['y'] = -1849.46, ['z'] = 27.3197, ['h'] = 132.0 },
	[311] = { ['x'] = 390.48, ['y'] = -1861.77, ['z'] = 26.7113, ['h'] = 134.0 },
	[312] = { ['x'] = 375.822, ['y'] = -1873.41, ['z'] = 26.035, ['h'] = 39.0 },
	[313] = { ['x'] = 357.387, ['y'] = -1885.69, ['z'] = 25.18, ['h'] = 40.0 },
	[314] = { ['x'] = 315.671, ['y'] = -1937.43, ['z'] = 24.8138, ['h'] = 139.0 },
	[315] = { ['x'] = 302.25, ['y'] = -1946.64, ['z'] = 24.6092, ['h'] = 55.0 },
	[316] = { ['x'] = 286.786, ['y'] = -1963.83, ['z'] = 22.9009, ['h'] = 39.0 },
	[317] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 233.0 },
	[318] = { ['x'] = 279.592, ['y'] = -1971.78, ['z'] = 21.5813, ['h'] = 47.0 },
	[319] = { ['x'] = 250.782, ['y'] = -2011.95, ['z'] = 19.2588, ['h'] = 54.0 },
	[320] = { ['x'] = 240.661, ['y'] = -2021.45, ['z'] = 18.7072, ['h'] = 132.0 },
	[321] = { ['x'] = 224.657, ['y'] = -2036.36, ['z'] = 18.1768, ['h'] = 58.0 },
	[322] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[323] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[324] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[325] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[326] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[327] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[328] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[329] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[330] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[331] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[332] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[333] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[334] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[335] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[336] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[337] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[338] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[339] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[340] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[341] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[342] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[343] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[344] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[345] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[346] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[347] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[348] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[349] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[350] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[351] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[352] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[353] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[354] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[355] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[356] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[357] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[358] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[359] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[360] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[361] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[362] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[363] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[364] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[365] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[366] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[367] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[368] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[369] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[370] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[371] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[372] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[373] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[374] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[375] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[376] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[377] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[378] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[379] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[380] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[381] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[382] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[383] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[384] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[385] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[386] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[387] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[388] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[389] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[390] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[391] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[392] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[393] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[394] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[395] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[396] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[397] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[398] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[399] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[400] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[401] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[402] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[403] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[404] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[405] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[406] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[407] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[408] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[409] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[410] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[411] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[412] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[413] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[414] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[415] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[416] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[417] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[418] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[419] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[420] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[421] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[422] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[423] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[424] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[425] = { ['x'] = -948.239, ['y'] = -951.487, ['z'] = 2.14531, ['h'] = 123.0 },
	[426] = { ['x'] = -960.719, ['y'] = -941.413, ['z'] = 2.14531, ['h'] = 125.0 },
	[427] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[428] = { ['x'] = -975.323, ['y'] = -909.596, ['z'] = 2.34262, ['h'] = 29.0 },
	[429] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[430] = { ['x'] = -987.459, ['y'] = -891.585, ['z'] = 2.15068, ['h'] = 206.0 },
	[431] = { ['x'] = -998.293, ['y'] = -904.541, ['z'] = 2.74627, ['h'] = 201.0 },
	[432] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[433] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[434] = { ['x'] = -1019.74, ['y'] = -895.29, ['z'] = 8.75882, ['h'] = 20.0 },
	[435] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[436] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[437] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[438] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[439] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[440] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[441] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[442] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[443] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[444] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[445] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[446] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[447] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[448] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[449] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[450] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[451] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[452] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[453] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[454] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[455] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[456] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[457] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[458] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[459] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 },
	[460] = { ['x'] = 0.0, ['y'] = 0.0, ['z'] = 0.0, ['h'] = 0.0 }
}


function buildTrevor()
	SetEntityCoords(PlayerPedId(),-1153.18300000 ,-1518.34800000, 9.63082300)
	Wait(1200)

	local generator = { x = curHouseCoords["x"] , y = curHouseCoords["y"], z = curHouseCoords["z"] - 35.0}
	SetEntityCoords(PlayerPedId(), generator.x, generator.y-4,generator.z+3.0)
	RequestModel(GetHashKey("shell_trevor"))
	while not HasModelLoaded(GetHashKey("shell_trevor")) do 
		Wait(0) 
	end
	local building = CreateObject(GetHashKey("shell_trevor"),generator.x+0.42222900,generator.y-0.13131700,generator.z+1.18855100,false,false,false)
	FreezeEntityPosition(building,true)
	SetEntityCoordsNoOffset(PlayerPedId(),curHouseCoords["x"] + 0.57,curHouseCoords["y"] - 3.97,curHouseCoords["z"] - 31.38)
	SetEntityHeading(PlayerPedId(),267.0)
	SetGameplayCamRelativeHeading(0.0)

end


function buildApartment(heading)
	SetEntityCoords(PlayerPedId(), 152.09986877441 , -1004.7946166992, -98.999984741211)
	Wait(1300)
	local generator = { x = curHouseCoords["x"] , y = curHouseCoords["y"], z = curHouseCoords["z"] - 28.0}
	Citizen.Wait(1500)
	RequestModel(GetHashKey('shell_v16low'))
	while not HasModelLoaded(GetHashKey('shell_v16low')) do 
		Wait(0) 
	end
	local building = CreateObject(GetHashKey('shell_v16low'),generator.x,generator.y,generator.z,false,false,false)

	FreezeEntityPosition(building,true)
	Citizen.Wait(600)
	SetEntityCoordsNoOffset(PlayerPedId(),curHouseCoords["x"] + 4.67,curHouseCoords["y"] - 6.56,curHouseCoords["z"] - 26.97)


end


function buildHouse()
	SetEntityCoords(PlayerPedId(), 152.09986877441 , -1004.7946166992, -98.999984741211)
	Wait(1300)
	local generator = { x = curHouseCoords["x"] , y = curHouseCoords["y"], z = curHouseCoords["z"] - 28.0}
	Citizen.Wait(1500)
	RequestModel(GetHashKey('shell_v16mid'))
	while not HasModelLoaded(GetHashKey('shell_v16mid')) do 
		Wait(0) 
	end
	local building = CreateObject(GetHashKey('shell_v16mid'),generator.x,generator.y,generator.z,false,false,false)

	FreezeEntityPosition(building,true)
	Citizen.Wait(600)
	SetEntityCoordsNoOffset(PlayerPedId(),curHouseCoords["x"] + 2, curHouseCoords["y"] - 14, curHouseCoords["z"] - 26.97)

end

function buildFranklin()
	SetEntityCoords(PlayerPedId(), 152.09986877441 , -1004.7946166992, -98.999984741211)
	Wait(1300)
	local generator = { x = curHouseCoords["x"] , y = curHouseCoords["y"], z = curHouseCoords["z"] - 28.0}
	Citizen.Wait(1500)
	RequestModel(GetHashKey('shell_apartment3'))
	while not HasModelLoaded(GetHashKey('shell_apartment3')) do 
		Wait(0) 
	end
	local building = CreateObject(GetHashKey('shell_apartment3'),generator.x,generator.y,generator.z,false,false,false)

	FreezeEntityPosition(building,true)
	Citizen.Wait(600)
	--x--  - forward + backward
	--y -- + right - left
	--z -- + down - up
	SetEntityCoordsNoOffset(PlayerPedId(),curHouseCoords["x"] + 11.8, curHouseCoords["y"] + 4.7, curHouseCoords["z"] - 17)
	
end


function buildMansionBasic()
	SetEntityCoords(PlayerPedId(), 152.09986877441 , -1004.7946166992, -98.999984741211)
	Wait(1300)
	local generator = { x = curHouseCoords["x"] , y = curHouseCoords["y"], z = curHouseCoords["z"] - 28.0}
	Citizen.Wait(1500)
	RequestModel(GetHashKey('shell_apartment2'))
	while not HasModelLoaded(GetHashKey('shell_apartment2')) do 
		Wait(0) 
	end
	local building = CreateObject(GetHashKey('shell_apartment2'),generator.x,generator.y,generator.z,false,false,false)

	FreezeEntityPosition(building,true)
	Citizen.Wait(600)
	SetEntityCoordsNoOffset(PlayerPedId(),curHouseCoords["x"] - 1.6, curHouseCoords["y"] + 9.2, curHouseCoords["z"] - 19.1)
end

-- function buildMansion()
-- 	SetEntityCoords(PlayerPedId(),-801.5,178.69,72.84) -- Default Garage location
-- 	Wait(1300)
-- 	local generator = { x = curHouseCoords["x"] , y = curHouseCoords["y"], z = curHouseCoords["z"] - 34.0}

-- 	local building = CreateObject(GetHashKey('shell_michael'),generator.x+3.57921200,generator.y+3.70079500,generator.z+0.045,false,false,false)

-- 	SetEntityCoords(PlayerPedId(), generator.x-5.5793 , generator.y+5.100, generator.z)
-- 	SetEntityHeading(PlayerPedId(),267.0)
-- 	SetGameplayCamRelativeHeading(0.0)
-- end

function buildTrailer()
	trailer = true
	DoScreenFadeOut(100)

	while IsScreenFadingOut() do
		Citizen.Wait(10)
	end

	SetEntityCoords(PlayerPedId(), 1040.64, 2676.53, -150.61)
	FreezeEntityPosition(PlayerPedId(),true)

	RequestModel(`shell_trailer`)
	while not HasModelLoaded(`shell_trailer`)
	do
		Citizen.Wait(100)
	end

	local generator = { x = curHouseCoords["x"] , y = curHouseCoords["y"], z = curHouseCoords["z"] - 75.0}
	loadedShell = CreateObject(`shell_trailer`, generator.x, generator.y, generator.z, false, false, false)
	FreezeEntityPosition(loadedShell, true)
	
	FloatTilSafeR(loadedShell)
	
	SetEntityCoords(PlayerPedId(), generator.x - 1.443, generator.y - 1.892, generator.z+1.7)
	SetEntityHeading(PlayerPedId(), 359.00)
	FreezeEntityPosition(PlayerPedId(), false)
	DoScreenFadeIn(100)
	while IsScreenFadingIn()
	do
		Citizen.Wait(100)
	end
end

