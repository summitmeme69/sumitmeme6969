-- current selling value depending on amount of people selling.
local value = 0.4

-- amount of weed4g's needed to start.
local weedcost = 1000

-- are we already running a looperino?
local ActiveRun = false

-- Current step of procedure, 0 nothing, 1 moving to location
local CurrentStep = 0

-- 1 in X chance of getting rep, higher = less obviously.
local repChance = 5

-- counter +0.1 chance per drop off, 1 in X
local CounterIncreaseChance = 22

-- chance for call in on sale
local PoliceCallChance = 5

-- run length
local DropOffCount = 0

-- our current drop point
local DropOffLocation =  { ['x'] = -10.81,['y'] = -1828.68,['z'] = 25.4,['h'] = 301.59, ['info'] = ' Grove shop' }

-- loop waiting period, changes to 1 for draw text options.
local waittime = 1000

local WeedVehicle = 0

-- drop marker
local CurrentMarker = 0

-- How many active deliveries we have, if this is 2 we dont require cooking
local DeliveryCounter = 0

-- What item is required to be cooked
local CurrentCookItem = 1

-- milliseconds to swap from cook to delivery
local GracePeriod = 0

local DropOffMax = 12

local lastDelivery = GetGameTimer() - GracePeriod

local lastCook = GetGameTimer() - GracePeriod

local SaleReputation = 0

local bandprice = math.random(250, 300)
local rollcashprice = math.random(80, 100)

-- local inkedmoneybagprice = math.random(10000, 15000)
-- local markedbillsprice = math.random(3500, 4000)

local rollcount = 10
local bandcount = 10

local FoodTable = {
    [1] = { ["id"] = "coffee", ["name"] = "Coffee" },
    [2] = { ["id"] = "icecream2", ["name"] = "Icecream2" },
    [3] = { ["id"] = "donut", ["name"] = "Donut" },
    [4] = { ["id"] = "sandwich", ["name"] = "Sandwich" },
    [5] = { ["id"] = "water", ["name"] = "Water" },
    [6] = { ["id"] = "taco", ["name"] = "Taco" },
    [7] = { ["id"] = "fishtaco", ["name"] = "Fish Taco" },
    [8] = { ["id"] = "churro", ["name"] = "Churro" },
    [9] = { ["id"] = "hamburger", ["name"] = "Hamburger" },
    [10] = { ["id"] = "eggsbacon", ["name"] = "Bacon and Eggs" },
    [11] = { ["id"] = "hotdog", ["name"] = "Hotdog" },
    [12] = { ["id"] = "burrito", ["name"] = "Burrito" },
    [13] = { ["id"] = "greencow", ["name"] = "Green Cow" },
}

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function CheckWeedRun()
    if exports["srp-inventory"]:hasEnoughOfItem("weedq", 5) then 
        TriggerServerEvent("weed:checkmoney")
    else
        TriggerEvent('DoLongHudText', "The taco did not seem dank enough.", 2)
    end
end

RegisterNetEvent("taco:deliver")
AddEventHandler("taco:deliver", function()
    if DeliveryCounter ~= 2 then
        if exports["srp-inventory"]:hasEnoughOfItem(FoodTable[CurrentCookItem]["id"],1) then
            TriggerEvent("inventory:removeItem", FoodTable[CurrentCookItem]["id"], 1)
            TriggerServerEvent('mission:finished', math.random(10,110))
            TriggerServerEvent("delivery:status",1)
        else
            TriggerEvent("DoLongHudText","You dont have the required food for the delivery!", 2)
        end
    else
        TriggerEvent("DoLongHudText","You require these orders to be delivered!", 2)
    end
end)

RegisterNetEvent("taco:deliver2")
AddEventHandler("taco:deliver2", function()
    if DeliveryCounter > 0 then
            TriggerEvent("taco:successStart")
            TriggerServerEvent("delivery:status",-1)
    else
        TriggerEvent("DoLongHudText","We dont need your service yet, sorry!", 2)
    end
end)

RegisterNetEvent("TacoShop:reputation")
AddEventHandler("TacoShop:reputation", function(rep)
    SaleReputation = rep
end)

RegisterNetEvent("taco:list")
AddEventHandler("taco:list", function()
    TriggerEvent('chat:addMessage', {
        color = { 0, 255, 0},
        multiline = true,
        args = {"Me", "We require a " .. FoodTable[CurrentCookItem]["name"] .. " to be delivered."}
    })
    TriggerEvent('deliver')
end)

TriggerEvent('chat:addMessage', {
    color = { 0, 255, 0},
    multiline = true,
    args = {"Me", "We require a " .. FoodTable[CurrentCookItem]["name"] .. " to be delivered."}
  })

