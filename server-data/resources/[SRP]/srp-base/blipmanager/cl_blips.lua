local blips = {
    {id = "pcenter", name = "Payments & Internet Center", scale = 0.7, sprite = 351, color = 17, x=-1081.8293457031, y=-248.12872314453, z=37.763294219971},
    {id = "courthouse", name = "Los Santos Courthouse", scale = 0.7, color = 5, sprite = 58, x=244.5550079345, y=-386.0076904298, z=45.402359008789315},
    {id = "Bennys", name = "Bennys Motor Works", scale = 0.7, color = 1, sprite = 72, x=-212.28814697266, y=-1324.95703125, z=30.890},
    {id = "Auto Exotics", name = "Auto Exotics", scale = 0.7, color = 1, sprite = 72, x=535.5615234375, y=-179.61291503906, z=54.364429473877},
    {id = "Auto Bodies", name = "Auto Bodies", scale = 0.7, color = 1, sprite = 72, x=-1417.1550292969, y=-446.43911743164, z=35.909713745117},
    {id = "Tuner Shop", name = "Tuner Shop", scale = 0.7, color = 1, sprite = 72, x=937.23828125, y=-970.89343261719, z=39.543106079102},
    {id = "Paleto Preformance", name = "Paleto Preformance", scale = 0.7, color = 1, sprite = 72, x=108.35273742676, y=6625.1982421875, z= 31.787202835083},
    {id = "Burger Shot", name = "Burger Shot", scale = 0.7, color = 21, sprite = 106, x=-1191.6701660156, y=-889.74584960938, z= 14.508341789246},
    {id = "truckjob1", name = "Delivery Garage", scale = 0.7, color = 17, sprite = 67, x =165.22, y=-28.38, z=67.94},
    {id = "truckjob2", name = "Delivery Garage", scale = 0.7, color = 17, sprite = 67, x = -627.99, y= -1649.99, z= 25.83},
    {id = "weazel", name = "Weazel News", scale = 0.7, color = 6, sprite = 47, x = -598.248046875, y= -929.77307128906, z= 23.869129180908},
    {id = "beanmachine", name = "Bean Machine", scale = 0.7, color = 44, sprite = 106, x = -629.541015625, y= 233.69226074219, z= 81.881462097168},
    {id = "bestbuds", name = "BestBuds", scale = 0.7, color = 61, sprite = 140, x = -622.3955078125, y= -297.32778930664, z= 35.341938018799},
}


AddEventHandler("srp-base:playerSessionStarted", function()
    Citizen.CreateThread(function()
        for k,v in ipairs(blips) do
            SRP.BlipManager:CreateBlip(v.id, v)
        end
    end)
end)


