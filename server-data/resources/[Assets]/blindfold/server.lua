RegisterServerEvent('blindfold')
AddEventHandler('blindfold', function(t)
  local src = source
  TriggerClientEvent('blindfold', t,src)
  TriggerClientEvent("DoLongHudText", t, "You have been bagged nerd!")
end)

RegisterServerEvent('blindfoldoff')
AddEventHandler('blindfoldoff', function(t)
  local src = source
  TriggerClientEvent('blindfoldoff', t,src)
  TriggerClientEvent("DoLongHudText", t, "Unbagged!")
end)
