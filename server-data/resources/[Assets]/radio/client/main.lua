local GuiOpened = false
RegisterNetEvent('radioGui')
AddEventHandler('radioGui', function()
  openGui()
end)

RegisterNetEvent('ChannelSet')
AddEventHandler('ChannelSet', function(chan)
  SendNUIMessage({set = true, setChannel = chan})
end)

RegisterNetEvent('radio:resetNuiCommand')
AddEventHandler('radio:resetNuiCommand', function()
    SendNUIMessage({reset = true})
end)

function openGui()
  if hasRadio() then
    local incall = exports["isPed"]:isPed("incall")
    if (incall) then
      TriggerEvent("DoShortHudText","You can not do that while in a call!",2)
      return
    end
    local job = exports["isPed"]:isPed("myjob")
    local Emergency = false
    if job == "police" then
      Emergency = true
    elseif job == "ems" then
      Emergency = true
    elseif job == "doctor" then
      Emergency = true
    end
    
    if not GuiOpened and hasRadio() then
      GuiOpened = true
      SetNuiFocus(false,false)
      SetNuiFocus(true,true)
      SendNUIMessage({open = true, jobType = Emergency})
    else
      GuiOpened = false
      SetNuiFocus(false,false)
      SendNUIMessage({open = false, jobType = Emergency})
    end
    toggleRadioAnimation(true)
    TriggerEvent("InteractSound_CL:PlayOnOne","radioon",0.6)
  end
end

function hasRadio()
  return exports["srp-inventory"]:hasEnoughOfItem("radio", 1, false)
end

RegisterNUICallback('click', function(data, cb)
  PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
end)

local vol = 30
RegisterNUICallback('volumeUp', function(data, cb)
  if vol < 100 then
    vol = vol + 10
    TriggerEvent("srp-voice:SetRadioVolume", vol)
    TriggerEvent('DoLongHudText', 'Volume ' ..vol/100)
  else
    TriggerEvent('DoLongHudText', 'Max Volume')
  end
end)

RegisterNUICallback('volumeDown', function(data, cb)
  vol = vol - 10
  if vol > 10 then
    TriggerEvent("srp-voice:SetRadioVolume", vol)
    TriggerEvent('DoLongHudText', 'Volume ' ..vol/100)
  else
    TriggerEvent('DoLongHudText', 'Lowest Volume')
  end
end)

RegisterNUICallback('cleanClose', function(data, cb)
  TriggerEvent("InteractSound_CL:PlayOnOne","radioon",0.6)
  GuiOpened = false
  SetNuiFocus(false,false)
  SendNUIMessage({open = false})
  TriggerEvent("animation:radio",GuiOpened)
end)

RegisterNUICallback('poweredOn', function(data, cb)
  TriggerEvent("InteractSound_CL:PlayOnOne","radioon",0.6)
  local fuckingidiot = tonumber(data.channel)
  if fuckingidiot == nil then
    fuckingidiot = 0
  end
  TriggerEvent('DoLongHudText', 'Radio On')

  exports['srp-voice']:addPlayerToRadio(fuckingidiot)
  exports["srp-voice"]:setVoiceProperty("radioEnabled", true)
end)

RegisterNUICallback('poweredOff', function(data, cb)
  TriggerEvent("InteractSound_CL:PlayOnOne","radiooff",0.6)
  TriggerEvent('DoLongHudText', 'Radio Off')

  exports['srp-voice']:removePlayerFromRadio()
  exports["srp-voice"]:setVoiceProperty("radioEnabled", false)
end)

local radioChannel = nil
RegisterNUICallback('close', function(data, cb)
  TriggerEvent("InteractSound_CL:PlayOnOne","radiooff",0.6)
  local fuckingidiot = tonumber(data.channel)
  if fuckingidiot == nil then
    fuckingidiot = 0
  end

  if fuckingidiot == 0 then
    TriggerEvent('DoLongHudText', 'Encrypted Channel', 2)
    exports['srp-voice']:removePlayerFromRadio()
    exports["srp-voice"]:setVoiceProperty("radioEnabled", false)
  else
    radioChannel = fuckingidiot
    exports['srp-voice']:addPlayerToRadio(radioChannel)
    exports["srp-voice"]:setVoiceProperty("radioEnabled", true)
  end

  GuiOpened = false
  SetNuiFocus(false,false)
  SendNUIMessage({open = false})
  toggleRadioAnimation()
  TriggerEvent("destroyPropRadio")
end)

function toggleRadioAnimation(pState)
  local isInTrunk = exports["isPed"]:isPed("intrunk")
  local isDead = exports["isPed"]:isPed("dead")

  if isInTrunk then return end
  if isDead then return end

  LoadAnimationDic("cellphone@")

  if pState then
    TriggerEvent("attachItemRadio","radio01")
    TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
  else
    StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 1.0)
    TriggerEvent("destroyPropRadio")
  end
end

function LoadAnimationDic(dict)
  if not HasAnimDictLoaded(dict) then
      RequestAnimDict(dict)

      while not HasAnimDictLoaded(dict) do
          Citizen.Wait(0)
      end
  end
end


Citizen.CreateThread(function()
  while true do
    if GuiOpened then
      Citizen.Wait(1)
      DisableControlAction(0, 1, GuiOpened) -- LookLeftRight
      DisableControlAction(0, 2, GuiOpened) -- LookUpDown
      DisableControlAction(0, 14, GuiOpened) -- INPUT_WEAPON_WHEEL_NEXT
      DisableControlAction(0, 15, GuiOpened) -- INPUT_WEAPON_WHEEL_PREV
      DisableControlAction(0, 16, GuiOpened) -- INPUT_SELECT_NEXT_WEAPON
      DisableControlAction(0, 17, GuiOpened) -- INPUT_SELECT_PREV_WEAPON
      DisableControlAction(0, 99, GuiOpened) -- INPUT_VEH_SELECT_NEXT_WEAPON
      DisableControlAction(0, 100, GuiOpened) -- INPUT_VEH_SELECT_PREV_WEAPON
      DisableControlAction(0, 115, GuiOpened) -- INPUT_VEH_FLY_SELECT_NEXT_WEAPON
      DisableControlAction(0, 116, GuiOpened) -- INPUT_VEH_FLY_SELECT_PREV_WEAPON
      DisableControlAction(0, 142, GuiOpened) -- MeleeAttackAlternate
      DisableControlAction(0, 106, GuiOpened) -- VehicleMouseControlOverride
    else
      Citizen.Wait(20)
    end    
  end
end)


-- RegisterNetEvent('srp-binds:keyEvent')
-- AddEventHandler('srp-binds:keyEvent', function(name,onDown)
--     if name ~= "radio" then return end
--     if onDown then 
--       openGui() 
--     end
-- end)

RegisterCommand("channel", function(source, args)
  if radioChannel ~= nil then
    TriggerEvent("DoLongHudText", "Current radio channel: " ..radioChannel)
  else
    TriggerEvent("DoLongHudText", "Your not on a radio channel!", 2)
  end
end)