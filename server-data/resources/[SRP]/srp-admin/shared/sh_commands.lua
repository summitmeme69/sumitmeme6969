local cmd = {}
cmd = {
    title = "Set Rank",
    command = "setrank",
    concmd = "setrank",
    category = "User Management",
    usage = "setrank <source> <rank>",
    description = "Sets the selected player's rank",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.rank then return end
    TriggerEvent('admin:setGroup', caller.source, args.target.source, args.rank)
end

function cmd.DrawCommand()
        cmd.vars.target = cmd.vars.target ~= nil and cmd.vars.target or nil
        cmd.vars.rank = cmd.vars.rank ~= nil and cmd.vars.rank or nil

        if WarMenu.Button("Select a target", "Selected: " .. (cmd.vars.target and cmd.vars.target.name or "None")) then SRP.Admin.Menu:DrawTargets(cmd.command, function(_target)
            cmd.vars.target = _target
        end) end           

        if WarMenu.Button("Select a rank", "Selected: " .. (cmd.vars.rank ~= nil and tostring(cmd.vars.rank) or "None")) then SRP.Admin.Menu:DrawRanks(cmd.command, function(_rank)
            cmd.vars.rank = _rank
        end) end

        local args = {
            target = cmd.vars.target,
            rank = cmd.vars.rank
        }
    
        if args.target and args.rank then if WarMenu.Button("Set " .. args.target.name .. "'s rank to " .. args.rank) then SRP.Admin:GetCommandData(cmd.command).runcommand(args) cmd.vars.target = nil cmd.vars.rank = nil end end
end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "God",
    command = "god",
    concmd = "god",
    category = "Player",
    usage = "god",
    description = "Enables god mode",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    local log = string.format("%s [%s] set god mode: %s", caller:getVar("name"), caller:getVar("steamid"), args.toggle and "true" or "false")
    SRP.Admin:Log(log, caller)
end

function cmd.Init()
    if IsDuplicityVersion() then return end

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if cmd.vars.enable then
                SetPlayerInvincible(PlayerId(), true)
            end
        end
    end)
end

function cmd.RunClCommand(args)
    cmd.vars.enable = args.toggle
    if not args.toggle then SetPlayerInvincible(PlayerId(), false) end
    TriggerEvent("carandplayerhud:godCheck",args.toggle)
end

function cmd.DrawCommand()
    cmd.vars.toggle = cmd.vars.toggle ~= nil and cmd.vars.toggle or nil         
    if WarMenu.Button("God Mode: " .. (cmd.vars.toggle and "Disable" or "Enable")) then cmd.vars.toggle = not cmd.vars.toggle SRP.Admin:GetCommandData(cmd.command).runcommand({toggle = cmd.vars.toggle}) end
end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Marker Teleport",
    command = "marker",
    concmd = "marker",
    category = "Player",
    usage = "marker",
    description = "Teleport To marker",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    local log = string.format("%s [%s] Teleported to marker", caller:getVar("name"), caller:getVar("steamid"))
    SRP.Admin:Log(log, caller)
end

function cmd.RunClCommand(args)
    SRP.Admin.teleportMarker()
end

function cmd.DrawCommand()      
    if WarMenu.Button("Teleport to marker") then SRP.Admin:GetCommandData(cmd.command).runcommand({}) end
end

SRP.Admin:AddCommand(cmd)



local cmd = {}
cmd = {
    title = "Teleport Coord",
    command = "tcoords",
    concmd = "tcoords",
    category = "Player",
    usage = "tcoords",
    description = "Teleport To Coords",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if args.x ~= nil and args.y ~= nil and args.z ~= nil then
        local pos = vector3(args.x,args.y,args.z)
        local log = string.format("%s [%s] Teleported to Coords", caller:getVar("name"), caller:getVar("steamid"),pos)
        SRP.Admin:Log(log, caller)
    end
end

function cmd.RunClCommand(args)
    if args.x ~= nil and args.y ~= nil and args.z ~= nil then
        local pos = vector3(args.x,args.y,args.z)
        local ped = PlayerPedId()

        Citizen.CreateThread(function()
            RequestCollisionAtCoord(pos)
            SetPedCoordsKeepVehicle(ped, pos)
            FreezeEntityPosition(ped, true)
            SetPlayerInvincible(PlayerId(), true)

            local startedCollision = GetGameTimer()

            while not HasCollisionLoadedAroundEntity(ped) do
                if GetGameTimer() - startedCollision > 5000 then break end
                Citizen.Wait(0)
            end

            FreezeEntityPosition(ped, false)
            SetPlayerInvincible(PlayerId(), false)
        end)

    end 

end

function cmd.DrawCommand()      
    cmd.vars.x = cmd.vars.x ~= nil and cmd.vars.x or nil
    cmd.vars.y = cmd.vars.y ~= nil and cmd.vars.y or nil
    cmd.vars.z = cmd.vars.z ~= nil and cmd.vars.z or nil
    if WarMenu.Button("Enter x", "x: " .. (cmd.vars.x and cmd.vars.x or "0.0")) then
        SRP.Admin.Menu:ShowTextEntry("Enter Item", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            if string.find(result, ",") then
                local resultSplit = SRP.Admin.split(result, ',')
                local x = tonumber(resultSplit[1]) 
                local y = tonumber(resultSplit[2]) 
                local z = tonumber(resultSplit[3]) 

                if x ~= nil and y ~= nil and z ~= nil then
                    cmd.vars.x = x +0.0
                    cmd.vars.y = y +0.0
                    cmd.vars.z = z +0.0
                end
            else
                local x = tonumber(result)
                if x ~= nil then
                    cmd.vars.x = x +0.0
                end
            end
        end)
    end

    if WarMenu.Button("Enter y", "y: " .. (cmd.vars.y and cmd.vars.y or "0.0")) then
        SRP.Admin.Menu:ShowTextEntry("Enter y", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            local y = tonumber(result)
            if y ~= nil then
                cmd.vars.y = y +0.0
            end
        end)
    end

    if WarMenu.Button("Enter z", "z: " .. (cmd.vars.z and cmd.vars.z or "0.0")) then
        SRP.Admin.Menu:ShowTextEntry("Enter z", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            local z = tonumber(result)
            if z ~= nil then
                cmd.vars.z = z +0.0
            end
        end)
    end

    if cmd.vars.x and cmd.vars.y and cmd.vars.z then if WarMenu.Button("Teleport to: " .. "X:["..cmd.vars.x.."] Y:["..cmd.vars.y.."] Z:["..cmd.vars.z.."]") then SRP.Admin:GetCommandData(cmd.command).runcommand({x = cmd.vars.x,y = cmd.vars.y,z = cmd.vars.z}) end end
end
SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Noclip",
    command = "noclip",
    concmd = "noclip",
    category = "Player",
    usage = "noclip",
    description = "Enables noclip",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    local log = string.format("%s [%s] set noclip: %s", caller:getVar("name"), caller:getVar("steamid"), args.toggle and "true" or "false")
    TriggerEvent("admin:isFlying",args.toggle)
    SRP.Admin:Log(log, caller)
end

function cmd.Init()
    if IsDuplicityVersion() then return end

    RegisterNetEvent("srp-admin:NoclipState")
    AddEventHandler("srp-admin:NoclipState", function(toggle)
        cmd.vars.toggle = toggle
    end)
end

function cmd.RunClCommand(args)
    cmd.vars.enable = args.toggle
    SRP.Admin:RunNclp(cmd.vars.enable)
end

function cmd.DrawCommand()
    cmd.vars.toggle = cmd.vars.toggle ~= nil and cmd.vars.toggle or nil
    if WarMenu.Button("Noclip: " .. (cmd.vars.toggle and "Disable" or "Enable")) then cmd.vars.toggle = not cmd.vars.toggle SRP.Admin:GetCommandData(cmd.command).runcommand({toggle = cmd.vars.toggle}) end
end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Teleport",
    command = "teleport",
    concmd = "teleport",
    category = "Player",
    usage = "teleport <source>",
    description = "Teleports to selected target",
    ranks = {"dev"},
    vars = {}
}

