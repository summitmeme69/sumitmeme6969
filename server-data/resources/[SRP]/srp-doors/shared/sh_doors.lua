SRP = SRP or {}
SRP.Doors = SRP.Doors or {}
SRP.DoorCoords = SRP.DoorCoords or {}
SRP.offSet = SRP.offSet or {}

SRP.DoorCoords = {
    [1] = { ["x"] = 441.21759033203, ["y"] = -977.9736328125, ["z"] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'}, -- Main Front Side Door
    [2] = { ["x"] = 440.21539306641, ["y"] = -985.80657958984, ["z"] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_05'}, -- Main Front Side Door
    [3] = { ["x"] = 445.88571166992, ["y"] = -983.65716552734, ["z"] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'}, -- Reception
    [4] = { ["x"] = 458.10989379883, ["y"] = -990.052734375, ["z"] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_05'}, -- Captains Office
    [5] = { ['x'] = 453.00659179688, ['y'] = -995.72308349609, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_05'}, -- Archives
    [6] = { ['x'] = 456.60659790039, ['y'] = -972.63293457031, ['z'] = 30.695190429688 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_reception_entrancedoor'}, -- Side Doors
    [7] = { ['x'] = 457.70111083984, ['y'] = -972.63293457031, ['z'] = 30.695190429688 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_reception_entrancedoor'}, -- Side Doors
    [8] = { ['x'] = 442.57583618164, ['y'] = -998.32086181641, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_reception_entrancedoor'}, -- Side Doors
    [9] = { ['x'] = 441.36264038086, ['y'] = -998.38684082031, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_reception_entrancedoor'}, -- Side Doors
    [10] = { ['x'] = 479.39340209961, ['y'] = -986.86151123047, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'}, -- Forensic
    [11] = { ['x'] = 479.20880126953, ['y'] = -987.96923828125, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_05'}, -- Forensic
    [12] = { ['x'] = 474.8307800293, ['y'] = -989.51208496094, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'}, -- Briefing
    [13] = { ['x'] = 438.47473144531, ['y'] = -995.70989990234, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_01'}, -- Press Room
    [14] = { ['x'] = 438.58023071289, ['y'] = -994.48352050781, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_01'}, -- Press Room
    [15] = { ['x'] = 469.02856445312, ['y'] = -985.63513183594, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_01'}, -- Hallway to Shooting, Briefing, ect
    [16] = { ['x'] = 469.04174804688, ['y'] = -986.75604248047, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_01'}, --Hallway to Shooting, Briefing, ect
    [17] = { ['x'] = 469.14724731445, ['y'] = -1013.8813476562, ['z'] = 26.381713867188 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_03'}, -- Backdoor By Gate

    -- Pillbox Medical ---
    [18] =  { ["x"] = 324.89,["y"] = -589.93,["z"] = 43.29,["h"] = 357.7, ["info"] = " doctor1", ["lock"] = 0, ["doorType"] = "gabz_pillbox_doubledoor_l"},
    [19] =  { ["x"] = 326.08,["y"] = -589.8,["z"] = 43.29,["h"] = 290.47, ["info"] = " doctor2", ["lock"] = 0, ["doorType"] = "gabz_pillbox_doubledoor_r"},
    [20] =  { ["x"] = 326.28,["y"] = -579.66,["z"] = 43.29,["h"] = 28.71, ["info"] = " doctor3", ["lock"] = 0, ["doorType"] = "gabz_pillbox_doubledoor_r"},
    [21] =  { ["x"] = 326.16,["y"] = -578.49,["z"] = 43.31,["h"] = 101.16, ["info"] = " doctor4", ["lock"] = 0, ["doorType"] = "gabz_pillbox_doubledoor_l"},
    [22] =  { ["x"] = 324.65,["y"] = -576.29,["z"] = 43.29,["h"] = 295.18, ["info"] = " doctor5r", ["lock"] = 0, ["doorType"] = "gabz_pillbox_doubledoor_r"},
    [23] =  { ["x"] = 323.88,["y"] = -575.72,["z"] = 43.29,["h"] = 179.2, ["info"] = " doctor5l", ["lock"] = 0, ["doorType"] = "gabz_pillbox_doubledoor_l"},
    [24] =  { ["x"] = 319.29,["y"] = -573.97,["z"] = 43.3,["h"] = 191.99, ["info"] = " doctor6r", ["lock"] = 0, ["doorType"] = "gabz_pillbox_doubledoor_r"},
    [25] =  { ["x"] = 318.74,["y"] = -573.66,["z"] = 43.3,["h"] = 153.63, ["info"] = " doctor6l", ["lock"] = 0, ["doorType"] = "gabz_pillbox_doubledoor_l"},
    [26] =  { ["x"] = 313.45,["y"] = -572.17,["z"] = 43.29,["h"] = 42.38, ["info"] = " doctor7r", ["lock"] = 0, ["doorType"] = "gabz_pillbox_doubledoor_r"},
    [27] =  { ["x"] = 312.8,["y"] = -571.49,["z"] = 43.29,["h"] = 239.47, ["info"] = " doctor7l", ["lock"] = 0, ["doorType"] = "gabz_pillbox_doubledoor_l"},
    [28] =  { ["x"] = 348.87,["y"] = -587.97,["z"] = 43.29,["h"] = 89.22, ["info"] = " doctor8", ["lock"] = 0, ["doorType"] = "gabz_pillbox_doubledoor_r"},
    [29] =  { ["x"] = 349.02,["y"] = -587.31,["z"] = 43.29,["h"] = 30.67, ["info"] = " doctor9", ["lock"] = 0, ["doorType"] = "gabz_pillbox_doubledoor_l"},
    [30] =  { ["x"] = 304.4,["y"] = -571.6,["z"] = 43.29,["h"] = 131.72, ["info"] = " doctor10", ["lock"] = 0, ["doorType"] = "gabz_pillbox_singledoor"},
    [31] =  { ["x"] = 307.94,["y"] = -569.85,["z"] = 43.29,["h"] = 33.55, ["info"] = " doctor11", ["lock"] = 0, ["doorType"] = "gabz_pillbox_singledoor"},
    [32] =  { ["x"] = 308.53607177734,["y"] = -597.13372802734,["z"] = 43.283985137939, ["info"] = " doctor12", ["lock"] = 0, ["doorType"] = "gabz_pillbox_singledoor"},

    -- Prison Cells --
    [33] =  { ["x"] = 1753.308,["y"] = 2478.855,["z"] = 45.58, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [34] =  { ["x"] = 1836.692,["y"] = 2593.746,["z"] = 45.89193, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [35] =  { ["x"] = 1838.891,["y"] = 2588.232,["z"] = 45.89193, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [36] =  { ["x"] = 1782.61,["y"] = 2586.159,["z"] = 45.70737, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [37] =  { ["x"] = 1782.745,["y"] = 2582.003,["z"] = 45.70938, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [38] =  { ["x"] = 1782.722,["y"] = 2577.874,["z"] = 45.71146, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [39] =  { ["x"] = 1782.668,["y"] = 2573.864,["z"] = 45.71352, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [40] =  { ["x"] = 1782.683,["y"] = 2569.763,["z"] = 45.71555, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [41] =  { ["x"] = 1782.701,["y"] = 2569.652,["z"] = 49.71911, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [42] =  { ["x"] = 1782.657,["y"] = 2573.816,["z"] = 49.71698, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [43] =  { ["x"] = 1782.766,["y"] = 2577.872,["z"] = 49.71653, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [44] =  { ["x"] = 1782.741,["y"] = 2581.956,["z"] = 49.71697, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [45] =  { ["x"] = 1782.717,["y"] = 2586.127,["z"] = 49.71707, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [46] =  { ["x"] = 1769.072,["y"] = 2585.326,["z"] = 45.71964, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [47] =  { ["x"] = 1769.086,["y"] = 2581.206,["z"] = 45.72169, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [48] =  { ["x"] = 1769.081,["y"] = 2577.193,["z"] = 45.72366, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [49] =  { ["x"] = 1769.102,["y"] = 2573.051,["z"] = 45.7257, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [50] =  { ["x"] = 1769.036,["y"] = 2585.225,["z"] = 49.71419, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [51] =  { ["x"] = 1769.016,["y"] = 2581.267,["z"] = 49.71419, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [52] =  { ["x"] = 1769.014,["y"] = 2577.098,["z"] = 49.71522, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [53] =  { ["x"] = 1769.114,["y"] = 2572.984,["z"] = 49.7146, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [54] =  { ["x"] = 1769.076,["y"] = 2568.905,["z"] = 49.71814, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    
    -- Jewl Store --
    [23] =  { ["x"] = -632.36,["y"] = -236.92,["z"] = 38.05,["h"] = 306.14, ["info"] = " 1", ["lock"] = 1,["doorType"] = 1425919976 },
    [24] =  { ["x"] = -631.06,["y"] = -238.68,["z"] = 38.11,["h"] = 298.21, ["info"] = " 2", ["lock"] = 1,["doorType"] = 9467943 },
    [25] = { ["x"] = -628.11181640625, ["y"] = -229.98641967773, ["z"] = 38.057052612305, ["info"] = " 3", ["lock"] = 1, ["doorType"] = 1335309163 },
    -- PDM Doors Locks

    [63] =  { ["x"] = -32.13,["y"] = -1102.59,["z"] = 26.43,["h"] = 254.48, ["info"] = " PDM Doors", ["lock"] = 0, ["doorType"] = "v_ilev_fib_door1"},
    [64] =  { ["x"] = -33.99,["y"] = -1108.18,["z"] = 26.43,["h"] = 82.73,  ["info"] = " PDM Doors", ["lock"] = 0, ["doorType"] = "v_ilev_fib_door1"},

    -- Paleto Office
    [65] = { ["x"] = -443.23126220703, ["y"] = 6015.7934570313, ["z"] = 31.716367721558, ["lock"] = 0,["doorType"] = "v_ilev_shrf2door"},
    [66] = { ["x"] = -444.05133056641, ["y"] = 6016.6479492188, ["z"] = 31.716367721558, ["lock"] = 0,["doorType"] = "v_ilev_shrf2door"},
    [67] = { ["x"] = 1855.1921386719, ["y"] = 3683.4545898438, ["z"] = 34.26749420166, ["lock"] = 0,["doorType"] = "v_ilev_shrfdoor"},

    -- Valt
    [68] = { ["x"] = 261.99899291992, ["y"] = 221.50576782227, ["z"] = 106.68346405029, ["lock"] = 0,["doorType"] = "hei_v_ilev_bk_gate2_pris"},

     -- Best Buds
    [74] = { ["x"] = -622.13110351563, ["y"] = -291.44961547852, ["z"] = 35.34188079834, ["lock"] = 0,["doorType"] = "V_iLev_FIB_door3"},

    [20] = { ['x'] = 479.40658569336, ['y'] = -998.88793945312, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_03'}, -- Armory
    [30] = { ['x'] = 449.61758422852, ['y'] = -981.78460693359, ['z'] = 34.958251953125 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_05'}, -- Training Room
    [31] = { ['x'] = 449.65713500977, ['y'] = -989.9208984375, ['z'] = 34.958251953125 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'}, -- Training Room
    [32] = { ['x'] = 449.73626708984, ['y'] = -995.65716552734, ['z'] = 34.958251953125 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_05'}, -- Dispatch Center
    [33] = { ['x'] = 459.30990600586, ['y'] = -991.09448242188, ['z'] = 34.958251953125 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_05'}, -- Meeting Room
    [34] = { ['x'] = 459.1516418457, ['y'] = -980.37359619141, ['z'] = 34.958251953125 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'}, -- Meeting Room
    [35] = { ['x'] = 463.91207885742, ['y'] = -983.81536865234, ['z'] = 43.686401367188 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_03'}, -- Heli Pad
    [40] = { ['x'] = 479.43298339844, ['y'] = -1002.6065673828, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_01'}, -- Lineup
    [41] = { ['x'] = 475.22637939453, ['y'] = -1007.340637207, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_01'}, -- Processing
    [42] = { ['x'] = 480.30328369141, ['y'] = -998.20220947266, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_02'}, -- Door past lineup
    [43] = { ['x'] = 481.58242797852, ['y'] = -998.22857666016, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_02'}, -- Door past lineup
    [44] = { ['x'] = 482.21539306641, ['y'] = -996.23736572266, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'}, -- Interrogation 2
    [45] = { ['x'] = 482.24176025391, ['y'] = -992.91430664062, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'}, -- Observation 2
    [46] = { ['x'] = 482.28131103516, ['y'] = -988.24615478516, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'}, -- Interrogation 1
    [47] = { ['x'] = 482.33407592773, ['y'] = -984.73846435547, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'}, -- Observation 1
    [48] = { ['x'] = 479.41979980469, ['y'] = -986.80877685547, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_02'}, -- Door to Evidence, Garage, Identificaiton
    [49] = { ['x'] = 479.51208496094, ['y'] = -985.43737792969, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_02'}, -- Door to Evidence, Garage, Identificaiton
    [50] = { ['x'] = 475.70111083984, ['y'] = -989.67034912109, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_03'}, -- Evidence
    [51] = { ['x'] = 486.84396362305, ['y'] = -1000.6285400391, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_03'}, -- Armory
    [52] = { ['x'] = 487.29229736328, ['y'] = -1002.5670166016, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_03'}, -- Shooting Range
    [53] = { ['x'] = 486.30328369141, ['y'] = -1002.6197509766, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_03'}, -- Shooting Range
    [54] = { ['x'] = 477.16485595703, ['y'] = -999.07250976562, ['z'] = 30.678344726562 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'}, -- Briefing
    [55] = { ['x'] = 468.0263671875, ['y'] = -1013.947265625, ['z'] = 26.381713867188 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_03'}, -- Backdoor By Gate
    [56] = { ['x'] = 470.83517456055, ['y'] = -1008.3296508789, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_02'}, -- Doors to Process, Cells, Line up, ect
    [57] = { ['x'] = 470.69012451172, ['y'] = -1009.7274780273, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_02'}, -- Doors to Process, Cells, Line up, ect
    [58] = { ['x'] = 475.20001220703, ['y'] = -1010.2944946289, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_door_04'}, -- Mugshot
    [59] = { ['x'] = 476.05715942383, ['y'] = -1008.4747314453, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_cells_door'}, -- Cell by Mugshot
    [60] = { ['x'] = 477.58682250977, ['y'] = -1011.4945068359, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_cells_door'}, -- Cell 1
    [61] = { ['x'] = 480.31649780273, ['y'] = -1011.4154052734, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_cells_door'}, -- Cell 2
    [62] = { ['x'] = 483.23077392578, ['y'] = -1011.3890380859, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_cells_door'}, -- Cell 3
    [63] = { ['x'] = 486.40878295898, ['y'] = -1011.4022216797, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_cells_door'}, -- Cell 4
    [64] = { ['x'] = 484.93188476562, ['y'] = -1008.4747314453, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_cells_door'}, -- Cell 5
    [65] = { ['x'] = 481.54284667969, ['y'] = -1004.4791259766, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_cells_door'}, -- Cell by Lineup
    [66] = { ['x'] = 463.54284667969, ['y'] = -996.29010009766, ['z'] = 26.26379394531 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_room13_parkingdoor'}, -- Parking Door
    [67] = { ['x'] = 463.62197875977, ['y'] = -975.11206054688, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_room13_parkingdoor'}, -- Parking Door
    [21] =  { ["x"] = 1845.371,["y"] = 2608.419,["z"] = 45.59, ["lock"] = 1, ["doorType"] = "prop_gate_prison_01"},
    [22] =  { ["x"] = 1819.203,["y"] = 2608.259,["z"] = 45.59, ["lock"] = 1, ["doorType"] = "prop_gate_prison_01"},
    [67] =  { ["x"] = 1844.81,["y"] = 2586.37,["z"] = 46.01, ["lock"] = 1, ["doorType"] = "prop_pris_door_03"},
    [68] =  { ["x"] = -1126.318,["y"] = -1447.335,["z"] = 5.05, ["lock"] = 1, ["doorType"] = "gabz_haters_entrance_back"},
    [65] =  { ["x"] = -1119.336,["y"] = -1440.309,["z"] = 5.22, ["lock"] = 0, ["doorType"] = "gabz_haters_entrance_front"},
    [66] =  { ["x"] = -1128.001,["y"] = -1440.327,["z"] = 5.22, ["lock"] = 1, ["doorType"] = "gabz_haters_int_door"},
    [67] =  { ["x"] = -622.488,["y"] = -291.1915,["z"] = 35.34, ["lock"] = 1, ["doorType"] = "v_ilev_gendoor01"},
    [68] =  { ["x"] = -202.8277,["y"] = -1324.55,["z"] = 31.09, ["lock"] = 1, ["doorType"] = "gabz_v_ilev_spraydoor"}, 
    [69] =  { ["x"] = -32.43347,["y"] = -1102.46,["z"] = 26.42238, ["lock"] = 1, ["doorType"] = "v_ilev_fib_door1"},
    [70] =  { ["x"] = -34.51234,["y"] = -1108.164,["z"] = 26.42238, ["lock"] = 1, ["doorType"] = "v_ilev_fib_door1"},
    [71] =  { ["x"] = 1745.8385009766,["y"] = 2493.2028808594,["z"] = 45.591323852539, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [72] =  { ["x"] = 1747.9592285156,["y"] = 2489.4645996094,["z"] = 45.589122772217, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [73] =  { ["x"] = 1749.8146972656,["y"] = 2485.8720703125,["z"] = 45.587097167969, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"}, 
    [74] =  { ["x"] = 1751.7692871094,["y"] = 2482.2976074219,["z"] = 45.585056304932, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [75] =  { ["x"] = 1753.7229003906,["y"] = 2478.7277832031,["z"] = 45.583019256592, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [76] =  { ["x"] = 1745.830078125,["y"] = 2493.0773925781,["z"] = 49.591991424561, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"}, 
    [77] =  { ["x"] = 1747.8317871094,["y"] = 2489.4226074219,["z"] = 49.592021942139, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"}, 
    [78] =  { ["x"] = 1749.8243408203,["y"] = 2485.9194335938,["z"] = 49.591793060303, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [79] =  { ["x"] = 1751.8334960938,["y"] = 2482.3073730469,["z"] = 49.590641021729, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"}, 
    [80] =  { ["x"] = 1753.8173828125,["y"] = 2478.7377929688,["z"] = 49.589469909668, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [81] =  { ["x"] = 1764.8930664062,["y"] = 2485.583984375,["z"] = 49.589527130127, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"}, 
    [82] =  { ["x"] = 1762.8692626953,["y"] = 2489.3793945312,["z"] = 49.589492797852, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"}, 
    [83] =  { ["x"] = 1760.8269042969,["y"] = 2492.8356933594,["z"] = 49.58948135376, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [84] =  { ["x"] = 1758.8420410156,["y"] = 2496.5322265625,["z"] = 49.589492797852, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [85] =  { ["x"] = 1756.9116210938,["y"] = 2500.1606445312,["z"] = 49.589492797852, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"}, 
    [86] =  { ["x"] = 1756.7963867188,["y"] = 2500.2370605469,["z"] = 45.602989196777, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"}, 
    [87] =  { ["x"] = 1758.8218994141,["y"] = 2496.5581054688,["z"] = 45.600936889648, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [88] =  { ["x"] = 1760.724609375,["y"] = 2493.1120605469,["z"] = 45.599052429199, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [89] =  { ["x"] = 1762.6840820312,["y"] = 2489.3840332031,["z"] = 45.596900939941, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"},
    [90] =  { ["x"] = 1764.7868652344,["y"] = 2485.7436523438,["z"] = 45.59476852417, ["lock"] = 0, ["doorType"] = "bobo_prison_cellgate"}, 
    [91] =  { ["x"] = 1796.8199462891,["y"] = 2596.1027832031,["z"] = 45.795558929443, ["lock"] = 1, ["doorType"] = "prop_fnclink_03gate5"},
    [92] =  { ["x"] = 1797.0400390625,["y"] = 2592.251953125,["z"] = 45.795680999756, ["lock"] = 0, ["doorType"] = "prop_fnclink_03gate5"},
    [93] =  { ["x"] = 1840.6029052734,["y"] = 2594.3059082031,["z"] = 46.012298583984, ["lock"] = 1, ["doorType"] = "prison_visit_gate"}, 
    [94] =  { ["x"] = 1833.1981201172,["y"] = 2594.3662109375,["z"] = 46.012298583984, ["lock"] = 1, ["doorType"] = "prison_visit_gate"},
    [95] =  { ["x"] = 1826.8801269531,["y"] = 2586.0576171875,["z"] = 46.012245178223, ["lock"] = 1, ["doorType"] = "Prop_Pris_door_03"},
    [96] =  { ["x"] = 369.01193237305,["y"] = -1607.9099121094,["z"] = 29.292062759399, ["lock"] = 1, ["doorType"] = "V_ILev_SHRF2DOOR"},
    [97] =  { ["x"] = 369.78280639648,["y"] = -1607.0085449219,["z"] = 29.292055130005, ["lock"] = 1, ["doorType"] = "V_ILev_SHRF2DOOR"},
    [98] =  { ["x"] = 362.74374389648,["y"] = -1612.9639892578,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "V_ILev_PH_CELLGATE"},
    [99] =  { ["x"] = 360.30706787109,["y"] = -1610.8521728516,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "V_ILev_PH_CELLGATE"},
    [100] =  { ["x"] = 351.42938232422,["y"] = -1603.4200439453,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "V_ILev_PH_CELLGATE"},
    [101] =  { ["x"] = 349.13235473633,["y"] = -1601.5419921875,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "V_ILev_PH_CELLGATE"},
    [102] =  { ["x"] = 352.77471923828,["y"] = -1596.8530273438,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "V_ILev_PH_CELLGATE"},
    [103] =  { ["x"] = 355.30801391602,["y"] = -1599.0789794922,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "V_ILev_PH_CELLGATE"},
    [104] =  { ["x"] = 364.10168457031,["y"] = -1606.5198974609,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "V_ILev_PH_CELLGATE"},
    [105] =  { ["x"] = 366.16070556641,["y"] = -1608.1303710938,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "V_ILev_PH_CELLGATE"},
    [106] =  { ["x"] = 374.3420715332,["y"] = -1603.400390625,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "v_ilev_ph_gendoor002"},
    [107] =  { ["x"] = 383.01245117188,["y"] = -1603.3973388672,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "v_ilev_ph_gendoor002"}, 
    [108] =  { ["x"] = 378.57730102539,["y"] = -1598.8505859375,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "v_ilev_ph_gendoor002"}, 
    [109] =  { ["x"] = 369.6640625,["y"] = -1591.3752441406,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "v_ilev_ph_gendoor002"}, 
    [110] =  { ["x"] = 366.17687988281,["y"] = -1588.9168701172,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "v_ilev_ph_gendoor002"}, 
    [111] =  { ["x"] = 362.15295410156,["y"] = -1593.5950927734,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "v_ilev_ph_gendoor002"}, 
    [112] =  { ["x"] = 368.00622558594,["y"] = -1595.7796630859,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "v_ilev_ph_gendoor002"}, 
    [113] =  { ["x"] = 378.79809570312,["y"] = -1601.4554443359,["z"] = 36.948673248291, ["lock"] = 1, ["doorType"] = "v_ilev_arm_secdoor"}, 
    [114] =  { ["x"] = 372.1911315918,["y"] = -1600.1511230469,["z"] = 29.292060852051, ["lock"] = 1, ["doorType"] = "v_ilev_arm_secdoor"},
    [115] =  { ["x"] = 400.84375,["y"] = -1609.7321777344,["z"] = 29.292045593262, ["lock"] = 0, ["doorType"] = "prop_facgate_07b"},
    [116] =  { ["x"] = 392.08148193359,["y"] = -1635.2934570312,["z"] = 29.292037963867, ["lock"] = 1, ["doorType"] = "prop_fnclink_03gate5"},
    [117] = { ['x'] = 463.54284667969, ['y'] = -996.29010009766, ['z'] = 26.26379394531 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_room13_parkingdoor'},
    [118] = { ['x'] = 463.62197875977, ['y'] = -975.11206054688, ['z'] = 26.263793945312 , ["lock"] = 1,  ["doorType"] = 'gabz_mrpd_room13_parkingdoor'}, 
    [119] = { ['x'] = 489.08193969727, ['y'] = -1020.0619506836, ['z'] = 28.209747314453 , ["lock"] = 1,  ["doorType"] = 'hei_prop_station_gate'},
    [120] = { ['x'] = 256.3116, ['y'] = 220.6579, ['z'] = 106.4296 , ["lock"] = 1,  ["doorType"] = 'hei_v_ilev_bk_gate_pris'},
    [121] = { ['x'] = 262.1981, ['y'] = 222.5188, ['z'] = 106.4296 , ["lock"] = 1,  ["doorType"] = 'hei_v_ilev_bk_gate2_pris'},
    [122] = { ['x'] = 251.8576, ['y'] = 221.0655, ['z'] = 101.8324 , ["lock"] = 1,  ["doorType"] = 'hei_v_ilev_bk_safegate_pris'},
    [123] = { ['x'] = 261.3004, ['y'] = 214.5051, ['z'] = 101.8324 , ["lock"] = 1,  ["doorType"] = 'hei_v_ilev_bk_safegate_pris'},
}

SRP.offSet = {
    ["gabz_mrpd_door_01"] = {1.05, 0.0, 0.0},
    ["gabz_mrpd_door_02"] = {1.05, 0.0, 0.0},
    ["gabz_mrpd_door_03"] = {1.05, 0.0, 0.0},
    ["gabz_mrpd_door_03r"] = {1.05, 0.0, 0.0},
    ["gabz_mrpd_door_04"] = {1.05, 0.0, 0.0},
    ["gabz_mrpd_door_05"] = {-1.14, 0.0, 0.0},
    ["gabz_mrpd_cells_door"] = {-1.14, 0.0, 0.0},
    ["gabz_mrpd_garage_door"] = {0.00, 0.0, 0.0},
    ["gabz_mrpd_room13_parkingdoor"] = {1.05, 0.0, 0.0},
    ["gabz_mrpd_reception_entrancedoor"] = {1.05, 0.0, 0.0},
    ["v_ilev_rc_door2"] = {1.05, 0.0, 0.0},
    ["bobo_prison_cellgate"] = {-1.15, 0.0, 1.10},
    [-1156020871] = {1.55, 0.0, -0.1},
    [-1033001619] = {1.15, 0.0, 0.0},
    ["prop_fnclink_03gate5"] = {1.55, 0.0, -0.1},
    ["hei_v_ilev_bk_gate2_pris"] = {1.20, 0.0, 0.0},
    ["ba_Prop_Door_Club_Glass"] = {1.20, 0.0, 0.0},

    [-222270721] = {1.2, 0.0, 0.0},

    [746855201] = {1.19, 0.0, 0.08},
    [1309269072] = {1.45, 0.0, 0.02},
    [-1023447729] = {1.45, 0.0, 0.02},

    [-495720969] = {-1.25, 0.0, 0.02},
    [464151082] = {-1.14, 0.0, 0.3},
    [-543497392] = {-1.14, 0.0, 0.0},


    [1770281453] = {-1.14, 0.0, 0.0},
    [1173348778] = {-1.14, 0.0, 0.0},
    [479144380] = {-1.14, 0.0, 0.0},

    [1242124150] = {-1.14, 0.0, 0.0},
    [2088680867] = {-1.14, 0.0, 0.0},
    [-320876379] = {-1.14, 0.0, 0.0},
    [631614199] = {-1.14, 0.0, 0.0},
    [-1320876379] = {-1.14, 0.0, 0.0},
    [-1437850419] = {-1.14, 0.0, 0.0},
    [-681066206] = {-1.14, 0.0, 0.0},
    [245182344] = {-1.14, 0.0, 0.0},


    [-1167410167] = {-1.14, 0.0, 1.2},
    [-642608865] = {-1.32, 0.0, -0.23},
    [749848321] = {-1.08, 0.0, 0.2},


    [933053701] = {-1.08, 0.0, 0.2},
    [185711165] = {-1.08, 0.0, 0.2},
    [-1726331785] = {-1.08, 0.0, 0.2},

    [551491569] = {-1.2, 0.0, -0.23},
    [-710818483] = {-1.3, 0.0, -0.23},
    [-543490328] = {-1.0, 0.0, 0.0},
    [-1417290930] = {1.0, 0.0, 0.0},
    [-574290911] = {1.14, 0.0, 0.0},

    [1773345779] = {-1.14, 0.0, 0.0},
    [1971752884] = {-1.14, 0.0, 0.0},
    [1641293839] = {1.07, 0.0, 0.0},
    [1507503102] = {-1.10, 0.0, 0.0},

    [1888438146] = {0.9, 0.0, 0.0},
    [272205552] = {-1.1, 0.0, 0.0},
    [9467943] = {-1.2, 0.0, 0.1},
    [534758478] = {-1.2, 0.0, 0.1},

    [988364535] = {0.4, 0.0, 0.1},
    [-1141522158] = {-0.4, 0.0, 0.1},
    [1219405180] = {-1.20, 0.0, 0.0},

    [-1011692606] = {1.37, 0.0, 0.05},
    [91564889] = {1.37, 0.0, 0.05},

    ["gabz_pillbox_doubledoor_r"] = {-1.17, 0.0, 0.05},
    ["gabz_pillbox_doubledoor_l"] = {1.17, 0.0, 0.05},
    ["gabz_pillbox_singledoor"] = {1.17, 0.0, 0.05},
    ["Prop_Strip_Door_01"] = {1.17, 0.0, 0.05},

    [-1821777087] = {-1.18, 0.0, 0.05},
    [-1687047623] = {-1.18, 0.0, 0.05},
    [1015445881] = {-1.0, 0.0, -0.30},
    ["v_ilev_fib_door1"] = {-1.18, 0.0,-0.1},
    [-550347177] = {-1.18, 0.0,-0.1},
    [447044832] = {-1.0, 0.0,-0.1},
    [1335311341] = {-1.1, 0.0,-0.0},
}

-- Gang name , then rank , then door numbers
SRP.rankCheck = {
    ["parts_shop"] = {
        [1] = {
            ["between"] = {},
            ["single"] = {156}
        },
        [3] = {
            ["between"] = {},
            ["single"] = {278,279}
        }
    },
    ["lost_mc"] = {
        [1] = {
            ["between"] = {},
            ["single"] = {187,188,189}
        }
    },
    ["carpet_factory"] = {
        [1] = {
            ["between"] = {},
            ["single"] = {160,161}
        }
    },
    ["illegal_carshop"] = {
        [1] = {
            ["between"] = {},
            ["single"] = {162,163,268,269,273,274}
        },
        [2] = {
            ["between"] = {},
            ["single"] = {266,267,272}
        },
        [3] = {
            ["between"] = {},
            ["single"] = {265}
        }
    },
    ["tuner_carshop"] = {
        [2] = {
            ["between"] = {},
            ["single"] = {192,193}
        }
    },
    ["rooster_academy"] = {
        [3] = {
            ["between"] = {
                [1] = {219,223},
                [2] = {230,239}
            },
            ["single"] = {}
        }
    },
    ["strip_club"] = {
        [1] = {
            ["between"] = {},
            ["single"] = {114}
        },

        [3] = {
            ["between"] = {
                [1] = {115,116},
                [2] = {245,246}
            },
            ["single"] = {248}
        },

        [4] = {
            ["between"] = {
                [1] = {249,250}
            },
            ["single"] = {247}
        }
    },

    ["weed_factory"] = {
        [2] = {
            ["between"] = {},
            ["single"] = {164}
        }
    },
    ["winery_factory"] = {
        [3] = {
            ["between"] = {},
            ["single"] = {164}
        },

        [4] = {
            ["between"] = {
                [1] = {222,230}
            },
            ["single"] = {}
        }
    },
    ["drift_school"] = {
        [1] = {
            ["between"] = {
                [1] = {240,243}
            },
            ["single"] = {}
        },

        [3] = {
            ["between"] = {},
            ["single"] = {244}
        }
    },
    ["car_shop"] = {
        [2] = {
            ["between"] = {},
            ["single"] = {270,271}
        },
    },
}

function SRP.alterState(alterNum)

    if SRP.DoorCoords[alterNum]["lock"] == 0 then 
        SRP.DoorCoords[alterNum]["lock"] = 1 
    else 
        SRP.DoorCoords[alterNum]["lock"] = 0 
    end
    TriggerClientEvent("srp:Door:alterState",-1,alterNum,SRP.DoorCoords[alterNum]["lock"])

end

RegisterNetEvent( "srp:Door:alterState" )
AddEventHandler( "srp:Door:alterState", function(alterNum,num)
	SRP.DoorCoords[alterNum]["lock"] = num
end)

RegisterNetEvent("srp-doors:alterlockstateclient")
AddEventHandler("srp-doors:alterlockstateclient", function(doorCoords)
    SRP.DoorCoords = doorCoords
end)