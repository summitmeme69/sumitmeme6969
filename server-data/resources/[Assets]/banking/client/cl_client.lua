-- Settings
local displayBankBlips = true -- Toggles Bank Blips on the map (Default: true)


inBank = false

-- ATMS
local atms = {
  [1] = -1126237515,
  [2] = 506770882,
  [3] = -870868698,
  [4] = 150237004,
  [5] = -239124254,
  [6] = -1364697528,  
}



function IsNearATM()
  for i = 1, #atms do
    local objFound = GetClosestObjectOfType( GetEntityCoords(PlayerPedId()), 1.5, atms[i], 0, 0, 0)

    if DoesEntityExist(objFound) then
      TaskTurnPedToFaceEntity(PlayerPedId(), objFound, 3.0)
      return true
    end
  end

  return false
end

-- Banks
local banks = {
  {name="Bank", id=108, x=150.266, y=-1040.203, z=29.374},
  {name="Bank", id=108, x=-1212.980, y=-330.841, z=37.787},
  {name="Bank", id=108, x=-2962.582, y=482.627, z=15.703},

  {name="Bank", id=108, x=314.187, y=-278.621, z=54.170},
  {name="Bank", id=108, x=-351.534, y=-49.529, z=49.042},
  {name="Bank", id=108, x=241.727, y=220.706, z=106.286},
  {name="Bank", id=108, x=1176.0833740234, y=2706.3386230469, z=38.157722473145},
  {name="Bank", id=108, x=-112.09, y=6470.12, z=31.63},
  {name="Bank", id=108, x=241.74893188477, y=225.23568725586, z=106.28679656982},

}

RegisterNetEvent("bank:getLogsUpdates")
AddEventHandler("bank:getLogsUpdates" ,function(log)
  SendNUIMessage({
    updatelogs = 'yes',
    logs = log
  })
end)

RegisterNetEvent('bank:getbankAccountNumber')
AddEventHandler('bank:getbankAccountNumber', function(n)
  local d = GetEntityCoords(PlayerPedId())
  local s = GetStreetNameAtCoord(d.x , d.y , d.z)
  local a = GetStreetNameFromHashKey(s)
  SendNUIMessage({bankAccountNumber = true , bank = n , street = a})
end)

-- Display Map Blips
Citizen.CreateThread(function()
  if (displayBankBlips == true) then
    for _, item in pairs(banks) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipScale(item.blip, 0.75)
      SetBlipColour(item.blip, 2)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
  end
end)

local jobs = {["police"] = 4 ,["ems"] = 4 , ["car_shop"] = 4 , ["burger_shot"] = 4 , ["tuner_carshop"] = 4 ,  ["best_buds"] = 4 ,  ["bean_machine"] = 4 , ["vanilla_unicorn"] = 4, ["autobodies"] = 4, ["drift_school"] = 4, ["paleto_mech"] = 4}
-- Open Gui and Focus NUI
function openGui(a)
  for k,v in pairs(jobs) do
    local rank = exports["isPed"]:GroupRank(k)
    if(rank ~= nil) then
      if rank >= v then
        SendNUIMessage({bussiness = true, jobname = k})
      end
    end
  end
  local LocalPlayer = exports["srp-base"]:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter()
  local cash = Player.cash
  bankanimation()
  inBank = true

  SetNuiFocus(true, true)
  if(a == nil) then
    a = false
  end
  SendNUIMessage({openBank = true , cash = cash , atm = a})
 
end

RegisterNetEvent('bank:checkATM')
AddEventHandler('bank:checkATM', function()
  if IsNearATM() then
    atmOpen = true
    TriggerServerEvent("bank:get:balance")
    openGui(true)
    for k,v in pairs(jobs) do
      local rank = exports["isPed"]:GroupRank(k)
      if(rank ~= nil) then
        if rank >= v then
          local cid = exports["isPed"]:isPed("cid")
          TriggerServerEvent('bank:get:money', k)
        end
      end
    end
    SendNUIMessage({atm = true})
    bankOpen = true
  else
    TriggerEvent("DoLongHudText","No ATM.",2)
  end
end)


-- Close Gui and disable NUI
function closeGui()
  SetNuiFocus(false, false)
  SendNUIMessage({openBank = false})
  bankOpen = false
  atmOpen = false
  bankanimation()
  inBank = false
end


