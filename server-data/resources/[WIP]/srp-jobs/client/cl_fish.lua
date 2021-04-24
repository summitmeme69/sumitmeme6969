TryToFish = function()
    if IsPedSwimming(PlayerPedId()) then return TriggerEvent("DoLongHudText","You haven't quite learned how to multitask yet",2) end
    if IsPedInAnyVehicle(PlayerPedId()) then return TriggerEvent("DoLongHudText","Exit your vehicle first to start fishing!",2) end
    local waterValidated, castLocation = IsInWater()

    if waterValidated then
        local fishingRod = GenerateFishingRod(PlayerPedId())
        poleTimer = 5
        if baitTimer == 0 then
            CastBait(fishingRod, castLocation)
        end
    else
        TriggerEvent("DoLongHudText","You need to aim towards the fish!",2)
    end
end

poleTimer = 0
baitTimer = 0

function timerCount()
    if poleTimer ~= 0 then
        poleTimer = poleTimer - 1
    end
    if baitTimer ~= 0 then
        baitTimer = baitTimer - 1
    end
    SetTimeout(1000, timerCount)
end

local rodHandle = ""
timerCount()

CastBait = function(rodHandle, castLocation)
    baitTimer = 5
    local startedCasting = GetGameTimer()
    while not IsControlJustPressed(0, 47) do
        Citizen.Wait(5)
        DisableControlAction(0, 311, true)
        DisableControlAction(0, 157, true)
        DisableControlAction(0, 158, true)
        DisableControlAction(0, 160, true)
        DisableControlAction(0, 164, true)
        if GetGameTimer() - startedCasting > 5000 then
            TriggerEvent("DoLongHudText","You need to cast the bait",2)
            if DoesEntityExist(rodHandle) then
                DeleteEntity(rodHandle)
            end
            return 

        end
    end
    PlayAnimation(PlayerPedId(), "mini@tennis", "forehand_ts_md_far", {
        ["flag"] = 48
    })
    while IsEntityPlayingAnim(PlayerPedId(), "mini@tennis", "forehand_ts_md_far", 3) do
        Citizen.Wait(0)
    end
    PlayAnimation(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", {
        ["flag"] = 11
    })   
    local startedBaiting = GetGameTimer()
    local randomBait = math.random(10000, 30000)
    DrawBusySpinner("Waiting for a fish to bite...")
    DisableControlAction(0, 311, true)
    DisableControlAction(0, 157, true)
    DisableControlAction(0, 158, true)
    DisableControlAction(0, 160, true)
    DisableControlAction(0, 164, true)
    local interupted = false
    Citizen.Wait(1000)
    while GetGameTimer() - startedBaiting < randomBait do
        Citizen.Wait(5)
        if not IsEntityPlayingAnim(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", 3) then
            interupted = true
            break
        end
    end
    RemoveLoadingPrompt()
    if interupted then
        ClearPedTasks(PlayerPedId())
        CastBait(rodHandle, castLocation)
        return
    end

    local caughtFish = TryToCatchFish()
    ClearPedTasks(PlayerPedId())
    if caughtFish then
        TriggerEvent("player:receiveItem",'fish', math.random(1,2))
        TriggerEvent("DoLongHudText","You caught a fish!",1)
    else
        TriggerEvent("DoLongHudText","The fish got loose!",2)
    end
	if DoesEntityExist(rodHandle) then
        DeleteEntity(rodHandle)
    end
    Citizen.Wait(1500)
    local rodHandle = GenerateFishingRod(PlayerPedId())
    CastBait(rodHandle, castLocation)
end


TryToCatchFish = function()
    local minigameSprites = {
        ["powerDict"] = "custom",
        ["powerName"] = "bar",
        ["tennisDict"] = "tennis",
        ["tennisName"] = "swingmetergrad"
    }

    while not HasStreamedTextureDictLoaded(minigameSprites["powerDict"]) and not HasStreamedTextureDictLoaded(minigameSprites["tennisDict"]) do
        RequestStreamedTextureDict(minigameSprites["powerDict"], false)
        RequestStreamedTextureDict(minigameSprites["tennisDict"], false)
        Citizen.Wait(5)
    end
    local swingOffset = 0.1
    local swingReversed = false
    local DrawObject = function(x, y, width, height, red, green, blue)
        DrawRect(x + (width / 2.0), y + (height / 2.0), width, height, red, green, blue, 150)
    end
    while true do
        Citizen.Wait(5)
        ShowHelpNotification("Press ~INPUT_CONTEXT~ in the green area.")
        DrawSprite(minigameSprites["powerDict"], minigameSprites["powerName"], 0.5, 0.4, 0.01, 0.2, 0.0, 255, 0, 0, 255)
        DrawObject(0.49453227, 0.3, 0.010449, 0.03, 0, 255, 0)
        DrawSprite(minigameSprites["tennisDict"], minigameSprites["tennisName"], 0.5, 0.4 + swingOffset, 0.018, 0.002, 0.0, 0, 0, 0, 255)
        if swingReversed then
            swingOffset = swingOffset - 0.005
        else
            swingOffset = swingOffset + 0.005
        end
        if swingOffset > 0.1 then
            swingReversed = true
        elseif swingOffset < -0.1 then
            swingReversed = false
        end
        if IsControlJustPressed(0, 38) then
            swingOffset = 0 - swingOffset
            extraPower = (swingOffset + 0.1) * 250 + 1.0
            if extraPower >= 45 then
                return true
            else
                return false
            end
        end
    end
    SetStreamedTextureDictAsNoLongerNeeded(minigameSprites["powerDict"])
    SetStreamedTextureDictAsNoLongerNeeded(minigameSprites["tennisDict"])
end



IsInWater = function()
    local startedCheck = GetGameTimer()
    local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped)
    local forwardVector = GetEntityForwardVector(ped)
    local forwardPos = vector3(pedPos["x"] + forwardVector["x"] * 10, pedPos["y"] + forwardVector["y"] * 10, pedPos["z"])
    local fishHash = `a_c_fish`
    WaitForModel(fishHash)
    local waterHeight = GetWaterHeight(forwardPos["x"], forwardPos["y"], forwardPos["z"])
    local fishHandle = CreatePed(1, fishHash, forwardPos, 0.0, false)
    SetEntityAlpha(fishHandle, 0, true)
    TriggerEvent("DoLongHudText","Checking Fishing Location",1)
    while GetGameTimer() - startedCheck < 3000 do
        Citizen.Wait(0)
    end
    RemoveLoadingPrompt()
    local fishInWater = IsEntityInWater(fishHandle)
    DeleteEntity(fishHandle)
    SetModelAsNoLongerNeeded(fishHash)
    TriggerEvent("DoLongHudText", "[G] - To Cast")
    return fishInWater, fishInWater and vector3(forwardPos["x"], forwardPos["y"], waterHeight) or false
