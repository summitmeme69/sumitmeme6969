Config = {}

Config.AirVent = {-635.94, -213.95, 53.54} -- First step
Config.Cooldown = 1000
Config.AirVentDist = 15 -- Distance to show the ['air_vent'] text
Config.GasTime = 5 -- Time before removing the gas, in minutes
Config.RobTime = 5 -- How many minutes the thief has to rob the jewels before the robbery gets cancelled
Config.WeaponsWL = true -- Needs specific weapon to smash the glass?
Config.Weapons = {
	{ name = 'WEAPON_CROWBAR', chance = 50 },
	{ name = 'WEAPON_ADVANCEDRIFLE', chance = 100 },
	{ name = 'WEAPON_ASSAULTRIFLE', chance = 100 },
	{ name = 'WEAPON_ASSAULTRIFLE_MK2', chance = 100 },
	{ name = 'WEAPON_ASSAULTSHOTGUN', chance = 100 },
	{ name = 'WEAPON_ASSAULTSMG', chance = 100 },
	{ name = 'WEAPON_BULLPUPSHOTGUN', chance = 100 },
	{ name = 'WEAPON_CARBINERIFLE', chance = 100 },
	{ name = 'WEAPON_COMBATMG', chance = 100 },
	{ name = 'WEAPON_COMBATPISTOL', chance = 30 },
	{ name = 'WEAPON_COMPACTRIFLE', chance = 100 },
	{ name = 'WEAPON_DBSHOTGUN', chance = 100 },
	{ name = 'WEAPON_GUSENBERG', chance = 100 },
	{ name = 'WEAPON_HEAVYPISTOL', chance = 100 },
	{ name = 'WEAPON_MACHINEPISTOL', chance = 100 },
	{ name = 'WEAPON_MG', chance = 100 },
	{ name = 'WEAPON_MICROSMG', chance = 100 },
	{ name = 'WEAPON_MINISMG', chance = 100 },
	{ name = 'WEAPON_MICROSMG', chance = 100 },
	{ name = 'WEAPON_PISTOL', chance = 10 },
	{ name = 'WEAPON_PISTOL50', chance = 20 },
	{ name = 'WEAPON_PISTOL_MK2', chance = 100 },
	{ name = 'WEAPON_PUMPSHOTGUN', chance = 100 },
	{ name = 'WEAPON_REVOLVER', chance = 100 },
	{ name = 'WEAPON_SAWNOFFSHOTGUN', chance = 100 },
	{ name = 'WEAPON_SMG', chance = 100 },
	{ name = 'WEAPON_VINTAGEPISTOL', chance = 20 },
}


Config.Lang = {
	['blip'] = 'Vangelico Jewelry',
	['air_vent'] = 'Inspect',
	['plant_gas'] = 'Press ~r~[E]~w~ to plant the bomb',
	['started'] = 'Vangelico Robbery Started',
	['police'] = 'Alarm Triggered at Vangelico Jewelry',
	['break'] = 'Press ~r~[E]~w~ to break the glass',
	['needs_weapon'] = 'You need something to break the glass',
	['stole'] = 'You stole ',
	
}
