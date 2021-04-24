local DISCORD_WEBHOOK5 = "https://discord.com/api/webhooks/804496496547463188/lrDO7G_kiExgUKqeDOzR5tYW1VSNaUApTwutYOf7DKBBeVmgskY5NK1mAtx3Y3Qq8G9W"
local DISCORD_NAME5 = "Banking Triggers"

local STEAM_KEY = "0C007CC382AB06D1D99D9B45EC3924B1"
local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png" -- default is FiveM logo

PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, content = "Banking Logs ***Online***", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount, cid ,reason, statement)
  local src = source
  local user = exports["srp-base"]:getModule("Player"):GetUser(src)
  if (tonumber(user:getCash()) >= amount) then
    user:removeMoney(amount)
    user:addBank(amount)
    TriggerEvent("bank:addlog", cid, amount, reason, statement)
    local sname = GetPlayerName(source)
    local identity = GetPlayerIdentifiers(source)
    sendToDiscord5("Banking Logs", sname .. ' has deposited $'.. amount .. " \n\nSteam ID : **" .. identity[1] .. "** \n\nLicense : **" .. identity[2] .. "**", 255)
  else
    TriggerClientEvent('DoShortHudText', src, 'You do not have enough money to deposit')
  end
end)


RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount, cid , reason, statement)
  local src = source
  local user = exports["srp-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  if (tonumber(user:getBalance()) >= amount) then
    user:removeBank(amount)
    user:addMoney(amount)
    TriggerEvent("bank:addlog", cid, amount, reason, statement)
    TriggerClientEvent("banking:updateBalance", src, char.bank)
    local sname = GetPlayerName(source)
    local identity = GetPlayerIdentifiers(source)
    sendToDiscord5("Banking Logs", sname .. ' has withdrawn $'.. amount .. " \n\nSteam ID : **" .. identity[1] .. "** \n\nLicense : **" .. identity[2] .. "**", 255)
  else
    TriggerClientEvent('DoShortHudText', src, 'You dont have enough money to withdraw')
  end
end)

RegisterServerEvent('bank:givemecash')
AddEventHandler('bank:givemecash', function(sender, reciever, amount)
  local user = exports["srp-base"]:getModule("Player"):GetUser(sender)
  local player = exports["srp-base"]:getModule("Player"):GetUser(tonumber(reciever))
  if tonumber(amount) <= user:getCash() then
    user:removeMoney(amount)
    player:addMoney(amount)    
  else
    TriggerClientEvent('DoShortHudText', sender, 'Not enough money', 2)
  end
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(receiver, amount, cid, statement)
  local user = exports["srp-base"]:getModule("Player"):GetUser(source)
  local player = exports["srp-base"]:getModule("Player"):GetUser(tonumber(receiver))
  local sname = GetPlayerName(_source)
  local tname = GetPlayerName(to)
  local identity = GetPlayerIdentifiers(_source)
  local identity2 = GetPlayerIdentifiers(to)
  if player ~= false then
    if source ~= receiver then
      if tonumber(amount) <= user:getBalance() then
        user:removeBank(amount)
        player:addBank(amount)
        sendToDiscord5("Banking Logs", sname .. ' has transferred $'.. amount .. ' to '.. tname .. " \n\nSending Steam ID : **" .. identity[1] .. "** \n\nSending License : **" .. identity[2] .. "** \n\nReceiving Steam ID : **" .. identity2[1] .. "** \n\nReceiving License : **" .. identity2[2] .. "**", 255)
      else
        TriggerClientEvent('DoShortHudText', source, 'Not enough money', 2)
      end
    end
  else
    TriggerClientEvent('DoShortHudText', source, 'Invaild ID', 2)
  end
end)

RegisterCommand('cash', function(source, args)
  local user = exports["srp-base"]:getModule("Player"):GetUser(source)
  local char = user:getCurrentCharacter()
  local cash = char.cash
  TriggerClientEvent('banking:updateCash', source, cash, true)
end)

