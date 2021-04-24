onJob = 0
isSignedIn = false

RegisterNetEvent("srp-jobmanager:playerBecameJob")
AddEventHandler("srp-jobmanager:playerBecameJob", function(job, name, notify)
	if job == "ems" then
		isSignedIn = true
	else
		isSignedIn = false
		StopJob()
	end
end)



RegisterNetEvent("nowUnemployed")
AddEventHandler("nowUnemployed", function()
	onJob = 0
end)