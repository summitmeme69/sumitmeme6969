local imDead = false

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not imDead then
        imDead = true
    else
        imDead = false
    end
end)

--- event syncRadioData
--- syncs the current players on the radio to the client
---@param radioTable table the table of the current players on the radio
function syncRadioData(radioTable)
	radioData = radioTable
	logger.info(('[radio] Syncing radio table.'))
	if GetConvarInt('voice_debugMode', 0) >= 4 then
		print('-------- RADIO TABLE --------')
		tPrint(radioData)
		print('-----------------------------')
	end
	for tgt, enabled in pairs(radioTable) do
		if tgt ~= playerServerId then
			toggleVoice(tgt, enabled, 'radio')
		end
	end
end
RegisterNetEvent('srp-voice:syncRadioData', syncRadioData)

--- event setTalkingOnRadio
--- sets the players talking status, triggered when a player starts/stops talking.
---@param plySource number the players server id.
---@param enabled boolean whether the player is talking or not.
function setTalkingOnRadio(plySource, enabled)
	toggleVoice(plySource, enabled, 'radio')
	radioData[plySource] = enabled
	playMicClicks(enabled)
end
RegisterNetEvent('srp-voice:setTalkingOnRadio', setTalkingOnRadio)

--- event addPlayerToRadio
--- adds a player onto the radio.
---@param plySource number the players server id to add to the radio.
function addPlayerToRadio(plySource)
	radioData[plySource] = false
	if radioPressed then
		logger.info(('[radio] %s joined radio %s while we were talking, adding them to targets'):format(plySource, radioChannel))
		playerTargets(radioData, NetworkIsPlayerTalking(PlayerId()) and callData or {})
	else
		logger.info(('[radio] %s joined radio %s'):format(plySource, radioChannel))
	end
end
RegisterNetEvent('srp-voice:addPlayerToRadio', addPlayerToRadio)

--- event removePlayerFromRadio
--- removes the player (or self) from the radio
---@param plySource number the players server id to remove from the radio.
function removePlayerFromRadio(plySource)
	if plySource == playerServerId then
		logger.info(('[radio] Left radio %s, cleaning up.'):format(radioChannel))
		for tgt, enabled in pairs(radioData) do
			if tgt ~= playerServerId then
				toggleVoice(tgt, false)
			end
		end
		radioData = {}
		playerTargets(NetworkIsPlayerTalking(PlayerId()) and callData or {})
	else
		radioData[plySource] = nil
		toggleVoice(plySource, false)
		if radioPressed then
			logger.info(('[radio] %s left radio %s while we were talking, updating targets.'):format(plySource, radioChannel))
			playerTargets(radioData, NetworkIsPlayerTalking(PlayerId()) and callData or {})
		else
			logger.info(('[radio] %s has left radio %s'):format(plySource, radioChannel))
		end
	end
end
RegisterNetEvent('srp-voice:removePlayerFromRadio', removePlayerFromRadio)

--- function setRadioChannel
--- sets the local players current radio channel and updates the server
---@param channel number the channel to set the player to, or 0 to remove them.
function setRadioChannel(channel)
	if GetConvarInt('voice_enableRadios', 1) ~= 1 then return end
	TriggerServerEvent('srp-voice:setPlayerRadio', channel)
	radioChannel = channel
	if GetConvarInt('voice_enableUi', 1) == 1 then
		SendNUIMessage({
			radioChannel = channel,
			radioEnabled = radioEnabled
		})
	end
end

--- exports setRadioChannel
--- sets the local players current radio channel and updates the server
---@param channel number the channel to set the player to, or 0 to remove them.
exports('setRadioChannel', setRadioChannel)
-- mumble-voip compatability
exports('SetRadioChannel', setRadioChannel)

--- exports removePlayerFromRadio
--- sets the local players current radio channel and updates the server
exports('removePlayerFromRadio', function()
	setRadioChannel(0)
end)

--- exports addPlayerToRadio
--- sets the local players current radio channel and updates the server
---@param radio number the channel to set the player to, or 0 to remove them.
exports('addPlayerToRadio', function(radio)
	local radio = tonumber(radio)
	if radio then
		setRadioChannel(radio)
	end
end)


RegisterCommand('+radiotalk', function()
	if GetConvarInt('voice_enableRadios', 1) ~= 1 then return end
	if imDead then
        return false
    end

	if not radioPressed and radioEnabled then
		if radioChannel > 0 then
			logger.info(('[radio] Start broadcasting, update targets and notify server.'))
			playerTargets(radioData, NetworkIsPlayerTalking(PlayerId()) and callData or {})
			TriggerServerEvent('srp-voice:setTalkingOnRadio', true)
			radioPressed = true
			playMicClicks(true)
			if GetConvarInt('voice_enableRadioAnim', 0) == 1 then
				RequestAnimDict('random@arrests')
				while not HasAnimDictLoaded('random@arrests') do
					Citizen.Wait(10)
				end
				TaskPlayAnim(PlayerPedId(), "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
			end
			Citizen.CreateThread(function()
				TriggerEvent("srp-voice:radioActive", true)
				TriggerEvent("hud:voice:transmitting", true)
				while radioPressed do
					Wait(0)
					SetControlNormal(0, 249, 1.0)
					SetControlNormal(1, 249, 1.0)
					SetControlNormal(2, 249, 1.0)
				end
			end)
		end
	end
end, false)

RegisterCommand('-radiotalk', function()
	if radioChannel > 0 or radioEnabled then
		radioPressed = false
		MumbleClearVoiceTargetPlayers(1)
		playerTargets(NetworkIsPlayerTalking(PlayerId()) and callData or {})
		TriggerEvent("srp-voice:radioActive", false)
		playMicClicks(false)
		if GetConvarInt('voice_enableRadioAnim', 0) == 1 then
			StopAnimTask(PlayerPedId(), "random@arrests", "generic_radio_enter", -4.0)
		end
		TriggerServerEvent('srp-voice:setTalkingOnRadio', false)
		TriggerEvent("hud:voice:transmitting", false)
	end
end, false)
RegisterKeyMapping('+radiotalk', 'Talk over Radio', 'keyboard', GetConvar('voice_defaultRadio', 'CAPITAL'))

--- event syncRadio
--- syncs the players radio, only happens if the radio was set server side.
---@param _radioChannel number the radio channel to set the player to.
function syncRadio(_radioChannel)
	if GetConvarInt('voice_enableRadios', 1) ~= 1 then return end
	logger.info(('[radio] radio set serverside update to radio %s'):format(radioChannel))
	radioChannel = _radioChannel
end
RegisterNetEvent('srp-voice:clSetPlayerRadio', syncRadio)
