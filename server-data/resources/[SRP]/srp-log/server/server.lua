local DISCORD_WEBHOOK5 = "https://discordapp.com/api/webhooks/831302419911933953/RfayTWct_EZFbl7fMjAK3Pqr3GqqEtykZEPDej31pCqJnAWMew8_ixUNCnfz7iNpmYql"
local DISCORD_NAME5 = "Weapon Triggers"

local STEAM_KEY = "0C007CC382AB06D1D99D9B45EC3924B1"
local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png" -- default is FiveM logo

PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, content = "Weapon Logs ***Online***", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })


function sanitize(string)
    return string:gsub('%@', '')
end

exports('sanitize', function(string)
    sanitize(string)
end)

RegisterNetEvent("discordLogs")
AddEventHandler("discordLogs", function(message, color, channel)
    discordLog(message, color, channel)
end)

-- Define default colors
if string.find(Config.joinColor,"#") then
	local joinColor = tonumber(Config.joinColor:gsub("#",""),16)
else
	local joinColor = Config.joinColor
end

if string.find(Config.leaveColor,"#") then
	local leaveColor = tonumber(Config.leaveColor:gsub("#",""),16)
else
	local leaveColor = Config.leaveColor
end

if string.find(Config.chatColor,"#") then
	local chatColor = tonumber(Config.chatColor:gsub("#",""),16)
else
	local chatColor = Config.chatColor
end

if string.find(Config.shootingColor,"#") then
	local shootingColor = tonumber(Config.shootingColor:gsub("#",""),16)
else
	local shootingColor = Config.shootingColor
end

if string.find(Config.deathColor,"#") then
	local deathColor = tonumber(Config.deathColor:gsub("#",""),16)
else
	local deathColor = Config.deathColor
end

if string.find(Config.resourceColor,"#") then
	local resourceColor = tonumber(Config.resourceColor:gsub("#",""),16)
else
	local resourceColor = Config.resourceColor
end


-- Get exports from server side
exports('discord', function(message, id, id2, color, channel)

	-- Check if hex or decimal color is used
	if string.find(color,"#") then
		_color = tonumber(color:gsub("#",""),16)
	else
		_color = color
	end

	if id ~= 0 then
		local ids = ExtractIdentifiers(id)
		local postal = getPlayerLocation(id)
		if Config.postal then _postal = "\n**Nearest Postal:** ".. postal .."" else _postal = "" end
		if Config.discordID then if ids.discord ~= "" then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**Discord ID:** N/A" end else _discordID = "" end
		if Config.steamID then if ids.steam ~= "" then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "\n**Steam ID:** N/A" end else _steamID = "" end
		if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamURL = "" end
		if Config.playerID then _playerID ="\n**Player ID:** " ..id.."" else _playerID = "" end
		local player1 = message..'\n'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..''.._steamURL
		_message = player1
	else
		_message = message
	end

	if id2 ~= 0 then
		local ids2 = ExtractIdentifiers(id2)
		local postal2 = getPlayerLocation(id2)
		if Config.postal then _postal2 = "\n**Nearest Postal:** ".. postal2 .."" else _postal2 = "" end
		if Config.discordID then if ids2.discord ~= "" then _discordID2 ="\n**Discord ID:** <@" ..ids2.discord:gsub("discord:", "")..">" else _discordID2 = "\n**Discord ID:** N/A" end else _discordID2 = "" end
		if Config.steamID then if ids2.steam ~= "" then _steamID2 ="\n**Steam ID:** " ..ids2.steam.."" else _steamID2 = "\n**Steam ID:** N/A" end else _steamID2 = "" end
		if Config.steamURL then  if ids2.steam ~= "" then _steamURL2 ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids2.steam:gsub("steam:", ""),16).."" else _steamURL2 = "\n**Steam URL:** N/A" end else _steamURL2 = "" end
		if Config.playerID then _playerID2 ="\n**Player ID:** " ..id2.."" else _playerID2 = "" end
		local player2 = _playerID2..''.. _postal2 ..''.. _discordID2..''.._steamID2..''.._steamURL2
		_message = player1..'\n'..player2
	end

    discordLog(_message, _color, channel)
