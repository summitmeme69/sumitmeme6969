RegisterServerEvent("asset_portals:get:coords")
AddEventHandler("asset_portals:get:coords", function()
    local hiddenmeth = vector3(1000.7489013672, -2011.9045410156, 31.77735710144) 
    -- local leavecoords = vector3(1088.1312255859, -3187.5009765625 + 0.3, -38.993473052979)
    local enterrecycle = vector3(580.54571533203, -422.21768188477, 24.73034286499)
    local leaverecycle = vector3(997.51324462891, -3091.9892578125, -38.999923706055)
    local hiddenCraft = vector3(474.93255615234, -1308.3104248047, 29.206659317017)
    -- local hiddenmeth = vector3(150.52998352051, 322.67651367188, 112.33367919922)
    local hiddenmethleave = vector3(997.06408691406, -3200.4626464844, -36.393661499023)
    TriggerClientEvent("asset_portals:recieve:coords", source, entercoords, leavecoords, enterrecycle, leaverecycle, hiddenCraft, hiddenmeth, hiddenmethleave)
end)