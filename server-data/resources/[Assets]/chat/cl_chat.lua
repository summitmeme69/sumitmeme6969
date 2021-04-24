local chatInputActive = false
local chatInputActivating = false
local enabled = true

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntered')

--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, color, text, cmd)
  if cmd == "OOC" and not enabled then
    return
  end


  local hud = exports["isPed"]:isPed("hud")
  if color == 8 then
    TriggerEvent("phone:addnotification",author,text)
    return
  end
  if hud < 3 then
    local args = { text }
    if author ~= "" then
      table.insert(args, 1, author)
    end
    SendNUIMessage({
      type = 'ON_MESSAGE',
      message = {
        color = color,
        multiline = true,
        args = args
      }
    })
  end
end)

RegisterNetEvent('chat:showCID')
AddEventHandler('chat:showCID', function(cidInformation, pid)
  local person_src = pid
  local pid = GetPlayerFromServerId(person_src)
	local targetPed = GetPlayerPed(pid)
	local myCoords = GetEntityCoords(GetPlayerPed(-1))
  local targetCoords = GetEntityCoords(targetPed)
    if pid ~= -1 then
	    if GetDistanceBetweenCoords(myCoords, targetCoords, true) <= 1.5 then
          SendNUIMessage({
            type = 'ON_MESSAGE',
            message = {
              color = 9,
              multiline = false,
              args = cidInformation
            }
          })
      end
    end
end)

AddEventHandler('chat:addMessage', function(message)
  local hud = exports["isPed"]:isPed("hud")
    if hud then
      SendNUIMessage({
        type = 'ON_MESSAGE',
        message = message
      })
   end
end)

AddEventHandler('chat:addSuggestion', function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end)

AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

RegisterNetEvent('chat:close')
AddEventHandler('chat:close', function()
  SendNUIMessage({
    type = 'ON_CLOSE_CHAT'
  })
end)

AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
    end
  end

  cb('ok')
end)
RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');

  cb('ok')
end)

Controlkey = {["generalChat"] = {245,"T"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
  Controlkey["generalChat"] = table["generalChat"]
end)

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false)
  chatInputActive = false
  chatInputActivating = false

  while true do
    Wait(0)

    if not chatInputActive then
      if IsControlPressed(0,245) and not focusTaken then
        chatInputActive = true
        chatInputActivating = true

        SendNUIMessage({
          type = 'ON_OPEN'
        })
      end
    end

    if chatInputActivating then
      if not IsControlPressed(0,245) then
        SetNuiFocus(true)

        chatInputActivating = false
      end
    end

    if chatLoaded then
      local shouldBeHidden = false

      if IsScreenFadedOut() or IsPauseMenuActive() then
        shouldBeHidden = true
      end

      if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
        chatHidden = shouldBeHidden

        SendNUIMessage({
          type = 'ON_SCREEN_STATE_CHANGE',
          shouldHide = shouldBeHidden
        })
      end
    end
  end
end)



local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()

    local suggestions = {}

    for _, command in ipairs(registeredCommands) do
        if IsAceAllowed(('command.%s'):format(command.name)) then
            table.insert(suggestions, {
                name = '/' .. command.name,
                help = ''
            })
        end
    end

    TriggerEvent('chat:addSuggestions', suggestions)
  end
end


AddEventHandler('onClientResourceStart', function(resName)
  Wait(500)

  refreshCommands()
end)

AddEventHandler('onClientResourceStop', function(resName)
  Wait(500)

  refreshCommands()
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');

  refreshCommands()

  chatLoaded = true

  cb('ok')
end)

local msgCount2 = 0
local scary2 = 0
local scaryloop2 = false
local dicks2 = 0
local dicks3 = 0
local dicks = 0

local ped = PlayerPedId()
local isInVehicle = IsPedInAnyVehicle(ped, true)

Citizen.CreateThread( function()
    while true do
        Wait(1000)
        ped = PlayerPedId()
        isInVehicle = IsPedInAnyVehicle(ped, true)
    end
end)

RegisterCommand('me', function(source, args)
    local Coords = GetEntityCoords(PlayerPedId())
    local text = '' -- edit here if you want to change the language : EN: the person / FR: la personne
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ''
    TriggerServerEvent('3dme:shareDisplay', text, Coords)
end)

RegisterNetEvent('Do3DText')
AddEventHandler("Do3DText", function(text, source, Coords)

    local lCoords = GetEntityCoords(PlayerPedId())
    local distIs  = Vdist(lCoords.x, lCoords.y, Coords.z, Coords.x, Coords.y, Coords.z)
    if(distIs <= 6) then
        TriggerEvent('DoHudTextCoords', GetPlayerFromServerId(source), text)
    end
end)



RegisterNetEvent('DoHudTextCoords')
AddEventHandler('DoHudTextCoords', function(mePlayer, text)
    dicks2 = 600
    msgCount2 = msgCount2 + 0.22
    local mycount2 = msgCount2

    scary2 = 600 - (msgCount2 * 100)
    TriggerEvent("scaryLoop2")
    local power2 = true
    while dicks2 > 0 do

        dicks2 = dicks2 - 1
        local plyCoords2 = GetEntityCoords(GetPlayerPed(-1))
        local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
        local dist = Vdist2(coordsMe, plyCoords2)

        output = dicks2

        if output > 255 then
            output = 255
        end
        if dist < 500 then
            if HasEntityClearLosToEntity(PlayerPedId(), GetPlayerPed(mePlayer), 17 ) then

                if not isInVehicle and GetFollowPedCamViewMode() == 0 then
                    DrawText3DTest(coordsMe["x"],coordsMe["y"],coordsMe["z"]+(mycount2/2) - 0.2, text, output,power2)
                elseif not isInVehicle and GetFollowPedCamViewMode() == 4 then
                    DrawText3DTest(coordsMe["x"],coordsMe["y"],coordsMe["z"]+(mycount2/7) - 0.1, text, output,power2)
                elseif GetFollowPedCamViewMode() == 4 then
                    DrawText3DTest(coordsMe["x"],coordsMe["y"],coordsMe["z"]+(mycount2/7) - 0.2, text, output,power2)
                else
                    DrawText3DTest(coordsMe["x"],coordsMe["y"],coordsMe["z"]+mycount2 - 1.25, text, output,power2)
                end
            end
        end

        Citizen.Wait(1)
    end

end)

function DrawText3DTest(x,y,z, text, dicks,power)

    local onScreen,_x,_y=World3dToScreen2d(x,y,z + 0.1)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    if dicks > 255 then
        dicks = 255
    end
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 155)
        SetTextEdge(1, 0, 0, 0, 250)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
         SetTextColour(255, 255, 255, dicks)

        DrawText(_x,_y)
        local factor = (string.len(text)) / 250
        if dicks < 115 then
             DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 11, 1, 11, dicks)
        else
             DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 11, 1, 11, 115)
        end

    end
end

RegisterNetEvent('scaryLoop2')
AddEventHandler('scaryLoop2', function()
  if scaryloop2 then return end
  scaryloop2 = true
  while scary2 > 0 do
    if msgCount2 > 2.6 then
      scary2 = 0
   end
   Citizen.Wait(1)
   scary2 = scary2 - 1
  end
  dicks2 = 0
  scaryloop2 = false
  scary2 = 0
  msgCount2 = 0
end)



RegisterCommand("ooc_toggle", function(source, args)
  enabled = not enabled
  TriggerEvent("DoLongHudText", ('OOC has been %s!'):format(enabled and 'Enabled' or 'Disabled')) -- Pkarti was here
end)