end)

-- Sending message to the All Logs channel and to the channel it has listed
function discordLog(message, color, channel)
  if Config.AllLogs then
	PerformHttpRequest(Config.webhooks["all"], function(err, text, headers) end, 'POST', json.encode({username = Config.username, embeds = {{["color"] = color, ["author"] = {["name"] = Config.communtiyName,["icon_url"] = Config.communtiyLogo}, ["description"] = "".. message .."",["footer"] = {["text"] = "© SummitRP - "..os.date("%x %X %p"),["icon_url"] = "https://cdn.discordapp.com/attachments/753717564378710036/813171369029664788/Summit_Logo_4.png",},}}, avatar_url = Config.avatar}), { ['Content-Type'] = 'application/json' })
  end
	PerformHttpRequest(Config.webhooks[channel], function(err, text, headers) end, 'POST', json.encode({username = Config.username, embeds = {{["color"] = color, ["author"] = {["name"] = Config.communtiyName,["icon_url"] = Config.communtiyLogo}, ["description"] = "".. message .."",["footer"] = {["text"] = "© SummitRP - "..os.date("%x %X %p"),["icon_url"] = "https://cdn.discordapp.com/attachments/753717564378710036/813171369029664788/Summit_Logo_4.png",},}}, avatar_url = Config.avatar}), { ['Content-Type'] = 'application/json' })
end

-- Event Handlers

-- Send message when Player connects to the server.
AddEventHandler("playerConnecting", function(name, setReason, deferrals)
	local ids = ExtractIdentifiers(source)
	if Config.discordID then if ids.discord ~= "" then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**Discord ID:** N/A" end else _discordID = "" end
	if Config.steamID then if ids.steam ~= "" then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "\n**Steam ID:** N/A" end else _steamID = "" end
	if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
	discordLog('**' .. sanitize(GetPlayerName(source)) .. '** is connecting to the server.'.. _discordID..''.._steamID..''.._steamURL..'', joinColor, 'joins')
end)

-- Send message when Player disconnects from the server
AddEventHandler('playerDropped', function(reason)
	local ids = ExtractIdentifiers(source)
	local postal = getPlayerLocation(source)
	if Config.postal then _postal = "\n**Nearest Postal:** ".. postal .."" else _postal = "" end
	if Config.discordID then if ids.discord ~= "" then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**Discord ID:** N/A" end else _discordID = "" end
	if Config.steamID then if ids.steam ~= "" then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "\n**Steam ID:** N/A" end else _steamID = "" end
	if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
	if Config.playerID then _playerID ="\n**Player ID:** " ..source.."" else _playerID = "" end
	discordLog('**' .. sanitize(GetPlayerName(source)) .. '** has left the server. (Reason: ' .. reason .. ')'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..''.._steamURL..'', leaveColor, 'leaving')
end)

-- Send message when Player creates a chat message (Does not show commands)
AddEventHandler('chatMessage', function(source, name, msg)
	local ids = ExtractIdentifiers(source)
	local postal = getPlayerLocation(source)
	if Config.postal then _postal = "\n**Nearest Postal:** ".. postal .."" else _postal = "" end
	if Config.discordID then if ids.discord ~= "" then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**Discord ID:** N/A" end else _discordID = "" end
	if Config.steamID then if ids.steam ~= "" then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "\n**Steam ID:** N/A" end else _steamID = "" end
	if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
	if Config.playerID then _playerID ="\n**Player ID:** " ..source.."" else _playerID = "" end

	discordLog('**' .. sanitize(GetPlayerName(source)) .. '**: ``' .. msg .. '``'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..''.._steamURL..'', chatColor, 'chat')
end)

