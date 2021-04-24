function SRP.Util.MissionText(self, text, time)
    if not text then return end

    text = tostring(text)
    
    drawTxt(0.97, 1.43, 1.0,1.0,0.4, text, 255, 255, 255, 255)  -- INT: kmh
end


function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,15)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2)
end


function SRP.Util.DrawText(self, text, font, centre, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

function SRP.Util.DrawText3D(self, x,y,z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x,y,z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end


function SRP.Util.RotationToDirection(self,rotation)

  local z = math.rad(rotation.z);
  local x = math.rad(rotation.x);
  local num = math.abs(math.cos(x));



  local vector3Direction = vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
  return vector3Direction
end

function SRP.Util.ScreenRelToWorld(self,camPos,camRot,coord)

      local distance = 1000.0
      local camForward = SRP.Util.RotationToDirection(self,camRot);
      local rotUp = camRot + vector3(distance, 0, 0);
      local rotDown = camRot + vector3(-distance, 0, 0);
      local rotLeft = camRot + vector3(0, 0, -distance);
      local rotRight = camRot + vector3(0, 0, distance);

      local camRight = SRP.Util.RotationToDirection(self,rotRight) - SRP.Util.RotationToDirection(self,rotLeft);
      local camUp = SRP.Util.RotationToDirection(self,rotUp) - SRP.Util.RotationToDirection(self,rotDown);

      local rollRad = -math.rad(camRot.y);

      local camRightRoll = camRight * math.cos(rollRad) - camUp * math.sin(rollRad);
      local camUpRoll = camRight * math.sin(rollRad) + camUp * math.cos(rollRad);

      local point3D = camPos + camForward * distance + camRightRoll + camUpRoll;
      local point2D;
      local b,cx,cy = GetScreenCoordFromWorldCoord(point3D.x,point3D.y,point3D.z)
      local point2D = {X = cx,Y = cy};
      if not point2D or not cx or not cy then 
        return camPos + camForward * distance; 
      end


      local point3DZero = camPos + camForward * distance;
      local b,cx,cy = GetScreenCoordFromWorldCoord(point3DZero.x,point3DZero.y,point3DZero.z)
      local point2DZero = {X = cx,Y = cy};
      if not point2DZero or not cx or not cy then 
        return camPos + camForward * distance; 
      end

      local eps = 0.001;
      if (math.abs(point2D.X - point2DZero.X) < eps or math.abs(point2D.Y - point2DZero.Y) < eps) then 
        return camPos + camForward * distance; 
      end



      local scaleX = (coord.x - point2DZero.X) / (point2D.X - point2DZero.X);
      local scaleY = (coord.y - point2DZero.Y) / (point2D.Y - point2DZero.Y);
      local point3Dret = camPos + camForward * distance + camRightRoll * scaleX + camUpRoll * scaleY;
      return point3Dret;



end

--functions

function GetVehicles()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end


function FetchVehProps(vehicle)	
    local color1, color2 = GetVehicleColours(vehicle)	
	local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)	
	local extras = {}	
	local model2 = GetEntityModel(vehicle)
	local vehname = GetDisplayNameFromVehicleModel(model2)

	for id=0, 12 do	
		if DoesExtraExist(vehicle, id) then	
			local state = IsVehicleExtraTurnedOn(vehicle, id) == 1	
			extras[tostring(id)] = state	
		end	
	end	

	return {	
		model             = GetDisplayNameFromVehicleModel(model2),	

		plate             = GetVehicleNumberPlateText(vehicle),	
		plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),	

		bodyHealth        = tonumber(string.format("%." .. (1 or 0) .. "f", GetVehicleBodyHealth(vehicle))),	
		engineHealth      = tonumber(string.format("%." .. (1 or 0) .. "f", GetVehicleEngineHealth(vehicle))),	

		fuelLevel         = tonumber(string.format("%." .. (1 or 0) .. "f", GetVehicleFuelLevel(vehicle))),	
		dirtLevel         = tonumber(string.format("%." .. (1 or 0) .. "f", GetVehicleDirtLevel(vehicle))),	
		color1            = color1,	
		color2            = color2,	

		pearlescentColor  = pearlescentColor,	
		wheelColor        = wheelColor,	

		wheels            = GetVehicleWheelType(vehicle),	
		windowTint        = GetVehicleWindowTint(vehicle),	

		neonEnabled       = {	
			IsVehicleNeonLightEnabled(vehicle, 0),	
			IsVehicleNeonLightEnabled(vehicle, 1),	
			IsVehicleNeonLightEnabled(vehicle, 2),	
			IsVehicleNeonLightEnabled(vehicle, 3)	
		},	

		extras            = extras,	

		neonColor         = table.pack(GetVehicleNeonLightsColour(vehicle)),	
		tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),	

		modSpoilers       = GetVehicleMod(vehicle, 0),	
		modFrontBumper    = GetVehicleMod(vehicle, 1),	
		modRearBumper     = GetVehicleMod(vehicle, 2),	
		modSideSkirt      = GetVehicleMod(vehicle, 3),	
		modExhaust        = GetVehicleMod(vehicle, 4),	
		modFrame          = GetVehicleMod(vehicle, 5),	
		modGrille         = GetVehicleMod(vehicle, 6),	
		modHood           = GetVehicleMod(vehicle, 7),	
		modFender         = GetVehicleMod(vehicle, 8),	
		modRightFender    = GetVehicleMod(vehicle, 9),	
		modRoof           = GetVehicleMod(vehicle, 10),	

		modEngine         = GetVehicleMod(vehicle, 11),	
		modBrakes         = GetVehicleMod(vehicle, 12),	
		modTransmission   = GetVehicleMod(vehicle, 13),	
		modHorns          = GetVehicleMod(vehicle, 14),	
		modSuspension     = GetVehicleMod(vehicle, 15),	
		modArmor          = GetVehicleMod(vehicle, 16),	

		modTurbo          = IsToggleModOn(vehicle, 18),	
		modSmokeEnabled   = IsToggleModOn(vehicle, 20),	
		modXenon          = IsToggleModOn(vehicle, 22),	

		modFrontWheels    = GetVehicleMod(vehicle, 23),	
		modBackWheels     = GetVehicleMod(vehicle, 24),	

		modPlateHolder    = GetVehicleMod(vehicle, 25),	
		modVanityPlate    = GetVehicleMod(vehicle, 26),	
		modTrimA          = GetVehicleMod(vehicle, 27),	
		modOrnaments      = GetVehicleMod(vehicle, 28),	
		modDashboard      = GetVehicleMod(vehicle, 29),	
		modDashboardColour = GetVehicleDashboardColour(vehicle),	
		modInteriorColour = GetVehicleInteriorColour(vehicle),	
		modXenonColour = GetVehicleHeadlightsColour(vehicle),	
		modDial           = GetVehicleMod(vehicle, 30),	
		modDoorSpeaker    = GetVehicleMod(vehicle, 31),	
		modSeats          = GetVehicleMod(vehicle, 32),	
		modSteeringWheel  = GetVehicleMod(vehicle, 33),	
		modShifterLeavers = GetVehicleMod(vehicle, 34),	
		modAPlate         = GetVehicleMod(vehicle, 35),	
		modSpeakers       = GetVehicleMod(vehicle, 36),	
		modTrunk          = GetVehicleMod(vehicle, 37),	
		modHydrolic       = GetVehicleMod(vehicle, 38),	
		modEngineBlock    = GetVehicleMod(vehicle, 39),	
		modAirFilter      = GetVehicleMod(vehicle, 40),	
		modStruts         = GetVehicleMod(vehicle, 41),	
		modArchCover      = GetVehicleMod(vehicle, 42),	
		modAerials        = GetVehicleMod(vehicle, 43),	
		modTrimB          = GetVehicleMod(vehicle, 44),	
		modTank           = GetVehicleMod(vehicle, 45),	
		modWindows        = GetVehicleMod(vehicle, 46),	
		modLivery         = GetVehicleMod(vehicle, 48),	
		modoldLivery      = GetVehicleLivery(vehicle)	
	}	
