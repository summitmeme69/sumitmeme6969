SRP.SettingsData = SRP.SettingsData or {}
SRP.Settings = SRP.Settings or {}

SRP.Settings.Current = {}
-- Current bind name and keys
SRP.Settings.Default = {
  ["tokovoip"] = {
    ["stereoAudio"] = true,
    ["localClickOn"] = true,
    ["localClickOff"] = true,
    ["remoteClickOn"] = true,
    ["remoteClickOff"] = true,
    ["clickVolume"] = 0.8,
    ["radioVolume"] = 0.8,
    ["phoneVolume"] = 0.8,
    ["releaseDelay"] = 200
  },
  ["hud"] = {

  }

}


function SRP.SettingsData.setSettingsTable(settingsTable, shouldSend)
  if settingsTable == nil then
    SRP.Settings.Current = SRP.Settings.Default
    TriggerServerEvent('srp-base:sv:player_settings_set',SRP.Settings.Current)
    SRP.SettingsData.checkForMissing()
  else
    if shouldSend then
      SRP.Settings.Current = settingsTable
      TriggerServerEvent('srp-base:sv:player_settings_set',SRP.Settings.Current)
      SRP.SettingsData.checkForMissing()
    else
       SRP.Settings.Current = settingsTable
       SRP.SettingsData.checkForMissing()
    end
  end

  TriggerEvent("event:settings:update",SRP.Settings.Current)

end

function SRP.SettingsData.setSettingsTableGlobal(self, settingsTable)
  SRP.SettingsData.setSettingsTable(settingsTable,true);
end

function SRP.SettingsData.getSettingsTable()
    return SRP.Settings.Current
end

function SRP.SettingsData.setVarible(self,tablename,atrr,val)
  SRP.Settings.Current[tablename][atrr] = val
  TriggerServerEvent('srp-base:sv:player_settings_set',SRP.Settings.Current)
end

function SRP.SettingsData.getVarible(self,tablename,atrr)
  return SRP.Settings.Current[tablename][atrr]
end

function SRP.SettingsData.checkForMissing()
  local isMissing = false

  for j,h in pairs(SRP.Settings.Default) do
    if SRP.Settings.Current[j] == nil then
      isMissing = true
      SRP.Settings.Current[j] = h
    else
      for k,v in pairs(h) do
        if  SRP.Settings.Current[j][k] == nil then
           SRP.Settings.Current[j][k] = v
           isMissing = true
        end
      end
    end
  end
  

  if isMissing then
    TriggerServerEvent('srp-base:sv:player_settings_set',SRP.Settings.Current)
  end


end

RegisterNetEvent("srp-base:cl:player_settings")
AddEventHandler("srp-base:cl:player_settings", function(settingsTable)
  SRP.SettingsData.setSettingsTable(settingsTable,false)
end)


RegisterNetEvent("srp-base:cl:player_reset")
AddEventHandler("srp-base:cl:player_reset", function(tableName)
  if SRP.Settings.Default[tableName] then
      if SRP.Settings.Current[tableName] then
        SRP.Settings.Current[tableName] = SRP.Settings.Default[tableName]
        SRP.SettingsData.setSettingsTable(SRP.Settings.Current,true)
      end
  end
end)