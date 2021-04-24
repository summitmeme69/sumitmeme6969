local DISCORD_WEBHOOK5 = "https://discordapp.com/api/webhooks/832764259422175252/y6wwkLlTTCYrJR8sWIIkm55YakZdCawS92u1d_KgpahBcExHDJe9XGbq3y1EzFQ_FKCf"
local DISCORD_NAME5 = "Mission Finished Logs"

local STEAM_KEY = "0C007CC382AB06D1D99D9B45EC3924B1"
local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png" -- default is FiveM logo

PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

RegisterServerEvent('mission:finished')
AddEventHandler('mission:finished', function(money)
    local src = source
    local player = GetPlayerName(src)
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    if money ~= nil then
        user:addMoney(money)
        if money > 110 then
        sendToDiscord5("Mission Finished Logs", "Player ID: ".. src ..", Steam: ".. player ..",  Just Received $".. money .." From Mission Finished Event.")
        end
    end
end)

local counter = 0
RegisterServerEvent('delivery:status')
AddEventHandler('delivery:status', function(status)
    if status == -1 then
        counter = 0
    elseif status == 1 then
        counter = 2
    end
    TriggerClientEvent('delivery:deliverables', -1, counter, math.random(1,13))
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