end	

function SetVehProps(vehicle, props)	
    SetVehicleModKit(vehicle, 0)	

	if props.plate ~= nil then	
		SetVehicleNumberPlateText(vehicle, props.plate)	
	end	

	if props.plateIndex ~= nil then	
		SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)	
	end	

	if props.bodyHealth ~= nil then	
		SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0)	
	end	

	if props.engineHealth ~= nil then	
		SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0)	
	end	

	if props.fuelLevel ~= nil then	
		SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0)	
	end	

	if props.dirtLevel ~= nil then	
		SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0)	
	end	

	if props.color1 ~= nil then	
		local color1, color2 = GetVehicleColours(vehicle)	
		SetVehicleColours(vehicle, props.color1, color2)	
	end	

	if props.color2 ~= nil then	
		local color1, color2 = GetVehicleColours(vehicle)	
		SetVehicleColours(vehicle, color1, props.color2)	
	end	

	if props.pearlescentColor ~= nil then	
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)	
		SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)	
	end	

	if props.wheelColor ~= nil then	
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)	
		SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor)	
	end	

	if props.wheels ~= nil then	
		SetVehicleWheelType(vehicle, props.wheels)	
	end	

	if props.windowTint ~= nil then	
		SetVehicleWindowTint(vehicle, props.windowTint)	
	end	

	if props.neonEnabled ~= nil then	
		SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])	
		SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])	
		SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])	
		SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])	
	end	

	if props.extras ~= nil then	
		for id,enabled in pairs(props.extras) do	
			if enabled then	
				SetVehicleExtra(vehicle, tonumber(id), 0)	
			else	
				SetVehicleExtra(vehicle, tonumber(id), 1)	
			end	
		end	
	end	

	if props.neonColor ~= nil then	
		SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])	
	end	

	if props.modSmokeEnabled ~= nil then	
		ToggleVehicleMod(vehicle, 20, true)	
	end	

	if props.tyreSmokeColor ~= nil then	
		SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])	
	end	

	if props.modSpoilers ~= nil then	
		SetVehicleMod(vehicle, 0, props.modSpoilers, false)	
	end	

	if props.modFrontBumper ~= nil then	
		SetVehicleMod(vehicle, 1, props.modFrontBumper, false)	
	end	

	if props.modRearBumper ~= nil then	
		SetVehicleMod(vehicle, 2, props.modRearBumper, false)	
	end	

	if props.modSideSkirt ~= nil then	
		SetVehicleMod(vehicle, 3, props.modSideSkirt, false)	
	end	

	if props.modExhaust ~= nil then	
		SetVehicleMod(vehicle, 4, props.modExhaust, false)	
	end	

	if props.modFrame ~= nil then	
		SetVehicleMod(vehicle, 5, props.modFrame, false)	
	end	

	if props.modGrille ~= nil then	
		SetVehicleMod(vehicle, 6, props.modGrille, false)	
	end	

	if props.modHood ~= nil then	
		SetVehicleMod(vehicle, 7, props.modHood, false)	
	end	

	if props.modFender ~= nil then	
		SetVehicleMod(vehicle, 8, props.modFender, false)	
	end	

	if props.modRightFender ~= nil then	
		SetVehicleMod(vehicle, 9, props.modRightFender, false)	
	end	

	if props.modRoof ~= nil then	
		SetVehicleMod(vehicle, 10, props.modRoof, false)	
	end	

	if props.modEngine ~= nil then	
		SetVehicleMod(vehicle, 11, props.modEngine, false)	
	end	

	if props.modBrakes ~= nil then	
		SetVehicleMod(vehicle, 12, props.modBrakes, false)	
	end	

	if props.modTransmission ~= nil then	
		SetVehicleMod(vehicle, 13, props.modTransmission, false)	
	end	

	if props.modHorns ~= nil then	
		SetVehicleMod(vehicle, 14, props.modHorns, false)	
	end	

	if props.modSuspension ~= nil then	
		SetVehicleMod(vehicle, 15, props.modSuspension, false)	
	end	

	if props.modArmor ~= nil then	
		SetVehicleMod(vehicle, 16, props.modArmor, false)	
	end	

	if props.modTurbo ~= nil then	
		ToggleVehicleMod(vehicle,  18, props.modTurbo)	
	end	

	if props.modXenon ~= nil then	
		ToggleVehicleMod(vehicle,  22, props.modXenon)	
	end	

	if props.modFrontWheels ~= nil then	
		SetVehicleMod(vehicle, 23, props.modFrontWheels, false)	
	end	

	if props.modBackWheels ~= nil then	
		SetVehicleMod(vehicle, 24, props.modBackWheels, false)	
	end	

	if props.modPlateHolder ~= nil then	
		SetVehicleMod(vehicle, 25, props.modPlateHolder, false)	
	end	

	if props.modVanityPlate ~= nil then	
		SetVehicleMod(vehicle, 26, props.modVanityPlate, false)	
	end	

	if props.modTrimA ~= nil then	
		SetVehicleMod(vehicle, 27, props.modTrimA, false)	
	end	

	if props.modOrnaments ~= nil then	
		SetVehicleMod(vehicle, 28, props.modOrnaments, false)	
	end	

	if props.modDashboard ~= nil then	
		SetVehicleMod(vehicle, 29, props.modDashboard, false)	
	end	

	if props.modDashboardColour ~= nil then	
		SetVehicleDashboardColour(vehicle, props.modDashboardColour)	
	end	

	if props.modInteriorColour ~= nil then	
		SetVehicleInteriorColour(vehicle, props.modInteriorColour)	
	end	

	if props.modXenonColour ~= nil then	
		SetVehicleHeadlightsColour(vehicle, props.modXenonColour)	
	end	

	if props.modDial ~= nil then	
		SetVehicleMod(vehicle, 30, props.modDial, false)	
	end	

	if props.modDoorSpeaker ~= nil then	
		SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)	
	end	

	if props.modSeats ~= nil then	
		SetVehicleMod(vehicle, 32, props.modSeats, false)	
	end	

	if props.modSteeringWheel ~= nil then	
		SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)	
	end	

	if props.modShifterLeavers ~= nil then	
		SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)	
	end	

	if props.modAPlate ~= nil then	
		SetVehicleMod(vehicle, 35, props.modAPlate, false)	
	end	

	if props.modSpeakers ~= nil then	
		SetVehicleMod(vehicle, 36, props.modSpeakers, false)	
	end	

	if props.modTrunk ~= nil then	
		SetVehicleMod(vehicle, 37, props.modTrunk, false)	
	end	

	if props.modHydrolic ~= nil then	
		SetVehicleMod(vehicle, 38, props.modHydrolic, false)	
	end	

	if props.modEngineBlock ~= nil then	
		SetVehicleMod(vehicle, 39, props.modEngineBlock, false)	
	end	

	if props.modAirFilter ~= nil then	
		SetVehicleMod(vehicle, 40, props.modAirFilter, false)	
	end	

	if props.modStruts ~= nil then	
		SetVehicleMod(vehicle, 41, props.modStruts, false)	
	end	

	if props.modArchCover ~= nil then	
		SetVehicleMod(vehicle, 42, props.modArchCover, false)	
	end	

	if props.modAerials ~= nil then	
		SetVehicleMod(vehicle, 43, props.modAerials, false)	
	end	

	if props.modTrimB ~= nil then	
		SetVehicleMod(vehicle, 44, props.modTrimB, false)	
	end	

	if props.modTank ~= nil then	
		SetVehicleMod(vehicle, 45, props.modTank, false)	
	end	

	if props.modWindows ~= nil then	
		SetVehicleMod(vehicle, 46, props.modWindows, false)	
	end	

	if props.modLivery ~= nil then	
		SetVehicleMod(vehicle, 48, props.modLivery, false)	
		SetVehicleLivery(vehicle, props.modLivery)	
	end	

	if props.modoldLivery ~= nil then	
		SetVehicleLivery(vehicle, props.modoldLivery)	
	end	
