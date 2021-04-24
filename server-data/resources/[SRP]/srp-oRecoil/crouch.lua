local crouched = false
crouchKey = 19


Citizen.CreateThread( function()
	while true do 
		Citizen.Wait(1)
		local ped = PlayerPedId()
		if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
			DisableControlAction(0, crouchKey, true) 
            if (not IsPauseMenuActive()) then 
                if (IsDisabledControlJustPressed(0, crouchKey)) and not IsPedInAnyVehicle(ped, false) then 
                    RequestAnimSet("move_ped_crouched")
                    while (not HasAnimSetLoaded("move_ped_crouched")) do 
                        Citizen.Wait(100)
                    end 		
                    if (crouched) then 
                        ResetPedWeaponMovementClipset(ped)
                        ResetPedStrafeClipset(ped)
                        TriggerEvent("AnimSet:Set")
                        crouched = false 
                    elseif (not crouched) then
                        SetPedMovementClipset( ped, "move_ped_crouched", 0.55 )
                        SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
                        crouched = true 
                    end
                end
            end
		else
			crouched = false
        end
	end
end)
