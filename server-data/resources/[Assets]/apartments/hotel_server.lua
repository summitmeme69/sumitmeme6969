local motels = {}
local houses = {}
local IsNewLogin = false

RegisterServerEvent('character:loadspawns')
AddEventHandler('character:loadspawns', function(cid, NewPlayer)
    houses = {}
    motels = {}
    local src = source
    local pussy = 0
    local number = math.random(1,88)
    local asshole = {}
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local cid = char.id
    IsNewLogin = NewPlayer
    exports.ghmattimysql:execute("SELECT * FROM __motels WHERE cid= ?", {cid}, function(data)
        asshole = data
        if data[1] == nil then
            table.insert(motels, {owner = cid, roomnumber = number})
            exports.ghmattimysql:execute("SELECT * FROM __housedata WHERE cid= ?", {cid}, function(chicken)
                exports.ghmattimysql:execute("SELECT * FROM __housekeys WHERE cid= ?", {cid}, function(chicken2)
                    for k, r in pairs(chicken) do
                        if r ~= nil then
                            if r.housename ~= nil then
                                local random = math.random(1111,9999)
                                houses[random] = {}
                                table.insert(houses[random], {["house_name"] = r.housename, ["house_model"] = r.house_model, ["house_id"] = r.house_id})
                            end
                        end
                    end
                    for k, j in pairs(chicken2) do
                        if j ~= nil then
                            if j.housename ~= nil then
                                local random = math.random(1111,9999)
                                houses[random] = {}
                                table.insert(houses[random], {["house_name"] = j.housename, ["house_model"] = j.house_model, ["house_id"] = j.house_id})
                            end
                        end
                    end
                    for k, v in pairs(motels) do
                        if v.owner == cid then
                            pussy = v.roomnumber
                        end
                    end
                    
                    if IsNewLogin then
                        TriggerClientEvent("hotel:creation:character", src, pussy, 1)
                        TriggerClientEvent('hotel:SetID', src, cid)
                    else
                        TriggerClientEvent('hotel:createRoom1', src, pussy, 1, houses)
                        TriggerClientEvent('hotel:SetID', src, cid)
                        TriggerEvent("raid_clothes:get_character_current", src)
                    end
                end)
            end)
        else

            exports.ghmattimysql:execute("SELECT * FROM __housedata WHERE cid= ?", {cid}, function(chicken)
                exports.ghmattimysql:execute("SELECT * FROM __housekeys WHERE cid= ?", {cid}, function(chicken2)
                    for k, r in pairs(chicken) do
                        if r ~= nil then
                            if r.housename ~= nil then
                                local random = math.random(1111,9999)
                                houses[random] = {}
                                table.insert(houses[random], {["house_name"] = r.housename, ["house_model"] = r.house_model, ["house_id"] = r.house_id})
                     
                            end
                        end
            

                    end

                    for k, j in pairs(chicken2) do
                        if j ~= nil then
                            if j.housename ~= nil then
                                local random = math.random(1111,9999)
                                houses[random] = {}
                                table.insert(houses[random], {["house_name"] = j.housename, ["house_model"] = j.house_model, ["house_id"] = j.house_id})
                            end
                        end
                    end
                    TriggerClientEvent('hotel:createRoom1', src, asshole[1].roomNumber, asshole[1].roomType, houses)
                    TriggerClientEvent('hotel:SetID', src, cid)
                    TriggerEvent("raid_clothes:get_character_current", src)
                    
                end)
            end)
        end
    end)
end)

RegisterServerEvent('hotel:updatelocks')
AddEventHandler('hotel:updatelocks', function(status)
    local src = source
    TriggerClientEvent('hotel:updateLockStatus', src, status)
end)

RegisterServerEvent('hotel:room')
AddEventHandler('hotel:room', function(curRoomType)
    local src = source
    TriggerClientEvent("DoLongHudText", src, "Your Motel Is Located At  (Hotel-" .. tonumber(curRoomType) .. ")")
end)

RegisterServerEvent('hotel:clearStates')
AddEventHandler('hotel:clearStates', function(cid)
    for k, v in pairs(motels) do
        if v.owner == cid then
            table.remove(motels, k)
        end
    end
end)

RegisterServerEvent('hotel:upgradeApartment')
AddEventHandler('hotel:upgradeApartment', function(cid, roomType, roomNumber)
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    for k, v in pairs(motels) do
        if v.owner == cid then
            table.remove(motels, k)
        end
    end
    if roomType == 1 then
        exports.ghmattimysql:execute('INSERT INTO __motels(cid, roomType, roomNumber) VALUES(?, ?, ?)', {cid, 2, roomNumber})
        exports.ghmattimysql:execute("UPDATE user_inventory2 SET name = @newname WHERE name = @oldname", {
            ['@newname'] = "motel2-"..char.id,
            ['@oldname'] = "motel1-"..char.id
        })
        TriggerClientEvent('newRoomType', src, 2)
    else
        TriggerClientEvent('DoLongHudText', src, "You already have an Apartment", 2)
    end
end)

RegisterServerEvent("hotel:attempting")
AddEventHandler("hotel:attempting", function(amount)
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    if (tonumber(user:getBalance()) >= tonumber(amount)) then
        user:removeBank(tonumber(amount))
        TriggerClientEvent("integrity:confirmed", src)
    else
        TriggerClientEvent("DoLongHudText", src, "You cant afford this upgrade")
    end
end)