RegisterNetEvent("srp-burgershot:startprocess3")
AddEventHandler("srp-burgershot:startprocess3", function()
    local rank = exports["isPed"]:GroupRank("burger_shot")
    if rank > 0 then    
        if exports["srp-inventory"]:hasEnoughOfItem("rawpatty", 1) then 
            local dict = 'missfinale_c2ig_11'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "pushcar_offcliff_f", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 124.72439575195)
            local finished = exports['srp-taskbar']:taskBar(25000, 'Cooking the Patty')
            if (finished == 100) then
                TriggerEvent("inventory:removeItem", "rawpatty", 1)
                TriggerEvent('player:receiveItem', 'patty', 2)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            else
                FreezeEntityPosition(GetPlayerPed(-1),false)
            end
        else
            TriggerEvent('DoLongHudText', 'You need some Raw Patty to Make some Cooked Pattys! (Required Amount: 2)', 1)
        end
    else
        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
    end
end)

RegisterNetEvent("srp-burgershot:startfryer")
AddEventHandler("srp-burgershot:startfryer", function()
    local rank = exports["isPed"]:GroupRank("burger_shot")
    if rank > 0 then  
        if exports["srp-inventory"]:hasEnoughOfItem("potato", 1) then
            local dict = 'missfinale_c2ig_11'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "pushcar_offcliff_f", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 124.72439575195)
            local finished = exports['srp-taskbar']:taskBar(20000, 'Dropping Fries')
            if (finished == 100) then
                TriggerEvent('player:receiveItem', 'fries', 2)
                TriggerEvent("inventory:removeItem", "potato", 1)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            else
                FreezeEntityPosition(GetPlayerPed(-1),false)
            end
        else
            TriggerEvent('DoLongHudText', 'You Havent Got Any Cut Potatoes! (Required Amount: 1)', 1)
        end
    else
        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
    end
end)

RegisterNetEvent("srp-burgershot:makeshake")
AddEventHandler("srp-burgershot:makeshake", function()
    local rank = exports["isPed"]:GroupRank("burger_shot")
    if rank > 0 then
        if exports["srp-inventory"]:hasEnoughOfItem("milkshakeformula", 1) then
            local dict = 'mp_ped_interaction'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 124.72439575195)
            local finished = exports['srp-taskbar']:taskBar(10000, 'Making Milk Shake')
            if (finished == 100) then
                TriggerEvent('player:receiveItem', 'mshake', 2)
                TriggerEvent("inventory:removeItem", "milkshakeformula", 1)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            else
                FreezeEntityPosition(GetPlayerPed(-1),false)
            end
        else
            TriggerEvent('DoLongHudText', 'You Havent got any Milk Shake Formula! (Required Amount: 1)', 1)
        end
    else
        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
    end
end)

RegisterNetEvent("srp-burgershot:getcola")
AddEventHandler("srp-burgershot:getcola", function()
    local rank = exports["isPed"]:GroupRank("burger_shot")
    if rank > 0 then
        if exports["srp-inventory"]:hasEnoughOfItem("hfcs", 1) then   
            local dict = 'mp_ped_interaction'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 124.72439575195)
            local finished = exports['srp-taskbar']:taskBar(5000, 'Getting Coke')
            if (finished == 100) then
                TriggerEvent('player:receiveItem', 'softdrink', 2)
                TriggerEvent("inventory:removeItem", "hfcs", 1)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            else
                FreezeEntityPosition(GetPlayerPed(-1),false)
            end
        else
            TriggerEvent('DoLongHudText', 'You do not have enough Syrup! (Required Amount: 1)', 1)
        end
    else
        TriggerEvent('DoLongHudText', 'You are not a burgershot worker!', 2)
    end
end)
