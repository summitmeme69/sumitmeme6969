RegisterServerEvent('setupgangcash')
AddEventHandler('setupgangcash', function(amount)
local src = source
local user = exports["srp-base"]:getModule("Player"):GetUser(src)
if (tonumber(user:getBalance()) >= tonumber(amount)) then
    user:removeMoney(tonumber(amount))
else
    TriggerClientEvent('DoLongHudText', src, "Quit wasting my time and come back when you have the shit.", 1)
end
end)

RegisterServerEvent('setupgangdb')
AddEventHandler("setupgangdb", function(groupname)
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local gang = groupname
	TriggerClientEvent('DoLongHudText', src, "The Group ".. groupname .." has been started!", 1)
        exports.ghmattimysql:execute('INSERT INTO gangs (cid, gang_name, reputation, leader, ingang, grove, covenant, brouge, forum, jamestown, mirrorpark, fudge, vespucci, cougar, harmony) VALUES (@cid, @gang_name, @reputation, @leader, @ingang, @grove, @covenant, @brouge, @forum, @jamestown, @mirrorpark, @fudge, @vespucci, @cougar, @harmony)', {
        ['@cid'] = char.id,
        ['@gang_name'] = gang,
        ['@reputation'] = "0",
        ['@leader'] = "1",
        ['@ingang'] = "1",
        ['@grove'] = "0",
        ['@covenant'] = "0",
        ['@brouge'] = "0",
        ['@forum'] = "0",
        ['@jamestown'] = "0",
        ['@mirrorpark'] = "0",
        ['@fudge'] = "0",
        ['@vespucci'] = "0",
        ['@cougar'] = "0",
        ['@harmony'] = "0",
        },function(data)
        TriggerClientEvent("gang:approved", src, true)
        TriggerClientEvent("gang:leader", src, true)
    end)
end)

RegisterServerEvent("srp-territories:approvedgang")
AddEventHandler("srp-territories:approvedgang", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid`= ? AND `ingang` = ?', {character.id, "1"}, function(data)
		if data[1] then
            TriggerClientEvent("gang:approved", src, true)
        end
    end)
end)

RegisterServerEvent("srp-territories:leader")
AddEventHandler("srp-territories:leader", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid`= ? AND `leader` = ?', {character.id, "1"}, function(data)
		if data[1] then
            TriggerClientEvent("gang:leader", src, true)
        end
    end)
end)

RegisterServerEvent("srp-territories:grove")
AddEventHandler("srp-territories:grove", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid`= ? AND `grove` = ?', {character.id, "1"}, function(data)
		if data[1] then
            TriggerClientEvent("gang:targettinggrove", src, true)
        end
    end)
end)

RegisterServerEvent("srp-territories:covenant")
AddEventHandler("srp-territories:covenant", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid`= ? AND `covenant` = ?', {character.id, "1"}, function(data)
		if data[1] then
            TriggerClientEvent("gang:targettingcov", src, true)
        end
    end)
end)

RegisterServerEvent("srp-territories:brouge")
AddEventHandler("srp-territories:brouge", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid`= ? AND `brouge` = ?', {character.id, "1"}, function(data)
		if data[1] then
            TriggerClientEvent("gang:targettingbrouge", src, true)
        end
    end)
end)

RegisterServerEvent("srp-territories:forum")
AddEventHandler("srp-territories:forum", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid`= ? AND `forum` = ?', {character.id, "1"}, function(data)
		if data[1] then
            TriggerClientEvent("gang:targettingforum", src, true)
        end
    end)
end)

RegisterServerEvent("srp-territories:jamestown")
AddEventHandler("srp-territories:jamestown", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid`= ? AND `jamestown` = ?', {character.id, "1"}, function(data)
		if data[1] then
            TriggerClientEvent("gang:targettingjamestown", src, true)
        end
    end)
end)

RegisterServerEvent("srp-territories:mirrorpark")
AddEventHandler("srp-territories:mirrorpark", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid`= ? AND `mirrorpark` = ?', {character.id, "1"}, function(data)
		if data[1] then
            TriggerClientEvent("gang:targettingmirror", src, true)
        end
    end)
end)

RegisterServerEvent("srp-territories:fudge")
AddEventHandler("srp-territories:fudge", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid`= ? AND `fudge` = ?', {character.id, "1"}, function(data)
		if data[1] then
            TriggerClientEvent("gang:targettingfudge", src, true)
        end
    end)
end)

RegisterServerEvent("srp-territories:vespucci")
AddEventHandler("srp-territories:vespucci", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid`= ? AND `vespucci` = ?', {character.id, "1"}, function(data)
		if data[1] then
            TriggerClientEvent("gang:targettingvespucci", src, true)
        end
    end)
