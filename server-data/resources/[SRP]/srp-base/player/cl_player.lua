SRP.Player = SRP.Player or {}
SRP.LocalPlayer = SRP.LocalPlayer or {}

local function GetUser()
    return SRP.LocalPlayer
end

function SRP.LocalPlayer.setVar(self, var, data)
    GetUser()[var] = data
end

function SRP.LocalPlayer.getVar(self, var)
    return GetUser()[var]
end

function SRP.LocalPlayer.setCurrentCharacter(self, data)
    if not data then return end
    GetUser():setVar("character", data)
end

function SRP.LocalPlayer.getCurrentCharacter(self)
    return GetUser():getVar("character")
end

RegisterNetEvent("srp-base:networkVar")
AddEventHandler("srp-base:networkVar", function(var, val)
    SRP.LocalPlayer:setVar(var, val)
end)

