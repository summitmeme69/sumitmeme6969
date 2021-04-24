
local degHealth = {
    ["breaks"] = 0,-- has neg effect
    ["axle"] = 0,	-- has neg effect
    ["radiator"] = 0, -- has neg effect
    ["clutch"] = 0,	-- has neg effect
    ["transmission"] = 0, -- has neg effect
    ["electronics"] = 0, -- has neg effect
    ["fuel_injector"] = 0, -- has neg effect
    ["fuel_tank"] = 0 
}


RegisterServerEvent("mech:check:materials")
AddEventHandler("mech:check:materials", function(shop, srcID)
    if not srcID then
        src = source
    else
        src = srcID
    end
    exports.ghmattimysql:execute('SELECT * FROM mech_materials WHERE Shop = @Shop', {['@Shop'] = shop}, function (result) 
        if result ~= nil then
            local strng = "\n Aluminium - " .. result[1]["aluminium"] .. " \n Rubber - " .. result[1]["rubber"] .. " \n Scrap - " .. result[1]["scrapmetal"] .. " \n Plastic - " .. result[1]["plastic"] .. " \n Copper - " .. result[1]["copper"] .. " \n Steel - " .. result[1]["steel"] .. " \n Glass - " .. result[1]["glass"]
            TriggerClientEvent("customNotification",src,strng)
        end
    end)
end)


RegisterServerEvent("mech:add:materials")
AddEventHandler("mech:add:materials", function(materials,amount, shop)
    local src = source
    if amount > 0 then
        AddMats(src, materials, amount, shop)
        TriggerClientEvent('inventory:removeItem',src, string.lower(materials), amount)
        Citizen.Wait(200)
        TriggerEvent("mech:check:materials", shop, src)
    end
end)


RegisterServerEvent("mech:remove:materials")
AddEventHandler("mech:remove:materials", function(materials, amount, deg, plate, shop)
    local src = source
    if not amount then
        TriggerClientEvent('DoLongHudText',src, 'Error: You need to do /mechadd [part] [amount]', 2) 
        return
    end
    UpdateDBMats(src, materials, amount, shop, deg, plate)
    TriggerClientEvent('DoShortHudText', src,'Vehicle has been updated with repairs!')
    Citizen.Wait(500)
    TriggerClientEvent('veh:requestUpdate', src)   
end)


RegisterServerEvent("transfer:attempt:send")
AddEventHandler("transfer:attempt:send", function(plate, target)
    local pSrc = source
    local pUser = exports["srp-base"]:getModule("Player"):GetUser(pSrc)
    local pChar = pUser:getCurrentCharacter().id
    local pSteam = GetPlayerIdentifiers(pSrc)[1]

    -- target shit
    local tUser = exports["srp-base"]:getModule("Player"):GetUser(target)
    local tChar = tUser:getCurrentCharacter().id
    local tSteam = GetPlayerIdentifiers(target)[1]

    exports.ghmattimysql:execute("SELECT * FROM characters_cars WHERE cid = ? AND license_plate = ?",{pChar, plate}, function(data)
        if data[1] then
            exports.ghmattimysql:execute("UPDATE characters_cars SET `cid` = @cid, `owner` = @owner WHERE license_plate = @license_plate", {
                ['cid'] = tChar, 
                ['owner'] = tSteam,
                ['license_plate'] = plate
            })
            TriggerClientEvent("DoLongHudText", pSrc, "You have successfully transfered this vehicle!")
            TriggerClientEvent("DoLongHudText", target, "You have successfully received keys to your new ride!")
            TriggerClientEvent("keys:remove", pSrc, plate)
            TriggerClientEvent('keys:received', target, plate)
        else
            TriggerClientEvent("DoLongHudText", pSrc, "You dont own this vehicle", 2)
        end

    end)
end)


function UpdateDBMats(srcID, part, amount, shop, deg, plate)
    local mat = string.lower(part)
    exports.ghmattimysql:execute("SELECT * FROM mech_materials WHERE Shop = ?",{shop}, function(data)
        if data[1][mat] > tonumber(0) then
            local updateDB = data[1][mat] - amount
            exports.ghmattimysql:execute("UPDATE mech_materials SET "..mat.." = @parts WHERE Shop = @Shop", {
                ['@parts'] = updateDB,
                ['@Shop'] = shop
            })
            UpdateDeg(deg, plate)
        else
            TriggerClientEvent("DoLongHudText", srcID, "You do not have enough " ..mat.." to finish the repair")
        end
    end)
end


