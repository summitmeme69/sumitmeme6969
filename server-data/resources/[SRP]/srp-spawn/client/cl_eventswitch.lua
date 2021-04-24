function Login.playerLoaded() end

function Login.characterLoaded()
  -- Main events leave alone 
  TriggerEvent("srp-base:playerSpawned")
  TriggerEvent("loadedinafk")
  TriggerEvent("playerSpawned")
  TriggerServerEvent('character:loadspawns')
  TriggerServerEvent("kGetWeather")

  -- Main events leave alone 
  TriggerEvent("resetinhouse")
  TriggerEvent("fx:clear")
  TriggerServerEvent('tattoos:retrieve')
  TriggerServerEvent('Blemishes:retrieve')
  TriggerServerEvent("currentconvictions")
  TriggerServerEvent("GarageData")
  TriggerEvent("banking:viewBalance")
  TriggerServerEvent('srp-doors:requestlatest')
  TriggerServerEvent("srp-weapons:getAmmo")
  Wait(3000)
  TriggerServerEvent("bones:server:requestServer")

  	-- Events
	TriggerServerEvent("police:SetMeta")
	TriggerServerEvent("server:currentpasses")
	TriggerServerEvent("commands:player:login")
	TriggerServerEvent("retreive:licenes:server")
	TriggerServerEvent("srp-inventory:RetreiveSettings")
	--Licenses for hunting / fishing
	
	TriggerServerEvent('srp-fish:retreive:license')
	TriggerServerEvent('srp-hunting:retreive:license')

  -- Gang shit
  TriggerServerEvent('srp-territories:approvedgang')
  TriggerServerEvent('srp-territories:leader')
  TriggerServerEvent('srp-territories:grove')

  -- Jail/Bank Logs
	TriggerServerEvent("retreive:jail",exports["isPed"]:isPed("cid"))	
	TriggerServerEvent("bank:getLogs")
end

function Login.characterSpawned()

  isNear = false
  TriggerServerEvent('srp-base:sv:player_control')
  TriggerServerEvent('srp-base:sv:player_settings')

  TriggerServerEvent("TokoVoip:clientHasSelecterCharacter")
  TriggerEvent("spawning", false)
  TriggerEvent("attachWeapons")
  TriggerEvent("tokovoip:onPlayerLoggedIn", true)

  TriggerServerEvent("request-dropped-items")
  TriggerServerEvent("server-request-update", exports["isPed"]:isPed("cid"))
  TriggerServerEvent("stocks:retrieveclientstocks")

  if Spawn.isNew then
    Wait(1000)
    if not exports["srp-inventory"]:hasEnoughOfItem("mobilephone", 1, false) then
        TriggerEvent("player:receiveItem", "mobilephone", 1)
    end

    -- commands to make sure player is alive and full food/water/health/no injuries
    local src = GetPlayerServerId(PlayerId())
    TriggerServerEvent("reviveGranted", src)
    TriggerEvent("Hospital:HealInjuries", src, true)
    TriggerServerEvent("ems:healplayer", src)
    TriggerEvent("heal", src)
    TriggerEvent("status:needs:restore", src)
    TriggerServerEvent("srp-spawn:newPlayerFullySpawned")
  end
  SetPedMaxHealth(PlayerPedId(), 200)
  SetPlayerMaxArmour(PlayerId(), 60)
  runGameplay() -- moved from srp-base 
  Spawn.isNew = false
end
RegisterNetEvent("srp-spawn:characterSpawned");
AddEventHandler("srp-spawn:characterSpawned", Login.characterSpawned);
