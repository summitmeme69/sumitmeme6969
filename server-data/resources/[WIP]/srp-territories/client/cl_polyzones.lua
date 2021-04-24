NearGrove, NearCovenant, NearForum, NearBrouge, NearJamestown, NearMirrorPark, NearFudge, NearVespucci, NearCougar, NearHarmony = false, false, false, false, false, false, false, false, false
TargettingGrove, TargettingCovenant, TargettingForum, TargettingBrouge, TargettingJamestown, TargettingMirrorPark, TargettingFudge, TargettingVespucci, TargettingCougar, TargettingHarmony = false, false, false, false, false, false, false, false, false
OnCooldown = false
AlreadyShot = false

Citizen.CreateThread(function()
exports["srp-polyzone"]:AddBoxZone("grovestreet", vector3(41.45, -1881.74, 22.46), 363.39999999999, 70, {
name="grove",
heading=48,
debugPoly=false,
minZ=0.91,
maxZ=50.71
}) 
exports["srp-polyzone"]:AddBoxZone("Covenant", vector3(155.4, -1884.54, 23.58), 118.8, 40, {
name="Covenant",
heading=67,
debugPoly=false,
minZ=0.91,
maxZ=50.71
})
exports["srp-polyzone"]:AddBoxZone("ForumDr", vector3(-84.32, -1557.19, 32.39), 350.4, 180, {
name="ForumDr",
heading=142,
debugPoly=false,
minZ=0.91,
maxZ=50.71
})
exports["srp-polyzone"]:AddBoxZone("Brouge", vector3(251.47, -1738.92, 32.69), 122.4, 150, {
name="Brouge",
heading=140,
debugPoly=false,
minZ=0.91,
maxZ=50.71
})
exports["srp-polyzone"]:AddBoxZone("Jamestown", vector3(404.07, -1894.42, 24.61), 450.0, 200, {
name="Jamestown",
heading=143,
debugPoly=false,
minZ=0.91,
maxZ=50.71
})
exports["srp-polyzone"]:AddBoxZone("MirrorPark", vector3(1342.67, -562.5, 73.99), 140.0, 120, {
name="MirrorPark",
heading=70,
debugPoly=false,
minZ=100.59,
maxZ=35.59
})
exports["srp-polyzone"]:AddBoxZone("Fudge", vector3(1335.86, -1611.34, 52.49), 400.4, 180, {
name="Fudge",
heading=125,
debugPoly=false,
minZ=90.49,
maxZ=25.49
})
exports["srp-polyzone"]:AddBoxZone("Vespucci", vector3(-1113.7, -1601.84, 4.4), 200, 150, {
name="Vespucci",
heading=40,
debugPoly=false,
minZ=3.4,
maxZ=8.0
})
exports["srp-polyzone"]:AddBoxZone("Cougar", vector3(-1497.17, -258.96, 50.36), 225.0, 150, {
name="Cougar",
heading=315,
debugPoly=false,
minZ=90.56,
maxZ=0.16
})
exports["srp-polyzone"]:AddBoxZone("Harmony", vector3(850.29, 2692.07, 37.65), 1000, 250, {
name="Harmony",
heading=90,
debugPoly=false,
minZ=80.65,
maxZ=0.65
})
end)

RegisterNetEvent('srp-polyzone:enter')
AddEventHandler('srp-polyzone:enter', function(name)
    if name == "grovestreet" then
    NearGrove = true
    print("In Grove")
    elseif name == "Covenant" then
    NearCovenant = true
    print("In Covenant")
    elseif name == "ForumDr" then
    NearForum = true
    print("In Forum")
    elseif name == "Brouge" then
    NearBrouge = true
    print("In Brouge")
    elseif name == "Jamestown" then
    NearJamestown = true
    print("In Jamestown")
    elseif name == "MirrorPark" then
    NearMirrorPark = true
    print("In MirrorPark")
    elseif name == "Fudge" then
    NearFudge = true
    print("In Fudge")
    elseif name == "Vespucci" then
    NearVespucci = true
    print("In Vespucci")
    elseif name == "Cougar" then
    NearCougar = true
    print("In Cougar")
    elseif name == "Harmony" then
    NearHarmony = true
    print("In Harmony")
end
end)

RegisterNetEvent('srp-polyzone:exit')
AddEventHandler('srp-polyzone:exit', function(name)
    if name == "grovestreet" then
        NearGrove = false
        TriggerEvent("cooldown")
    elseif name == "Covenant" then
        NearCovenant = false
        TriggerEvent("cooldown")
    elseif name == "ForumDr" then
        NearForum = false
        TriggerEvent("cooldown")
    elseif name == "Brouge" then
        NearBrouge = false
        TriggerEvent("cooldown")
    elseif name == "Jamestown" then
        NearJamestown = false
        TriggerEvent("cooldown")
    elseif name == "MirrorPark" then
        NearMirrorPark = false
        TriggerEvent("cooldown")
    elseif name == "Fudge" then
        NearFudge = false
        TriggerEvent("cooldown")
    elseif name == "Vespucci" then
        NearVespucci = false
        TriggerEvent("cooldown")
    elseif name == "Cougar" then
        NearCougar = false
        TriggerEvent("cooldown")
    elseif name == "Harmony" then
        NearHarmony = false
        TriggerEvent("cooldown")
    end
end)

