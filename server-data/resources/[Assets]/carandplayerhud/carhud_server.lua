local plateChangesReturn = {}

RegisterServerEvent('carfill:checkmoney')
AddEventHandler('carfill:checkmoney', function(costs, location)
	local src = source
	local player = exports["srp-base"]:getModule("Player"):GetUser(src)

	if player:getCash() >= costs then
		TriggerClientEvent("RefuelCarServerReturn", src)
		player:removeMoney(costs)
	else
		moneyleft = costs - player:getCash()
		TrigerClientEvent('DoLongHudText', src, "Requires $" .. costs)
	end
end)

RegisterServerEvent('GPSTrack:Accepted')
AddEventHandler('GPSTrack:Accepted', function(x,y,z,stage)
	local srcid = source
	TriggerClientEvent("GPSTrack:Accepted",-1,x,y,z,srcid,stage)
end)


RegisterServerEvent('car:spotlight')
AddEventHandler('car:spotlight', function(state)
	local serverID = source
	TriggerClientEvent('car:spotlight', -1, serverID, state)
end)

RegisterNetEvent("facewear:adjust")
AddEventHandler("facewear:adjust", function(pTargetId, pType, pShouldRemove)
	TriggerClientEvent("facewear:adjust", pTargetId, pType, pShouldRemove)
end)

RegisterCommand("anchor", function(source, args, rawCommand)
    TriggerClientEvent('client:anchor', source)
end)

RegisterServerEvent("actionclose")
AddEventHandler("actionclose", function(string, Coords)
	TriggerClientEvent("Do3DText", -1, string, source, Coords)
end)
