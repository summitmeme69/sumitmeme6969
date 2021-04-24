isCop = false
isInService = false

RegisterNetEvent('nowCopGarage')
AddEventHandler('nowCopGarage', function()
  	isCop = true
	isInService = true
    TriggerEvent('nowCop')
    TriggerEvent('nowService')
	TriggerEvent('nowCopHud')
	TriggerEvent('nowCopDeath')
	TriggerEvent('nowCopSpawn')
	TriggerEvent('nowMedic')
	SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
	SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
	SetPoliceIgnorePlayer(PlayerPedId(),true)
	TriggerEvent("armory:ammo")
end)


RegisterNetEvent("hasSignedOnEms")
AddEventHandler("hasSignedOnEms", function()
	SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
	SetPoliceIgnorePlayer(PlayerPedId(),true)
end)


RegisterNetEvent('emsduty')
AddEventHandler('emsduty', function()
	TriggerEvent('srp-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "attempt:duty:EMS"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "police:noLongerEMS"
            }
        },
    })
end)

RegisterNetEvent("attempt:duty:EMS")
AddEventHandler("attempt:duty:EMS", function()
	TriggerServerEvent("attemptdutym")
end)