-- Send message when Player died (including reason/killer check) (Not always working)
RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(id,player,killer,DeathReason,Weapon)
	local ids = ExtractIdentifiers(source)
	local postal = getPlayerLocation(source)
	if DeathReason then _DeathReason = "`"..DeathReason.."`" else _DeathReason = "`died`" end
	if Weapon then _Weapon = ""..Weapon.."" else _Weapon = "" end
	if Config.postal then _postal = "\n**Nearest Postal:** ".. postal .."" else _postal = "" end
	if Config.discordID then if ids.discord ~= "" then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**Discord ID:** N/A" end else _discordID = "" end
	if Config.steamID then if ids.steam ~= "" then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "\n**Steam ID:** N/A" end else _steamID = "" end
	if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
	if Config.playerID then _playerID ="\n**Player ID:** " ..source.."" else _playerID = "" end

	if id == 1 then  -- Suicide/died
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** '.._DeathReason..''.._Weapon..''.._playerID..''.. _postal ..''.. _discordID..''.._steamID..''.._steamURL..'', deathColor, 'deaths') -- sending to deaths channel
	elseif id == 2 then -- Killed by other player
	local ids2 = ExtractIdentifiers(killer)
	local postal2 = getPlayerLocation(killer)
	if Config.postal then _postal2 = "\n**Nearest Postal:** ".. postal2 .."" else _postal2 = "" end
	if Config.discordID then if ids2.discord ~= "" then _KillDiscordID ="\n**Discord ID:** <@" ..ids2.discord:gsub("discord:", "")..">" else _KillDiscordID = "\n**Discord ID:** N/A" end else _KillDiscordID = "" end
	if Config.steamID then if ids2.steam ~= "" then _KillSteamID ="\n**Steam ID:** " ..ids2.steam.."" else _KillSteamID = "\n**Steam ID:** N/A" end else _KillSteamID = "" end
	if Config.steamURL then  if ids2.steam ~= "" then _KillSteamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids2.steam:gsub("steam:", ""),16).."" else _KillSteamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
	if Config.playerID then _killPlayerID ="\n**Player ID:** " ..killer.."" else _killPlayerID = "" end
		discordLog('**' .. GetPlayerName(killer) .. '** '.._DeathReason..' ' .. GetPlayerName(source).. ' `('.._Weapon..')`\n\n**[Player INFO]**'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..''.._steamURL..'\n\n**[Killer INFO]**'.._killPlayerID..''.. _postal2 ..''.. _KillDiscordID..''.._KillSteamID..''.._KillSteamURL..'', deathColor, 'deaths') -- sending to deaths channel
	else -- When gets killed by something else
        discordLog('**' .. sanitize(GetPlayerName(source)) .. '** `died`'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..''.._steamURL..'', deathColor, 'deaths') -- sending to deaths channel
	end
end)

-- Send message when Player fires a weapon
RegisterServerEvent('playerShotWeapon')
AddEventHandler('playerShotWeapon', function(weapon)
	local ids = ExtractIdentifiers(source)
	local postal = getPlayerLocation(source)
	if Config.postal then _postal = "\n**Nearest Postal:** ".. postal .."" else _postal = "" end
	if Config.discordID then if ids.discord ~= "" then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**Discord ID:** N/A" end else _discordID = "" end
	if Config.steamID then if ids.steam ~= "" then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "\n**Steam ID:** N/A" end else _steamID = "" end
	if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamID = "" end
	if Config.playerID then _playerID ="\n**Player ID:** " ..source.."" else _playerID = "" end
	if Config.weaponLog then
		discordLog('**' .. sanitize(GetPlayerName(source))  .. '** fired a `' .. weapon .. '`'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..''.._steamURL..'', shootingColor, 'shooting')
    end
end)