end



GenerateFishingRod = function(ped)
    local pedPos = GetEntityCoords(ped)
    local fishingRodHash = `prop_fishing_rod_01`
    WaitForModel(fishingRodHash)
    rodHandle = CreateObject(fishingRodHash, pedPos, true)
    AttachEntityToEntity(rodHandle, ped, GetPedBoneIndex(ped, 18905), 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded(fishingRodHash)
    return rodHandle
end



PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0
                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end
                if settings["flag"] then
                    flag = settings["flag"]
                end
                if settings["playbackRate"] then

                    playbackRate = settings["playbackRate"]

                end
                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end



FadeOut = function(duration)
    DoScreenFadeOut(duration)
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
end



FadeIn = function(duration)
    DoScreenFadeIn(500)
    while not IsScreenFadedIn() do
        Citizen.Wait(0)
    end
end



WaitForModel = function(model)
    if not IsModelValid(model) then
        return
    end
	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
	end
end



DrawBusySpinner = function(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end




-- Process

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function playerAnim()
	loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end
-- Cut Fish


local DoingTask2 = false
RegisterNetEvent("sellfish")
AddEventHandler("sellfish", function()
    if not DoingTask2 then
        DoingTask2 = true
        if exports["srp-inventory"]:hasEnoughOfItem("sushiroll",5,false) then 
            local finished = exports["srp-taskbar"]:taskBar(4000,"Selling Fish")
            if finished == 100 then
                local sushi = math.random(30, 50)
                DoingTask2 = false
                TriggerEvent("inventory:removeItem", "sushiroll", 5)
                TriggerServerEvent('srp-fish:sellSushi', sushi)
            else
                DoingTask2 = false
            end
        end
    end
end)



-- Blips
local blips = {
    {title="Fishing Pier", colour=62, id=410, scale=0.7, x = -3427.2314453125, y = 967.49719238281, z = 8.3466892242432},
    {title="Fishing Processing", colour=41, id=501, scale=0.7, x = -3250.2976074219, y = 992.57708740234, z = 12.489754676819},
    {title="La Spada", colour=9, id=356, scale=0.7, x = -1037.6729736328, y = -1397.1528320312, z = 5.5531921386719}
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, info.scale)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

CanFish = true
RegisterNetEvent("srp-fish:tryToFish")
AddEventHandler("srp-fish:tryToFish", function()
    if CanFish then
        if poleTimer == 0 then 
            TryToFish()
        end
    else
        TriggerEvent("DoLongHudText", "You need a fishing license, contact the police", 2)
    end
end)

RegisterNetEvent("srp-fish:allowed")
AddEventHandler("srp-fish:allowed", function(allowed)
    CanFish = allowed
end)

-- Notification
ShowHelpNotification = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end