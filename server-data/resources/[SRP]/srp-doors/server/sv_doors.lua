local steamIds = {
    ["steam:11000013218ef32"] = true, --syd
    ["steam:1100001113b37ba"] = true, --syd
}

RegisterServerEvent('srp-doors:alterlockstate2')
AddEventHandler('srp-doors:alterlockstate2', function()
    SRP.DoorCoords[10]["lock"] = 0
    SRP.DoorCoords[11]["lock"] = 0
    SRP.DoorCoords[12]["lock"] = 0
    SRP.DoorCoords[39]["lock"] = 0
    SRP.DoorCoords[40]["lock"] = 0
    SRP.DoorCoords[41]["lock"] = 0
    SRP.DoorCoords[42]["lock"] = 0
    SRP.DoorCoords[44]["lock"] = 0
    SRP.DoorCoords[45]["lock"] = 0
    SRP.DoorCoords[46]["lock"] = 0
    SRP.DoorCoords[47]["lock"] = 0
    SRP.DoorCoords[48]["lock"] = 0
    SRP.DoorCoords[49]["lock"] = 0
    SRP.DoorCoords[50]["lock"] = 0
    SRP.DoorCoords[51]["lock"] = 0
    SRP.DoorCoords[52]["lock"] = 0
    SRP.DoorCoords[53]["lock"] = 0
    SRP.DoorCoords[54]["lock"] = 0
    SRP.DoorCoords[55]["lock"] = 0
    SRP.DoorCoords[56]["lock"] = 0

    TriggerClientEvent('srp-doors:alterlockstateclient', source, SRP.DoorCoords)

end)

RegisterServerEvent('srp-doors:alterlockstate')
AddEventHandler('srp-doors:alterlockstate', function(alterNum)
    SRP.alterState(alterNum)
end)

RegisterServerEvent('srp-doors:ForceLockState')
AddEventHandler('srp-doors:ForceLockState', function(alterNum, state)
    SRP.DoorCoords[alterNum]["lock"] = state
    TriggerClientEvent('SRP:Door:alterState', -1, alterNum, state)
end)

RegisterServerEvent('srp-doors:requestlatest')
AddEventHandler('srp-doors:requestlatest', function()
    local src = source 
    local steamcheck = GetPlayerIdentifiers(source)[1]
    if steamIds[steamcheck] then
        TriggerClientEvent('doors:HasKeys',src,true)
    end
    TriggerClientEvent('srp-doors:alterlockstateclient', source,SRP.DoorCoords)
end)

function isDoorLocked(door)
    if SRP.DoorCoords[door].lock == 1 then
        return true
    else
        return false
    end
end