end	

function GetCurrentMod(id)	
    local plyPed = PlayerPedId()	
    local plyVeh = GetVehiclePedIsIn(plyPed, false)	
    local mod = GetVehicleMod(plyVeh, id)	
    local modName = GetLabelText(GetModTextLabel(plyVeh, id, mod))	

    return mod, modName	
end	

function GetCurrentWheel()	
    local plyPed = PlayerPedId()	
    local plyVeh = GetVehiclePedIsIn(plyPed, false)	
    local wheel = GetVehicleMod(plyVeh, 23)	
    local wheelName = GetLabelText(GetModTextLabel(plyVeh, 23, wheel))	
    local wheelType = GetVehicleWheelType(plyVeh)	

    return wheel, wheelName, wheelType	
end	

function GetCurrentCustomWheelState()	
    local plyPed = PlayerPedId()	
    local plyVeh = GetVehiclePedIsIn(plyPed, false)	
    local state = GetVehicleModVariation(plyVeh, 23)	

    if state then	
        return 1	
    else	
        return 0	
    end	
end	

function GetOriginalWheel()	
    return originalWheel	
end	

function GetOriginalCustomWheel()	
    return originalCustomWheels	
end	

function GetCurrentWindowTint()	
    local plyPed = PlayerPedId()	
    local plyVeh = GetVehiclePedIsIn(plyPed, false)	

    return GetVehicleWindowTint(plyVeh)	
