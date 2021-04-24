local toggled = false

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')
 
AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end
 
    TriggerEvent('chatMessage', source, author, message)
 
    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message)
    end
end)

AddEventHandler("chatMessage", function(source, args, raw)
    CancelEvent()
end)
 



AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

-- command suggestions for clients

local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)

RegisterCommand('ooc', function(source, args)
    if not args[1] then return end
    local src = source
    local msg = ""
    for i = 1, #args do
      msg = msg .. " " .. args[i]
    end
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
    if not toggled then
        TriggerClientEvent('chatMessage', -1, 'OOC '.. name .. ' ['.. src .. '] ', 2, msg, "OOC")
    elseif toggled then
        TriggerClientEvent("DoLongHudText", src, "OOC is disabled", 2)
    end
 end)

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text,Coords)
	TriggerClientEvent('Do3DText', -1, text, source, Coords)
	if logEnabled then
		setLog(text, source)
	end
end)

RegisterCommand("clear", function(source)
    TriggerClientEvent("chat:clear", source)
end)

RegisterCommand("clearall", function(source)
    local steamIdentifier = GetPlayerIdentifiers(source)[1]
    exports.ghmattimysql:execute("SELECT rank FROM users WHERE hex_id = ?", {steamIdentifier}, function(data)
        if data[1].rank ~= "user" then
            TriggerClientEvent("chat:clear", -1)
        end
    end)
end)


RegisterCommand("disable", function(source, args)
    local pSrc = source
    local command = string.lower(args[1])
    local steamIdentifier = GetPlayerIdentifiers(source)[1]
    exports.ghmattimysql:execute("SELECT rank FROM users WHERE hex_id = ?", {steamIdentifier}, function(data)
        if data[1].rank ~= "user" then
            if command == "ooc" then
                toggled = not toggled
                TriggerClientEvent("DoLongHudText", pSrc, ('OOC has been %s!'):format(toggled and 'Disabled' or 'Enabled')) -- Pkarti was here
            end
        end
    end)
end)

