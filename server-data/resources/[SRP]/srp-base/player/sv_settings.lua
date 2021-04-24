RegisterServerEvent("srp-base:sv:player_settings_set")
AddEventHandler("srp-base:sv:player_settings_set", function(settingsTable)
    local src = source
    SRP.DB:UpdateSettings(src, settingsTable, function(UpdateSettings, err)
            if UpdateSettings then
                -- we are good here.
            end
    end)
end)

RegisterServerEvent("srp-base:sv:player_settings")
AddEventHandler("srp-base:sv:player_settings", function()
    local src = source
    SRP.DB:GetSettings(src, function(loadedSettings, err)
        if loadedSettings ~= nil then 
            TriggerClientEvent("srp-base:cl:player_settings", src, loadedSettings) 
        else 
            TriggerClientEvent("srp-base:cl:player_settings",src, nil) 
        end
    end)
end)
