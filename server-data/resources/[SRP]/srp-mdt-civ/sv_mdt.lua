

RegisterServerEvent("mdt-civ:hotKeyOpen")
AddEventHandler("mdt-civ:hotKeyOpen", function()
	local usource = source
	MySQL.Async.fetchAll("SELECT * FROM (SELECT * FROM `mdt_reports` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(reports)
		for r = 1, #reports do
			reports[r].charges = json.decode(reports[r].charges)
		end
		MySQL.Async.fetchAll("SELECT * FROM (SELECT * FROM `mdt_warrants` ORDER BY `id` DESC LIMIT 3) sub ORDER BY `id` DESC", {}, function(warrants)
			for w = 1, #warrants do
				warrants[w].charges = json.decode(warrants[w].charges)
			end


			local officer = GetCharacterName(usource)
			TriggerClientEvent('mdt-civ:toggleVisibilty', usource, reports, warrants, officer)
		end)
	end)
end)

RegisterServerEvent("mdt-civ:getOffensesAndOfficer")
AddEventHandler("mdt-civ:getOffensesAndOfficer", function()
	local usource = source
	local charges = {}
	local jailtime = {}
	MySQL.Async.fetchAll('SELECT * FROM fine_types', {
	}, function(fines)
		for j = 1, #fines do
			if fines[j].category == 0 or fines[j].category == 1 or fines[j].category == 2 or fines[j].category == 3 then
				table.insert(charges, fines[j])
			end
		end

		local officer = GetCharacterName(usource)

		TriggerClientEvent("mdt-civ:returnOffensesAndOfficer", usource, charges, officer)
	end)
end)

RegisterServerEvent("mdt-civ:performOffenderSearch")
AddEventHandler("mdt-civ:performOffenderSearch", function(query)
	local usource = source
	local matches = {}
	MySQL.Async.fetchAll("SELECT * FROM `characters` WHERE LOWER(`first_name`) LIKE @query OR LOWER(`last_name`) LIKE @query OR CONCAT(LOWER(`first_name`), ' ', LOWER(`last_name`)) LIKE @query", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)

		for index, data in ipairs(result) do
			table.insert(matches, data)
		end

		TriggerClientEvent("mdt-civ:returnOffenderSearchResults", usource, matches)
	end)
end)

RegisterServerEvent("mdt-civ:getOffenderDetails")
AddEventHandler("mdt-civ:getOffenderDetails", function(offender)
	local usource = source
	MySQL.Async.fetchAll('SELECT * FROM `user_mdt` WHERE `char_id` = @id', {
		['@id'] = offender.id
	}, function(result)
		offender.notes = ""
		offender.mugshot_url = ""
		if result[1] then
			offender.notes = result[1].notes
			offender.mugshot_url = result[1].mugshot_url
		end
		MySQL.Async.fetchAll('SELECT * FROM `user_convictions` WHERE `char_id` = @id', {
			['@id'] = offender.id
		}, function(convictions)
			if convictions[1] then
				offender.convictions = {}
				for i = 1, #convictions do
					local conviction = convictions[i]
					offender.convictions[conviction.offense] = conviction.count
				end
			end

			MySQL.Async.fetchAll('SELECT * FROM `mdt_warrants` WHERE `char_id` = @id', {
				['@id'] = offender.id
			}, function(warrants)
				if warrants[1] then
					offender.haswarrant = true
				end

				TriggerClientEvent("mdt-civ:returnOffenderDetails", usource, offender)
			end)
		end)
	end)
end)

RegisterServerEvent("mdt-civ:getOffenderDetailsById")
AddEventHandler("mdt-civ:getOffenderDetailsById", function(char_id)
	local usource = source
	MySQL.Async.fetchAll('SELECT * FROM `characters` WHERE `id` = @id', {
		['@id'] = char_id
	}, function(result)
		local offender = result[1]
		MySQL.Async.fetchAll('SELECT * FROM `user_mdt` WHERE `char_id` = @id', {
			['@id'] = offender.id
		}, function(result)
			offender.notes = ""
			offender.mugshot_url = ""
			if result[1] then
				offender.notes = result[1].notes
				offender.mugshot_url = result[1].mugshot_url
			end
			MySQL.Async.fetchAll('SELECT * FROM `user_convictions` WHERE `char_id` = @id', {
				['@id'] = offender.id
			}, function(convictions)
				if convictions[1] then
					offender.convictions = {}
					for i = 1, #convictions do
						local conviction = convictions[i]
						offender.convictions[conviction.offense] = conviction.count
					end
				end

				TriggerClientEvent("mdt-civ:returnOffenderDetails", usource, offender)
			end)
		end)

	end)
end)

RegisterServerEvent("mdt-civ:performReportSearch")
AddEventHandler("mdt-civ:performReportSearch", function(query)
	local usource = source
	local matches = {}
	MySQL.Async.fetchAll("SELECT * FROM `mdt_reports` WHERE `id` LIKE @query OR LOWER(`title`) LIKE @query OR LOWER(`name`) LIKE @query OR LOWER(`author`) LIKE @query or LOWER(`charges`) LIKE @query", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)

		for index, data in ipairs(result) do
			data.charges = json.decode(data.charges)
			table.insert(matches, data)
		end

		TriggerClientEvent("mdt-civ:returnReportSearchResults", usource, matches)
	end)
end)

RegisterServerEvent("mdt-civ:getWarrants")
AddEventHandler("mdt-civ:getWarrants", function()
	local usource = source
	MySQL.Async.fetchAll("SELECT * FROM `mdt_warrants`", {}, function(warrants)
		for i = 1, #warrants do
			warrants[i].expire_time = ""
			warrants[i].charges = json.decode(warrants[i].charges)
		end
		TriggerClientEvent("mdt-civ:returnWarrants", usource, warrants)
	end)
end)

RegisterServerEvent("mdt-civ:getReportDetailsById")
AddEventHandler("mdt-civ:getReportDetailsById", function(query, _source)
	if _source then source = _source end
	local usource = source
	MySQL.Async.fetchAll("SELECT * FROM `mdt_reports` WHERE `id` = @query", {
		['@query'] = query
	}, function(result)
		if result and result[1] then
			result[1].charges = json.decode(result[1].charges)
			TriggerClientEvent("mdt-civ:returnReportDetails", usource, result[1])
		end
	end)
end)

function GetCharacterName(source)
	local user = exports["srp-base"]:getModule("Player"):GetUser(source)
	if user ~= false then
		local characterId = user:getVar("character").id
		local result = MySQL.Sync.fetchAll('SELECT first_name, last_name FROM characters WHERE id = @id', {
			['@id'] = characterId
		})

		if result[1] and result[1].first_name and result[1].last_name then
			return ('%s %s'):format(result[1].first_name, result[1].last_name)
		end
	end
end


function tprint (tbl, indent)
  if not indent then indent = 0 end
  local toprint = string.rep(" ", indent) .. "{\r\n"
  indent = indent + 2 
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if (type(k) == "number") then
      toprint = toprint .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      toprint = toprint  .. k ..  "= "   
    end
    if (type(v) == "number") then
      toprint = toprint .. v .. ",\r\n"
    elseif (type(v) == "string") then
      toprint = toprint .. "\"" .. v .. "\",\r\n"
    elseif (type(v) == "table") then
      toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
    else
      toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
    end
  end
  toprint = toprint .. string.rep(" ", indent-2) .. "}"
  return toprint
end