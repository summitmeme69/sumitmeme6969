local rep = nil

-- Dialogue
RegisterNetEvent('what')
AddEventHandler('what', function()
    TriggerEvent("mt:missiontext", "What do you wanna know?", "1")
    Citizen.Wait(2000)
    TriggerEvent("boss")
    ClearPrints()
end)

RegisterNetEvent('invmembers')
AddEventHandler('invmembers', function()
	if IsAGang then
	Citizen.Wait(1000)
    TriggerEvent("invite")
	elseif not IsAGang then
	TriggerEvent("mt:missiontext", "Can't invite someone to nothing bozo", "1")
	Citizen.Wait(1000)
	ClearPrints()
	end
end)


IsAGang = false
RegisterNetEvent("setupgang")
AddEventHandler("setupgang", function()
	if not IsAGang then
    TriggerEvent("mt:missiontext", "So you want to start a group?", "1")
    Citizen.Wait(1500)
    TriggerEvent("mt:missiontext", "Bring me $15000, and we can speak more about it.", "1")
    Citizen.Wait(4000)
    TriggerEvent("setupgang2")
    ClearPrints()
	elseif IsAGang then
	TriggerEvent("mt:missiontext", "You are already in a group.", "1")
	Citizen.Wait(2500)
	ClearPrints()
	end
end)

RegisterNetEvent("GroveStreet")
AddEventHandler("GroveStreet", function()
    if IsAGang then
        TriggerEvent("mt:missiontext", "So you want to take Grove St?", "1")
        Citizen.Wait(1500)
        TriggerEvent("mt:missiontext", "First thing you need to know is that it's NOT a lot of territory to hold, but its popular.", "1")
        Citizen.Wait(4000)
        TriggerEvent("mt:missiontext", "There's going to be constant crime in this area, and police presence is heavy.", "1")
        Citizen.Wait(4000)
        TriggerEvent("mt:missiontext", "The locals don't take kindly to violence unless youre defending the block.", "1")
        Citizen.Wait(4000)
        TriggerEvent("mt:missiontext", "They also appreciate when their needs are supplied, so they'll pay a higher rate than other areas.", "1")
        Citizen.Wait(4000)
        TriggerEvent("mt:missiontext", "So... what do ya think?", "1")
        Citizen.Wait(1000)
    TriggerEvent("GroveStreet2")
    ClearPrints()
elseif not IsAGang then
TriggerEvent("mt:missiontext", "Come back when you're an established group", "1")
Citizen.Wait(1000)
ClearPrints()
end
end)


-- Menus 
RegisterNetEvent('boss1')
AddEventHandler('boss1', function()
    TriggerEvent('srp-context:sendMenu', {
    {
        id = 1,
        header = "Talk To Mr V",
        txt = ""
    },
    {
        id = 2,
        header = "How do I set this shit up!",
        txt = "Start a Group!",
        params = {
            event = "setupgang",
        }
    },
    {
        id = 3,
        header = "What's the word",
        txt = "Target an Area!",
        params = {
            event = "what",
        }
    },
    {
        id = 4,
        header = "How do I get the boys involved?",
        txt = "Invite Members!",
        params = {
            event = "invmembers",
        }
    },
    {
        id = 5,
        header = "What is my Reputation?",
        txt = "Check Your Rep!",
        params = {
            event = "repcheck",
        }
    },
})
end)

RegisterNetEvent('boss')
AddEventHandler('boss', function()
     Citizen.Wait(5)
     TriggerEvent('srp-context:sendMenu', {
        {
            id = 1,
            header = "Talk to Mr. V",
            txt = ""
        },
        {
            id = 2,
            header = "What's the word about Grove St?",
            txt = "0 groups are targeting this area.",
            params = {
                event = "GroveStreet",
            }
        },
    })
end)

Leader = false
RegisterNetEvent('invite')
AddEventHandler('invite', function()
    if Leader == true then
    Citizen.Wait(5)
    TriggerEvent('srp-context:sendMenu', {
        {
            id = 1,
            header = "Invite/Remove Members",
            txt = ""
        },
        {
            id = 2,
            header = "Invite Member",
            txt = "Invite a member to your group!",
            params = {
                event = "invitemembers",
            }
        },
        {
            id = 3,
            header = "Remove Member",
            txt = "Remove someone from your group!",
            params = {
                event = "removemembers",
            }
        },
    })
elseif Leader == false then
    TriggerEvent("mt:missiontext", "Can't speak to you about this", 2500)
end
end)