RegisterNetEvent('deliver')
AddEventHandler('deliver', function()
    TriggerEvent('srp-context:sendMenu', {
        {
            id = 1,
            header = "Suber Eat's Orders",
            txt = ""
        },
        {
            id = 2,
            header = "Set Delivery!",
			txt = "Fufill Order",
			params = {
                event = "taco:deliver"
            }
        },
    })
end)

RegisterNetEvent("delivery:deliverables")
AddEventHandler("delivery:deliverables", function(newCounter,nextItem)
    DeliveryCounter = newCounter
    CurrentCookItem = nextItem
end)



RegisterNetEvent("taco:successStart")
AddEventHandler("taco:successStart", function()
    EndRuns()
    ActiveRun = true
    local toolong = 0

    TriggerEvent("player:receiveItem","weedtaco", 1)
    while ActiveRun do
        Wait(1)
        if CurrentStep == 0 then
            DropOffLocation = DropOffsClose[math.random(#DropOffsClose)]
            BlipCreation()
            CurrentStep = 1
        end
        local plyCoords = GetEntityCoords(PlayerPedId())
        local inVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
        local distance = Vdist(DropOffLocation["x"],DropOffLocation["y"],DropOffLocation["z"],plyCoords)
        if distance < 45.0 and not inVehicle then
            waittime = 1
            DrawText3Ds(DropOffLocation["x"],DropOffLocation["y"],DropOffLocation["z"],"Press E to drop off package.")
            if IsControlJustReleased(1,38) and ActiveRun and distance < 1.5 then
                AttemptDropOffTaco()
                EndRuns()
            end
        end
        toolong = toolong + 1
        if toolong > 180000 then
            TriggerEvent("DoLongHudText","Taco Run timed out!")
            EndRuns()
        end
    end

end)

function AttemptDropOffTaco()
    if exports["srp-inventory"]:hasEnoughOfItem("weedtaco",1) then
        TriggerEvent("inventory:removeItem","weedtaco", 1)

        TriggerEvent("attachItemDrugs","cashcase01")
        TriggerEvent("Evidence:StateSet",4,1600)

        if math.random(CounterIncreaseChance) == CounterIncreaseChance then
            TriggerServerEvent("TacoShop:IncreaseCounter")
        end

        local payment = math.random(10,80)
        if exports["srp-inventory"]:hasEnoughOfItem("inkedmoneybag",1) then     
            TriggerEvent("inventory:removeItem","inkedmoneybag", 1)   
            payment = payment + ( inkedmoneybagprice + math.ceil(inkedmoneybagprice * SaleReputation/100) )            
            TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
        elseif exports["srp-inventory"]:hasEnoughOfItem("markedbills",1) then     
            TriggerEvent("inventory:removeItem","markedbills", 1)   
            payment = payment + ( markedbillsprice + math.ceil(markedbillsprice * SaleReputation/100) )            
            TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
        elseif exports["srp-inventory"]:hasEnoughOfItem("rollcash",rollcount) then     
            TriggerEvent("inventory:removeItem","rollcash", rollcount)   
            payment = payment + ( rollcashprice + math.ceil(rollcashprice * SaleReputation/100) )              
            TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
        elseif exports["srp-inventory"]:hasEnoughOfItem("band",bandcount) then     
            TriggerEvent("inventory:removeItem","band", bandcount)   
            payment = payment + ( bandprice + math.ceil(bandprice * SaleReputation/100) )              
            TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
        else
            TriggerEvent("DoLongHudText","Thanks, no extra sauce though?!")
        end
        TriggerServerEvent('mission:finished', payment)
    end
end


function ClearBlips()
    RemoveBlip(CurrentMarker)
    CurrentMarker = 0
end

function BlipCreation()
    ClearBlips()
    CurrentMarker = AddBlipForCoord(DropOffLocation["x"],DropOffLocation["y"],DropOffLocation["z"])
    SetBlipSprite(CurrentMarker, 514)
    SetBlipScale(CurrentMarker, 1.0)
    SetBlipAsShortRange(CurrentMarker, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drop Off")
    EndTextCommandSetBlipName(CurrentMarker)
end

function EndRuns()
    ClearBlips()
    SetVehicleHasBeenOwnedByPlayer(WeedVehicle,false)
    SetEntityAsNoLongerNeeded(WeedVehicle)

    ActiveRun = false
    waittime = 1000
    CurrentStep = 0
    DropOffCount = 0
    DropOffLocation =  { ['x'] = -10.81,['y'] = -1828.68,['z'] = 25.4,['h'] = 301.59, ['info'] = ' Grove shop' }
    Wait(1000)
    ClearBlips()
end
