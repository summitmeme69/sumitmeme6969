local robbableItems = {
 [1] = {chance = 3, id = 0, quantity = math.random(20, 50)},
 [2] = {chance = 2, id = 'plastic', quantity = math.random(1, 2)},
 [3] = {chance = 3, id = 'pistolammo', quantity = 1},
 [4] = {chance = 5, id = 'rollcash', quantity = math.random(3,5)},
 [5] = {chance = 6, id = 'cuffs', quantity = 1},
 [6] = {chance = 8, id = 'oxy', quantity = math.random(2,3)},
 [7] = {chance = 15, id = 'band', quantity = math.random(1,2)},
}

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local user = exports["srp-base"]:getModule("Player"):GetUser(source)
 TriggerClientEvent('inventory:removeItem', source, 'lockpick', 1)
 TriggerClientEvent('DoLongHudText',  source, 'The lockpick bent out of shape' , 1)
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
 local source = tonumber(source)
 local user = exports["srp-base"]:getModule("Player"):GetUser(source)
 local cash = math.random(350, 450)
 user:addMoney(cash)
 TriggerClientEvent('DoLongHudText',  source, 'You found a $'..cash , 1)
 TriggerClientEvent("robbery:register:finishedLockpick", source)
 TriggerClientEvent("houseRobberies:reset", source)
end)


RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local source = tonumber(source)
 local item = {}
 local user = exports["srp-base"]:getModule("Player"):GetUser(source)
 local gotID = {}

 for i=1, math.random(1, 2) do
  item = robbableItems[math.random(1, #robbableItems)]
  if math.random(1, 15) >= item.chance then
    if tonumber(item.id) == 0 and not gotID[item.id] then
      gotID[item.id] = true
      user:addMoney(item.quantity)
      TriggerClientEvent('DoLongHudText',  source, 'You found $'..item.quantity , 1)
    elseif not gotID[item.id] then
      gotID[item.id] = true
      TriggerClientEvent('player:receiveItem', source, item.id, item.quantity)
      TriggerClientEvent('DoLongHudText', source, 'You found '..item.id, 1)
    end
  else
    TriggerClientEvent('DoLongHudText', source, 'You found nothing', 1)
    end
  end
end)
