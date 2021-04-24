
function SRP.Core.ConsoleLog(self, msg, mod, ply)
	if not tostring(msg) then return end
	if not tostring(mod) then mod = "No Module" end

	local pMsg = string.format("^3[SRP LOG - %s]^7 %s", mod, msg)
	if not pMsg then return end

	if ply and tonumber(ply) then
		TriggerClientEvent("srp-base:consoleLog", ply, msg, mod)
	end
end

AddEventHandler("onResourceStart", function(resource)
	TriggerClientEvent("srp-base:waitForExports", -1)

	if not SRP.Core.ExportsReady then return end

	Citizen.CreateThread(function()
		while true do 
			Citizen.Wait(0)
			if SRP.Core.ExportsReady then
				TriggerEvent("srp-base:exportsReady")
				return
			else
			end
		end
	end)
end)

RegisterNetEvent("srp-base:playerSessionStarted")
AddEventHandler("srp-base:playerSessionStarted", function()

	local src = source
	local name = GetPlayerName(src)
	local user = SRP.Player:GetUser(src)
end)

AddEventHandler("srp-base:characterLoaded", function(user, char)
	local src = source
	local hexId = user:getVar("hexid")

	if char.phone_number == 0 then
		SRP.Core:CreatePhoneNumber(source, function(phonenumber, err)	
			local q = [[UPDATE characters SET phone_number = @phone WHERE owner = @owner and id = @cid]]
			local v = {
				["phone"] = phoneNumber,
				["owner"] = hexId,
				["cid"] = char.id
			}

			exports.ghmattimysql.execute(q, v, function()
				char.phone_number = char.phone_number
				user:setCharacter(char)
			end)
		end)
	end
end)


-- Paycheck shit
Citizen.CreateThread(function()
	while true do
		Citizen.Wait((60 * 1000) * 45) -- 45 mins
		TriggerClientEvent('paycheck:client:call', -1)
		print("^1[srp-base] Paychecks Sent^0")
	end
end)

RegisterServerEvent('paycheck:server:send')
AddEventHandler('paycheck:server:send', function(cid)
	local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	local job = user:getVar("job")
	if user ~= false then
		if job == "unemployed" or job == "drift_school" then -- Bum Jobs 
			TriggerEvent("paycheck:server:add", src, cid, 25)
		elseif job == "police" or job == "ems" then -- All Emergency Jobs
			TriggerEvent("paycheck:server:add", src, cid, 100)
		elseif job == "best_buds" or job == "burger_shot" or job == "bean_machine" or job == "vanilla_unicorn" then -- Civ Jobs
			TriggerEvent("paycheck:server:add", src, cid, 50)
		elseif job == "auto_bodies" or job == "tuner_shop" or job == "paleto_mech" or job == "auto_exotics" then -- Mechanic Shops
			TriggerEvent("paycheck:server:add", src, cid, 50)
		elseif job == "car_shop" then -- Car Dealer Shops
			TriggerEvent("paycheck:server:add", src, cid, 50)
		end
	end
end)

RegisterServerEvent('paycheck:server:add')
AddEventHandler('paycheck:server:add', function(srcID, cid, amount)
	exports.ghmattimysql:execute('SELECT `paycheck` FROM characters WHERE `id`= ?', {cid}, function(data)
		local newAmount = data[1].paycheck + tonumber(amount)
		exports.ghmattimysql:execute("UPDATE characters SET `paycheck` = ? WHERE `id` = ?", {newAmount, cid})
		Citizen.Wait(500)
		TriggerClientEvent('DoLongHudText', srcID, 'A payslip of $'.. tonumber(amount) ..' making a total of $' ..newAmount ..' with $0 tax withheld on your last payment.', 1)
	end)
end)

RegisterServerEvent("paycheck:collect")
AddEventHandler("paycheck:collect", function(cid)
	local src = source
	local user = exports["srp-base"]:getModule("Player"):GetUser(src)
	exports.ghmattimysql:execute('SELECT `paycheck` FROM characters WHERE `id`= ?', {cid}, function(data)
		local amount = tonumber(data[1].paycheck)
		if amount >= 1 then
			exports.ghmattimysql:execute("UPDATE characters SET `paycheck` = ? WHERE `id` = ?", {"0", cid})
			user:addBank(amount)
		else
			TriggerClientEvent("DoLongHudText", src, "Your broke, go work!")
		end
	end)
end)