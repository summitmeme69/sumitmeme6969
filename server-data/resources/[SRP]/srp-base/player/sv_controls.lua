RegisterServerEvent("srp-base:sv:player_control_set")
AddEventHandler("srp-base:sv:player_control_set", function(controlsTable)
    local src = source
    SRP.DB:UpdateControls(src, controlsTable, function(UpdateControls, err)
            if UpdateControls then
                -- we are good here.
            end
    end)
end)

RegisterServerEvent("srp-base:sv:player_controls")
AddEventHandler("srp-base:sv:player_controls", function()
    local src = source
    SRP.DB:GetControls(src, function(loadedControls, err)
        if loadedControls ~= nil then 
            TriggerClientEvent("srp-base:cl:player_control", src, loadedControls) 
        else 
            TriggerClientEvent("srp-base:cl:player_control",src, nil)
        end
    end)
end)