end)

RegisterServerEvent("srp-territories:cougar")
AddEventHandler("srp-territories:cougar", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid`= ? AND `cougar` = ?', {character.id, "1"}, function(data)
		if data[1] then
            TriggerClientEvent("gang:targettingcougar", src, true)
        end
    end)
end)

RegisterServerEvent("srp-territories:harmony")
AddEventHandler("srp-territories:harmony", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid`= ? AND `harmony` = ?', {character.id, "1"}, function(data)
		if data[1] then
            TriggerClientEvent("gang:targettingharmony", src, true)
        end
    end)
end)

RegisterServerEvent('gangs:invmembers')
AddEventHandler("gangs:invmembers", function(TargetID)
    local src = source
	local target = tonumber(TargetID)
	local user = exports["srp-base"]:getModule("Player"):GetUser(target)
    local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT gang_name,reputation FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
        if result[1].gang_name or result[1].reputation then
            print(result[1].gang_name)
            print(result[1].reputation)
        exports.ghmattimysql:execute("UPDATE characters SET `ingang` = @ingang WHERE `id` = @id", { ['ingang'] = "1", ['id'] = target})
        exports.ghmattimysql:execute('INSERT INTO gangs (cid, gang_name, reputation, leader, ingang, grove, covenant, brouge, forum, jamestown, mirrorpark, fudge, vespucci, cougar, harmony) VALUES (@cid, @gang_name, @reputation, @leader, @ingang, @grove, @covenant, @brouge, @forum, @jamestown, @mirrorpark, @fudge, @vespucci, @cougar, @harmony)', {
            ['@cid'] = target,
            ['@gang_name'] = result[1].gang_name,
            ['@reputation'] = result[1].reputation,
            ['@leader'] = "1",
            ['@ingang'] = "1",
            ['@grove'] = "0",
            ['@covenant'] = "0",
            ['@brouge'] = "0",
            ['@forum'] = "0",
            ['@jamestown'] = "0",
            ['@mirrorpark'] = "0",
            ['@fudge'] = "0",
            ['@vespucci'] = "0",
            ['@cougar'] = "0",
            ['@harmony'] = "0",
            },function(data)
            TriggerClientEvent("gang:approved", target, true)
            TriggerClientEvent('DoLongHudText', src, "Invited CID ".. target .." To The "..result[1].gang_name.."!", 1)
            end)
        end
    end)
end)

RegisterServerEvent('gangs:removemembers')
AddEventHandler("gangs:removemembers", function(TargetID)
    local src = source
	local target = tonumber(TargetID)
	local user = exports["srp-base"]:getModule("Player"):GetUser(target)
    exports.ghmattimysql:execute('DELETE FROM gangs WHERE `cid`= ?', {target})
    TriggerClientEvent("gang:approved", target, false)
    TriggerClientEvent('DoLongHudText', src, "Removed Player ".. target .." From The Group!", 1)
end)

function updatePlayerInfo(source)
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM `gangs` WHERE `cid` = @cid', {['@cid'] = char.id}, function(rep)
        if ( rep and rep[1] ) then
              TriggerClientEvent('territories:getRep', src, rep[1].reputation)
          end
      end)
  end

RegisterServerEvent("srp-territories:addrep")
AddEventHandler("srp-territories:addrep", function(source, amount)
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(rep)
    exports.ghmattimysql:execute('SELECT gang_name FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
		exports.ghmattimysql:execute('UPDATE `gangs` SET `reputation` = @reputation WHERE `gang_name` = @gang_name',
			{
			['@reputation'] = (rep[1].reputation + amount),
			['@gang_name'] = result[1].gang_name
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)
end)

 RegisterServerEvent("territories:getRep")
 AddEventHandler("territories:getRep", function()
     local src = source
     local user = exports["srp-base"]:getModule("Player"):GetUser(src)
     local char = user:getCurrentCharacter()
     exports.ghmattimysql:execute('SELECT gang_name FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
     exports.ghmattimysql:execute("SELECT reputation FROM gangs WHERE gang_name = @gang_name", {['gang_name'] = result[1].gang_name}, function(result)
         if result[1].reputation then
            local rep = json.decode(result[1].reputation)
         TriggerClientEvent("mt:missiontext", src, "Your Groups Reputation Is ".. rep, 2500)
        end
    end)
end)
end)

RegisterServerEvent("targetgrove")
AddEventHandler("targetgrove", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result2)
        exports.ghmattimysql:execute('SELECT gang_name FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
            exports.ghmattimysql:execute('UPDATE `gangs` SET `grove` = @grove WHERE `gang_name` = @gang_name',
                {
                ['@grove'] = "1",
                ['@gang_name'] = result[1].gang_name
                }, function ()
            end)
        end)
    end)
end)

