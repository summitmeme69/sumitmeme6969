SRP.Jobs.CurPlayerJobs = {}

for k,v in pairs(SRP.Jobs.ValidJobs) do
    SRP.Jobs.CurPlayerJobs[k] = {}
end

function SRP.Jobs.IsWhiteListed(self, hexId, characterId, job, callback)
    if not hexId or not characterId then return end

    local q = [[SELECT cid, owner, cid, job, rank FROM jobs_whitelist WHERE cid = @cid AND job = @job LIMIT 1]]
    local v = {["owner"] = hexId, ["cid"] = characterId, ["job"] = job}

    exports.ghmattimysql:execute(q, v, function(results)
        if not results then callback(false, false) return end

        local isWhiteListed = (results and results[1]) and results[1] or false
        local rank = (isWhiteListed and results[1].rank) and results[1].rank or false
        callback(isWhiteListed, rank)
    end)
end

function SRP.Jobs.JobExists(self, job)
    return SRP.Jobs.ValidJobs[job] ~= nil
end

function SRP.Jobs.CountJob(self, job)
    if not SRP.Jobs:JobExists(job) then return 0 end

    local count = 0
    for k,v in pairs(SRP.Jobs.CurPlayerJobs[job]) do
        if job == "ems" then
            if v.isWhiteListed == true then
                count = count + 1
            end
        else
            count = count + 1
        end
    end

    return count
end

function SRP.Jobs.CanBecomeJob(self, user, job, callback)
    if not user then callback(false) return end
    if not user:getVar("characterLoaded") then callback(false, "Character not loaded") return end

    local src = user:getVar("source")
    local hexId = user:getVar("hexid")
    local characterId = user:getVar("character").id

    -- if SRP.Jobs.ValidJobs[job].requireDriversLicense and not exports["police"]:CheckLicense(characterId, "Drivers License") then
    --     callback(false, "You need a drivers license.")
    --     return
    -- end

    if not hexId or not characterId or not src then callback(false, "Id's don't exist") return end
        if not SRP.Jobs.ValidJobs[job] then callback(false, "Job isn't a valid job") return end
        
        TriggerEvent("srp-jobmanager:attemptBecomeJob", src, characterId, function(allowed, reason)
            if not allowed then callback(false, reason) return end
        end)

        if WasEventCanceled() then callback(false) return end

        -- if SRP.Jobs:CountJob(job) < 1 and SRP.Jobs.ValidJobs[job].name == "EMS" then
        --     callback(true)
        --     return
        -- else
        --     callback(false)
        --     return
        -- end

        if SRP.Jobs.ValidJobs[job].whitelisted then
            SRP.Jobs:IsWhiteListed(hexId, characterId, job, function(whiteListed, rank)
                if not whiteListed then callback(false, "You're not whitelisted for this job") return end
                callback(true, nil, rank)
            end)
            return
        end

        if SRP.Jobs:JobExists(job) then
            local jobTable = SRP.Jobs.ValidJobs[job]
            if jobTable and jobTable.max then
                if SRP.Jobs:CountJob(job) >= jobTable.max then callback(false, "There are too many employees for this job right now, try again later") return end
            end
        end
        callback(true)
end

function SRP.Jobs.AddWhiteList(self, user, job, rank)
    local cid = user:getCurrentCharacter().id
    local hexId = user:getVar("hexid")
    local q = [[INSERT INTO jobs_whitelist (cid, owner, job, rank) VALUES (@cid, @owner, @job, @rank)]]
    local v = {["cid"] = cid, ["owner"] = hexId, ["job"] = job, ["rank"] = rank}
    exports.ghmattimysql:execute(q, v)
end

function SRP.Jobs.SetRank(self, user, job, rank)
    local q = [[UPDATE jobs_whitelist SET (rank) VALUES (@rank) WHERE cid = @cid]]
    local v = {["cid"] = cid, ["rank"] = rank}
    exports.ghmattimysql:execute(q, v)
end