-- function cmd.RunCommand(caller, args)
--     if not args.target then return end
--     local log = string.format("%s [%s] teleported to: %s", caller:getVar("name"), caller:getVar("steamid"), args.target:getVar("name"), args.target:getVar("steamid"))
--     SRP.Admin:Log(log, caller)
-- end

function cmd.RunClCommand(args)
    if not args.target then return end
    TriggerServerEvent('admin:teleportToPlayer', args.target.source) 
end

function cmd.DrawCommand()
    cmd.vars.target = cmd.vars.target ~= nil and cmd.vars.target or nil

    if WarMenu.Button("Select a target", "Selected: " .. (cmd.vars.target and cmd.vars.target.name or "None")) then SRP.Admin.Menu:DrawTargets(cmd.command, function(_target)
        cmd.vars.target = _target
    end) end

    if cmd.vars.target then if WarMenu.Button("Teleport to " .. cmd.vars.target.name .. "'s position") then SRP.Admin:GetCommandData(cmd.command).runcommand({target = cmd.vars.target, retn = false}) end end
    if cmd.vars.lastPos then if WarMenu.Button("Return to your last position") then SRP.Admin:GetCommandData(cmd.command).runcommand({target = false, retn = true}) end end
end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Bring",
    command = "bring",
    concmd = "bring",
    category = "Player",
    usage = "bring <source>",
    description = "Brings targeted player to you.",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.target then return end  
    TriggerEvent("admin:bringPlayer", caller.source, args.target.source)
end

function cmd.DrawCommand()
    cmd.vars.target = cmd.vars.target ~= nil and cmd.vars.target or nil

    if WarMenu.Button("Select a target", "Selected: " .. (cmd.vars.target and cmd.vars.target.name or "None")) then SRP.Admin.Menu:DrawTargets(cmd.command, function(_target)
        cmd.vars.target = _target
    end) end

    if cmd.vars.target then if WarMenu.Button("Bring " .. cmd.vars.target.name .. " to you.") then SRP.Admin:GetCommandData(cmd.command).runcommand({target = cmd.vars.target, retn = false}) end end
end