end	

function GetCurrentVehicleWheelSmokeColour()	
    local plyPed = PlayerPedId()	
    local plyVeh = GetVehiclePedIsIn(plyPed, false)	
    local r, g, b = GetVehicleTyreSmokeColor(plyVeh)	

    return r, g, b	
end	

function GetCurrentNeonState(id)	
    local plyPed = PlayerPedId()	
    local plyVeh = GetVehiclePedIsIn(plyPed, false)	
    local isEnabled = IsVehicleNeonLightEnabled(plyVeh, id)	

    if isEnabled then	
        return 1	
    else	
        return 0	
    end	
end	

function GetCurrentNeonColour()	
    local plyPed = PlayerPedId()	
    local plyVeh = GetVehiclePedIsIn(plyPed, false)	
    local r, g, b = GetVehicleNeonLightsColour(plyVeh)	

    return r, g, b	
end	

function GetCurrentXenonState()	
    local plyPed = PlayerPedId()	
    local plyVeh = GetVehiclePedIsIn(plyPed, false)	
    local isEnabled = IsToggleModOn(plyVeh, 22)	

    if isEnabled then	
        return 1	
    else	
        return 0	
    end	
end	

function GetCurrentXenonColour()	
    local plyPed = PlayerPedId()	
    local plyVeh = GetVehiclePedIsIn(plyPed, false)	

    return GetVehicleHeadlightsColour(plyVeh)	
end	

function GetCurrentTurboState()	
    local plyPed = PlayerPedId()	
    local plyVeh = GetVehiclePedIsIn(plyPed, false)	
    local isEnabled = IsToggleModOn(plyVeh, 18)	

    if isEnabled then	
        return 1	
    else	
        return 0	
    end	
end	

function GetCurrentExtraState(extra)	
    local plyPed = PlayerPedId()	
    local plyVeh = GetVehiclePedIsIn(plyPed, false)	
    return IsVehicleExtraTurnedOn(plyVeh, extra)	
end	

--end functions