-- Getting exports from clientside
RegisterServerEvent('ClientDiscord')
AddEventHandler('ClientDiscord', function(message, id, id2, color, channel)

	-- Check if hex or decimal color is used
	if string.find(color,"#") then
		_color = tonumber(color:gsub("#",""),16)
	else
		_color = color
	end

	if id ~= 0 then
		local ids = ExtractIdentifiers(id)
		local postal = getPlayerLocation(id)
		if Config.postal then _postal = "\n**Nearest Postal:** ".. postal .."" else _postal = "" end
		if Config.discordID then if ids.discord ~= "" then _discordID ="\n**Discord ID:** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "\n**Discord ID:** N/A" end else _discordID = "" end
		if Config.steamID then if ids.steam ~= "" then _steamID ="\n**Steam ID:** " ..ids.steam.."" else _steamID = "\n**Steam ID:** N/A" end else _steamID = "" end
		if Config.steamURL then  if ids.steam ~= "" then _steamURL ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "\n**Steam URL:** N/A" end else _steamURL = "" end
		if Config.playerID then _playerID ="\n**Player ID:** " ..id.."" else _playerID = "" end
		local player1 = message..'\n'.._playerID..''.. _postal ..''.. _discordID..''.._steamID..''.._steamURL
		_message = player1
	else
		_message = message
	end

	if id2 ~= 0 then
		local ids2 = ExtractIdentifiers(id2)
		local postal2 = getPlayerLocation(id2)
		if Config.postal then _postal2 = "\n**Nearest Postal:** ".. postal2 .."" else _postal2 = "" end
		if Config.discordID then if ids2.discord ~= "" then _discordID2 ="\n**Discord ID:** <@" ..ids2.discord:gsub("discord:", "")..">" else _discordID2 = "\n**Discord ID:** N/A" end else _discordID2 = "" end
		if Config.steamID then if ids2.steam ~= "" then _steamID2 ="\n**Steam ID:** " ..ids2.steam.."" else _steamID2 = "\n**Steam ID:** N/A" end else _steamID2 = "" end
		if Config.steamURL then  if ids2.steam ~= "" then _steamURL2 ="\nhttps://steamcommunity.com/profiles/" ..tonumber(ids2.steam:gsub("steam:", ""),16).."" else _steamURL2 = "\n**Steam URL:** N/A" end else _steamURL2 = "" end
		if Config.playerID then _playerID2 ="\n**Player ID:** " ..id2.."" else _playerID2 = "" end
		local player2 = _playerID2..''.. _postal2 ..''.. _discordID2..''.._steamID2..''.._steamURL2
		_message = player1..'\n'..player2
	end

   discordLog(_message, _color,  channel)
end)

-- Send message when a resource is being stopped
AddEventHandler('onResourceStop', function (resourceName)
    discordLog('**' .. resourceName .. '** has been stopped.', resourceColor, 'resources')
end)

-- Send message when a resource is being started
AddEventHandler('onResourceStart', function (resourceName)
    Wait(100)
    discordLog('**' .. resourceName .. '** has been started.', resourceColor, 'resources')
end)

RegisterServerEvent('Proopies:GetIdentifiers')
AddEventHandler('Proopies:GetIdentifiers', function(src)
	local ids = ExtractIdentifiers(src)
	return ids
end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function getPlayerLocation(src)

local raw = LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'postal_file'))
local postals = json.decode(raw)
local nearest = nil

local player = src
local ped = GetPlayerPed(player)
local playerCoords = GetEntityCoords(ped)

local x, y = table.unpack(playerCoords)

	local ndm = -1
	local ni = -1
	for i, p in ipairs(postals) do
		local dm = (x - p.x) ^ 2 + (y - p.y) ^ 2
		if ndm == -1 or dm < ndm then
			ni = i
			ndm = dm
		end
	end

	if ni ~= -1 then
		local nd = math.sqrt(ndm)
		nearest = {i = ni, d = nd}
	end
	_nearest = postals[nearest.i].code
	return _nearest
end

-- Checking Everything, Each Bullet ya Feel.
AddEventHandler('weaponDamageEvent', function(sender, data)
    if data.weaponDamage > 1 then
        sendToDiscord6("Weapon Logs", "Player ID: ".. sender .." Just Hit Someone For ".. data.weaponDamage .." Damage")
    end
end)

-- Checking For DMG Multiplier
AddEventHandler('weaponDamageEvent', function(sender, data)
    if data.weaponDamage > 60 then
        DropPlayer(source, "You have been automatically kicked for using Damage Multipliers! If this was a false-positive, please let the Summit Staff Team know so they can fix this issue!")
        sendToDiscord5("Weapon Logs", "Player ID: ".. sender .." Just Hit Someone For ".. data.weaponDamage .." Damage")
    end
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


  function sendToDiscord6(name, message, color)
    local connect = {
      {
        ["color"] = color,
        ["title"] = "**".. name .."**",
        ["description"] = message,
      }
    }
    PerformHttpRequest(DISCORD_WEBHOOK6, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME6, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
  end