RegisterServerEvent('srp:idcard')
AddEventHandler('srp:idcard', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    if (tonumber(user:getCash()) >= 500) then
        user:removeMoney(50)
        TriggerClientEvent('courthouse:idbuy', src)
    else
        TriggerClientEvent("DoLongHudText", src, "You need $50", 2)
    end
end)

RegisterServerEvent('cash:remove')
AddEventHandler('cash:remove', function(pSrc, amount)
    local user = exports["srp-base"]:getModule("Player"):GetUser(tonumber(pSrc))
	if (tonumber(user:getCash()) >= amount) then
		user:removeMoney(amount)
	end
end)