atmuse = false
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 
function bankanimation()
    local player = GetPlayerPed( -1 )
    if IsNearATM() then
      if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 

            loadAnimDict( "amb@prop_human_atm@male@enter" )
            loadAnimDict( "amb@prop_human_atm@male@exit" )
            loadAnimDict( "amb@prop_human_atm@male@idle_a" )

          if ( atmuse ) then 
              ClearPedTasks(PlayerPedId())
              TaskPlayAnim( player, "amb@prop_human_atm@male@exit", "exit", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
              atmuse = false
              local finished = exports["srp-taskbar"]:taskBar(3000,"Retrieving Card")
              ClearPedTasks(PlayerPedId())
          else
              atmuse = true
              TaskPlayAnim( player, "amb@prop_human_atm@male@idle_a", "idle_b", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
          end
      end
    else
        if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 

            loadAnimDict( "mp_common" )

            if ( atmuse ) then 
                ClearPedTasks(PlayerPedId())
                TaskPlayAnim( player, "mp_common", "givetake1_a", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
                atmuse = false
                local finished = exports["srp-taskbar"]:taskBar(1000,"Retrieving Card")
                ClearPedTasks(PlayerPedId())
            else
                atmuse = true
                TaskPlayAnim( player, "mp_common", "givetake1_a", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
                Citizen.Wait(1000)
                ClearPedTasks(PlayerPedId())
            end
        end
    end
end



RegisterNetEvent('bank:openbank')
AddEventHandler('bank:openbank', function()
  if not (IsInVehicle()) and not bankOpen then
    TriggerServerEvent("bank:get:balance")
    openGui()
    bankOpen = true
    for k,v in pairs(jobs) do
      local rank = exports["isPed"]:GroupRank(k)
      if(rank ~= nil) then
        if rank >= v then
          local cid = exports["isPed"]:isPed("cid")
          TriggerServerEvent('bank:get:money', k)
        end
      end
    end
  else

    if(atmOpen or bankOpen) then
      closeGui()
      atmOpen = false
      bankOpen = false
    end

    if atBank then
      atBank = false
    end
  end
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNUICallback('balance', function(data, cb)
  SendNUIMessage({openSection = "balance"})
  cb('ok')
end)

RegisterNUICallback('withdraw', function(data, cb)
  SendNUIMessage({openSection = "withdraw"})
  cb('ok')
end)

RegisterNUICallback('deposit', function(data, cb)
  SendNUIMessage({openSection = "deposit"})
  cb('ok')
end)

RegisterNUICallback('transfer', function(data, cb)
  SendNUIMessage({openSection = "transfer"})
  cb('ok')
end)

RegisterNUICallback('depositBussinessSubmit', function(data, cb)
  for k,v in pairs(jobs) do
    local rank = exports["isPed"]:GroupRank(k)
    if(rank ~= nil) then
      if rank >= v then
        if tonumber(data.amount) < 0 then
          TriggerEvent('DoLongHudText', 'You cannot afford this!', 2)
        else
          local cid = exports["isPed"]:isPed("cid")
          if(IsNearATM() == true or IsNearBank() == true) then
            TriggerServerEvent('bank:BussinessDeposit',k, data.amount, cid, data.reason, false)
            Citizen.Wait(500)
            TriggerServerEvent('bank:get:money', k)
          end
        end
      end
    end
  end
end)

RegisterNUICallback('withdrawSubmit', function(data, cb)
  if tonumber(data.amount) < 0 then
    TriggerEvent('DoLongHudText', 'You cannot afford this!', 2)
  else
    local cid = exports["isPed"]:isPed("cid")
    if(data.reason == '') then
      data.reason = "Non reason specificed"
    end
    TriggerEvent("bank:withdraw" , data.amount, cid, data.reason, false)
  end
end)

RegisterNUICallback('withdrawBussinessSubmit', function(data, cb)
  for k,v in pairs(jobs) do
    local rank = exports["isPed"]:GroupRank(k)
    if(rank ~= nil) then
      if rank >= v then
        if tonumber(data.amount) < 0 then
            TriggerEvent('DoLongHudText', 'You cannot afford this!', 2)
        else
            local cid = exports["isPed"]:isPed("cid")
          if(IsNearATM() == true or IsNearBank() == true) then
              TriggerServerEvent('bank:BussinessWithdraw',k,data.amount, cid, data.reason, true)
          end
        end
      end
    end
  end
end)

RegisterNUICallback('depositSubmit', function(data, cb)
  if tonumber(data.amount) < 0 then
    TriggerEvent('DoLongHudText', 'You cannot afford this!', 2)
  else
    local cid = exports["isPed"]:isPed("cid")
    if(data.reason == '') then
      data.reason = "Non reason specificed"
    end
    TriggerEvent('bank:deposit', data.amount, cid, data.reason , true)
    cb('ok')
  end
end)

RegisterNUICallback('transferSubmit', function(data, cb)
  local fromPlayer = GetPlayerServerId();
  if tonumber(data.amount) < 0 then
    TriggerEvent('DoLongHudText', 'You cannot afford this!', 2)
  else
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("bank:transfer", tonumber(data.toPlayer), tonumber(data.amount), cid, false)
    cb('ok')
  end
end)


-- Check if player is near an atm


-- Check if player is in a vehicle
function IsInVehicle()
  local ply = PlayerPedId()
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

-- Check if player is near a bank
function IsNearBank()
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(banks) do
    local distance = #(vector3(item.x, item.y, item.z) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
    if(distance <= 2) then
      return true
    end
  end
end

-- Check if player is near another player
function IsNearPlayer(player)
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
  local ply2Coords = GetEntityCoords(ply2, 0)
  local distance = Vdist2(plyCoords, ply2Coords)
  if(distance <= 5) then
    return true
  end
end

-- Remove from cash, add to bank
RegisterNetEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount, cid, reason, statement)
  if(IsNearBank() == true ) then
    TriggerServerEvent("bank:deposit", tonumber(amount), cid,reason, statement)
  end
end)

-- Process withdraw if conditions met
RegisterNetEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount, cid, reason, statement)
  if(IsNearATM() == true or IsNearBank() == true) then
    TriggerServerEvent("bank:withdraw", tonumber(amount), cid, reason, statement)
  end
end)

-- Process give cash if conditions met
RegisterNetEvent('bank:givecash')
AddEventHandler('bank:givecash', function(sender, reciever, amount)
	t, distance = GetClosestPlayer()
  if(distance ~= -1 and distance < 7.5) then
    if tonumber(reciever) == GetPlayerServerId(t) then
      print(reciever, amount)
      TriggerServerEvent("bank:givemecash", sender, reciever, amount)
      TriggerEvent("animation:PlayAnimation","id")
    else
      TriggerEvent("DoLongHudText", "This player is not online", 2)
    end
  else
    TriggerEvent("DoLongHudText", "You are not near this player", 2)
  end
end)


RegisterNetEvent('banking:updateBalance')
AddEventHandler('banking:updateBalance', function(balance, show)
	SendNUIMessage({
		updateBalance = true,
		balance = balance,
    name = "",
    show = show
	})
end)

RegisterNetEvent('banking:updateCash')
AddEventHandler('banking:updateCash', function(balance, show)
  local id = PlayerId()
  TriggerEvent('isPed:UpdateCash', balance)
	SendNUIMessage({
		updateCash = true,
		cash = balance,
    show = show
	})
end)

RegisterNetEvent("banking:viewBalance")
AddEventHandler("banking:viewBalance", function()
  SendNUIMessage({
    viewBalance = true
  })
end)

-- Send NUI Message to display add balance popup
RegisterNetEvent("banking:addBalance")
AddEventHandler("banking:addBalance", function(amount)
	SendNUIMessage({
		addBalance = true,
		amount = amount
	})
end)

RegisterNetEvent("banking:removeBalance")
AddEventHandler("banking:removeBalance", function(amount)
	SendNUIMessage({
		removeBalance = true,
		amount = amount
	})
end)

RegisterNetEvent("banking:addCash")
AddEventHandler("banking:addCash", function(amount)
	SendNUIMessage({
		addCash = true,
		amount = amount
	})
end)

-- Send NUI Message to display remove balance popup
RegisterNetEvent("banking:removeCash")
AddEventHandler("banking:removeCash", function(amount)
	SendNUIMessage({
		removeCash = true,
		amount = amount
	})
end)

RegisterNetEvent("srp-base:addedMoney")
AddEventHandler("srp-base:addedMoney", function(amt, total)
  TriggerEvent("banking:updateCash", total)
  TriggerEvent("banking:addCash", amt)
end)

RegisterNetEvent("srp-base:removedMoney")
AddEventHandler("srp-base:removedMoney", function(amt, total)
  TriggerEvent("banking:updateCash", total)
  TriggerEvent("banking:removeCash", amt)
end)

RegisterNetEvent("banking:transfer:getlogs")
AddEventHandler("banking:transfer:getlogs", function()
  TriggerServerEvent("bank:getLogs")
end)

RegisterNetEvent("bank:getBussinessCashBal")
AddEventHandler("bank:getBussinessCashBal" , function(cash)
  SendNUIMessage({getBussinessCashBal = true , cash = cash})
end)



function GetPlayers()
  local players = {}
  for i = 0, 256 do
    if NetworkIsPlayerActive(i) then
      players[#players+1]= i
    end
  end

  return players
end


function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local closestPed = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)
  for index,value in ipairs(players) do
    local target = GetPlayerPed(value)
    if(target ~= ply) then
      local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
      local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
      if(closestDistance == -1 or closestDistance > distance) then
        closestPlayer = value
        closestPed = target
        closestDistance = distance
      end
    end
  end
  
  return closestPlayer, closestDistance, closestPed

end