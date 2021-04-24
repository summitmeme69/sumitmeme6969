RegisterServerEvent('error')
AddEventHandler('error',function(resource, args)

    sendToDiscord("```Error in "..resource..'```', args)
end)



function sendToDiscord(name, args, color)
    local connect = {
          {
              ["color"] = 16711680,
              ["title"] = "".. name .."",
              ["description"] = args,
              ["footer"] = {
                  ["text"] = "SummitRP",
              },
          }
      }
    PerformHttpRequest('https://discordapp.com/api/webhooks/831204664460050442/ryvJvSCXOn3A9IMUHKyUN78EbYFogRXaO_rShiw6oZC9GRzFbSGvUISCOZwr25cbmlj4', function(err, text, headers) end, 'POST', json.encode({username = "Error Log", embeds = connect, avatar_url = "https://cdn.discordapp.com/attachments/829431733337194518/829480658031214602/Summit.gif"}), { ['Content-Type'] = 'application/json' })
end
