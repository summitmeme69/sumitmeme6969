safeLocations = {
    [1] =  { x = 28.26,y = -1339.25,z = 29.5, h = 356.94, robbed = false},
	[2] =  { x = -43.44,y = -1748.46,z = 29.43, h = 48.64, robbed = false},
	[3] =  { x = -709.67,y = -904.19,z = 19.22, h = 84.34, robbed = false},
	[4] =  { x = -1220.84,y = -915.88,z = 11.33, h = 125.89, robbed = false},
	[5] =  { x = 1159.78,y = -314.06,z = 69.21, h = 99.31, robbed = false},
	[6] =  { x = 378.08,y = 333.37,z = 103.57, h = 338.48, robbed = false},
	[7] =  { x = -1829.03,y = 798.92,z = 138.19, h = 127.41, robbed = false},
	[8] =  { x = -2959.64,y = 387.16,z = 14.05, h = 173.43, robbed = false},
	[9] =  { x = -3047.55,y = 585.67,z = 7.91, h = 104.0, robbed = false},
	[10] =  { x = -3249.92,y = 1004.42,z = 12.84, h = 81.06, robbed = false},
	[11] =  { x = 2549.25,y = 384.91,z = 108.63, h = 84.09, robbed = false},
	[12] =  { x = 1169.24,y = 2717.96,z = 37.16, h = 266.31, robbed = false},
	[13] =  { x = 546.42,y = 2663.01, z = 42.16, h = 186.64, robbed = false},
	[14] =  { x = 1959.27,y = 3748.78,z = 32.35, h = 26.58, robbed = false},
	[15] =  { x = 2672.89,y = 3286.54,z = 55.25, h = 60.89, robbed = false},
	[16] =  { ['x'] = 0.0,['y'] = 0.0,['z'] = 0.0, h = 60.89, robbed = false},
	[17] =  { x = 1707.66, y = 4920.13,z = 42.07, h = 320.34, robbed = false},
	[18] =  { x = 1734.69,y = 6420.48,z = 35.04, h = 332.9, robbed = false}
}

storePedLocations = {
    [1] =  { x = 24.18, y = -1347.35, z = 29.5, h = 271.32, recent = false, registers = {}},
	[2] =  { x = -46.56, y = -1757.98, z = 29.43, h = 48.68, recent = false, registers = {}},
	[3] =  { x = -706.02, y = -913.61, z = 19.22, h = 85.61,  recent = false, registers = {}},
	[4] =  { x = -1221.97, y = -908.42,z = 12.33, h = 31.1, recent = false, registers = {}},
	[5] =  { x = 1164.99, y = -322.78, z = 69.21, h = 96.91,  recent = false, registers = {}},
	[6] =  { x = 372.25, y = 326.43, z = 103.57, h = 252.9,  recent = false, registers = {}},
	[7] =  { x = -1819.98, y = 794.57, z = 138.09, h = 126.56, recent = false, registers = {}},
	[8] =  { x = -2966.24, y = 390.94, z = 15.05, h = 84.58,  recent = false, registers = {}},
	[9] =  { x = -3038.92, y = 584.21, z = 7.91, h = 19.43, recent = false, registers = {}},
	[10] =  { x = -3242.48, y = 999.79,z = 12.84, h = 351.35, recent = false, registers = {}},
	[11] =  { x = 2557.14, y = 380.64, z = 108.63, h = 353.01, recent = false, registers = {}},
	[12] =  { x = 1166.02, y = 2711.15, z = 38.16, h = 175.0, recent = false, registers = {}},
	[13] =  { x = 549.32, y = 2671.3, z = 42.16, h = 94.96, recent = false, registers = {}},
	[14] =  { x = 1959.96, y = 3739.99, z = 32.35, h = 296.38, recent = false, registers = {}},
	[15] =  { x = 2677.98, y = 3279.28, z = 55.25, h = 327.81, recent = false, registers = {}},
	[16] =  { x = 1392.88, y = 3606.7, z = 34.99, h = 201.69, recent = false, registers = {}},
	[17] =  { x = 1697.8, y = 4922.69, z = 42.07, h = 322.95, recent = false, registers = {}},
	[18] =  { x = 1728.82, y = 6417.38, z = 35.04, h = 233.94, recent = false, registers = {}}
}


RegisterServerEvent("police:camrobbery")
AddEventHandler("police:camrobbery", function(storeid)
    TriggerClientEvent("police:notifySecurityCam",-1,storeid)
end)

RegisterServerEvent('store:robbery:register')
AddEventHandler('store:robbery:register', function(storeid,RegisterObject)
    local src = source
	if storeid ~= nil then
		if storePedLocations[storeid].recent or #storePedLocations[storeid].registers >= 2 then 
			TriggerClientEvent('DoLongHudText', src, 'This store has been robbed recently.', 2)
			return
		end
		
		for i = 1, #storePedLocations[storeid].registers do
			if storePedLocations[storeid].registers[i] == RegisterObject then
				TriggerClientEvent('DoLongHudText', src, 'This register has been robbed already.', 2)
				return
			end
		end

		table.insert(storePedLocations[storeid].registers, RegisterObject)

		TriggerClientEvent('store:register', src, storeid, 1)
	end
end)

RegisterServerEvent('store:robbery:safe')
AddEventHandler('store:robbery:safe', function(storeid)
    local src = source
	if storeid ~= nil then
		if safeLocations[storeid].robbed then 
			TriggerClientEvent('DoLongHudText', src, 'This safe has been robbed recently.', 2)
			return
		end

		safeLocations[storeid].robbed = true

		TriggerClientEvent('store:dosafe', src, storeid, 1)
	end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1800000)
        for k, v in pairs(storePedLocations) do
            table.remove(storePedLocations, k)
        end
        for k, v in pairs(safeLocations) do
            table.remove(safeLocations, k)
        end
        print("^1[srp-robbery] Resetting All Stores / Safes^0")
    end
end)