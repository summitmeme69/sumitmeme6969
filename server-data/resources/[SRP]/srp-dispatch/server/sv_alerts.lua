RegisterServerEvent("srp-alerts:teenA")
AddEventHandler("srp-alerts:teenA",function(targetCoords)
    TriggerClientEvent('srp-alerts:policealertA', -1, targetCoords)
	return
end)

RegisterServerEvent("srp-alerts:teenB")
AddEventHandler("srp-alerts:teenB",function(targetCoords)
    TriggerClientEvent('srp-alerts:policealertB', -1, targetCoords)
	return
end)

RegisterServerEvent("srp-alerts:teenpanic")
AddEventHandler("srp-alerts:teenpanic",function(targetCoords)
    TriggerClientEvent('srp-alerts:panic', -1, targetCoords)
	return
end)

RegisterServerEvent("srp-alerts:fourA")
AddEventHandler("srp-alerts:fourA",function(targetCoords)
    TriggerClientEvent('srp-alerts:tenForteenA', -1, targetCoords)
	return
end)

RegisterServerEvent("srp-alerts:fourB")
AddEventHandler("srp-alerts:fourB",function(targetCoords)
    TriggerClientEvent('srp-alerts:tenForteenB', -1, targetCoords)
	return
end)

RegisterServerEvent("srp-alerts:downperson")
AddEventHandler("srp-alerts:downperson",function(targetCoords)
    TriggerClientEvent('srp-alerts:downalert', -1, targetCoords)
	return
end)

RegisterServerEvent("srp-alerts:shoot")
AddEventHandler("srp-alerts:shoot",function(targetCoords)
    TriggerClientEvent('srp-outlawalert:gunshotInProgress', -1, targetCoords)
	return
end)

RegisterServerEvent("srp-alerts:storerob")
AddEventHandler("srp-alerts:storerob",function(targetCoords)
    TriggerClientEvent('srp-alerts:storerobbery', -1, targetCoords)
	return
end)

RegisterServerEvent("srp-alerts:crypto")
AddEventHandler("srp-alerts:crypto",function(targetCoords)
    TriggerClientEvent('srp-alerts:cryptohack', -1, targetCoords)
	return
end)

RegisterServerEvent("srp-alerts:houserob")
AddEventHandler("srp-alerts:houserob",function(targetCoords)
    TriggerClientEvent('srp-alerts:houserobbery', -1, targetCoords)
	return
end)

RegisterServerEvent("srp-alerts:tbank")
AddEventHandler("srp-alerts:tbank",function(targetCoords)
    TriggerClientEvent('srp-alerts:banktruck', -1, targetCoords)
	return
end)

RegisterServerEvent("srp-alerts:robjew")
AddEventHandler("srp-alerts:robjew",function()
    TriggerClientEvent('srp-alerts:jewelrobbey', -1)
	return
end)

RegisterServerEvent("srp-alerts:AlertUnion:sv")
AddEventHandler("srp-alerts:AlertUnion:sv",function()
    TriggerClientEvent('srp-alerts:AlertUnion:cl', -1)
	return
end)

RegisterServerEvent("srp-alerts:AlertUnion:svC4")
AddEventHandler("srp-alerts:AlertUnion:svC4",function()
    TriggerClientEvent('srp-alerts:AlertUnion:clC4', -1)
	return
end)

RegisterServerEvent("srp-alerts:AlertPacific:sv")
AddEventHandler("srp-alerts:AlertPacific:sv",function()
    TriggerClientEvent('srp-alerts:AlertPacific:cl', -1)
	return
end)

RegisterServerEvent("srp-alerts:methexplosion:sv")
AddEventHandler("srp-alerts:methexplosion:sv",function()
    TriggerClientEvent('srp-alerts:methexplosion:cl', -1, targetCoords)
	return
end)