SRP.Admin:AddCommand(cmd)
local cmd = {}
cmd = {
    title = "Attach",
    command = "attach",
    concmd = "attach",
    category = "Player",
    usage = "attach <source>",
    description = "Attaches to selected target",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.target then return end
     local log = string.format("%s [%s] set attach: %s", caller:getVar("name"), caller:getVar("steamid"), args.toggle and "true" or "false")
    SRP.Admin:Log(log, caller)
end

function cmd.RunCommand(caller, args)
    TriggerEvent("admin:getCoords", caller.source, args.target.source, args.toggle)
end

function cmd.DrawCommand()
    cmd.vars.target = cmd.vars.target ~= nil and cmd.vars.target or nil

    if WarMenu.Button("Select a target", "Selected: " .. (cmd.vars.target and cmd.vars.target.name or "None")) then SRP.Admin.Menu:DrawTargets(cmd.command, function(_target)
        cmd.vars.target = _target
    end) end

    cmd.vars.toggle = cmd.vars.toggle ~= nil and cmd.vars.toggle or nil
    if WarMenu.Button("Attach: " .. (cmd.vars.toggle and "Disable" or "Enable")) then cmd.vars.toggle = not cmd.vars.toggle SRP.Admin:GetCommandData(cmd.command).runcommand({toggle = cmd.vars.toggle,target = cmd.vars.target}) end
end



SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Kick",
    command = "kick",
    concmd = "kick",
    category = "User Management",
    usage = "kick <source>",
    description = "Kicks selected target",
    ranks = {"moderator"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.target then return end
    if not args.reason then args.reason = "No Reason Given" end
    TriggerEvent("admin:DropPlayer", args.target.source, args.reason)
end

function cmd.DrawCommand()
    cmd.vars.target = cmd.vars.target ~= nil and cmd.vars.target or nil
    cmd.vars.reason = cmd.vars.reason ~= nil and cmd.vars.reason or nil

    if WarMenu.Button("Select a target", "Selected: " .. (cmd.vars.target and cmd.vars.target.name or "None")) then SRP.Admin.Menu:DrawTargets(cmd.command, function(_target)
        cmd.vars.target = _target
    end) end

    if WarMenu.Button("Enter a reason", "Reason: " .. (cmd.vars.reason and cmd.vars.reason or "No Reason Given")) then
        SRP.Admin.Menu:DrawTextInput(cmd.vars.reason and cmd.vars.reason or "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            cmd.vars.reason = result
        end)
    end

    if cmd.vars.target then if WarMenu.Button("Kick " .. cmd.vars.target.name) then SRP.Admin:GetCommandData(cmd.command).runcommand({target = cmd.vars.target, reason = cmd.vars.reason}) end end
end


SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Vehicle Garage State",
    command = "plate",
    concmd = "plate",
    category = "Utility",
    usage = "plate <name>",
    description = "Set's current vehicle in/out of a garage",
    ranks = {"moderator"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.reason then args.reason = "" end
    TriggerEvent("srp-admin:update:vehicle", caller.source, args.reason)
end

function cmd.DrawCommand()
    cmd.vars.toggle = cmd.vars.toggle ~= nil and cmd.vars.toggle or nil
    cmd.vars.reason = cmd.vars.reason ~= nil and cmd.vars.reason or nil


    if WarMenu.Button("Enter a plate", "Plate: " .. (cmd.vars.reason and cmd.vars.reason or "")) then
        SRP.Admin.Menu:DrawTextInput(cmd.vars.reason and cmd.vars.reason or "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            cmd.vars.reason = result
        end)
    end

    if WarMenu.Button("Set State") then cmd.vars.toggle = not cmd.vars.toggle SRP.Admin:GetCommandData(cmd.command).runcommand({toggle = cmd.vars.toggle, reason = cmd.vars.reason}) end
end


SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Search Inventory",
    command = "Search_inventory",
    concmd = "Search_inventory",
    category = "User Management",
    usage = "Search <source>",
    description = "Search selected players inventory!",
    ranks = {"admin"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.target then return end
    TriggerEvent("admin:search", caller.source, args.target.source)
end

function cmd.DrawCommand()
    cmd.vars.target = cmd.vars.target ~= nil and cmd.vars.target or nil

    if WarMenu.Button("Select a target", "Selected: " .. (cmd.vars.target and cmd.vars.target.name or "None")) then SRP.Admin.Menu:DrawTargets(cmd.command, function(_target)
        cmd.vars.target = _target
    end) end

    cmd.vars.toggle = cmd.vars.toggle ~= nil and cmd.vars.toggle or nil
    if WarMenu.Button("Search Player") then cmd.vars.toggle = not cmd.vars.toggle SRP.Admin:GetCommandData(cmd.command).runcommand({toggle = cmd.vars.toggle,target = cmd.vars.target}) end
end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Cloak",
    command = "cloak",
    concmd = "cloak",
    category = "Player",
    usage = "cloak",
    description = "Turn your self invisible",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    local src = caller:getVar("source")

    if args.toggle == true then cmd.vars.cloaked[src] = true else cmd.vars.cloaked[src] = nil end

    TriggerClientEvent("srp-admin:Cloak", -1, src, args.toggle)

    local log = string.format("%s [%s] set cloak: %s", caller:getVar("name"), caller:getVar("steamid"), args.toggle and "true" or "false")
    SRP.Admin:Log(log, caller)
end

function cmd.Init()
    cmd.vars.cloaked = {}
    cmd.vars.cloakedVeh = {}

    if IsDuplicityVersion() then 
        AddEventHandler("srp-base:characterLoaded", function(user, char)
            local src = user:getVar("source")
            TriggerClientEvent("srp-admin:Cloak", src, cmd.vars.cloaked)
        end)

        AddEventHandler("playerDropped", function()
            local src = source
            if cmd.vars.cloaked[src] then
                TriggerClientEvent("srp-admin:Cloak", -1, src, false)
                cmd.vars.cloaked[src] = nil
            end
        end)

        return
    end


    

    RegisterNetEvent("srp-admin:CloakRemote")
    AddEventHandler("srp-admin:CloakRemote", function()
        if SRP.Admin:GetPlayerRank() == "dev" then
            cmd.vars.toggle = not cmd.vars.toggle
            SRP.Admin:GetCommandData(cmd.command).runcommand({toggle = cmd.vars.toggle})
        end
    end)

    RegisterNetEvent("srp-admin:Cloak")
    AddEventHandler("srp-admin:Cloak", function(player, toggle)
        if type(player) == "table" then
            cmd.vars.cloaked = player
            TriggerEvent("hud:HidePlayer", player)
        else
            cmd.vars.cloaked[player] = toggle
            TriggerEvent("hud:HidePlayer", player, toggle)
        end
    end)
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            for k,v in pairs(cmd.vars.cloaked) do
                if DoesPlayerExist(k) then
                    local playerId = GetPlayerFromServerId(k)
                    local ped = GetPlayerPed(playerId)
                    local isInVehicle = IsPedInAnyVehicle(ped, true)
                    local vehicle = cmd.vars.cloakedVeh[k]

                    local function uncloakCar(vehicle)
                        NetworkFadeInEntity(vehicle, 0)
                        SetEntityCanBeDamaged(vehicle, true)
                        SetEntityInvincible(vehicle, false)
                        SetVehicleCanBeVisiblyDamaged(vehicle, true)
                        SetVehicleStrong(vehicle, false)
                        SetVehicleSilent(vehicle, false)
                        SetEntityAlpha(vehicle, 255, false)
                        SetEntityLocallyVisible(vehicle)
                        cmd.vars.cloakedVeh[k] = nil
                    end

                    if not v then
                        NetworkFadeInEntity(ped, 0)
                        SetEntityLocallyVisible(ped)
                        SetPlayerVisibleLocally(playerId, true)
                        SetPedConfigFlag(ped, 52, false)
                        SetPlayerInvincible(playerId, false)
                        SetPedCanBeTargettedByPlayer(ped, playerId, true)
                        SetPedCanBeTargetted(ped, false)
                        SetEveryoneIgnorePlayer(playerId, false)
                        SetIgnoreLowPriorityShockingEvents(playerId, false)
                        SetPlayerCanBeHassledByGangs(playerId, true)
                        SetEntityAlpha(ped, 255, false)
                        SetPedCanRagdoll(ped, true)
                        if vehicle then uncloakCar(vehicle) end
                        cmd.vars.cloaked[k] = nil
                    else
                        if ped == PlayerPedId() then
                            SetEntityAlpha(ped, 255, false)
                        else
                            SetEntityAlpha(ped, 255, false)
                            SetEntityLocallyInvisible(ped)
                            SetPlayerInvisibleLocally(playerId, true)
                            NetworkFadeOutEntity(ped, true, false)
                        end

                        SetPedCanRagdoll(ped, false)
                        SetPedConfigFlag(ped, 52, true)
                        SetPlayerCanBeHassledByGangs(playerId, false)
                        SetIgnoreLowPriorityShockingEvents(playerId, true)
                        SetPedCanBeTargettedByPlayer(ped, playerId, false)
                        SetPedCanBeTargetted(ped, false)
                        SetEveryoneIgnorePlayer(playerId, true)
                        SetPlayerInvincible(playerId, true)

                        if vehicle then
                            if not IsPedInAnyVehicle(ped, true) then
                                uncloakCar(vehicle)
                            else
                                if ped == GetPedInVehicleSeat(vehicle, -1) then
                                    if ped == PlayerPedId() then
                                        SetEntityAlpha(vehicle, 100, false)
                                    else
                                        NetworkFadeOutEntity(vehicle, true, false)
                                        SetEntityAlpha(vehicle, 0, false)
                                        SetEntityLocallyInvisible(vehicle)
                                    end
                                    SetVehicleSilent(vehicle, true)
                                    SetEntityCanBeDamaged(vehicle, false)
                                    SetEntityInvincible(vehicle, true)
                                    SetVehicleCanBeVisiblyDamaged(vehicle, false)
                                    SetVehicleStrong(vehicle, true)
                                else
                                    uncloakCar(vehicle)
                                end
                            end
                        else
                            if IsPedInAnyVehicle(ped, true) then
                                local vehicle = GetVehiclePedIsIn(ped, false)
                                if vehicle and vehicle ~= 0 then
                                    if GetPedInVehicleSeat(vehicle, -1) == ped then
                                        cmd.vars.cloakedVeh[k] = vehicle
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

function cmd.DrawCommand()
    cmd.vars.toggle = cmd.vars.toggle ~= nil and cmd.vars.toggle or nil
    if WarMenu.Button("Cloak: " .. (cmd.vars.toggle and "Disable" or "Enable")) then cmd.vars.toggle = not cmd.vars.toggle SRP.Admin:GetCommandData(cmd.command).runcommand({toggle = cmd.vars.toggle}) end
end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Csay",
    command = "csay",
    concmd = "csay",
    category = "Utility",
    usage = "csay <message>",
    description = "Sends a serverwide chat message",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.message then return end

  
    TriggerClientEvent("chatMessage", -1, "Admin: ", {255, 0, 0}, args.message)
   

    local log = string.format("%s [%s] Csay: %s", caller:getVar("name"), caller:getVar("steamid"), args.message)
    SRP.Admin:Log(log, caller)
end

function cmd.DrawCommand()
    cmd.vars.message = cmd.vars.message ~= nil and cmd.vars.message or nil

    if WarMenu.Button("Enter a message", "Message: " .. (cmd.vars.message and cmd.vars.message or "No Message")) then
        SRP.Admin.Menu:ShowTextEntry("Enter a Message", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            cmd.vars.message = result
        end)
    end

    if cmd.vars.message then if WarMenu.Button("Send Message: " .. cmd.vars.message) then SRP.Admin:GetCommandData(cmd.command).runcommand({message = cmd.vars.message}) end end
end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Spawn Car",
    command = "scar",
    concmd = "scar",
    category = "Utility",
    usage = "scar <model>",
    description = "spawn's you a car",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.message then return end
    local src = caller:getVar("source")
    TriggerClientEvent("srp-admin:runSpawnCommand",src,args.message)
    exports["srp-base"]:AddLog("Admin", caller, "Spawned car", {car = tostring(args.message)}) 
    SRP.Admin:Log(log, caller)
end

function cmd.DrawCommand()
    cmd.vars.message = cmd.vars.message ~= nil and cmd.vars.message or nil

    if WarMenu.Button("Enter a model", "Model: " .. (cmd.vars.message and cmd.vars.message or "No model")) then
        SRP.Admin.Menu:ShowTextEntry("Enter a model", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            cmd.vars.message = result
        end)
    end 
    if WarMenu.Button("Seat into Vehicle") then TriggerEvent("srp-admin:SeatIntoLast") end

    if cmd.vars.message then if WarMenu.Button("Spawn model: " .. cmd.vars.message) then SRP.Admin:GetCommandData(cmd.command).runcommand({message = cmd.vars.message}) end end
end

-- SRP.Admin:AddCommand(cmd)

-- local cmd = {}
-- cmd = {
--     title = "Give Car",
--     command = "gcar",
--     concmd = "gcar",
--     category = "Utility",
--     usage = "gcar <model> <cid>",
--     description = "gives a cid a car",
--     ranks = {"dev"},
--     vars = {}
-- }

-- function cmd.RunCommand(caller, args)
--     if not args.message then return end
--     local src = caller:getVar("source")
    
--     SRP.Admin.DB:giveCar(args.message,args.reciver)

--     SRP.Admin:Log(log, caller)
-- end

-- function cmd.DrawCommand()
--     cmd.vars.message = cmd.vars.message ~= nil and cmd.vars.message or nil
--     cmd.vars.reciver = cmd.vars.reciver ~= nil and cmd.vars.reciver or nil

--     if WarMenu.Button("Enter a model", "Model: " .. (cmd.vars.message and cmd.vars.message or "No model")) then
--         SRP.Admin.Menu:ShowTextEntry("Enter a model", "", function(result)
--             if result then
--                 if string.gsub(result, " ", "") == "" or result == "" then result = nil end
--             end

--             cmd.vars.message = result
--         end)
--     end

--     if WarMenu.Button("Enter a cid", "Cid: " .. ( cmd.vars.reciver and  cmd.vars.reciver or "No cid")) then
--         SRP.Admin.Menu:ShowTextEntry("Enter a cid", "", function(result)
--             if result then
--                 if string.gsub(result, " ", "") == "" or result == "" then result = nil end
--             end

--              cmd.vars.reciver = result
--         end)
--     end

--     if cmd.vars.message and cmd.vars.reciver then if WarMenu.Button("Give model: " .. cmd.vars.message.." to "..cmd.vars.reciver) then SRP.Admin:GetCommandData(cmd.command).runcommand({message = cmd.vars.message,reciver = cmd.vars.reciver}) end end
-- end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Spawn Item",
    command = "stim",
    concmd = "stim",
    category = "Utility",
    usage = "stim <name>",
    description = "Gives you an item",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.message then return end
    if not args.amount then args.amount = 1 end
    local src = caller:getVar("source")
    TriggerClientEvent('player:receiveItem', src, args.message, args.amount)
    exports["srp-base"]:AddLog("Admin", caller, "Spawned item", {item = tostring(args.message),amount = tostring(args.amount)}) 
    SRP.Admin:Log(log, caller)
end

function cmd.DrawCommand()
    cmd.vars.message = cmd.vars.message ~= nil and cmd.vars.message or nil
    cmd.vars.amount = cmd.vars.amount ~= nil and cmd.vars.amount or nil
    if WarMenu.Button("Enter a item name", "Model: " .. (cmd.vars.message and cmd.vars.message or "No item")) then
        SRP.Admin.Menu:ShowTextEntry("Enter Item", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            cmd.vars.message = result
            if cmd.vars.amount == nil then cmd.vars.amount = 1 end
        end)
    end

    if WarMenu.Button("Enter Amount", "Amount: " .. (cmd.vars.amount and cmd.vars.amount or "1")) then
        SRP.Admin.Menu:ShowTextEntry("Enter Amount", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            local amount = tonumber(result)
            if amount == nil or amount <= 0 or amount >= 51 then amount = 1 end
            cmd.vars.amount = amount
        end)
    end

    if cmd.vars.message then if WarMenu.Button("Spawn Item: " .. cmd.vars.message.." | "..cmd.vars.amount) then SRP.Admin:GetCommandData(cmd.command).runcommand({message = cmd.vars.message,amount = cmd.vars.amount}) end end
end

SRP.Admin:AddCommand(cmd)


local cmd = {}
cmd = {
    title = "Weather / Time",
    command = "wTime",
    concmd = "wTime",
    category = "Utility",
    usage = "wTime <name>",
    description = "Changes weather ,time and light",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)

    local src = caller:getVar("source")

    if args.time ~= nil and args.time ~= 0 then
        TriggerEvent("weather:time",src,args.time)
    end

    if args.weather ~= nil and args.weather ~= "" then
        TriggerEvent("weather:setWeather",src,args.weather)
    end

    if args.light ~= nil and args.light ~= "" then
        TriggerClientEvent("weather:setCycle",src,args.light)
    end

    TriggerClientEvent("weather:blackout",src,args.blackout)

    exports["srp-base"]:AddLog("Admin", caller, "Changed weather/time/Cycle", {time = args.time, weather = args.weather, light = args.light, blackout = args.blackout}) 

     local log = string.format("%s [%s] Changed weather/time/Cycle: %s", caller:getVar("name"), caller:getVar("steamid"), json.encode({time = args.time, weather = args.weather, light = args.light, blackout = args.blackout}))
    SRP.Admin:Log(log, caller)


end

function cmd.DrawCommand()
    cmd.vars.time = cmd.vars.time ~= nil and cmd.vars.time or nil
    cmd.vars.weather = cmd.vars.weather ~= nil and cmd.vars.weather or nil
    cmd.vars.lightType = cmd.vars.lightType ~= nil and cmd.vars.lightType or nil


    if WarMenu.Button("Enter a time", "Time: " .. (cmd.vars.time and cmd.vars.time or "0")) then
        SRP.Admin.Menu:ShowTextEntry("Enter Time", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            local time = tonumber(result)
            if time == nil then time = 0 end
            cmd.vars.time = time
        end)
    end


    if WarMenu.Button("Enter a Weather status", "Weather: " .. (cmd.vars.weather and cmd.vars.weather or "none")) then
        SRP.Admin.Menu:ShowTextEntry("Enter Weather status", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            cmd.vars.weather = result
        end)
    end


    if WarMenu.Button("Enter a Cycle Effect", "Cycle: " .. (cmd.vars.lightType and cmd.vars.lightType or "none")) then
        SRP.Admin.Menu:ShowTextEntry("Enter Time Cycle Effect", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            cmd.vars.lightType = result
        end)
    end


    cmd.vars.toggle = cmd.vars.toggle ~= nil and cmd.vars.toggle or nil
    if WarMenu.Button("Blackout: " .. (cmd.vars.toggle and "Disable" or "Enable")) then cmd.vars.toggle = not cmd.vars.toggle end


    if cmd.vars.time or cmd.vars.weather or cmd.vars.lightType then if WarMenu.Button("Update Server/Client") then SRP.Admin:GetCommandData(cmd.command).runcommand({time = cmd.vars.time, weather = cmd.vars.weather, light = cmd.vars.lightType, blackout = cmd.vars.toggle}) end end
end

SRP.Admin:AddCommand(cmd)


local cmd = {}
cmd = {
    title = "Become Model",
    command = "bModel",
    concmd = "bModel",
    category = "Utility",
    usage = "bModel <name>",
    description = "Set's current model",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.message then return end
    local src = caller:getVar("source")
    TriggerClientEvent('raid_clothes:AdminSetModel', src, args.message)
    exports["srp-base"]:AddLog("Admin", caller, "Set Model", {item = tostring(args.message)}) 
    SRP.Admin:Log(log, caller)
end

function cmd.DrawCommand()
    cmd.vars.message = cmd.vars.message ~= nil and cmd.vars.message or nil

    if WarMenu.Button("Enter model name", "Model: " .. (cmd.vars.message and cmd.vars.message or "No model")) then
        SRP.Admin.Menu:ShowTextEntry("Enter Model", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            cmd.vars.message = result
        end)
    end

    if cmd.vars.message then if WarMenu.Button("Set Model: " .. cmd.vars.message) then SRP.Admin:GetCommandData(cmd.command).runcommand({message = cmd.vars.message}) end end
end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Tsay",
    command = "tsay",
    concmd = "tsay",
    category = "Utility",
    usage = "tsay <message>",
    description = "Sends a serverwide announcement",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.message then return end

    local string = [[<center><span style="font-size:28px;color:red;">%s<br /><hr style="border-color: rgba(255, 0, 0, 0.5);">%s</span></center>]]

    TriggerClientEvent("pNotify:SendNotification", -1, {text = string.format(string, args.message, args.message), layout = "top", timeout = 15000, type = "error", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}, queue = "announcement", progressBar = false})

    local log = string.format("%s [%s] Tsay: %s", caller:getVar("name"), caller:getVar("steamid"), args.message)
    SRP.Admin:Log(log, caller)
end

function cmd.DrawCommand()
    cmd.vars.message = cmd.vars.message ~= nil and cmd.vars.message or nil

    if WarMenu.Button("Enter a message", "Message: " .. (cmd.vars.message and cmd.vars.message or "No Message")) then
        SRP.Admin.Menu:ShowTextEntry("Enter a Message", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
            end

            cmd.vars.message = result
        end)
    end

    if cmd.vars.message then if WarMenu.Button("Send Announcement: " .. cmd.vars.message) then SRP.Admin:GetCommandData(cmd.command).runcommand({message = cmd.vars.message}) end end
end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Revive/Heal",
    command = "revive",
    concmd = "revive",
    category = "Player",
    usage = "revive <source>",
    description = "revives/heals selected player",
    ranks = {"moderator"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.target then return end

    TriggerEvent("reviveGranted", args.target.source)
    TriggerClientEvent("Hospital:HealInjuries", args.target.source,true) 
    TriggerEvent("ems:healplayer", args.target.source)
    TriggerClientEvent("heal", args.target.source)

    local log = string.format("%s [%s] revived and healed %s [%s]", caller:getVar("name"), caller:getVar("steamid"), args.target:getVar("name"), args.target:getVar("steamid"))
    SRP.Admin:Log(log, caller)
end

function cmd.DrawCommand()
    cmd.vars.target = cmd.vars.target or nil

    if WarMenu.Button("Select a target", "Selected: " .. (cmd.vars.target and cmd.vars.target.name or "None")) then SRP.Admin.Menu:DrawTargets(cmd.command, function(_target)
        cmd.vars.target = _target
    end) end

    if WarMenu.Button("Revive in Distance") then 
        TriggerEvent("srp-admin:ReviveInDistance")
    end


    if cmd.vars.target then if WarMenu.Button("Revive and Heal " .. cmd.vars.target.name) then SRP.Admin:GetCommandData(cmd.command).runcommand({target = cmd.vars.target, runontarget = true}) end end
end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Fix Car",
    command = "fixc",
    concmd = "fixc",
    category = "Player",
    usage = "fixc <source>",
    description = "Fixes the car the selected target is in or Current vehicle",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.target then return end
    local log = string.format("%s [%s] fixed %s's [%s] vehicle", caller:getVar("name"), caller:getVar("steamid"), args.target:getVar("name"), args.target:getVar("steamid"))
    SRP.Admin:Log(log, caller)
end

function cmd.RunClCommand(args)
    local ped = PlayerPedId()
    

    if args.runontarget then
        local playerIdx = GetPlayerFromServerId(args.target.source)
        ped = GetPlayerPed(playerIdx)
    end

    local vehicle = GetVehiclePedIsIn(ped, false)
    if not vehicle then return end

    SetVehicleFixed(vehicle)
    SetVehiclePetrolTankHealth(vehicle, 4000.0)
end

function cmd.DrawCommand()
    cmd.vars.target = cmd.vars.target or nil

    if WarMenu.Button("Select a target", "Selected: " .. (cmd.vars.target and cmd.vars.target.name or "None")) then SRP.Admin.Menu:DrawTargets(cmd.command, function(_target)
        cmd.vars.target = _target
    end) end

    if cmd.vars.target then if WarMenu.Button("Fix " .. cmd.vars.target.name .. "'s vehicle") then SRP.Admin:GetCommandData(cmd.command).runcommand({target = cmd.vars.target, runontarget = true}) end end
    if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then if WarMenu.Button("Fix Current vehicle.") then SRP.Admin:GetCommandData(cmd.command).runcommand({runontarget = false}) end end

end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Request Job",
    command = "rJob",
    concmd = "rJob",
    category = "Player",
    usage = "rJob <source>",
    description = "Attempt to sign onto a job.",
    ranks = {"dev"},
    vars = {}
}
function cmd.RunCommand(caller, args)
    local jobName = args.target
    local src = caller:getVar("source")

    if jobName == "police" then
        TriggerEvent("attemptduty",src)
    elseif jobName == "ems" then 
        TriggerEvent("attemptdutym",src)
    elseif jobName == "doctor" then
        TriggerClientEvent("isDoctor",src)
        Wait(1000)
        TriggerEvent("isDoctor",src)
    elseif jobName == "judge" then
        TriggerClientEvent("isJudge",src)
        Wait(1000)
        TriggerEvent("isJudge",src)
    else
        TriggerEvent("jobssystem:jobs",jobName,src)
    end
end

function cmd.DrawCommand()
    cmd.vars.target = cmd.vars.target or nil

    if WarMenu.Button("Select a job", "Selected: " .. (cmd.vars.target and cmd.vars.target or "None")) then SRP.Admin.Menu:DrawJobs(cmd.command, function(_target)
        cmd.vars.target = _target
    end) end

    if cmd.vars.target then if WarMenu.Button("Request [" .. cmd.vars.target .. "]") then SRP.Admin:GetCommandData(cmd.command).runcommand({target = cmd.vars.target}) end end
end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Entity View",
    command = "entview",
    concmd = "entview",
    category = "Utility",
    usage = "entview",
    description = "Enables entity view mode",
    ranks = {"dev"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    local log = string.format("%s [%s] set ent view: %s", caller:getVar("name"), caller:getVar("steamid"), args.toggle and "true" or "false")
    SRP.Admin:Log(log, caller)
end

function cmd.Init()
    if IsDuplicityVersion() then return end

    WarMenu.CreateSubMenu("filtermenu", "amenu", "Available Filters")
    SRP.Admin.Menu:SetSubMenuProperties("filtermenu")

    cmd.vars.filters = {
        ["all"] = false,
        ["ped"] = 1,
        ["veh"] = 2,
        ["obj"] = 3,
    }

    local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
    }

    local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
        return coroutine.wrap(function()
            local iter, id = initFunc()
            if not id or id == 0 then
            disposeFunc(iter)
            return
            end
            
            local enum = {handle = iter, destructor = disposeFunc}
            setmetatable(enum, entityEnumerator)
            
            local next = true
            repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
            until not next
            
            enum.destructor, enum.handle = nil, nil
            disposeFunc(iter)
        end)
    end

    local function EnumerateObjects()
        return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
    end

    local function EnumeratePeds()
        return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
    end

    local function EnumerateVehicles()
        return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
    end

    Citizen.CreateThread(function()
        while true do
            if cmd.vars.enable then
                local filter = cmd.vars.filters[cmd.vars.filter]
                local toDraw = {}
                local pedPos = GetEntityCoords(PlayerPedId(), false)

                local function debugEnt(ent)
                    local entPos = GetEntityCoords(ent, false)
                    local dist = Vdist2(entPos, pedPos)
                    if dist< cmd.vars.distance then toDraw[#toDraw+1]= ent end
                end

                if not filter or filter == 2 then
                    for veh in EnumerateVehicles() do
                        debugEnt(veh)
                    end
                end

                if not filter or filter == 3 then
                    for obj in EnumerateObjects() do
                        debugEnt(obj)
                    end
                end

                if not filter or filter == 1 then 
                    for ped in EnumeratePeds() do
                        if ped ~= PlayerPedId() then
                            debugEnt(ped)
                        end
                    end
                end

                for _, ent in ipairs(toDraw) do
                    local x, y, z = table.unpack(GetEntityCoords(ent, false))
                    local _, _x, _y = World3dToScreen2d(x, y, z)
                    local px, py, pz = table.unpack(GetGameplayCamCoords())
                    local dist = #(vector3(px, py, pz) - vector3(x, y, z))
                    local model = tostring(GetEntityModel(ent))
                    local isMission = tostring(IsEntityAMissionEntity(ent))
                    local isInControl = tostring(NetworkHasControlOfEntity(ent) == 1 and true or false)
                    local entType = tostring(GetEntityType(ent))

                    local scale = (1/dist) * 20
                    scale = scale * ((1/GetGameplayCamFov()) * 100)

                    SetDrawOrigin(x, y, z, 0)

                    SetTextScale(0.0*scale, 0.05*scale)
                    SetTextFont(0)
                    SetTextProportional(1)
                    SetTextColour(255, 0, 0, 255)
                    SetTextDropshadow(0, 0, 0, 0, 255)
                    SetTextEdge(2, 0, 0, 0, 150)
                    SetTextDropShadow()
                    SetTextOutline()
                    SetTextEntry("STRING")
                    SetTextCentre(1)
                    AddTextComponentString("Id: " .. ent .. "\nModel: " .. model .. "\nMission Ent: " .. isMission .. "\nNetwork Control: " .. isInControl .. "\nType: " .. entType)
                    DrawText()
                    
                    ClearDrawOrigin()
                end
            end

            Citizen.Wait(0)
        end
    end)
end

function cmd.RunClCommand(args)
    cmd.vars.enable = args.toggle
    cmd.vars.filter = args.filter
end

function cmd.DrawCommand()
    cmd.vars.toggle = cmd.vars.toggle or nil
    cmd.vars.filter = cmd.vars.filter or "all"
    cmd.vars.distance = cmd.vars.distance or 150

    if WarMenu.Button("Entity View: " .. (cmd.vars.toggle and "Disable" or "Enable")) then cmd.vars.toggle = not cmd.vars.toggle SRP.Admin:GetCommandData(cmd.command).runcommand({toggle = cmd.vars.toggle, filter = cmd.vars.filter}) end

    if WarMenu.Button("Enter view distance", "Entered: " .. (cmd.vars.distance or "150")) then 
        SRP.Admin.Menu:ShowTextEntry("Enter a distance", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
                result = tonumber(result)
                if not result then result = nil end
            end

            cmd.vars.distance = result
        end)
    end

    local function DrawFilters()
        WarMenu.OpenMenu("targetmenu")

        Citizen.CreateThread(function()
            while WarMenu.IsMenuOpened("targetmenu") do
                Citizen.Wait(0)
                for f, t in pairs(cmd.vars.filters) do
                    if WarMenu.MenuButton(f, "command") then cmd.vars.filter = f SRP.Admin.Menu:DrawCommand(cmd.command) return end
                end
                if WarMenu.MenuButton("Back", "command") then SRP.Admin.Menu:DrawCommand(cmd.command) return end
            end
        end)
    end

    if WarMenu.Button("Filter: " .. (cmd.vars.filter or "all")) then DrawFilters() end
end

SRP.Admin:AddCommand(cmd)

local cmd = {}
cmd = {
    title = "Delete Entity",
    command = "deleteent",
    concmd = "deleteent",
    category = "Utility",
    usage = "deleteent <entid>",
    description = "Deletes selected entities",
    ranks = {"moderator"},
    vars = {}
}

function cmd.RunCommand(caller, args)
    if not args.ent then return end
    local log = string.format("%s [%s] Deleted entity: %s", caller:getVar("name"), caller:getVar("steamid"), args.ent)
    if not args.target then return end
    local log = string.format("%s [%s] Attempted to sign on %s's [%s] to cop", caller:getVar("name"), caller:getVar("steamid"), args.target:getVar("name"), args.target:getVar("steamid"))
    SRP.Admin:Log(log, caller)
end

function cmd.RunClCommand(args)
    if not args.ent then return end
    if not DoesEntityExist(args.ent) then return end

    Citizen.CreateThread(function()
        local timeout = 0

        while true do
            if timeout >= 3000 then return end
            timeout = timeout + 1

            NetworkRequestControlOfEntity(args.ent)

            local nTimeout = 0

            while not NetworkHasControlOfEntity(args.ent) and nTimeout < 1000 do
                nTimeout = nTimeout + 1
                NetworkRequestControlOfEntity(args.ent)
                Citizen.Wait(0)
            end

            SetEntityAsMissionEntity(args.ent, true, true)

            DeleteEntity(args.ent)
            if GetEntityType(args.ent) == 2 then DeleteVehicle(args.ent) end

            if not DoesEntityExist(args.ent) then cmd.vars.ent = nil return end

            Citizen.Wait(0)
        end
    end)
end

function cmd.DrawCommand()
    cmd.vars.ent = cmd.vars.ent or nil

    if WarMenu.Button("Enter an entity ID") then 
        SRP.Admin.Menu:ShowTextEntry("Enter an entity ID", "", function(result)
            if result then
                if string.gsub(result, " ", "") == "" or result == "" then result = nil end
                result = tonumber(result)
                if not result then result = nil end
            end

            cmd.vars.ent = result
        end)
    end

    if WarMenu.Button("Select Entity Infront") then
        local coordA = GetEntityCoords(PlayerPedId(), false)
		local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)

        local offset = 0
        local rayHandle
        local entity

        for i = 0, 100 do
            rayHandle = CastRayPointToPoint(coordA.x, coordA.y, coordA.z, coordB.x, coordB.y, coordB.z + offset, 10, PlayerPedId(), -1)	
            a, b, c, d, entity = GetRaycastResult(rayHandle)
            offset = offset - 1
            if entity and Vdist(GetEntityCoords(entity, false), coordA) < 150 then break end
        end

        if entity then cmd.vars.ent = entity end
    end

    if cmd.vars.ent and DoesEntityExist(cmd.vars.ent) then
        x, y, z = table.unpack(GetEntityCoords(cmd.vars.ent, true))
        SetDrawOrigin(x, y, z, 0)
        RequestStreamedTextureDict("helicopterhud", false)
        DrawSprite("helicopterhud", "hud_corner", -0.01, -0.01, 0.05, 0.05, 0.0, 0, 255, 0, 200)
        DrawSprite("helicopterhud", "hud_corner", 0.01, -0.01, 0.05, 0.05, 90.0, 0, 255, 0, 200)
        DrawSprite("helicopterhud", "hud_corner", -0.01, 0.01, 0.05, 0.05, 270.0, 0, 255, 0, 200)
        DrawSprite("helicopterhud", "hud_corner", 0.01, 0.01, 0.05, 0.05, 180.0, 0, 255, 0, 200)
        ClearDrawOrigin()
    end

    if cmd.vars.ent then if WarMenu.Button("Delete Entity", "Entity: " .. (cmd.vars.ent or "none")) then
        SRP.Admin:GetCommandData(cmd.command).runcommand({ent = cmd.vars.ent})
    end end
end

SRP.Admin:AddCommand(cmd)

--[[
    function cmd.ChatCommand(args)
        local cmd = args[1] and args[1] or false
        local target = args[2] and args[2] or false
        local rank = args[3] and args[3] or false

        if not cmd or not target or not rank then return end

        if not SRP.Admin:RankExists(rank) then return end
        if not SRP.Admin:IsValidUser(target) then return end

        local args = {
            target = exports["srp-base"]:getModule("Player"):getUser(target),
            rank = rank
        }

        return args
    end
]]