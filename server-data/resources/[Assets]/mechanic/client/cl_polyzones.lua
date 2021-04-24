Tuner, auto_exotics, paleto_mech, auto_bodies = false, false, false, false

Citizen.CreateThread(function()
	exports["srp-polyzone"]:AddBoxZone("tuner", vector3(933.31, -971.0, 39.54), 30, 15, {
        name="tuner",
        heading=275,
      --  debugPoly=true,
        minZ=36.59,
        maxZ=40.39
    })

    exports["srp-polyzone"]:AddBoxZone("auto_exotics", vector3(542.17, -177.28, 54.49), 53.8, 25, {
        name="auto_exotics",
        heading=189,
        --debugPoly=true,
        minZ=53.29,
        maxZ=56.29
    })

    exports["srp-polyzone"]:AddBoxZone("paleto_mech", vector3(109.18, 6625.12, 31.79), 16.2, 10, {
        name="paleto_mech",
        heading=314,
        --debugPoly=true,
        minZ=29.39,
        maxZ=33.39
    })

    exports["srp-polyzone"]:AddBoxZone("auto_bodies", vector3(-1419.51, -447.71, 35.91), 26.6, 10, {
        name="auto_bodies",
        heading=302,
        --debugPoly=true,
        minZ=34.91,
        maxZ=38.11
    })
end)


RegisterNetEvent('srp-polyzone:enter')
AddEventHandler('srp-polyzone:enter', function(name)
    local job = exports["isPed"]:isPed("myjob")
    if name == "tuner" then
        if job == "tuner_shop" then
            Tuner = true     
        end
    elseif name == "auto_exotics" then
        if job == "auto_exotics" then
            auto_exotics = true
        end
    elseif name == "paleto_mech" then
        if job == "paleto_mech" then
            paleto_mech = true
        end
    elseif name == "auto_bodies" then
        if job == "auto_bodies" then
            auto_bodies = true
        end
    end
end)

RegisterNetEvent('srp-polyzone:exit')
AddEventHandler('srp-polyzone:exit', function(name)
    local job = exports["isPed"]:isPed("myjob")
    if name == "tuner" then
        if job == "tuner_shop" then
            Tuner = false  
        end    
    elseif name == "auto_exotics" then
        if job == "auto_exotics" then
            auto_exotics = false
        end
    elseif name == "paleto_mech" then
        if job == "paleto_mech" then
            paleto_mech = false
        end
    elseif name == "auto_bodies" then
        if job == "auto_bodies" then
            auto_bodies = false
        end
    end
end)