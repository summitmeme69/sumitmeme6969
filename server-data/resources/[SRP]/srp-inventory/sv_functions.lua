Citizen.CreateThread(function()
    TriggerEvent("inv:playerSpawned");
end)

RegisterServerEvent("server-item-quality-update")
AddEventHandler("server-item-quality-update", function(player, data)
    if data.quality < 1 then
        exports.ghmattimysql:execute("UPDATE user_inventory2 SET `quality` = @quality WHERE name = @name AND slot = @slot AND item_id = @item_id", {
            ['quality'] = "0", 
            ['name'] = 'ply-' ..player, 
            ['slot'] = data.slot,
            ['item_id'] = data.itemid
        })
    end
end)


RegisterServerEvent('people-search')
AddEventHandler('people-search', function(target)
    local source = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(target)
    local characterId = user:getVar("character").id
	TriggerClientEvent("server-inventory-open", source, "1", 'ply-'.. characterId)
end)

RegisterServerEvent('Stealtheybread')
AddEventHandler('Stealtheybread', function(target)
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local targetply = exports["srp-base"]:getModule("Player"):GetUser(target)
    user:addMoney(targetply:getCash())
    targetply:removeMoney(targetply:getCash())
end)


RegisterNetEvent('srp-weapons:getAmmo')
AddEventHandler('srp-weapons:getAmmo', function()
    local ammoTable = {}
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute("SELECT type, ammo FROM characters_weapons WHERE id = @id", {['id'] = char.id}, function(result)
        for i = 1, #result do
            if ammoTable["" .. result[i].type .. ""] == nil then
                ammoTable["" .. result[i].type .. ""] = {}
                ammoTable["" .. result[i].type .. ""]["ammo"] = result[i].ammo
                ammoTable["" .. result[i].type .. ""]["type"] = ""..result[i].type..""
            end
        end
        TriggerClientEvent('srp-items:SetAmmo', src, ammoTable)
    end)
end)

RegisterNetEvent('srp-weapons:updateAmmo')
AddEventHandler('srp-weapons:updateAmmo', function(newammo,ammoType,ammoTable)
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT ammo FROM characters_weapons WHERE type = @type AND id = @identifier',{['@type'] = ammoType, ['@identifier'] = char.id}, function(result)
        if result[1] == nil then
            exports.ghmattimysql:execute('INSERT INTO characters_weapons (id, type, ammo) VALUES (@identifier, @type, @ammo)', {
                ['@identifier'] = char.id,
                ['@type'] = ammoType,
                ['@ammo'] = newammo
            }, function()
            end)
        else
            exports.ghmattimysql:execute('UPDATE characters_weapons SET ammo = @newammo WHERE type = @type AND ammo = @ammo AND id = @identifier', {
                ['@identifier'] = char.id,
                ['@type'] = ammoType,
                ['@ammo'] = result[1].ammo,
                ['@newammo'] = newammo
            }, function()
            end)
        end
    end)
end)

RegisterServerEvent("srp-inventory:update:settings")
AddEventHandler("srp-inventory:update:settings", function(data)
    local src = source
    local user = GetPlayerIdentifiers(src)[1]
    local insert = {
        ["holdToDrag"] = data.holdToDrag,
        ["closeOnClick"] = data.closeOnClick,
        ["ctrlMovesHalf"] = data.ctrlMovesHalf,
        ["showTooltips"] = data.showTooltips,
        ["enableBlur"] = data.enableBlur
    }
    local encode = json.encode(insert)
    exports.ghmattimysql:execute('UPDATE users SET inventory_settings = ? WHERE hex_id = ?', {encode, user})
end)

RegisterServerEvent("srp-inventory:RetreiveSettings")
AddEventHandler("srp-inventory:RetreiveSettings", function()
    local src = source
    local user = GetPlayerIdentifiers(src)[1]
    exports.ghmattimysql:execute("SELECT `inventory_settings` FROM users WHERE hex_id = @hex_id", {['hex_id'] = user}, function(result)
        if (result[1]) then
            TriggerClientEvent('srp-base:update:settings', src, result[1].inventory_settings)
        end
    end)
end)