function SRP.Jobs.SetJob(self, user, job, notify, callback)
    if not user then return false end
    if not job or type(job) ~= "string" then return false end
    if not user:getVar("characterLoaded") then return false end 


    SRP.Jobs:CanBecomeJob(user, job, function(allowed, reason, rank) 
        if not allowed then
            if reason and type(reason) == "string" then
                TriggerClientEvent("DoLongHudText", user.source, tostring(reason), 1)
            end
            return
        end

        local src = user:getVar("source")
        local oldJob = user:getVar("job")
        local hexId = user:getVar("hexid")
        local characterId = user:getVar("character").id

        if oldJob then
            SRP.Jobs.CurPlayerJobs[oldJob][src] = nil
        end

        user:setVar("job", job)
        SRP.Jobs.CurPlayerJobs[job][src] = {rank = rank and rank or 0, lastPayCheck = GetGameTimer(),isWhiteListed = false} 

        local name = SRP.Jobs.ValidJobs[job].name

        TriggerClientEvent("srp-jobmanager:playerBecameJob", src, job, name, false)
        TriggerClientEvent("srp-jobmanager:playerBecomeEvent", src, job, name, notify)

        if SRP.Jobs:CountJob("trucker") >= 1 then
            TriggerEvent("lscustoms:IsTruckerOnline",true)
        elseif SRP.Jobs:CountJob("trucker") <= 0 then
            TriggerEvent("lscustoms:IsTruckerOnline", false)
        end

        if callback then callback() end
    end)
end

AddEventHandler("playerDropped", function(reason)
    local src = source

    for j,u in pairs(SRP.Jobs.CurPlayerJobs) do
        for k,s in pairs(u) do
            if k == src then SRP.Jobs.CurPlayerJobs[j][k] = nil end
        end
    end
end)

AddEventHandler("srp-base:characterLoaded", function(user, char)
    SRP.Jobs:SetJob(user, "unemployed", false)
end)

-- Need to think of a better way to do this, says no such export when resource is started
AddEventHandler("srp-base:exportsReady", function()
    exports["srp-base"]:addModule("JobManager", SRP.Jobs)
end)

local policebonus = 0
local emsbonus = 0
local civbonus = 0

RegisterServerEvent('updatePays')
AddEventHandler('updatePays', function(policebonus1,emsbonus1,civbonus1)
    policebonus = policebonus1
    emsbonus = emsbonus1
    civbonus = civbonus1
end)

RegisterServerEvent('updateSinglePays')
AddEventHandler('updateSinglePlays', function(bonus,bonusType)
    bonusType = bonusType
    bonus = bonus
    if bonusType == 'police' then
        policebonus = bonus
    end
    if bonusType == 'ems' then
        emsbonus = bonus
    end
    if bonusType == 'civilian' then
        civbonus = bonus
    end
end)

Citizen.CreateThread(function()
    while true do
        local src = source
        local curTime = os.time()
        for job,tbl in pairs(SRP.Jobs.CurPlayerJobs) do
            if SRP.Jobs.ValidJobs[job].paycheck then
                local payCheck = SRP.Jobs.ValidJobs[job].paycheck

                if SRP.Jobs.ValidJobs[job].name == "Police Officer" then
                    payCheck = payCheck + policebonus

                elseif SRP.Jobs.ValidJobs[job].name == "EMS" then
                    payCheck = payCheck + emsbonus

                else
                    payCheck = payCheck + civbonus
                end

                for src,data in pairs(tbl) do
                    local user = exports["srp-base"]:getModule("Player"):GetUser(src)
                    if user then
                        if tonumber(curTime) == tonumber(data.lastPayCheck) or tonumber(data.lastPayCheck) >= 480 then
                            SRP.Jobs.CurPlayerJobs[job][src].lastPayCheck = curTime
                            TriggerEvent("server:givepayJob", job, math.floor(payCheck), src)
                            exports["srp-base"]:AddLog("Job Pay", user, "User recieved paycheck, amount: " .. tostring(payCheck))
                        else

                        end
                    end
                end
            end
        end

        Citizen.Wait(1200000)
    end
end)

RegisterServerEvent('jobssystem:jobs')
AddEventHandler('jobssystem:jobs', function(job, src)
    if src == nil or src == 0 then src = source end

    local jobs = exports["srp-base"]:getModule("JobManager")
    local user = exports["srp-base"]:getModule("Player"):GetUser(src)

    if not user then return end
    if not jobs then return end

    jobs:SetJob(user, tostring(job))

end)



RegisterCommand('setjob', function(source, args)
TriggerEvent('jobssystem:jobs', args[1], source)
end)

RegisterCommand('addwhitelist', function(source, args)
    local user = exports["srp-base"]:getModule("Player"):GetUser(tonumber(args[1]))
    local jobs = exports["srp-base"]:getModule("JobManager")
    jobs:AddWhiteList(user, args[2], args[3])
end)