RegisterServerEvent('bank:withdrawAmende')
AddEventHandler('bank:withdrawAmende', function(amount)
  local src = source
  local user = exports["srp-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  user:removeMoney(amount)
end)

RegisterCommand('givecash', function(source, args)
  if tonumber(args[2]) then
    TriggerClientEvent("bank:givecash", source, source, args[1], tonumber(args[2]))
  end
end)


RegisterServerEvent("bank:addlog")
AddEventHandler("bank:addlog", function(cid, amount, reason, statement, bussiness)
  if statement == false then
    if bussiness == "1" then
      exports.ghmattimysql:execute('INSERT INTO __banking_logs (cid, amount, reason, withdraw) VALUES(?, ?, ?, ?)', {cid, amount, reason, "1", '1'})
    else
      exports.ghmattimysql:execute('INSERT INTO __banking_logs (cid, amount, reason, withdraw) VALUES(?, ?, ?, ?)', {cid, amount, reason, "0"})
    end
  else
    if bussiness == "1" then
      exports.ghmattimysql:execute('INSERT INTO __banking_logs (cid, amount, reason, withdraw) VALUES(?, ?, ?, ?)', {cid, amount, reason, "1", '1'})
    else
      exports.ghmattimysql:execute('INSERT INTO __banking_logs (cid, amount, reason, withdraw) VALUES(?, ?, ?, ?)', {cid, amount, reason, "0"})
    end
  end
end)

RegisterServerEvent('bank:BussinessDeposit')
AddEventHandler("bank:BussinessDeposit", function(bussiness, amount, cid, reason, statement)
  local src = source
  local user = exports["srp-base"]:getModule("Player"):GetUser(src)
  if (tonumber(user:getCash()) >= tonumber(amount)) then
    exports.ghmattimysql:execute('SELECT * FROM group_banking WHERE `group_type`= ?', {bussiness}, function(data)
      if data[1] then
        user:removeMoney(tonumber(amount))
        local updated = data[1].bank + tonumber(amount)
        exports.ghmattimysql:execute("UPDATE group_banking SET `bank` = @bank WHERE `group_type` = @group_type", {
          ['@bank'] = updated,
          ['@group_type'] = bussiness
        })
        print(cid, amount, reason, statement)
        TriggerEvent("bank:addlog", cid, amount, reason, statement, "1")
      end
    end)
  end
end)

RegisterServerEvent('bank:BussinessWithdraw')
AddEventHandler("bank:BussinessWithdraw", function(bussiness, amount, cid ,reason, statement)
  local src = source
  local user = exports["srp-base"]:getModule("Player"):GetUser(src)
  exports.ghmattimysql:execute('SELECT * FROM group_banking WHERE `group_type`= ?', {bussiness}, function(data)
    if data[1] then
      local updatedBal = data[1].bank - tonumber(amount)
      exports.ghmattimysql:execute("UPDATE group_banking SET `bank` = @bank WHERE `group_type` = @group_type", {
        ['@bank'] = updatedBal,
        ['@group_type'] = bussiness
      })
      TriggerEvent("bank:addlog", cid, amount, reason, statement, "1")
      TriggerClientEvent("bank:getBussinessCashBal", src, updatedBal)
      user:addMoney(tonumber(amount))
    end
  end)
end)



RegisterServerEvent("bank:get:money")
AddEventHandler("bank:get:money", function(bussiness)
  local src = source
  local user = exports["srp-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE `cid`= ?', {char.id}, function(pre)
    if pre[1] then
      exports.ghmattimysql:execute('SELECT * FROM group_banking WHERE `group_type`= ?', {bussiness}, function(data)
        if data[1] then
          TriggerClientEvent("bank:getBussinessCashBal", src, data[1].bank)
          TriggerClientEvent("bank:getbankAccountNumber", src, char.id)
        end
      end)
    end
  end)
end)

RegisterServerEvent("bank:getLogs")
AddEventHandler("bank:getLogs", function()
  local srcID = source
  local user = exports["srp-base"]:getModule("Player"):GetUser(srcID)
  local char = user:getCurrentCharacter()
  exports.ghmattimysql:execute('SELECT * FROM __banking_logs WHERE `cid`= ?', {char.id}, function(data)
    if data[1] then
      TriggerClientEvent("bank:getLogsUpdates", srcID, data)
    end
  end)
end)

RegisterServerEvent("bank:get:balance")
AddEventHandler("bank:get:balance", function()
  local src = source
  local user = exports["srp-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  Citizen.Wait(2000)
  TriggerClientEvent("banking:updateBalance", src, char.bank)
  TriggerClientEvent('banking:updateCash', src, char.cash)
  TriggerClientEvent("bank:getbankAccountNumber", src, char.id)
end)

function sendToDiscord5(name, message, color)
  local connect = {
    {
      ["color"] = color,
      ["title"] = "**".. name .."**",
      ["description"] = message,
    }
  }
  PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end