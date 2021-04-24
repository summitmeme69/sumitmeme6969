local hmm = vehicleBaseRepairCost

RegisterServerEvent('srp-bennys:attemptPurchase')
AddEventHandler('srp-bennys:attemptPurchase', function(cheap, type, upgradeLevel)
	local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    if type == "repair" then
        if user:getCash() >= hmm then
            user:removeMoney(hmm)
            TriggerClientEvent('srp-bennys:purchaseSuccessful', source)
        else
            TriggerClientEvent('srp-bennys:purchaseFailed', source)
        end
    elseif type == "performance" then
        if user:getCash() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('srp-bennys:purchaseSuccessful', source)
            user:removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('srp-bennys:purchaseFailed', source)
        end
    else
        if user:getCash() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('srp-bennys:purchaseSuccessful', source)
            user:removeMoney(vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('srp-bennys:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('srp-bennys:updateRepairCost')
AddEventHandler('srp-bennys:updateRepairCost', function(cost)
    hmm = cost
end)

RegisterServerEvent('srp-bennys:repairciv')
AddEventHandler('srp-bennys:repairciv', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(450)
end)