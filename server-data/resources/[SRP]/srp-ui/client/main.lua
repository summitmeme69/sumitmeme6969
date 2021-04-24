RegisterNetEvent('srp-ui:ShowUI')
AddEventHandler('srp-ui:ShowUI', function(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end)

RegisterNetEvent('srp-ui:HideUI')
AddEventHandler('srp-ui:HideUI', function()
	SendNUIMessage({
		action = 'hide'
	})
end)