Citizen.CreateThread(function()
    while true do 
        if IsPedArmed(PlayerPedId(), 6) then
            Citizen.Wait(1)
        else
           Citizen.Wait(1500)
        end  

       if IsPedShooting(PlayerPedId()) and IsAGang and NearGrove and not TargettingGrove and not AlreadyShot and not OnCooldown then
        local ply = PlayerPedId()
        print("shot in grove while not targetting")
        AlreadyShot = true
        print(AlreadyShot)
        print('lost rep')
        TriggerServerEvent('srp-territories:addrep', GetPlayerServerId(PlayerId()), -1)

       elseif IsPedShooting(PlayerPedId()) and IsAGang and NearCovenant and not TargettingCovenant and not AlreadyShot and not OnCooldown then
        local ply = PlayerPedId()
        print("shot in cov while not targetting")
        AlreadyShot = true
        print(AlreadyShot)
        print('lost rep')
        TriggerServerEvent('srp-territories:addrep', GetPlayerServerId(PlayerId()), -1)

    elseif IsPedShooting(PlayerPedId()) and IsAGang and NearForum and not TargettingForum and not AlreadyShot and not OnCooldown then
        local ply = PlayerPedId()
        print("shot in Forum while not targetting")
        AlreadyShot = true
        print(AlreadyShot)
        print('lost rep')
        TriggerServerEvent('srp-territories:addrep', GetPlayerServerId(PlayerId()), -1)
        
    elseif IsPedShooting(PlayerPedId()) and IsAGang and NearBrouge and not TargettingBrouge and not AlreadyShot and not OnCooldown then
        local ply = PlayerPedId()
        print("shot in Brouge while not targetting")
        AlreadyShot = true
        print(AlreadyShot)
        print('lost rep')
        TriggerServerEvent('srp-territories:addrep', GetPlayerServerId(PlayerId()), -1)

    elseif IsPedShooting(PlayerPedId()) and IsAGang and NearJamestown and not TargettingJamestown and not AlreadyShot and not OnCooldown then
        local ply = PlayerPedId()
        print("shot in Jamestown while not targetting")
        AlreadyShot = true
        print(AlreadyShot)
        print('lost rep')
        TriggerServerEvent('srp-territories:addrep', GetPlayerServerId(PlayerId()), -1)

    elseif IsPedShooting(PlayerPedId()) and IsAGang and NearMirrorPark and not TargettingMirrorPark and not AlreadyShot and not OnCooldown then
        local ply = PlayerPedId()
        print("shot in MirrorPark while not targetting")
        AlreadyShot = true
        print(AlreadyShot)
        print('lost rep')
        TriggerServerEvent('srp-territories:addrep', GetPlayerServerId(PlayerId()), -1)

    elseif IsPedShooting(PlayerPedId()) and IsAGang and NearFudge and not TargettingFudge and not AlreadyShot and not OnCooldown then
        local ply = PlayerPedId()
        print("shot in Fudge while not targetting")
        AlreadyShot = true
        print(AlreadyShot)
        print('lost rep')
        TriggerServerEvent('srp-territories:addrep', GetPlayerServerId(PlayerId()), -1)
        
    elseif IsPedShooting(PlayerPedId()) and IsAGang and NearVespucci and not TargettingVespucci and not AlreadyShot and not OnCooldown then
        local ply = PlayerPedId()
        print("shot in Vespucci while not targetting")
        AlreadyShot = true
        print(AlreadyShot)
        print('lost rep')
        TriggerServerEvent('srp-territories:addrep', GetPlayerServerId(PlayerId()), -1)
                
    elseif IsPedShooting(PlayerPedId()) and IsAGang and NearCougar and not TargettingCougar and not AlreadyShot and not OnCooldown then
        local ply = PlayerPedId()
        print("shot in Cougar while not targetting")
        AlreadyShot = true
        print(AlreadyShot)
        print('lost rep')
        TriggerServerEvent('srp-territories:addrep', GetPlayerServerId(PlayerId()), -1)
                        
    elseif IsPedShooting(PlayerPedId()) and IsAGang and NearHarmony and not TargettingHarmony and not AlreadyShot and not OnCooldown then
        local ply = PlayerPedId()
        print("shot in Harmony while not targetting")
        AlreadyShot = true
        print(AlreadyShot)
        print('lost rep')
        TriggerServerEvent('srp-territories:addrep', GetPlayerServerId(PlayerId()), -1)
       end
    end
end)

RegisterNetEvent("cooldown")
AddEventHandler("cooldown", function()
    print("worked")
    OnCooldown = true
    Citizen.Wait(30000)
    OnCooldown = false
end)