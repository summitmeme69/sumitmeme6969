RegisterServerEvent('dispatch:svNotify')
AddEventHandler('dispatch:svNotify', function(data)
    if data.dispatchCode == "10-13A" then
        local recipientList = {
            police = "police",
            ems = "ems"
        }
        TriggerClientEvent('dispatch:clNotify',-1,{
            dispatchCode = "10-13A", 
            callSign = data.callSign, 
            dispatchMessage = "Officer Down URGENT!", 
            firstStreet = 
            data.firstStreet, 
            recipientList = recipientList, 
            playSound = true, 
            soundName = "10-1314", 
            isImportant = true, 
            priority = 3, 
            origin = data.origin, 
            blipSprite = 84, 
            blipColor = 1
        })
    elseif data.dispatchCode == "10-13B" then
        local recipientList = {
            police = "police",
            ems = "ems"
        }
        TriggerClientEvent('dispatch:clNotify', -1, { 
            dispatchCode = "10-13B", 
            callSign = data.callSign, 
            dispatchMessage = "Officer Down", 
            firstStreet = data.firstStreet,
            recipientList = recipientList, 
            playSound = false,
            soundName = "10-1314", 
            isImportant = false, 
            priority = 3, 
            origin = data.origin, 
            blipSprite = 84, 
            blipColor = 3
        })
    else
        TriggerClientEvent('dispatch:clNotify',-1, data)
    end
end)

RegisterCommand('togglealerts', function(source, args, user)
    local user = exports["srp-base"]:getModule("Player"):GetUser(source)
    if user:getVar("job") == "police" or user:getVar("job") == "ems" then
        TriggerClientEvent('dispatch:toggleNotifications', source, args[1])
    end
end)

RegisterCommand("callsign", function(source, args)
    local user = exports["srp-base"]:getModule("Player"):GetUser(source)
    local characterId = user:getVar("character").id
    if user:getVar("job") == "police" or user:getVar("job") == "ems" then
		exports.ghmattimysql:execute("UPDATE jobs_whitelist SET `callsign` = @callsign WHERE cid = @cid AND job = @job", {
			['callsign'] = args[1], 
			['cid'] = characterId,
            ['job'] = user:getVar("job")
		}) 
		TriggerClientEvent('police:setCallSign', source, args[1])
		TriggerClientEvent('DoLongHudText', source, 'Your callsign has been changed to: ' ..args[1])
	end
end)


RegisterServerEvent("dispatch:CallSign")
AddEventHandler("dispatch:CallSign", function()
    local user = exports["srp-base"]:getModule("Player"):GetUser(source)
    local characterId = user:getVar("character").id
    if user:getVar("job") == "police" or user:getVar("job") == "ems" then
		exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ? AND job = ?', {characterId, user:getVar("job")}, function(callback)
			Citizen.Wait(1500)
			TriggerClientEvent('police:setCallSign', source, callback[1].callsign)
		end)
	end
end)

