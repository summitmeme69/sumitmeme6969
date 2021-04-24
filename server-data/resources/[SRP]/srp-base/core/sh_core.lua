SRP.Core = SRP.Core or {}

function SRP.Core.ConsoleLog(self, msg, mod)
    if not tostring(msg) then return end
    if not tostring(mod) then mod = "No Module" end
    
    local pMsg = string.format("[SRP LOG - %s] %s", mod, msg)
    if not pMsg then return end

end

RegisterNetEvent("srp-base:consoleLog")
AddEventHandler("srp-base:consoleLog", function(msg, mod)
    SRP.Core:ConsoleLog(msg, mod)
end)

function getModule(module)
    if not SRP[module] then print("Warning: '" .. tostring(module) .. "' module doesn't exist") return false end
    return SRP[module]
end

function addModule(module, tbl)
    if SRP[module] then print("Warning: '" .. tostring(module) .. "' module is being overridden") end
    SRP[module] = tbl
end

SRP.Core.ExportsReady = false

function SRP.Core.WaitForExports(self)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if exports and exports["srp-base"] then
                TriggerEvent("srp-base:exportsReady")
                SRP.Core.ExportsReady = true
                return
            end
        end
    end)
end

exports("getModule", getModule)
exports("addModule", addModule)
SRP.Core:WaitForExports()

local webhook = 'https://discord.com/api/webhooks/830456765439148033/17v89r9e9CF3FZ2zkWOjoUXdpG5QyXmaAehVuS4dyy-a5QYGNVEWOoHJVD2xXQMbGUVy' -- Your Discord webhook for logs
local webhook2 = 'https://discord.com/api/webhooks/830459579023884329/uj_ATt7EehnenOisAKoQmLWTfL0chIc77XB410IZdtH94wwIaBCruook0SGXvH1QiiFu' -- Your Discord webhook for logs
local webhook3 = 'https://discord.com/api/webhooks/830449848725143563/pRsJ60iNXAW3lKtcu9-XD4s7pC_yBgbhXP2QbxxDfGaLYBHeHgIzfEzrz4j7ZBF0h1al' -- Your Discord webhook for logs
local webhook4 = 'https://discord.com/api/webhooks/830454311754006639/OJI7tFpz2p7uOlb2hHY1SRlZxluKm8D4RSDLE9n4EdKy_-EH8dOeZLGImwk_JyIh_TP2' -- Your Discord webhook for logs
local webhook5 = 'https://discordapp.com/api/webhooks/831302419911933953/RfayTWct_EZFbl7fMjAK3Pqr3GqqEtykZEPDej31pCqJnAWMew8_ixUNCnfz7iNpmYql' -- Your Discord webhook for logs

local webhook6 = 'https://discord.com/api/webhooks/832344803765256222/S0-om94VWLK28THta4o32JDdiWOluyToNFdUE8L-fo0_BME2MGX_bUh7mnfUnePzXURx' -- MDT - Reports Deleted
local webhook7 = 'https://discord.com/api/webhooks/832347453067886592/3806ZxO1oN4QPAk2z8PSXlvUrlO_vtHrByffa8YODsqcxVIkpPSCkUPCLNwTbyMfgBwt' -- MDT - Warrant Deleted

local webhook8 = 'https://discord.com/api/webhooks/835231807175131216/NUhrkDQJJFwygxyGRiV_U39bZARPQ2pdI7VWbVggL_nRWXubxdJKAx5S9CnXm-Ys2Z_4' -- Teleporters - Meth Enter / Leave
local webhook9 = 'https://discord.com/api/webhooks/835231934225055774/Tqu4hwRNrzIqbSkEgS9LxuFG0OMQ0OhbdDHd08ZKLH-DS82GaJzqU8PfCMNM0QoApRaj' -- Teleporters - Coke Enter / Leave
local webhook10 = 'https://discord.com/api/webhooks/835232091461255168/iiBLOaGUfoC41Pdleyvb1xZRyFgY_I2ZqZKLLRyCinNgEsgwBvZOLXIuAeqiouBD4lZ4' -- Teleporters - Recycle Enter / Leave


RegisterNetEvent('convienceregister:log')
AddEventHandler('convienceregister:log', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "started to a empty a Convience Store Register!", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)

RegisterNetEvent('conviencesafe:log')
AddEventHandler('conviencesafe:log', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "started to a empty a Convience Store Safe!", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

      PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	

end)

RegisterNetEvent('stealcommand:log')
AddEventHandler('stealcommand:log', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "/steal command used", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

    PerformHttpRequest(webhook2, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)

RegisterNetEvent('jewelrobbery:log')
AddEventHandler('jewelrobbery:log', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "Jewelry Store Robbery", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

    PerformHttpRequest(webhook3, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)

RegisterNetEvent('banktruckrobbery:log')
AddEventHandler('banktruckrobbery:log', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "Bank Truck Robbery", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

  	PerformHttpRequest(webhook4, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)


RegisterNetEvent('dmg:log')
AddEventHandler('dmg:log', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "Damage Exceeded", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }
    PerformHttpRequest(webhook5, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)

RegisterNetEvent('srp-mdt:delreport')
AddEventHandler('srp-mdt:delreport', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local hexId = user:getVar("hexid")
    local pCharName = char.first_name .. " " ..char.last_name
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "MDT - Report Deleted", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['fields'] = {
                {
                    ['name'] = '`Character Name`',
                    ['value'] = pCharName,
                    ['inline'] = true
                },
                {
                    ['name'] = '`Reason For Log`',
                    ['value'] = "Deleted a MDT Report",
                    ['inline'] = true
                }
            },
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

  	PerformHttpRequest(webhook6, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)

RegisterNetEvent('srp-mdt:delwarrant')
AddEventHandler('srp-mdt:delwarrant', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local hexId = user:getVar("hexid")
    local pCharName = char.first_name .. " " ..char.last_name
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "MDT - Warrent Deleted", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['fields'] = {
                {
                    ['name'] = '`Character Name`',
                    ['value'] = pCharName,
                    ['inline'] = true
                },
                {
                    ['name'] = '`Reason For Log`',
                    ['value'] = "Deleted a MDT Warrent",
                    ['inline'] = true
                }
            },
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

  	PerformHttpRequest(webhook7, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)

RegisterNetEvent('meth:enter')
AddEventHandler('meth:enter', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "Entered the Meth Lab!", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

    PerformHttpRequest(webhook8, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)

RegisterNetEvent('meth:leave')
AddEventHandler('meth:leave', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "Left the Meth Lab!", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

    PerformHttpRequest(webhook8, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)

RegisterNetEvent('coke:enter')
AddEventHandler('coke:enter', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "Entered the Coke Lab!", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

    PerformHttpRequest(webhook9, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)

RegisterNetEvent('coke:leave')
AddEventHandler('coke:leave', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "Left the Coke Lab!", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

    PerformHttpRequest(webhook9, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)

RegisterNetEvent('recycle:enter')
AddEventHandler('recycle:enter', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "Entered the Recycle Plant", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

    PerformHttpRequest(webhook10, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)

RegisterNetEvent('recycle:leave')
AddEventHandler('recycle:leave', function()
    local src = source
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local LogData = {
        {
            ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "Left the Recycle Plant!", src, hexId, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

    PerformHttpRequest(webhook11, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = LogData}), { ['Content-Type'] = 'application/json' })	
end)