RegisterNetEvent('GroveStreet2')
AddEventHandler('GroveStreet2', function()
    Citizen.Wait(5)
    TriggerEvent('srp-context:sendMenu', {
        {
            id = 1,
            header = "Target Grove Street",
            txt = ""
        },
        {
            id = 2,
            header = "Let's talk more",
            txt = "You have the stuff!",
            params = {
                event = "target",
            }
        },
        {
            id = 3,
            header = "I'll be back soon",
            txt = "Cancel!",
            params = {
                event = "cancel",
            }
        },
    })
end)

RegisterNetEvent('setupgang2')
AddEventHandler('setupgang2', function()
    Citizen.Wait(5)
    TriggerEvent('srp-context:sendMenu', {
        {
            id = 1,
            header = "Start a group for $15000",
            txt = ""
        },
        {
            id = 2,
            header = "Let's talk more",
            txt = "You have the stuff!",
            params = {
                event = "setupgang3",
            }
        },
        {
            id = 3,
            header = "I'll be back soon",
            txt = "Cancel!",
            params = {
                event = "cancel",
            }
        },
    })
end)


-- Ui Applications
RegisterNetEvent("setupgang3")
AddEventHandler("setupgang3", function()
    local src = source
    Citizen.Wait(1000)
    TriggerEvent("DoLongHudText", "Alright, fill out your group name and we can go from there.")
    local groupname = exports["srp-applications"]:KeyboardInput({
        header = "Start Group",
        rows = {
            {
                id = 0,
                txt = "Group Name"
            }
        }
    })
	TriggerServerEvent("setupgangcash", 15000)
    if groupname then

    TriggerServerEvent("setupgangdb", groupname[1].input)
    end
end)

RegisterNetEvent("invitemembers")
AddEventHandler("invitemembers", function()
	TriggerEvent("mt:missiontext", "So you wanna involve some people? Write their names down on here", "1")
    Citizen.Wait(2000)
	ClearPrints()
    local inv = exports["srp-applications"]:KeyboardInput({
        header = "Invite Member",
        rows = {
            {
                id = 0,
                txt = "Character ID"
            }
        }
    })
    if inv then

        TriggerServerEvent("gangs:invmembers", inv[1].input)
    end
end)

RegisterNetEvent("removemembers")
AddEventHandler("removemembers", function()
    local inv = exports["srp-applications"]:KeyboardInput({
        header = "Remove Member",
        rows = {
            {
                id = 0,
                txt = "Character ID"
            }
        }
    })
    if inv then
	
        TriggerServerEvent("gangs:removemembers", inv[1].input)
    end
end)



-- Events And Testing Commands

RegisterNetEvent("target")
AddEventHandler("target", function()
	TriggerServerEvent("targetgrove")
end)

RegisterNetEvent("gang:approved")
AddEventHandler("gang:approved", function(allowed)
    IsAGang = allowed
end)

RegisterNetEvent("gang:leader")
AddEventHandler("gang:leader", function(allowed)
    Leader = allowed
end)

-- Target Areas
RegisterNetEvent("gang:targettinggrove")
AddEventHandler("gang:targettinggrove", function(allowed)
    TargettingGrove = allowed
end)

RegisterNetEvent("gang:targettingcov")
AddEventHandler("gang:targettingcov", function(allowed)
    TargettingCovenant = allowed
end)

RegisterNetEvent("gang:targettingforum")
AddEventHandler("gang:targettingforum", function(allowed)
    TargettingForum = allowed
end)

RegisterNetEvent("gang:targettingbrouge")
AddEventHandler("gang:targettingbrouge", function(allowed)
    TargettingBrouge = allowed
end)

RegisterNetEvent("gang:targettingjamestown")
AddEventHandler("gang:targettingjamestown", function(allowed)
    TargettingJamestown = allowed
end)

RegisterNetEvent("gang:targettingmirror")
AddEventHandler("gang:targettingmirror", function(allowed)
    TargettingMirrorPark = allowed
end)

RegisterNetEvent("gang:targettingfudge")
AddEventHandler("gang:targettingfudge", function(allowed)
    TargettingFudge = allowed
end)

RegisterNetEvent("gang:targettingvespucci")
AddEventHandler("gang:targettingvespucci", function(allowed)
    TargettingVespucci = allowed
end)

RegisterNetEvent("gang:targettingcougar")
AddEventHandler("gang:targettingcougar", function(allowed)
    TargettingCougar = allowed
end)

RegisterNetEvent("gang:targettingharmony")
AddEventHandler("gang:targettingharmony", function(allowed)
    TargettingHarmony = allowed
end)

RegisterNetEvent('territories:getRep')
AddEventHandler('territories:getRep', function(reputation)
	rep = reputation
end)

RegisterNetEvent('repcheck')
AddEventHandler('repcheck', function()
    print("running")
    TriggerServerEvent('territories:getRep')
end)

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end)