RegisterServerEvent("targetcovenant")
AddEventHandler("targetcovenant", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result2)
        exports.ghmattimysql:execute('SELECT gang_name FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
            exports.ghmattimysql:execute('UPDATE `gangs` SET `covenant` = @covenant WHERE `gang_name` = @gang_name',
                {
                ['@covenant'] = "1",
                ['@gang_name'] = result[1].gang_name
                }, function ()
            end)
        end)
    end)
end)

RegisterServerEvent("targetbrouge")
AddEventHandler("targetbrouge", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result2)
        exports.ghmattimysql:execute('SELECT gang_name FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
            exports.ghmattimysql:execute('UPDATE `gangs` SET `brouge` = @brouge WHERE `gang_name` = @gang_name',
                {
                ['@brouge'] = "1",
                ['@gang_name'] = result[1].gang_name
                }, function ()
            end)
        end)
    end)
end)

RegisterServerEvent("targetforum")
AddEventHandler("targetforum", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result2)
        exports.ghmattimysql:execute('SELECT gang_name FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
            exports.ghmattimysql:execute('UPDATE `gangs` SET `forum` = @forum WHERE `gang_name` = @gang_name',
                {
                ['@forum'] = "1",
                ['@gang_name'] = result[1].gang_name
                }, function ()
            end)
        end)
    end)
end)

RegisterServerEvent("targetjamestown")
AddEventHandler("targetjamestown", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result2)
        exports.ghmattimysql:execute('SELECT gang_name FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
            exports.ghmattimysql:execute('UPDATE `gangs` SET `jamestown` = @jamestown WHERE `gang_name` = @gang_name',
                {
                ['@jamestown'] = "1",
                ['@gang_name'] = result[1].gang_name
                }, function ()
            end)
        end)
    end)
end)

RegisterServerEvent("targetmirror")
AddEventHandler("targetmirror", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result2)
        exports.ghmattimysql:execute('SELECT gang_name FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
            exports.ghmattimysql:execute('UPDATE `gangs` SET `mirrorpark` = @mirrorpark WHERE `gang_name` = @gang_name',
                {
                ['@mirrorpark'] = "1",
                ['@gang_name'] = result[1].gang_name
                }, function ()
            end)
        end)
    end)
end)

RegisterServerEvent("targetfudge")
AddEventHandler("targetfudge", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result2)
        exports.ghmattimysql:execute('SELECT gang_name FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
            exports.ghmattimysql:execute('UPDATE `gangs` SET `fudge` = @fudge WHERE `gang_name` = @gang_name',
                {
                ['@fudge'] = "1",
                ['@gang_name'] = result[1].gang_name
                }, function ()
            end)
        end)
    end)
end)

RegisterServerEvent("targetvespucci")
AddEventHandler("targetvespucci", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result2)
        exports.ghmattimysql:execute('SELECT gang_name FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
            exports.ghmattimysql:execute('UPDATE `gangs` SET `vespucci` = @vespucci WHERE `gang_name` = @gang_name',
                {
                ['@vespucci'] = "1",
                ['@gang_name'] = result[1].gang_name
                }, function ()
            end)
        end)
    end)
end)

RegisterServerEvent("targetcougar")
AddEventHandler("targetcougar", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result2)
        exports.ghmattimysql:execute('SELECT gang_name FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
            exports.ghmattimysql:execute('UPDATE `gangs` SET `cougar` = @cougar WHERE `gang_name` = @gang_name',
                {
                ['@cougar'] = "1",
                ['@gang_name'] = result[1].gang_name
                }, function ()
            end)
        end)
    end)
end)

RegisterServerEvent("targetharmony")
AddEventHandler("targetharmony", function()
    local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    exports.ghmattimysql:execute('SELECT * FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result2)
        exports.ghmattimysql:execute('SELECT gang_name FROM gangs WHERE `cid` = @cid', { ['@cid'] = char.id }, function(result)
            exports.ghmattimysql:execute('UPDATE `gangs` SET `harmony` = @harmony WHERE `gang_name` = @gang_name',
                {
                ['@harmony'] = "1",
                ['@gang_name'] = result[1].gang_name
                }, function ()
            end)
        end)
    end)
end)