function AddMats(srcID, part, amount, shop)
    local mat = string.lower(part)
    exports.ghmattimysql:execute("SELECT * FROM mech_materials WHERE Shop = ?",{shop}, function(data)
        local updateDB = data[1][mat] + amount
        exports.ghmattimysql:execute("UPDATE mech_materials SET "..mat.." = @parts WHERE Shop = @Shop", {
            ['@parts'] = updateDB,
            ['@Shop'] = shop
        })
        TriggerClientEvent("DoLongHudText", srcID, "Shop inventory updated!")
    end)
end


function UpdateDeg(deg, plate)
    exports.ghmattimysql:execute("UPDATE characters_cars SET degredation = @degredation WHERE license_plate = @license_plate", {
        ['@degredation'] = deg,
        ['@license_plate'] = plate
    })
end



RegisterNetEvent('scrap:towTake')
AddEventHandler('scrap:towTake', function(degname,itemname,plate, amount, removepart)
    local _src = source
    local amount = amount*10
    exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE license_plate = @license_plate', {['@license_plate'] = plate}, function (result) 
        local deg = result[1].degredation
        degMe = result[1].degredation
        local temp = deg:split(",")
        if(temp[1] ~= nil) then	
            for i,v in ipairs(temp) do
                if i == 1 then
                    degHealth.breaks = tonumber(v)
                    if degHealth.breaks == nil then
                        degHealth.breaks = 0
                    end
                elseif i == 2 then
                    degHealth.axle = tonumber(v)
                elseif i == 3 then
                    degHealth.radiator = tonumber(v)
                elseif i == 4 then
                    degHealth.clutch = tonumber(v)
                elseif i == 5 then
                    degHealth.transmission = tonumber(v)
                elseif i == 6 then
                    degHealth.electronics = tonumber(v)
                elseif i == 7 then
                    degHealth.fuel_injector = tonumber(v)
                elseif i == 8 then	
                    degHealth.fuel_tank = tonumber(v)
                end
            end
        end
        local updateDB = ""  
        if degname == "breaks" then 
        degHealth["breaks"] = degHealth["breaks"] + amount
        if degHealth["breaks"] > 100 then
            degHealth["breaks"] = 100
        end
        updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
        elseif degname == "axle" then
            degHealth["axle"] = degHealth["axle"] + amount
            if degHealth["axle"] > 100 then
                degHealth["axle"] = 100
            end
        updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
        elseif degname == "radiator" then
            degHealth["radiator"] = degHealth["radiator"] + amount
            if degHealth["radiator"] > 100 then
                degHealth["radiator"] = 100
            end
        updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
        elseif degname == "clutch" then
            degHealth["clutch"] = degHealth["clutch"] + amount
            if degHealth["clutch"] > 100 then
                degHealth["clutch"] = 100
            end
        updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
        elseif degname == "transmission" then
            degHealth["transmission"] = degHealth["transmission"] + amount
            if degHealth["transmission"] > 100 then
                degHealth["transmission"] = 100
            end
        updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
        elseif degname == "electronics" then
            degHealth["electronics"] = degHealth["electronics"] + amount
            if degHealth["electronics"] > 100 then
                degHealth["electronics"] = 100
            end
        updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
        elseif degname == "fuel_injector" then
            degHealth["fuel_injector"] = degHealth["fuel_injector"] + amount
            if degHealth["fuel_injector"] > 100 then
                degHealth["fuel_injector"] = 100
            end
        updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
        elseif degname == "fuel_tank" then
            degHealth["fuel_tank"] = degHealth["fuel_tank"] + amount
            if degHealth["fuel_tank"] > 100 then
                degHealth["fuel_tank"] = 100
            end
        updateDB = degHealth["breaks"]..","..degHealth["axle"]..","..degHealth["radiator"]..","..degHealth["clutch"]..","..degHealth["transmission"]..","..degHealth["electronics"]..","..degHealth["fuel_injector"]..","..degHealth["fuel_tank"]
        end 
        TriggerClientEvent('mech:tools:cl', _src, itemname, removepart, updateDB, plate)
    end)
end)


function string:split(delimiter)
    local result = { }
    local from  = 1
    local delim_from, delim_to = string.find( self, delimiter, from  )
    while delim_from do
      table.insert( result, string.sub( self, from , delim_from-1 ) )
      from  = delim_to + 1
      delim_from, delim_to = string.find( self, delimiter, from  )
    end
    table.insert( result, string.sub( self, from  ) )
    return result
end
