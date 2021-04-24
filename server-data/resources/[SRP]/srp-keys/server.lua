RegisterServerEvent('keys:send')
AddEventHandler('keys:send', function(player, data)
    TriggerClientEvent('keys:received', player, data)
end)

RegisterServerEvent('enteredMyVehicle')
AddEventHandler('enteredMyVehicle', function(plate)
  local source = tonumber(source)
  local user = exports["srp-base"]:getModule("Player"):GetUser(source)
  local char = user:getCurrentCharacter()
  exports.ghmattimysql:execute("SELECT * FROM characters_cars WHERE cid = @cid AND license_plate = @license_plate", {
    ['@cid'] = char.id,
    ['@license_plate'] = plate
  }, function(data)
    if data[1] ~= nil then
      TriggerClientEvent('veh.checkOwner',source,true)
    else
      TriggerClientEvent('veh.checkOwner',source,false)
      TriggerClientEvent('veh.getDegredation',source,plate)
    end
  end)
end)