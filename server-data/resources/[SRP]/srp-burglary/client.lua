local isLockpicking = false
local safe = 0
local safepos = {}
local isRobbing = false
local curHouseCoords = {x = 0, y = 0, z = 0}
local disturbance = 0
local isAgro = false
local myRobbableItems = {}
local robberyped = nil
local isPolice = false
local robbableHouses = {
  [1] = {x = 1061.04, y = -378.61, z = 68.24, robbed = false, info = 'West Mirror Drive 1'},
  [2] = {x = 1029.42, y = -408.96, z = 65.95, robbed = false, info = 'West Mirror Drive 2'},
  [3] = {x = 1011.27, y = -422.89, z = 64.96, robbed = false, info = 'West Mirror Drive 3'},
  [4] = {x = 988.2, y = -433.74, z = 63.9, robbed = false, info = 'West Mirror Drive 4'},
  [5] = {x = 967.9, y = -452.62, z = 62.41, robbed = false, info = 'West Mirror Drive 5'},
  [6] = {x = 943.26, y = -463.9, z = 61.4, robbed = false, info = 'West Mirror Drive 6'},
  [7] = {x = 922.18, y = -478.69, z = 61.09, robbed = false, info = 'West Mirror Drive 7'},
  [8] = {x = 906.58, y = -489.69, z = 59.44, robbed = false, info = 'West Mirror Drive 8'},
  [9] = {x = 878.99, y = -498.51, z = 57.88, robbed = false, info = 'West Mirror Drive 9'},
  [10] = {x = 862.28, y = -509.58, z = 57.33, robbed = false, info = 'West Mirror Drive 10'},
  [11] = {x = 851.09, y = -532.73, z = 57.93, robbed = false, info = 'West Mirror Drive 11'},
  [12] = {x = 844.37, y = -563.77, z = 57.84, robbed = false, info = 'West Mirror Drive 12'},
  [13] = {x = 861.92, y = -582.26, z = 58.16, robbed = false, info = 'West Mirror Drive 13'},
  [14] = {x = 887.43, y = -607.54, z = 58.22, robbed = false, info = 'West Mirror Drive 14'},
  [15] = {x = 903.47, y = -615.87, z = 58.46, robbed = false, info = 'West Mirror Drive 15'},
  [16] = {x = 929.51, y = -639.12, z = 58.25, robbed = false, info = 'West Mirror Drive 16'},
  [17] = {x = 943.4, y = -653.71, z = 58.43, robbed = false, info = 'West Mirror Drive 17'},
  [18] = {x = 960.54, y = -669.38, z = 58.45, robbed = false, info = 'West Mirror Drive 18'},
  [19] = {x = 970.9, y = -701.41, z = 58.49, robbed = false, info = 'West Mirror Drive 19'},
  [20] = {x = 979.49, y = -715.95, z = 58.22, robbed = false, info = 'West Mirror Drive 20'},
  [21] = {x = 997.52, y = -729.0, z = 57.82, robbed = false, info = 'West Mirror Drive 21'},
  [22] = {x = 979.92, y = -627.24, z = 59.24, robbed = false, info = 'West Mirror Drive 22'},
  [23] = {x = 892.79, y = -540.7, z = 58.51, robbed = false, info = 'West Mirror Drive 23'},
  [24] = {x = 924.02, y = -525.3, z = 59.58, robbed = false, info = 'West Mirror Drive 24'},
  [25] = {x = 946.26, y = -518.79, z = 60.63, robbed = false, info = 'West Mirror Drive 25'},
  [26] = {x = 969.57, y = -502.1, z = 62.15, robbed = false, info = 'West Mirror Drive 26'},
  [27] = {x = 1014.14, y = -468.72, z = 64.29, robbed = false, info = 'West Mirror Drive 27'},
  [28] = {x = 1112.37, y = -390.29, z = 68.74, robbed = false, info = 'West Mirror Drive 28'},
  [29] = {x = 1263.96, y = -429.2, z = 69.81, robbed = false, info = 'East Mirror Drive 1'},
  [30] = {x = 1266.76, y = -457.85, z = 70.52, robbed = false, info = 'East Mirror Drive 2'},
  [31] = {x = 1260.28, y = -479.9, z = 70.19, robbed = false, info = 'East Mirror Drive 3'},
  [32] = {x = 1251.86, y = -494.2, z = 69.91, robbed = false, info = 'East Mirror Drive 4'},
  [33] = {x = 1251.5, y = -515.63, z = 69.35, robbed = false, info = 'East Mirror Drive 5'},
  [34] = {x = 1242.17, y = -565.88, z = 69.66, robbed = false, info = 'East Mirror Drive 6'},
  [35] = {x = 1241.1, y = -601.67, z = 69.59, robbed = false, info = 'East Mirror Drive 7'},
  [36] = {x = 1251.6, y = -621.98, z = 69.41, robbed = false, info = 'East Mirror Drive 8'},
  [37] = {x = 1265.41, y = -647.89, z = 67.93, robbed = false, info = 'East Mirror Drive 9'},
  [38] = {x = 1271.13, y = -683.04, z = 66.04, robbed = false, info = 'East Mirror Drive 10'},
  [39] = {x = 1265.94, y = -703.52, z = 64.56, robbed = false, info = 'East Mirror Drive 11'},
  [40] = {x = 1302.79, y = -528.61, z = 71.47, robbed = false, info = 'Nikola Place 1'},
  [41] = {x = 1327.76, y = -535.86, z = 72.45, robbed = false, info = 'Nikola Place 2'},
  [42] = {x = 1347.87, y = -548.01, z = 73.9, robbed = false, info = 'Nikola Place 3'},
  [43] = {x = 1372.97, y = -555.69, z = 74.69, robbed = false, info = 'Nikola Place 4'},
  [44] = {x = 1388.3, y = -569.93, z = 74.5, robbed = false, info = 'Nikola Place 5'},
  [45] = {x = 1385.47, y = -592.93, z = 74.49, robbed = false, info = 'Nikola Place 6'},
  [46] = {x = 1367.28, y = -605.44, z = 74.72, robbed = false, info = 'Nikola Place 7'},
  [47] = {x = 1341.63, y = -597.5, z = 74.71, robbed = false, info = 'Nikola Place 8'},
  [48] = {x = 1323.76, y = -582.45, z = 73.25, robbed = false, info = 'Nikola Place 9'},
  [49] = {x = 1301.24, y = -573.21, z = 71.74, robbed = false, info = 'Nikola Place 10'},
  [50] = {x = 1437.15, y = -1492.97, z = 63.44, robbed = false, info = 'Fudge Lane 1'},
  [51] = {x = 1379.49, y = -1515.41, z = 58.04, robbed = false, info = 'Fudge Lane 2'},
  [52] = {x = 1338.24, y = -1524.22, z = 54.59, robbed = false, info = 'Fudge Lane 3'},
  [53] = {x = 1316.2, y = -1528.01, z = 51.42, robbed = false, info = 'Fudge Lane 4'},
  [54] = {x = 1231.17, y = -1591.76, z = 53.56, robbed = false, info = 'Fudge Lane 5'},
  [55] = {x = 1205.91, y = -1607.85, z = 50.54, robbed = false, info = 'Fudge Lane 6'},
  [56] = {x = 1192.94, y = -1622.69, z = 45.23, robbed = false, info = 'Fudge Lane 7'},
  [57] = {x = 1192.82, y = -1655.06, z = 43.03, robbed = false, info = 'Fudge Lane 8'},
  [58] = {x = 1214.11, y = -1643.33, z = 48.65, robbed = false, info = 'Fudge Lane 9'},
  [59] = {x = 1244.78, y = -1625.69, z = 53.29, robbed = false, info = 'Fudge Lane 10'},
  [60] = {x = 1261.31, y = -1616.26, z = 54.75, robbed = false, info = 'Fudge Lane 11'},
  [61] = {x = 1286.4, y = -1603.31, z = 54.83, robbed = false, info = 'Fudge Lane 12'},
  [62] = {x = 1327.22, y = -1552.61, z = 54.06, robbed = false, info = 'Fudge Lane 13'},
  [63] = {x = 1360.39, y = -1554.92, z = 55.95, robbed = false, info = 'Fudge Lane 14'},
  [64] = {x = 1382.68, y = -1544.46, z = 57.11, robbed = false, info = 'Fudge Lane 15'},
  [65] = {x = 1365.25, y = -1720.38, z = 65.64, robbed = false, info = 'Amarillo Vista 1'},
  [66] = {x = 1315.17, y = -1732.63, z = 54.71, robbed = false, info = 'Amarillo Vista 2'},
  [67] = {x = 1295.86, y = -1739.44, z = 54.28, robbed = false, info = 'Amarillo Vista 3'},
  [68] = {x = 1258.81, y = -1761.27, z = 49.67, robbed = false, info = 'Amarillo Vista 4'},
  [69] = {x = 1251.01, y = -1735.07, z = 52.03, robbed = false, info = 'Amarillo Vista 5'},
  [70] = {x = 1289.66, y = -1711.45, z = 55.28, robbed = false, info = 'Amarillo Vista 7'},
  [71] = {x = 1316.97, y = -1699.67, z = 57.84, robbed = false, info = 'Amarillo Vista 8'},
  [72] = {x = 1355.45, y = -1690.85, z = 60.5, robbed = false, info = 'Amarillo Vista 9'},
  [73] = {x = -51.01, y = -1783.87, z = 28.31, robbed = false, info = 'Grove Street 1'},
  [74] = {x = -42.56, y = -1792.78, z = 27.83, robbed = false, info = 'Grove Street 2'},
  [75] = {x = 20.57, y = -1844.12, z = 24.61, robbed = false, info = 'Grove Street 3'},
  [76] = {x = 29.32, y = -1853.94, z = 24.07, robbed = false, info = 'Grove Street 4'},
  [77] = {x = 45.32, y = -1864.99, z = 23.28, robbed = false, info = 'Grove Street 5'},
  [78] = {x = 54.44, y = -1873.17, z = 22.81, robbed = false, info = 'Grove Street 6'},
  [79] = {x = 100.48, y = -1913.0, z = 21.21, robbed = false, info = 'Grove Street 7'},
  [80] = {x = 117.81, y = -1920.55, z = 21.33, robbed = false, info = 'Grove Street 8'},
  [81] = {x = 126.4, y = -1929.47, z = 21.39, robbed = false, info = 'Grove Street 9'},
  [82] = {x = 114.05, y = -1960.69, z = 21.34, robbed = false, info = 'Grove Street 10'},
  [83] = {x = 85.31, y = -1959.0, z = 21.13, robbed = false, info = 'Grove Street 11'},
  [84] = {x = 76.92, y = -1948.61, z = 21.18, robbed = false, info = 'Grove Street 12'},
  [85] = {x = 72.94, y = -1938.5, z = 21.17, robbed = false, info = 'Grove Street 13'},
  [86] = {x = 57.03, y = -1922.37, z = 21.92, robbed = false, info = 'Grove Street 14'},
  [87] = {x = 39.59, y = -1911.99, z = 21.96, robbed = false, info = 'Grove Street 15'},
  [88] = {x = 23.75, y = -1895.77, z = 22.78, robbed = false, info = 'Grove Street 16'},
  [89] = {x = 4.58, y = -1883.77, z = 23.7, robbed = false, info = 'Grove Street 17'},
  [90] = {x = -5.8, y = -1871.52, z = 24.16, robbed = false, info = 'Grove Street 18'},
  [91] = {x = -21.18, y = -1858.15, z = 25.4, robbed = false, info = 'Grove Street 19'},
  [92] = {x = -33.71, y = -1847.46, z = 26.2, robbed = false, info = 'Grove Street 20'},
  [93] = {x = -157.6, y = -1680.11, z = 33.44, robbed = false, info = 'Forum Drive 1/Apt1'},
  [94] = {x = -148.39, y = -1688.04, z = 32.88, robbed = false, info = 'Forum Drive 1/Apt2'},
  [95] = {x = -147.3, y = -1688.99, z = 32.88, robbed = false, info = 'Forum Drive 1/Apt3'},
  [96] = {x = -143.08, y = -1692.38, z = 32.88, robbed = false, info = 'Forum Drive 1/Apt4'},
  [97] = {x = -141.89, y = -1693.43, z = 32.88, robbed = false, info = 'Forum Drive 1/Apt5'},
  [98] = {x = -141.79, y = -1693.55, z = 36.17, robbed = false, info = 'Forum Drive 1/Apt6'},
  [99] = {x = -142.19, y = -1692.69, z = 36.17, robbed = false, info = 'Forum Drive 1/Apt7'},
  [100] = {x = -147.39, y = -1688.39, z = 36.17, robbed = false, info = 'Forum Drive 1/Apt8'},
  [101] = {x = -148.69, y = -1687.35, z = 36.17, robbed = false, info = 'Forum Drive 1/Apt9'},
  [102] = {x = -157.54, y = -1679.61, z = 36.97, robbed = false, info = 'Forum Drive 1/Apt10'},
  [103] = {x = -158.86, y = -1680.02, z = 36.97, robbed = false, info = 'Forum Drive 1/Apt11'},
  [104] = {x = -160.83, y = -1637.93, z = 34.03, robbed = false, info = 'Forum Drive 2/Apt1'},
  [105] = {x = -160.0, y = -1636.41, z = 34.03, robbed = false, info = 'Forum Drive 2/Apt2'},
  [106] = {x = -153.87, y = -1641.77, z = 36.86, robbed = false, info = 'Forum Drive 2/Apt3'},
  [107] = {x = -159.85, y = -1636.42, z = 37.25, robbed = false, info = 'Forum Drive 2/Apt4'},
  [108] = {x = -161.31, y = -1638.13, z = 37.25, robbed = false, info = 'Forum Drive 2/Apt5'},
  [109] = {x = -150.79, y = -1625.26, z = 33.66, robbed = false, info = 'Forum Drive 2/Apt6'},
  [110] = {x = -150.74, y = -1622.68, z = 33.66, robbed = false, info = 'Forum Drive 2/Apt7'},
  [111] = {x = -145.59, y = -1617.88, z = 36.05, robbed = false, info = 'Forum Drive 2/Apt8'},
  [112] = {x = -145.84, y = -1614.71, z = 36.05, robbed = false, info = 'Forum Drive 2/Apt9'},
  [113] = {x = -152.23, y = -1624.37, z = 36.85, robbed = false, info = 'Forum Drive 2/Apt10'},
  [114] = {x = -150.38, y = -1625.5, z = 36.85, robbed = false, info = 'Forum Drive 2/Apt11'},
  [115] = {x = -120.58, y = -1575.04, z = 34.18, robbed = false, info = 'Forum Drive 3/Apt1'},
  [116] = {x = -114.73, y = -1579.95, z = 34.18, robbed = false, info = 'Forum Drive 3/Apt2'},
  [117] = {x = -119.6, y = -1585.41, z = 34.22, robbed = false, info = 'Forum Drive 3/Apt3'},
  [118] = {x = -123.81, y = -1590.67, z = 34.21, robbed = false, info = 'Forum Drive 3/Apt4'},
  [119] = {x = -139.85, y = -1598.7, z = 34.84, robbed = false, info = 'Forum Drive 3/Apt6'},
  [120] = {x = -146.85, y = -1596.64, z = 34.84, robbed = false, info = 'Forum Drive 3/Apt7'},
  [121] = {x = -139.49, y = -1588.39, z = 34.25, robbed = false, info = 'Forum Drive 3/Apt8'},
  [122] = {x = -133.47, y = -1581.2, z = 34.21, robbed = false, info = 'Forum Drive 3/Apt9'},
  [123] = {x = -120.63, y = -1575.05, z = 37.41, robbed = false, info = 'Forum Drive 3/Apt10'},
  [124] = {x = -114.71, y = -1580.4, z = 37.41, robbed = false, info = 'Forum Drive 3/Apt11'},
  [125] = {x = -119.53, y = -1585.26, z = 37.41, robbed = false, info = 'Forum Drive 3/Apt12'},
  [126] = {x = -123.67, y = -1590.39, z = 37.41, robbed = false, info = 'Forum Drive 3/Apt13'},
  [127] = {x = -140.08, y = -1598.75, z = 38.22, robbed = false, info = 'Forum Drive 3/Apt15'},
  [128] = {x = -145.81, y = -1597.55, z = 38.22, robbed = false, info = 'Forum Drive 3/Apt16'},
  [129] = {x = -147.47, y = -1596.26, z = 38.22, robbed = false, info = 'Forum Drive 3/Apt17'},
  [130] = {x = -139.77, y = -1587.8, z = 37.41, robbed = false, info = 'Forum Drive 3/Apt18'},
  [131] = {x = -133.78, y = -1580.56, z = 37.41, robbed = false, info = 'Forum Drive 3/Apt19'},
  [132] = {x = 16.5, y = -1443.77, z = 30.95, robbed = false, info = 'Forum Drive 4'},
  [133] = {x = -1.98, y = -1442.55, z = 30.97, robbed = false, info = 'Forum Drive 5'},
  [134] = {x = -32.87, y = -1446.34, z = 31.9, robbed = false, info = 'Forum Drive 7'},
  [135] = {x = -45.73, y = -1445.58, z = 32.43, robbed = false, info = 'Forum Drive 8'},
  [136] = {x = -64.48, y = -1449.57, z = 32.53, robbed = false, info = 'Forum Drive 9'},
  [137] = {x = -167.71, y = -1534.71, z = 35.1, robbed = false, info = 'Forum Drive 10/Apt1'},
  [138] = {x = -180.71, y = -1553.51, z = 35.13, robbed = false, info = 'Forum Drive 10/Apt2'},
  [139] = {x = -187.47, y = -1562.96, z = 35.76, robbed = false, info = 'Forum Drive 10/Apt3'},
  [140] = {x = -191.86, y = -1559.4, z = 34.96, robbed = false, info = 'Forum Drive 10/Apt4'},
  [141] = {x = -195.55, y = -1556.06, z = 34.96, robbed = false, info = 'Forum Drive 10/Apt5'},
  [142] = {x = -183.81, y = -1540.59, z = 34.36, robbed = false, info = 'Forum Drive 10/Apt6'},
  [143] = {x = -179.69, y = -1534.66, z = 34.36, robbed = false, info = 'Forum Drive 10/Apt7'},
  [144] = {x = -175.06, y = -1529.53, z = 34.36, robbed = false, info = 'Forum Drive 10/Apt8'},
  [145] = {x = -167.62, y = -1534.9, z = 38.33, robbed = false, info = 'Forum Drive 10/Apt10'},
  [146] = {x = -180.19, y = -1553.89, z = 38.34, robbed = false, info = 'Forum Drive 10/Apt11'},
  [147] = {x = -186.63, y = -1562.32, z = 39.14, robbed = false, info = 'Forum Drive 10/Apt12'},
  [148] = {x = -188.32, y = -1562.5, z = 39.14, robbed = false, info = 'Forum Drive 10/Apt13'},
  [149] = {x = -192.14, y = -1559.64, z = 38.34, robbed = false, info = 'Forum Drive 10/Apt14'},
  [150] = {x = -195.77, y = -1555.92, z = 38.34, robbed = false, info = 'Forum Drive 10/Apt15'},
  [151] = {x = -184.06, y = -1539.83, z = 37.54, robbed = false, info = 'Forum Drive 10/Apt16'},
  [152] = {x = -179.58, y = -1534.93, z = 37.54, robbed = false, info = 'Forum Drive 10/Apt17'},
  [153] = {x = -174.87, y = -1529.18, z = 37.54, robbed = false, info = 'Forum Drive 10/Apt18'},
  [154] = {x = -208.75, y = -1600.32, z = 34.87, robbed = false, info = 'Forum Drive 11/Apt1'},
  [155] = {x = -210.05, y = -1607.17, z = 34.87, robbed = false, info = 'Forum Drive 11/Apt2'},
  [156] = {x = -212.05, y = -1616.86, z = 34.87, robbed = false, info = 'Forum Drive 11/Apt3'},
  [157] = {x = -213.8, y = -1618.07, z = 34.87, robbed = false, info = 'Forum Drive 11/Apt4'},
  [158] = {x = -221.82, y = -1617.45, z = 34.87, robbed = false, info = 'Forum Drive 11/Apt5'},
  [159] = {x = -223.06, y = -1601.38, z = 34.89, robbed = false, info = 'Forum Drive 11/Apt6'},
  [160] = {x = -222.52, y = -1585.71, z = 34.87, robbed = false, info = 'Forum Drive 11/Apt7'},
  [161] = {x = -218.91, y = -1580.06, z = 34.87, robbed = false, info = 'Forum Drive 11/Apt8'},
  [162] = {x = -216.48, y = -1577.45, z = 34.87, robbed = false, info = 'Forum Drive 11/Apt9'},
  [163] = {x = -206.23, y = -1585.55, z = 34.87, robbed = false, info = 'Forum Drive 11/Apt10'},
  [164] = {x = -206.63, y = -1585.8, z = 38.06, robbed = false, info = 'Forum Drive 11/Apt12'},
  [165] = {x = -216.05, y = -1576.86, z = 38.06, robbed = false, info = 'Forum Drive 11/Apt13'},
  [166] = {x = -218.37, y = -1579.89, z = 38.06, robbed = false, info = 'Forum Drive 11/Apt14'},
  [167] = {x = -222.25, y = -1585.37, z = 38.06, robbed = false, info = 'Forum Drive 11/Apt15'},
  [168] = {x = -222.26, y = -1600.93, z = 38.06, robbed = false, info = 'Forum Drive 11/Apt16'},
  [169] = {x = -222.21, y = -1617.39, z = 38.06, robbed = false, info = 'Forum Drive 11/Apt17'},
  [170] = {x = -214.12, y = -1617.62, z = 38.06, robbed = false, info = 'Forum Drive 11/Apt18'},
  [171] = {x = -212.29, y = -1617.34, z = 38.06, robbed = false, info = 'Forum Drive 11/Apt19'},
  [172] = {x = -210.46, y = -1607.36, z = 38.05, robbed = false, info = 'Forum Drive 11/Apt20'},
  [173] = {x = -209.45, y = -1600.57, z = 38.05, robbed = false, info = 'Forum Drive 11/Apt21'},
  [174] = {x = -216.64, y = -1673.73, z = 34.47, robbed = false, info = 'Forum Drive 12/Apt1'},
  [175] = {x = -224.15, y = -1673.67, z = 34.47, robbed = false, info = 'Forum Drive 12/Apt2'},
  [176] = {x = -224.17, y = -1666.14, z = 34.47, robbed = false, info = 'Forum Drive 12/Apt3'},
  [177] = {x = -224.32, y = -1649.0, z = 34.86, robbed = false, info = 'Forum Drive 12/Apt4'},
  [178] = {x = -216.34, y = -1648.94, z = 34.47, robbed = false, info = 'Forum Drive 12/Apt5'},
  [179] = {x = -212.92, y = -1660.54, z = 34.47, robbed = false, info = 'Forum Drive 12/Apt6'},
  [180] = {x = -212.95, y = -1667.96, z = 34.47, robbed = false, info = 'Forum Drive 12/Apt7'},
  [181] = {x = -216.55, y = -1673.88, z = 37.64, robbed = false, info = 'Forum Drive 12/Apt8'},
  [182] = {x = -224.34, y = -1673.79, z = 37.64, robbed = false, info = 'Forum Drive 12/Apt9'},
  [183] = {x = -223.99, y = -1666.29, z = 37.64, robbed = false, info = 'Forum Drive 12/Apt10'},
  [184] = {x = -224.44, y = -1653.99, z = 37.64, robbed = false, info = 'Forum Drive 12/Apt11'},
  [185] = {x = -223.96, y = -1649.16, z = 38.45, robbed = false, info = 'Forum Drive 12/Apt12'},
  [186] = {x = -216.44, y = -1649.13, z = 37.64, robbed = false, info = 'Forum Drive 12/Apt13'},
  [187] = {x = -212.85, y = -1660.74, z = 37.64, robbed = false, info = 'Forum Drive 12/Apt14'},
  [188] = {x = -212.72, y = -1668.23, z = 37.64, robbed = false, info = 'Forum Drive 12/Apt15'},
  [189] = {x = 207.81, y = -1894.66, z = 24.82, robbed = false, info = 'Covenant Avenue 1'},
  [190] = {x = 192.27, y = -1884.01, z = 24.86, robbed = false, info = 'Covenant Avenue 2'},
  [191] = {x = 170.9, y = -1871.29, z = 24.41, robbed = false, info = 'Covenant Avenue 3'},
  [192] = {x = 149.69, y = -1865.39, z = 24.6, robbed = false, info = 'Covenant Avenue 4'},
  [193] = {x = 130.2, y = -1854.03, z = 25.06, robbed = false, info = 'Covenant Avenue 5'},
  [194] = {x = 104.32, y = -1884.78, z = 24.32, robbed = false, info = 'Covenant Avenue 6'},
  [195] = {x = 114.95, y = -1887.7, z = 23.93, robbed = false, info = 'Covenant Avenue 7'},
  [196] = {x = 127.69, y = -1896.79, z = 23.68, robbed = false, info = 'Covenant Avenue 8'},
  [197] = {x = 148.81, y = -1904.41, z = 23.54, robbed = false, info = 'Covenant Avenue 9'},
  [198] = {x = -1071.77, y = -1566.08, z = 4.39, robbed = false, info = 'Beachside Court 13'},
  [199] = {x = -1073.94, y = -1562.36, z = 4.46, robbed = false, info = 'Beachside Court 14'},
  [200] = {x = -1066.23, y = -1545.34, z = 4.91, robbed = false, info = 'Beachside Court 15'},
  [201] = {x = -113.52, y = -1478.46, z = 33.83, robbed = false, info = 'Carson Avenue 1/Apt1'},
  [202] = {x = -108.04, y = -1473.11, z = 33.83, robbed = false, info = 'Carson Avenue 1/Apt2'},
  [203] = {x = -113.89, y = -1468.64, z = 33.83, robbed = false, info = 'Carson Avenue 1/Apt3'},
  [204] = {x = -123.05, y = -1460.05, z = 33.83, robbed = false, info = 'Carson Avenue 1/Apt4'},
  [205] = {x = -126.68, y = -1456.71, z = 34.57, robbed = false, info = 'Carson Avenue 1/Apt5'},
  [206] = {x = -131.8, y = -1463.15, z = 33.83, robbed = false, info = 'Carson Avenue 1/Apt6'},
  [207] = {x = -125.47, y = -1473.1, z = 33.83, robbed = false, info = 'Carson Avenue 1/Apt7'},
  [208] = {x = -119.61, y = -1478.11, z = 33.83, robbed = false, info = 'Carson Avenue 1/Apt8'},
  [209] = {x = -122.98, y = -1460.25, z = 37.0, robbed = false, info = 'Carson Avenue 1/Apt9'},
  [210] = {x = -127.02, y = -1457.18, z = 37.8, robbed = false, info = 'Carson Avenue 1/Apt10'},
  [211] = {x = -131.92, y = -1463.16, z = 37.0, robbed = false, info = 'Carson Avenue 1/Apt11'},
  [212] = {x = -138.15, y = -1470.49, z = 37.0, robbed = false, info = 'Carson Avenue 1/Apt12'},
  [213] = {x = -125.48, y = -1473.39, z = 37.0, robbed = false, info = 'Carson Avenue 1/Apt13'},
  [214] = {x = -119.87, y = -1477.81, z = 37.0, robbed = false, info = 'Carson Avenue 1/Apt14'},
  [215] = {x = -77.1, y = -1515.61, z = 34.25, robbed = false, info = 'Carson Avenue 2/Apt1'},
  [216] = {x = -71.74, y = -1508.33, z = 33.44, robbed = false, info = 'Carson Avenue 2/Apt2'},
  [217] = {x = -65.73, y = -1513.55, z = 33.44, robbed = false, info = 'Carson Avenue 2/Apt3'},
  [218] = {x = -60.39, y = -1517.48, z = 33.44, robbed = false, info = 'Carson Avenue 2/Apt4'},
  [219] = {x = -54.1, y = -1523.19, z = 33.44, robbed = false, info = 'Carson Avenue 2/Apt5'},
  [220] = {x = -59.84, y = -1530.35, z = 34.24, robbed = false, info = 'Carson Avenue 2/Apt6'},
  [221] = {x = -62.18, y = -1532.27, z = 34.24, robbed = false, info = 'Carson Avenue 2/Apt7'},
  [222] = {x = -68.86, y = -1526.34, z = 34.24, robbed = false, info = 'Carson Avenue 2/Apt8'},
  [223] = {x = -77.3, y = -1515.62, z = 37.42, robbed = false, info = 'Carson Avenue 2/Apt9'},
  [224] = {x = -71.37, y = -1508.76, z = 36.63, robbed = false, info = 'Carson Avenue 2/Apt10'},
  [225] = {x = -65.85, y = -1513.39, z = 36.63, robbed = false, info = 'Carson Avenue 2/Apt11'},
  [226] = {x = -61.03, y = -1517.82, z = 36.63, robbed = false, info = 'Carson Avenue 2/Apt12'},
  [227] = {x = -54.23, y = -1523.33, z = 36.63, robbed = false, info = 'Carson Avenue 2/Apt13'},
  [228] = {x = -60.03, y = -1530.35, z = 37.42, robbed = false, info = 'Carson Avenue 2/Apt14'},
  [229] = {x = -61.53, y = -1532.14, z = 37.42, robbed = false, info = 'Carson Avenue 2/Apt15'},
  [230] = {x = -68.59, y = -1526.2, z = 37.42, robbed = false, info = 'Carson Avenue 2/Apt16'},
  [231] = {x = -35.11, y = -1554.6, z = 30.68, robbed = false, info = 'Strawberry Avenue 1/Apt1'},
  [232] = {x = -44.33, y = -1547.29, z = 31.27, robbed = false, info = 'Strawberry Avenue 1/Apt2'},
  [233] = {x = -36.07, y = -1537.29, z = 31.25, robbed = false, info = 'Strawberry Avenue 1/Apt3'},
  [234] = {x = -26.48, y = -1544.33, z = 30.68, robbed = false, info = 'Strawberry Avenue 1/Apt4'},
  [235] = {x = -20.54, y = -1550.16, z = 30.68, robbed = false, info = 'Strawberry Avenue 1/Apt5'},
  [236] = {x = -25.49, y = -1556.28, z = 30.69, robbed = false, info = 'Strawberry Avenue 1/Apt6'},
  [237] = {x = -34.37, y = -1566.55, z = 33.03, robbed = false, info = 'Strawberry Avenue 1/Apt7'},
  [238] = {x = -35.36, y = -1555.08, z = 33.83, robbed = false, info = 'Strawberry Avenue 1/Apt8'},
  [239] = {x = -43.9, y = -1547.83, z = 34.63, robbed = false, info = 'Strawberry Avenue 1/Apt9'},
  [240] = {x = -28.52, y = -1560.41, z = 33.83, robbed = false, info = 'Strawberry Avenue 1/Apt14'},
  [241] = {x = -14.63, y = -1543.73, z = 33.03, robbed = false, info = 'Strawberry Avenue 1/Apt12'},
  [242] = {x = -20.69, y = -1550.0, z = 33.83, robbed = false, info = 'Strawberry Avenue 1/Apt13'},
  [243] = {x = -26.96, y = -1544.93, z = 33.83, robbed = false, info = 'Strawberry Avenue 1/Apt11'},
  [244] = {x = -35.82, y = -1537.25, z = 34.63, robbed = false, info = 'Strawberry Avenue 1/Apt10'},
  [245] = {x = -84.12, y = -1622.47, z = 31.48, robbed = false, info = 'Strawberry Avenue 2/Apt1'},
  [246] = {x = -90.44, y = -1629.08, z = 31.51, robbed = false, info = 'Strawberry Avenue 2/Apt2'},
  [247] = {x = -97.46, y = -1638.56, z = 32.11, robbed = false, info = 'Strawberry Avenue 2/Apt3'},
  [248] = {x = -105.34, y = -1632.48, z = 32.91, robbed = false, info = 'Strawberry Avenue 2/Apt4'},
  [249] = {x = -108.73, y = -1629.04, z = 32.91, robbed = false, info = 'Strawberry Avenue 2/Apt5'},
  [250] = {x = -96.87, y = -1613.02, z = 32.32, robbed = false, info = 'Strawberry Avenue 2/Apt6'},
  [251] = {x = -92.45, y = -1608.14, z = 32.32, robbed = false, info = 'Strawberry Avenue 2/Apt7'},
  [252] = {x = -88.5, y = -1602.39, z = 32.32, robbed = false, info = 'Strawberry Avenue 2/Apt8'},
  [253] = {x = -81.05, y = -1608.75, z = 31.49, robbed = false, info = 'Strawberry Avenue 2/Apt9'},
  [254] = {x = -84.11, y = -1622.43, z = 34.69, robbed = false, info = 'Strawberry Avenue 2/Apt10'},
  [255] = {x = -90.11, y = -1629.4, z = 34.69, robbed = false, info = 'Strawberry Avenue 2/Apt11'},
  [256] = {x = -96.25, y = -1637.41, z = 35.49, robbed = false, info = 'Strawberry Avenue 2/Apt12'},
  [257] = {x = -98.24, y = -1638.72, z = 35.49, robbed = false, info = 'Strawberry Avenue 2/Apt13'},
  [258] = {x = -104.94, y = -1632.23, z = 36.29, robbed = false, info = 'Strawberry Avenue 2/Apt14'},
  [259] = {x = -108.73, y = -1628.99, z = 36.29, robbed = false, info = 'Strawberry Avenue 2/Apt15'},
  [260] = {x = -97.08, y = -1612.9, z = 35.49, robbed = false, info = 'Strawberry Avenue 2/Apt16'},
  [261] = {x = -92.88, y = -1607.79, z = 35.49, robbed = false, info = 'Strawberry Avenue 2/Apt17'},
  [262] = {x = -88.13, y = -1602.14, z = 35.49, robbed = false, info = 'Strawberry Avenue 2/Apt18'},
  [263] = {x = -80.67, y = -1608.63, z = 34.69, robbed = false, info = 'Strawberry Avenue 2/Apt19'},
  [264] = {x = 252.35, y = -1671.55, z = 29.67, robbed = false, info = 'Brouge Avenue 1'},
  [265] = {x = 241.38, y = -1688.28, z = 29.52, robbed = false, info = 'Brouge Avenue 2'},
  [266] = {x = 223.35, y = -1703.33, z = 29.49, robbed = false, info = 'Brouge Avenue 3'},
  [267] = {x = 216.83, y = -1717.15, z = 29.48, robbed = false, info = 'Brouge Avenue 4'},
  [268] = {x = 198.59, y = -1725.5, z = 29.67, robbed = false, info = 'Brouge Avenue 5'},
  [269] = {x = 152.28, y = -1823.45, z = 27.87, robbed = false, info = 'Brouge Avenue 6'},
  [270] = {x = 249.48, y = -1730.38, z = 29.67, robbed = false, info = 'Brouge Avenue 7'},
  [271] = {x = 257.05, y = -1723.09, z = 29.66, robbed = false, info = 'Brouge Avenue 8'},
  [272] = {x = 269.23, y = -1713.34, z = 29.67, robbed = false, info = 'Brouge Avenue 9'},
  [273] = {x = 281.13, y = -1694.16, z = 29.26, robbed = false, info = 'Brouge Avenue 10'},
  [274] = {x = 332.58, y = -1741.63, z = 29.74, robbed = false, info = 'Roy Lowenstein Blvd 1'},
  [275] = {x = 320.66, y = -1759.78, z = 29.64, robbed = false, info = 'Roy Lowenstein Blvd 2'},
  [276] = {x = 305.15, y = -1775.86, z = 29.1, robbed = false, info = 'Roy Lowenstein Blvd 3'},
  [277] = {x = 299.84, y = -1784.04, z = 28.44, robbed = false, info = 'Roy Lowenstein Blvd 4'},
  [278] = {x = 289.25, y = -1791.99, z = 28.09, robbed = false, info = 'Roy Lowenstein Blvd 5'},
  [279] = {x = 179.23, y = -1923.86, z = 21.38, robbed = false, info = 'Roy Lowenstein Blvd 6'},
  [280] = {x = 165.55, y = -1945.18, z = 20.24, robbed = false, info = 'Roy Lowenstein Blvd 7'},
  [281] = {x = 149.99, y = -1961.59, z = 19.08, robbed = false, info = 'Roy Lowenstein Blvd 8'},
  [282] = {x = 144.14, y = -1969.72, z = 18.86, robbed = false, info = 'Roy Lowenstein Blvd 9'},
  [283] = {x = 140.98, y = -1983.14, z = 18.33, robbed = false, info = 'Roy Lowenstein Blvd 10'},
  [284] = {x = 250.07, y = -1934.4, z = 24.51, robbed = false, info = 'Roy Lowenstein Blvd 11'},
  [285] = {x = 257.39, y = -1927.69, z = 25.45, robbed = false, info = 'Roy Lowenstein Blvd 12'},
  [286] = {x = 269.71, y = -1917.57, z = 26.19, robbed = false, info = 'Roy Lowenstein Blvd 13'},
  [287] = {x = 281.88, y = -1898.45, z = 26.88, robbed = false, info = 'Roy Lowenstein Blvd 14'},
  [288] = {x = 319.74, y = -1853.49, z = 27.53, robbed = false, info = 'Roy Lowenstein Blvd 15'},
  [289] = {x = 328.0, y = -1844.52, z = 27.76, robbed = false, info = 'Roy Lowenstein Blvd 16'},
  [290] = {x = 339.22, y = -1829.24, z = 28.34, robbed = false, info = 'Roy Lowenstein Blvd 17'},
  [291] = {x = 348.85, y = -1820.62, z = 28.9, robbed = false, info = 'Roy Lowenstein Blvd 18'},
  [292] = {x = 405.64, y = -1751.29, z = 29.72, robbed = false, info = 'Roy Lowenstein Blvd 19'},
  [293] = {x = 418.53, y = -1735.9, z = 29.61, robbed = false, info = 'Roy Lowenstein Blvd 20'},
  [294] = {x = 430.99, y = -1725.5, z = 29.61, robbed = false, info = 'Roy Lowenstein Blvd 21'},
  [295] = {x = 442.72, y = -1706.93, z = 29.49, robbed = false, info = 'Roy Lowenstein Blvd 22'},
  [296] = {x = 471.16, y = -1561.47, z = 32.8, robbed = false, info = 'Roy Lowenstein Blvd 23/Apt1'},
  [297] = {x = 465.83, y = -1567.54, z = 32.8, robbed = false, info = 'Roy Lowenstein Blvd 23/Apt2'},
  [298] = {x = 461.39, y = -1573.95, z = 32.8, robbed = false, info = 'Roy Lowenstein Blvd 23/Apt3'},
  [299] = {x = 455.53, y = -1579.34, z = 32.8, robbed = false, info = 'Roy Lowenstein Blvd 23/Apt4'},
  [300] = {x = 442.13, y = -1569.43, z = 32.8, robbed = false, info = 'Roy Lowenstein Blvd 23/Apt5'},
  [301] = {x = 436.5, y = -1563.9, z = 32.8, robbed = false, info = 'Roy Lowenstein Blvd 23/Apt6'},
  [302] = {x = 431.15, y = -1558.66, z = 32.8, robbed = false, info = 'Roy Lowenstein Blvd 23/Apt7'},
  [303] = {x = 500.25, y = -1697.49, z = 29.79, robbed = false, info = 'Jamestown Street 1'},
  [304] = {x = 490.6, y = -1714.39, z = 29.5, robbed = false, info = 'Jamestown Street 2'},
  [305] = {x = 479.51, y = -1736.71, z = 29.16, robbed = false, info = 'Jamestown Street 3'},
  [306] = {x = 475.44, y = -1757.74, z = 28.9, robbed = false, info = 'Jamestown Street 4'},
  [307] = {x = 472.88, y = -1775.22, z = 29.07, robbed = false, info = 'Jamestown Street 5'},
  [308] = {x = 440.01, y = -1830.31, z = 28.37, robbed = false, info = 'Jamestown Street 6'},
  [309] = {x = 428.12, y = -1841.33, z = 28.47, robbed = false, info = 'Jamestown Street 7'},
  [310] = {x = 412.58, y = -1856.23, z = 27.33, robbed = false, info = 'Jamestown Street 8'},
  [311] = {x = 399.67, y = -1864.78, z = 26.72, robbed = false, info = 'Jamestown Street 9'},
  [312] = {x = 386.04, y = -1882.27, z = 25.79, robbed = false, info = 'Jamestown Street 10'},
  [313] = {x = 368.05, y = -1896.76, z = 25.18, robbed = false, info = 'Jamestown Street 11'},
  [314] = {x = 324.15, y = -1937.81, z = 25.02, robbed = false, info = 'Jamestown Street 12'},
  [315] = {x = 312.81, y = -1956.66, z = 24.43, robbed = false, info = 'Jamestown Street 13'},
  [316] = {x = 296.54, y = -1972.44, z = 22.7, robbed = false, info = 'Jamestown Street 14'},
  [317] = {x = 291.23, y = -1980.74, z = 21.61, robbed = false, info = 'Jamestown Street 15'},
  [318] = {x = 280.23, y = -1993.25, z = 20.81, robbed = false, info = 'Jamestown Street 16'},
  [319] = {x = 257.12, y = -2023.84, z = 19.27, robbed = false, info = 'Jamestown Street 17'},
  [320] = {x = 251.39, y = -2029.73, z = 18.51, robbed = false, info = 'Jamestown Street 18'},
  [321] = {x = 236.5, y = -2045.73, z = 18.38, robbed = false, info = 'Jamestown Street 19'},
  [322] = {x = 296.87, y = -2097.86, z = 17.67, robbed = false, info = 'Jamestown Street 20/Apt1'},
  [323] = {x = 295.78, y = -2093.31, z = 17.67, robbed = false, info = 'Jamestown Street 20/Apt2'},
  [324] = {x = 293.68, y = -2087.92, z = 17.67, robbed = false, info = 'Jamestown Street 20/Apt3'},
  [325] = {x = 292.59, y = -2086.38, z = 17.67, robbed = false, info = 'Jamestown Street 20/Apt4'},
  [326] = {x = 289.53, y = -2077.1, z = 17.67, robbed = false, info = 'Jamestown Street 20/Apt5'},
  [327] = {x = 288.21, y = -2072.75, z = 17.67, robbed = false, info = 'Jamestown Street 20/Apt6'},
  [328] = {x = 279.29, y = -2043.26, z = 19.77, robbed = false, info = 'Jamestown Street 20/Apt7'},
  [329] = {x = 280.6, y = -2041.64, z = 19.77, robbed = false, info = 'Jamestown Street 20/Apt8'},
  [330] = {x = 286.69, y = -2034.4, z = 19.77, robbed = false, info = 'Jamestown Street 20/Apt9'},
  [331] = {x = 289.76, y = -2030.74, z = 19.77, robbed = false, info = 'Jamestown Street 20/Apt10'},
  [332] = {x = 323.53, y = -1990.66, z = 24.17, robbed = false, info = 'Jamestown Street 20/Apt11'},
  [333] = {x = 324.82, y = -1988.95, z = 24.17, robbed = false, info = 'Jamestown Street 20/Apt12'},
  [334] = {x = 331.63, y = -1982.15, z = 24.17, robbed = false, info = 'Jamestown Street 20/Apt13'},
  [335] = {x = 333.9, y = -1978.33, z = 24.17, robbed = false, info = 'Jamestown Street 20/Apt14'},
  [336] = {x = 362.6, y = -1986.24, z = 24.13, robbed = false, info = 'Jamestown Street 20/Apt15'},
  [337] = {x = 364.17, y = -1986.78, z = 24.14, robbed = false, info = 'Jamestown Street 20/Apt16'},
  [338] = {x = 375.15, y = -1990.66, z = 24.13, robbed = false, info = 'Jamestown Street 20/Apt18'},
  [339] = {x = 384.27, y = -1994.33, z = 24.24, robbed = false, info = 'Jamestown Street 20/Apt19'},
  [340] = {x = 385.74, y = -1995.01, z = 24.24, robbed = false, info = 'Jamestown Street 20/Apt20'},
  [341] = {x = 405.02, y = -2018.35, z = 23.33, robbed = false, info = 'Jamestown Street 20/Apt21'},
  [342] = {x = 402.43, y = -2024.68, z = 23.25, robbed = false, info = 'Jamestown Street 20/Apt22'},
  [343] = {x = 400.7, y = -2028.47, z = 23.25, robbed = false, info = 'Jamestown Street 20/Apt23'},
  [344] = {x = 397.38, y = -2034.67, z = 23.21, robbed = false, info = 'Jamestown Street 20/Apt24'},
  [345] = {x = 396.04, y = -2037.9, z = 23.04, robbed = false, info = 'Jamestown Street 20/Apt25'},
  [346] = {x = 392.7, y = -2044.32, z = 22.93, robbed = false, info = 'Jamestown Street 20/Apt26'},
  [347] = {x = 382.56, y = -2061.38, z = 21.78, robbed = false, info = 'Jamestown Street 20/Apt27'},
  [348] = {x = 378.73, y = -2067.02, z = 21.38, robbed = false, info = 'Jamestown Street 20/Apt28'},
  [349] = {x = 375.83, y = -2069.96, z = 21.55, robbed = false, info = 'Jamestown Street 20/Apt29'},
  [350] = {x = 371.63, y = -2074.86, z = 21.56, robbed = false, info = 'Jamestown Street 20/Apt30'},
  [351] = {x = 368.99, y = -2078.37, z = 21.38, robbed = false, info = 'Jamestown Street 20/Apt31'},
  [352] = {x = 364.48, y = -2083.31, z = 21.57, robbed = false, info = 'Jamestown Street 20/Apt32'},
  [353] = {x = 341.08, y = -2098.49, z = 18.21, robbed = false, info = 'Jamestown Street 20/Apt33'},
  [354] = {x = 333.01, y = -2106.72, z = 18.02, robbed = false, info = 'Jamestown Street 20/Apt34'},
  [355] = {x = 329.57, y = -2108.85, z = 17.91, robbed = false, info = 'Jamestown Street 20/Apt35'},
  [356] = {x = 324.18, y = -2112.44, z = 17.76, robbed = false, info = 'Jamestown Street 20/Apt36'},
  [357] = {x = 306.34, y = -2098.09, z = 17.53, robbed = false, info = 'Jamestown Street 20/Apt37'},
  [358] = {x = 306.07, y = -2086.4, z = 17.61, robbed = false, info = 'Jamestown Street 20/Apt38'},
  [359] = {x = 303.8, y = -2079.71, z = 17.66, robbed = false, info = 'Jamestown Street 20/Apt39'},
  [360] = {x = 302.18, y = -2076.06, z = 17.69, robbed = false, info = 'Jamestown Street 20/Apt40'},
  [361] = {x = 295.03, y = -2067.07, z = 17.66, robbed = false, info = 'Jamestown Street 20/Apt41'},
  [362] = {x = 286.77, y = -2053.13, z = 19.43, robbed = false, info = 'Jamestown Street 20/Apt42'},
  [363] = {x = 291.13, y = -2047.6, z = 19.66, robbed = false, info = 'Jamestown Street 20/Apt43'},
  [364] = {x = 293.65, y = -2044.56, z = 19.64, robbed = false, info = 'Jamestown Street 20/Apt44'},
  [365] = {x = 331.18, y = -2000.79, z = 23.81, robbed = false, info = 'Jamestown Street 20/Apt45'},
  [366] = {x = 335.45, y = -1995.13, z = 24.05, robbed = false, info = 'Jamestown Street 20/Apt46'},
  [367] = {x = 338.11, y = -1992.45, z = 23.61, robbed = false, info = 'Jamestown Street 20/Apt47'},
  [368] = {x = 356.72, y = -1997.29, z = 24.07, robbed = false, info = 'Jamestown Street 20/Apt48'},
  [369] = {x = 363.17, y = -1999.61, z = 24.05, robbed = false, info = 'Jamestown Street 20/Apt49'},
  [370] = {x = 366.89, y = -2000.92, z = 24.24, robbed = false, info = 'Jamestown Street 20/Apt50'},
  [371] = {x = 373.56, y = -2003.08, z = 24.27, robbed = false, info = 'Jamestown Street 20/Apt51'},
  [372] = {x = 376.97, y = -2004.75, z = 24.05, robbed = false, info = 'Jamestown Street 20/Apt52'},
  [373] = {x = 383.31, y = -2007.28, z = 23.88, robbed = false, info = 'Jamestown Street 20/Apt53'},
  [374] = {x = 393.38, y = -2015.4, z = 23.41, robbed = false, info = 'Jamestown Street 20/Apt54'},
  [375] = {x = 391.99, y = -2016.96, z = 23.41, robbed = false, info = 'Jamestown Street 20/Apt55'},
  [376] = {x = 388.18, y = -2025.47, z = 23.41, robbed = false, info = 'Jamestown Street 20/Apt56'},
  [377] = {x = 383.87, y = -2036.12, z = 23.41, robbed = false, info = 'Jamestown Street 20/Apt58'},
  [378] = {x = 382.6, y = -2037.41, z = 23.41, robbed = false, info = 'Jamestown Street 20/Apt59'},
  [379] = {x = 372.04, y = -2055.52, z = 21.75, robbed = false, info = 'Jamestown Street 20/Apt60'},
  [380] = {x = 370.9, y = -2056.9, z = 21.75, robbed = false, info = 'Jamestown Street 20/Apt61'},
  [381] = {x = 364.62, y = -2064.18, z = 21.75, robbed = false, info = 'Jamestown Street 20/Apt62'},
  [382] = {x = 357.72, y = -2073.24, z = 21.75, robbed = false, info = 'Jamestown Street 20/Apt64'},
  [383] = {x = 356.57, y = -2074.62, z = 21.75, robbed = false, info = 'Jamestown Street 20/Apt65'},
  [384] = {x = 334.14, y = -2092.86, z = 18.25, robbed = false, info = 'Jamestown Street 20/Apt66'},
  [385] = {x = 329.88, y = -2094.65, z = 18.25, robbed = false, info = 'Jamestown Street 20/Apt67'},
  [386] = {x = 321.57, y = -2099.85, z = 18.25, robbed = false, info = 'Jamestown Street 20/Apt68'},
  [387] = {x = 319.72, y = -2100.29, z = 18.25, robbed = false, info = 'Jamestown Street 20/Apt69'},
  [388] = {x = 332.15, y = -2070.86, z = 20.95, robbed = false, info = 'Jamestown Street 20/Apt70'},
  [389] = {x = 324.11, y = -2063.77, z = 20.72, robbed = false, info = 'Jamestown Street 20/Apt72'},
  [390] = {x = 321.03, y = -2061.05, z = 20.74, robbed = false, info = 'Jamestown Street 20/Apt73'},
  [391] = {x = 315.26, y = -2056.94, z = 20.72, robbed = false, info = 'Jamestown Street 20/Apt74'},
  [392] = {x = 312.31, y = -2054.58, z = 20.72, robbed = false, info = 'Jamestown Street 20/Apt75'},
  [393] = {x = 305.98, y = -2044.77, z = 20.9, robbed = false, info = 'Jamestown Street 20/Apt76'},
  [394] = {x = 313.74, y = -2040.53, z = 20.94, robbed = false, info = 'Jamestown Street 20/Apt77'},
  [395] = {x = 317.47, y = -2043.3, z = 20.94, robbed = false, info = 'Jamestown Street 20/Apt78'},
  [396] = {x = 324.69, y = -2049.25, z = 20.94, robbed = false, info = 'Jamestown Street 20/Apt79'},
  [397] = {x = 326.2, y = -2050.54, z = 20.94, robbed = false, info = 'Jamestown Street 20/Apt80'},
  [398] = {x = 333.56, y = -2056.94, z = 20.94, robbed = false, info = 'Jamestown Street 20/Apt81'},
  [399] = {x = 334.57, y = -2058.3, z = 20.94, robbed = false, info = 'Jamestown Street 20/Apt82'},
  [400] = {x = 341.86, y = -2064.11, z = 20.95, robbed = false, info = 'Jamestown Street 20/Apt83'},
  [401] = {x = 345.23, y = -2067.37, z = 20.94, robbed = false, info = 'Jamestown Street 20/Apt84'},
  [402] = {x = 363.43, y = -2046.13, z = 22.2, robbed = false, info = 'Jamestown Street 20/Apt85'},
  [403] = {x = 359.88, y = -2043.38, z = 22.2, robbed = false, info = 'Jamestown Street 20/Apt86'},
  [404] = {x = 352.51, y = -2037.24, z = 22.09, robbed = false, info = 'Jamestown Street 20/Apt87'},
  [405] = {x = 352.15, y = -2034.96, z = 22.36, robbed = false, info = 'Jamestown Street 20/Apt88'},
  [406] = {x = 344.83, y = -2028.81, z = 22.36, robbed = false, info = 'Jamestown Street 20/Apt89'},
  [407] = {x = 343.63, y = -2027.94, z = 22.36, robbed = false, info = 'Jamestown Street 20/Apt90'},
  [408] = {x = 336.17, y = -2021.61, z = 22.36, robbed = false, info = 'Jamestown Street 20/Apt91'},
  [409] = {x = 331.93, y = -2019.28, z = 22.35, robbed = false, info = 'Jamestown Street 20/Apt92'},
  [410] = {x = 335.78, y = -2010.93, z = 22.32, robbed = false, info = 'Jamestown Street 20/Apt93'},
  [411] = {x = 345.65, y = -2014.72, z = 22.4, robbed = false, info = 'Jamestown Street 20/Apt94'},
  [412] = {x = 354.15, y = -2021.71, z = 22.31, robbed = false, info = 'Jamestown Street 20/Apt96'},
  [413] = {x = 357.26, y = -2024.55, z = 22.3, robbed = false, info = 'Jamestown Street 20/Apt97'},
  [414] = {x = 362.71, y = -2028.26, z = 22.25, robbed = false, info = 'Jamestown Street 20/Apt98'},
  [415] = {x = 365.22, y = -2031.53, z = 22.4, robbed = false, info = 'Jamestown Street 20/Apt99'},
  [416] = {x = 371.47, y = -2040.7, z = 22.2, robbed = false, info = 'Jamestown Street 20/Apt100'},
  [417] = {x = -903.43, y = -1005.12, z = 2.16, robbed = false, info = 'Coopenmartha Court 1'},
  [418] = {x = -902.68, y = -997.07, z = 2.16, robbed = false, info = 'Coopenmartha Court 2'},
  [419] = {x = -900.17, y = -981.97, z = 2.17, robbed = false, info = 'Coopenmartha Court 3'},
  [420] = {x = -913.66, y = -989.39, z = 2.16, robbed = false, info = 'Coopenmartha Court 4'},
  [421] = {x = -908.07, y = -976.76, z = 2.16, robbed = false, info = 'Coopenmartha Court 5'},
  [422] = {x = -922.48, y = -983.07, z = 2.16, robbed = false, info = 'Coopenmartha Court 6'},
  [423] = {x = -927.84, y = -973.27, z = 2.16, robbed = false, info = 'Coopenmartha Court 6'},
  [424] = {x = -927.7, y = -949.4, z = 2.75, robbed = false, info = 'Coopenmartha Court 8'},
  [425] = {x = -934.92, y = -938.93, z = 2.15, robbed = false, info = 'Coopenmartha Court 9'},
  [426] = {x = -947.13, y = -927.75, z = 2.15, robbed = false, info = 'Coopenmartha Court 10'},
  [427] = {x = -947.68, y = -910.11, z = 2.35, robbed = false, info = 'Coopenmartha Court 11'},
  [428] = {x = -950.41, y = -905.28, z = 2.35, robbed = false, info = 'Coopenmartha Court 12'},
  [429] = {x = -986.43, y = -866.38, z = 2.2, robbed = false, info = 'Coopenmartha Court 13'},
  [430] = {x = -996.44, y = -875.87, z = 2.16, robbed = false, info = 'Coopenmartha Court 14'},
  [431] = {x = -1011.47, y = -880.83, z = 2.16, robbed = false, info = 'Coopenmartha Court 15'},
  [432] = {x = -1005.53, y = -897.67, z = 2.55, robbed = false, info = 'Coopenmartha Court 16'},
  [433] = {x = -975.57, y = -909.16, z = 2.16, robbed = false, info = 'Coopenmartha Court 17'},
  [434] = {x = -1010.99, y = -909.64, z = 2.14, robbed = false, info = 'Coopenmartha Court 18'},
  [435] = {x = -1022.89, y = -896.58, z = 5.42, robbed = false, info = 'Coopenmartha Court 19'},
  [436] = {x = -1031.35, y = -903.04, z = 3.7, robbed = false, info = 'Coopenmartha Court 20'},
  [437] = {x = -1027.9, y = -919.72, z = 5.05, robbed = false, info = 'Coopenmartha Court 21'},
  [438] = {x = -1024.41, y = -912.11, z = 6.97, robbed = false, info = 'Coopenmartha Court 22'},
  [439] = {x = -1043.03, y = -924.86, z = 3.16, robbed = false, info = 'Coopenmartha Court 23'},
  [440] = {x = -1053.82, y = -933.09, z = 3.36, robbed = false, info = 'Coopenmartha Court 24'},
  [441] = {x = -1090.89, y = -926.24, z = 3.14, robbed = false, info = 'Coopenmartha Court 25'},
  [442] = {x = -1085.1, y = -934.97, z = 3.09, robbed = false, info = 'Coopenmartha Court 26'},
  [443] = {x = -1075.69, y = -939.49, z = 2.36, robbed = false, info = 'Coopenmartha Court 27'},
  [444] = {x = -1084.41, y = -951.81, z = 2.37, robbed = false, info = 'Coopenmartha Court 28'},
  [445] = {x = -989.35, y = -975.21, z = 4.23, robbed = false, info = 'Imagination Court 1'},
  [446] = {x = -994.98, y = -966.47, z = 2.55, robbed = false, info = 'Imagination Court 2'},
  [447] = {x = -978.21, y = -990.68, z = 4.55, robbed = false, info = 'Imagination Court 3'},
  [448] = {x = -1019.04, y = -963.69, z = 2.16, robbed = false, info = 'Imagination Court 4'},
  [449] = {x = -1028.21, y = -968.02, z = 2.16, robbed = false, info = 'Imagination Court 5'},
  [450] = {x = -1032.18, y = -982.48, z = 2.16, robbed = false, info = 'Imagination Court 6'},
  [451] = {x = -1056.67, y = -1001.26, z = 2.16, robbed = false, info = 'Imagination Court 7'},
  [452] = {x = -1054.81, y = -1000.95, z = 6.42, robbed = false, info = 'Imagination Court 8'},
  [453] = {x = -1055.75, y = -998.78, z = 6.42, robbed = false, info = 'Imagination Court 9'},
  [454] = {x = -1042.39, y = -1024.61, z = 2.16, robbed = false, info = 'Imagination Court 10'},
  [455] = {x = -1022.48, y = -1022.42, z = 2.16, robbed = false, info = 'Imagination Court 11'},
  [456] = {x = -1008.47, y = -1015.29, z = 2.16, robbed = false, info = 'Imagination Court 12'},
  [457] = {x = -997.35, y = -1012.6, z = 2.16, robbed = false, info = 'Imagination Court 13'},
  [458] = {x = -967.46, y = -1008.5, z = 2.16, robbed = false, info = 'Imagination Court 14'},
  [459] = {x = -942.71, y = -1076.35, z = 2.54, robbed = false, info = 'Invention Court 1'},
  [460] = {x = -951.94, y = -1078.52, z = 2.16, robbed = false, info = 'Invention Court 2'},
  [461] = {x = -982.64, y = -1066.94, z = 2.55, robbed = false, info = 'Invention Court 3'},
  [462] = {x = -977.79, y = -1091.85, z = 4.23, robbed = false, info = 'Invention Court 4'},
  [463] = {x = -982.64, y = -1083.86, z = 2.55, robbed = false, info = 'Invention Court 5'},
  [464] = {x = -991.11, y = -1103.85, z = 2.16, robbed = false, info = 'Invention Court 6'},
  [465] = {x = -986.66, y = -1122.15, z = 4.55, robbed = false, info = 'Invention Court 7'},
  [466] = {x = -976.25, y = -1140.3, z = 2.18, robbed = false, info = 'Invention Court 8'},
  [467] = {x = -978.06, y = -1108.25, z = 2.16, robbed = false, info = 'Invention Court 9'},
  [468] = {x = -960.05, y = -1109.07, z = 2.16, robbed = false, info = 'Invention Court 11'},
  [469] = {x = -963.15, y = -1110.02, z = 2.18, robbed = false, info = 'Invention Court 10'},
  [470] = {x = -948.72, y = -1107.7, z = 2.18, robbed = false, info = 'Invention Court 12'},
  [471] = {x = -939.32, y = -1088.27, z = 2.16, robbed = false, info = 'Invention Court 13'},
  [472] = {x = -931.12, y = -1100.18, z = 2.18, robbed = false, info = 'Invention Court 14'},
  [473] = {x = -921.36, y = -1095.44, z = 2.16, robbed = false, info = 'Invention Court 15'},
  [474] = {x = -1176.2, y = -1072.88, z = 5.91, robbed = false, info = 'Imagination Court 15'},
  [475] = {x = -1180.93, y = -1056.36, z = 2.16, robbed = false, info = 'Imagination Court 16'},
  [476] = {x = -1183.71, y = -1044.88, z = 2.16, robbed = false, info = 'Imagination Court 17'},
  [477] = {x = -1188.65, y = -1041.64, z = 2.3, robbed = false, info = 'Imagination Court 18'},
  [478] = {x = -1198.67, y = -1023.73, z = 2.16, robbed = false, info = 'Imagination Court 19'},
  [479] = {x = -1203.28, y = -1021.27, z = 5.96, robbed = false, info = 'Imagination Court 20'},
  [480] = {x = -1098.74, y = -1679.17, z = 4.37, robbed = false, info = 'Beachside Avenue 1'},
  [481] = {x = -1097.58, y = -1673.07, z = 8.4, robbed = false, info = 'Beachside Avenue 2'},
  [482] = {x = -1349.59, y = -1187.7, z = 4.57, robbed = false, info = 'Beachside Avenue 3'},
  [483] = {x = -1347.14, y = -1167.87, z = 4.58, robbed = false, info = 'Beachside Avenue 4'},
  [484] = {x = -1350.20, y = -1161.41, z = 4.51, robbed = false, info = 'Beachside Avenue 5'},
  [485] = {x = -1347.23, y = -1145.91, z = 4.34, robbed = false, info = 'Beachside Avenue 6'},
  [486] = {x = -1336.27, y = -1145.51, z = 6.74, robbed = false, info = 'Beachside Avenue 7'},
  [487] = {x = -1374.53, y = -1074.28, z = 4.32, robbed = false, info = 'Beachside Avenue 8'},
  [488] = {x = -1376.91, y = -1070.31, z = 4.35, robbed = false, info = 'Beachside Avenue 9'},
  [489] = {x = -1379.84, y = -1066.37, z = 4.35, robbed = false, info = 'Beachside Avenue 10'},
  [490] = {x = -1381.87, y = -1062.06, z = 4.35, robbed = false, info = 'Beachside Avenue 11'},
  [491] = {x = -1384.78, y = -1058.38, z = 4.36, robbed = false, info = 'Beachside Avenue 12'},
  [492] = {x = -1386.93, y = -1054.22, z = 4.34, robbed = false, info = 'Beachside Avenue 13'},
  [493] = {x = -1370.18, y = -1042.84, z = 4.26, robbed = false, info = 'Beachside Avenue 14'},
  [494] = {x = -1366.28, y = -1039.9, z = 4.26, robbed = false, info = 'Beachside Avenue 15'},
  [495] = {x = -1362.4, y = -1037.3, z = 4.25, robbed = false, info = 'Beachside Avenue 16'},
  [496] = {x = -1358.3, y = -1035.08, z = 4.24, robbed = false, info = 'Beachside Avenue 17'},
  [497] = {x = -1754.06, y = -725.21, z = 10.29, robbed = false, info = 'Beachside Avenue 18'},
  [498] = {x = -1754.74, y = -708.34, z = 10.4, robbed = false, info = 'Beachside Avenue 19'},
  [499] = {x = -1764.34, y = -708.4, z = 10.62, robbed = false, info = 'Beachside Avenue 20'},
  [500] = {x = -1777.02, y = -701.53, z = 10.53, robbed = false, info = 'Beachside Avenue 21'},
  [501] = {x = -1770.67, y = -677.27, z = 10.38, robbed = false, info = 'Beachside Avenue 22'},
  [502] = {x = -1765.69, y = -681.05, z = 10.29, robbed = false, info = 'Beachside Avenue 23'},
  [503] = {x = -1791.69, y = -683.89, z = 10.65, robbed = false, info = 'Beachside Avenue 24'},
  [504] = {x = -1793.69, y = -663.88, z = 10.6, robbed = false, info = 'Beachside Avenue 25'},
  [505] = {x = -1803.64, y = -662.45, z = 10.73, robbed = false, info = 'Beachside Avenue 26'},
  [506] = {x = -1813.82, y = -657.05, z = 10.89, robbed = false, info = 'Beachside Avenue 27'},
  [507] = {x = -1819.73, y = -650.15, z = 10.98, robbed = false, info = 'Beachside Avenue 28'},
  [508] = {x = -1834.74, y = -642.54, z = 11.48, robbed = false, info = 'Beachside Avenue 29'},
  [509] = {x = -1836.49, y = -631.61, z = 10.76, robbed = false, info = 'Beachside Avenue 30'},
  [510] = {x = -1838.56, y = -629.2, z = 11.25, robbed = false, info = 'Beachside Avenue 31'},
  [511] = {x = -1872.51, y = -604.06, z = 11.89, robbed = false, info = 'Beachside Avenue 32'},
  [512] = {x = -1874.66, y = -593.01, z = 11.89, robbed = false, info = 'Beachside Avenue 33'},
  [513] = {x = -1883.28, y = -578.94, z = 11.82, robbed = false, info = 'Beachside Avenue 34'},
  [514] = {x = -1901.72, y = -586.55, z = 11.88, robbed = false, info = 'Beachside Avenue 35'},
  [515] = {x = -1913.45, y = -574.22, z = 11.44, robbed = false, info = 'Beachside Avenue 36'},
  [516] = {x = -1917.79, y = -558.82, z = 11.85, robbed = false, info = 'Beachside Avenue 37'},
  [517] = {x = -1924.05, y = -559.33, z = 12.07, robbed = false, info = 'Beachside Avenue 38'},
  [518] = {x = -1918.64, y = -542.55, z = 11.83, robbed = false, info = 'Beachside Avenue 39'},
  [519] = {x = -1947.03, y = -544.07, z = 11.87, robbed = false, info = 'Beachside Avenue 40'},
  [520] = {x = -1947.95, y = -531.65, z = 11.83, robbed = false, info = 'Beachside Avenue 41'},
  [521] = {x = -1968.27, y = -532.39, z = 12.18, robbed = false, info = 'Beachside Avenue 42'},
  [522] = {x = -1968.36, y = -523.33, z = 11.85, robbed = false, info = 'Beachside Avenue 43'},
  [523] = {x = -1980.0, y = -520.54, z = 11.9, robbed = false, info = 'Beachside Avenue 44'},
  [524] = {x = -1070.57, y = -1653.81, z = 4.41, robbed = false, info = 'Beachside Court 1'},
  [525] = {x = -1076.09, y = -1645.79, z = 4.51, robbed = false, info = 'Beachside Court 2'},
  [526] = {x = -1082.93, y = -1631.47, z = 4.74, robbed = false, info = 'Beachside Court 3'},
  [527] = {x = -1088.77, y = -1623.08, z = 4.74, robbed = false, info = 'Beachside Court 4'},
  [528] = {x = -1092.39, y = -1607.42, z = 8.47, robbed = false, info = 'Beachside Court 5'},
  [529] = {x = -1106.29, y = -1596.34, z = 4.6, robbed = false, info = 'Beachside Court 6'},
  [530] = {x = -1038.86, y = -1609.53, z = 5.0, robbed = false, info = 'Beachside Court 7'},
  [531] = {x = -1029.29, y = -1603.62, z = 4.97, robbed = false, info = 'Beachside Court 8'},
  [532] = {x = -1032.69, y = -1582.77, z = 5.14, robbed = false, info = 'Beachside Court 9'},
  [533] = {x = -1043.47, y = -1580.43, z = 5.04, robbed = false, info = 'Beachside Court 10'},
  [534] = {x = -1041.27, y = -1591.25, z = 4.99, robbed = false, info = 'Beachside Court 11'},
  [535] = {x = -1057.06, y = -1587.44, z = 4.61, robbed = false, info = 'Beachside Court 12'},
  [536] = {x = -1058.16, y = -1540.21, z = 5.05, robbed = false, info = 'Beachside Court 16'},
  [537] = {x = 35.27, y = 6662.8, z = 32.2, robbed = false, info = 'Procopio Drive 1'},
  [538] = {x = -9.75, y = 6654.15, z = 31.7, robbed = false, info = 'Procopio Drive 2'},
  [539] = {x = -41.3, y = 6636.99, z = 31.09, robbed = false, info = 'Procopio Drive 3'},
  [540] = {x = -130.1, y = 6551.49, z = 29.53, robbed = false, info = 'Procopio Drive 4'},
  [541] = {x = -229.77, y = 6445.18, z = 31.2, robbed = false, info = 'Procopio Drive 5'},
  [542] = {x = -238.37, y = 6423.4, z = 31.46, robbed = false, info = 'Procopio Drive 6'},
  [543] = {x = -272.14, y = 6400.61, z = 31.51, robbed = false, info = 'Procopio Drive 7'},
  [544] = {x = -359.51, y = 6334.64, z = 29.85, robbed = false, info = 'Procopio Drive 8'},
  [545] = {x = -407.22, y = 6314.12, z = 28.95, robbed = false, info = 'Procopio Drive 9'},
  [546] = {x = -447.9, y = 6271.69, z = 33.34, robbed = false, info = 'Procopio Drive 10'},
  [547] = {x = -467.97, y = 6206.18, z = 29.56, robbed = false, info = 'Procopio Drive 11'},
  [548] = {x = -379.73, y = 6253.05, z = 31.86, robbed = false, info = 'Procopio Drive 12'},
  [549] = {x = -370.91, y = 6267.2, z = 31.88, robbed = false, info = 'Procopio Drive 13'},
  [550] = {x = -302.07, y = 6327.4, z = 32.89, robbed = false, info = 'Procopio Drive 14'},
  [551] = {x = -280.62, y = 6350.84, z = 32.61, robbed = false, info = 'Procopio Drive 15'},
  [552] = {x = -247.88, y = 6369.98, z = 31.85, robbed = false, info = 'Procopio Drive 16'},
  [553] = {x = -227.7, y = 6377.93, z = 31.76, robbed = false, info = 'Procopio Drive 17'},
  [554] = {x = -213.86, y = 6396.5, z = 33.09, robbed = false, info = 'Procopio Drive 18'},
  [555] = {x = -189.07, y = 6409.72, z = 32.3, robbed = false, info = 'Procopio Drive 19'},
  [556] = {x = -167.23, y = 6439.25, z = 31.92, robbed = false, info = 'Procopio Drive 20 / Apt 1'},
  [557] = {x = -160.3, y = 6432.18, z = 31.92, robbed = false, info = 'Procopio Drive 20 / Apt 2'},
  [558] = {x = -150.38, y = 6422.38, z = 31.92, robbed = false, info = 'Procopio Drive 20 / Apt 3'},
  [559] = {x = -150.38, y = 6416.99, z = 31.92, robbed = false, info = 'Procopio Drive 20 / Apt 4'},
  [560] = {x = -157.31, y = 6409.99, z = 31.92, robbed = false, info = 'Procopio Drive 20 / Apt 5'},
  [561] = {x = -105.49, y = 6528.7, z = 30.17, robbed = false, info = 'Procopio Drive 21'},
  [562] = {x = -44.43, y = 6582.55, z = 32.18, robbed = false, info = 'Procopio Drive 22'},
  [563] = {x = -27.44, y = 6597.89, z = 31.87, robbed = false, info = 'Procopio Drive 23'},
  [564] = {x = 1.36, y = 6613.18, z = 31.89, robbed = false, info = 'Procopio Drive 24'},
  [565] = {x = 31.22, y = 6596.67, z = 32.83, robbed = false, info = 'Paleto Blvd 1'},
  [566] = {x = 11.5, y = 6578.22, z = 33.08, robbed = false, info = 'Paleto Blvd 2'},
  [567] = {x = -14.72, y = 6557.54, z = 33.25, robbed = false, info = 'Paleto Blvd 3'},
  [568] = {x = -374.77, y = 6190.77, z = 31.73, robbed = false, info = 'Paleto Blvd 5'},
}

local robbableItems = {
  [1] = {x = 1.90339700, y = -3.80026800, z = 1.29917900, name = "Fridge", isSearched = false},
  [2] = {x = -3.50363200, y = -6.55289400, z = 1.30625800, name = "Drawers", isSearched = false},
  [3] = {x = -3.50712600, y = -4.13621600, z = 1.29625800, name = "Table", isSearched = false},
  [4] = {x = 8.47819500, y = -2.50979300, z = 1.19712300, name = "Storage", isSearched = false},
  [5] = {x = 9.75982700, y = -1.35874100, z = 1.29625800, name = "Storage", isSearched = false},
  [6] = {x = 8.46626300, y = 4.53223600, z = 1.19425800, name = "Wardrobe", isSearched = false},
  [7] = {x = 5.84416200, y = 2.57377400, z = 1.22089100, name = "Table", isSearched = false},
  [8] = {x = 3.04164100, y = 0.31671810, z = 3.58363900, name = "Jewelry", isSearched = false},
  [9] = {x = 6.86376900, y = 1.20651200, z = 1.36589100, name = "Under Bed", isSearched = false},
  [10] = {x = 2.03442400, y = -5.61585100, z = 3.30395600, name = "Cupboards", isSearched = false},
  [11] = {x = -5.53120400, y = 0.76299670, z = 1.77236000, name = "Cabinet", isSearched = false},
  [12] = {x = -1.24716200, y = 1.07820500, z = 1.69089300, name = "Coffee Table", isSearched = false},
  [13] = {x = 2.91325400, y = -4.2783510, z = 1.82746400, name = "Table", isSearched = false},
}

local PlayerData = {}
local pedSpawned = false

local safeLockpick = false

RegisterNetEvent('houseRobberies:reset')
AddEventHandler('houseRobberies:reset', function()
  safeLockpick = false
end)

RegisterNetEvent('houseRobberies:attempt')
AddEventHandler('houseRobberies:attempt', function()
if isRobbing and DoesEntityExist(safe) then
  if exports["srp-inventory"]:hasEnoughOfItem('lockpick',1,false) then
    local playerCoords = GetEntityCoords(PlayerPedId(), true)
    if GetDistanceBetweenCoords(playerCoords, safepos.x, safepos.y, safepos.z, true) <= 3.0 then
      if safeLockpick == false then
        safeLockpick = true
        TriggerEvent("safecracking:houseRobbery")
      else
        TriggerEvent('DoLongHudText', 'This safe has already been robbed!', 2)
      end

      if math.random(1,100) > 50 then
        ClearPedTasks(PlayerPedId())
      end
    end
    end
  end

  if exports["srp-inventory"]:hasEnoughOfItem('lockpick',1,false) then 
      if isNight() and  not isRobbing then
    local playerCoords = GetEntityCoords(PlayerPedId(), true)
    for id,v in pairs(robbableHouses) do
      if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 1 then
        if robbableHouses[id]['robbed'] == false then
        TriggerEvent("lockpickAnimation")
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)
        TriggerEvent('HouseRobbery:build', id)
        Wait(1500)
        ClearPedTasks(PlayerPedId())
        elseif robbableHouses[id]['robbed'] == true then
          TriggerEvent('DoLongHudText', 'You have already robbed this house', 2)
          return
        end
        local finished = exports["srp-lockpicking"]:lockpick(100,5,2,10)
	      if finished == 100 then 
	      	isLockpicking = false
          safeLockpick = false
          pedSpawned = false
          robbableHouses[id]['robbed'] = true
          if math.random(1,100) == 5 then
            TriggerEvent('police:houseRobbery')
          end
          TriggerEvent('houseRobberies:createHouse', id)
	      elseif finished ~= 100 then
          TriggerEvent('inventory:removeItem',"lockpick", 1)
          TriggerEvent('houseRobberies:faildelete', id)
          isLockpicking = false
          ClearPedTasks(PlayerPedId())
	      end
      end
    end
  elseif not isRobbing and not exports["srp-inventory"]:hasEnoughOfItem('lockpick',1,false) then
    TriggerEvent('DoLongHudText', 'No Lockpick', 2)
  elseif not isNight() and not isRobbing then
  
  else
   -- TriggerEvent('DoLongHudText', 'House isnt robbable!', 2)
  end
end
end)

RegisterNetEvent('houseRobberies:createHouse')
AddEventHandler('houseRobberies:createHouse', function(id)
 local house = robbableHouses[id]

 myRobbableItems = robbableItems

 for i=1,#myRobbableItems do
  myRobbableItems[i]['isSearched'] = false
 end

 DoScreenFadeOut(100)
 Citizen.Wait(100)

 buildBasicHouse({x = house.x, y = house.y, z = house.z-50})
 Citizen.Wait(3000)

 randomAI({x = house.x, y = house.y, z = house.z-50})

 curHouseCoords = {x = house.x, y = house.y, z = house.z-50}
 disturbance = 0
 isAgro = false


  if math.random(3, 10) < 2 then
    TriggerEvent('houseRobberies:createDog')
  end


  DoScreenFadeIn(100)
  Citizen.Wait(100)

  isRobbing = true

 while isRobbing do
  Citizen.Wait(5)
  local playerCoords = GetEntityCoords(PlayerPedId(), true)

  if GetDistanceBetweenCoords(playerCoords, house.x+3.6, house.y-15, house.z-50, true) < 2.5 then
    TriggerEvent('srp-ui:ShowUI', 'show', ("[E] %s"):format("Leave House"))
    if IsControlJustPressed(0, 38) then
      TriggerEvent('srp-ui:HideUI')
      TriggerEvent('houseRobberies:deleteHouse', id)
    end
  else
    TriggerEvent('srp-ui:HideUI')
  end
 end
end)


RegisterNetEvent('houseRobberies:deleteHouse')
AddEventHandler('houseRobberies:deleteHouse', function(id)
  local house = robbableHouses[id]

  myRobbableItems = robbableItems
  DoScreenFadeOut(100)
  Citizen.Wait(100)

  FreezeEntityPosition(PlayerPedId(), true)
  DeleteSpawnedHouse(id)

  Citizen.Wait(1000)

  SetEntityCoords(PlayerPedId(), house.x, house.y, house.z)
  FreezeEntityPosition(PlayerPedId(), false)

  Citizen.Wait(500)

  DoScreenFadeIn(100)
  Citizen.Wait(100)

  TriggerEvent("robbery:guiclose")
  disturbance = 0
  isRobbing = false
  isPolice = false
end)

function isNight()
  local hour = GetClockHours()
  if hour > 19 or hour < 5 then
    return true
  end
end

function randomAI(generator)
  local modelhash = GetHashKey("a_m_m_beach_02")
  RequestModel(modelhash)

  while not HasModelLoaded(modelhash) do
    Citizen.Wait(0)
  end

  local airoll = math.random(5)
  if airoll == 1 then
    robberyped = CreatePed(GetPedType(modelhash), modelhash, generator.x+6.86376900,generator.y+1.20651200,generator.z+1.36589100, 15.0, 1, 1)
    SetEntityCoords(robberyped, generator.x+6.86376900, generator.y+1.20651200, generator.z+1.36589100)
    SetEntityHeading(robberyped, 80.0)
    SetEntityAsMissionEntity(robberyped, false, true)
    loadAnimDict("dead")
    TaskPlayAnim(robberyped, "dead", 'dead_a', 100.0, 1.0, -1, 1, 0, 0, 0, 0)
    pedSpawned = true
  elseif airoll == 2 then
    robberyped = CreatePed(GetPedType(modelhash), modelhash, generator.x+6.86376900,generator.y+1.20651200,generator.z+1.36589100, 15.0, 1, 1)
    SetEntityCoords(robberyped, generator.x-1.48765600, generator.y+1.68100600, generator.z+1.21640500)
    SetEntityHeading(robberyped, 190.0)
    SetEntityAsMissionEntity(robberyped, false, true)
    loadAnimDict("dead")
    TaskPlayAnim(robberyped, "dead", 'dead_b', 100.0, 1.0, -1, 1, 0, 0, 0, 0)
    pedSpawned = true
  end
end




















Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  local generator = {x = curHouseCoords["x"], y = curHouseCoords["y"], z = curHouseCoords["z"]}

  if isRobbing then
   for i=1,#myRobbableItems do
      if (GetDistanceBetweenCoords(generator.x + myRobbableItems[i]["x"], generator.y + myRobbableItems[i]["y"], generator.z + myRobbableItems[i]["z"], GetEntityCoords(GetPlayerPed(-1))) < 1.4) and not myRobbableItems[i]['isSearched'] then
        if not isPolice then
          DrawText3Ds(generator.x + myRobbableItems[i]["x"], generator.y + myRobbableItems[i]["y"], generator.z + myRobbableItems[i]["z"], '[G] - Search ' .. myRobbableItems[i]["name"])

          if IsControlJustReleased(1, 47) then
            myRobbableItems[i]['isSearched'] = true
            local distance, pedcount = closestNPC()
            local distadd = 0.1
            if pedcount > 0 then
              distadd = distadd + (pedcount / 100)
              local distancealter = (8.0 - distance) / 100
              distadd = distadd + distancealter
            end

            distadd = distadd * 100
            disturbance = disturbance + distadd
            if math.random(100) > 95 then
              disturbance = disturbance + 10
            end
            local finished = exports["srp-taskbar"]:taskBar(15000, "Searching "..myRobbableItems[i]['name'])
            if finished == 100 then
              TriggerServerEvent('houseRobberies:searchItem')
            end
          end
        end
      end
 	    end

    if IsPedShooting(PlayerPedId()) then
      disturbance = 90
      if not isAgro then
      agroNPC()
      end
    end

   TriggerEvent("robbery:guiupdate", math.ceil(disturbance))

   if disturbance > 85 then
    if not calledin then
     local num = 150 - disturbance
     num = math.random(math.ceil(num))
     local fuckup = math.ceil(num)

     if fuckup == 2 and GetEntitySpeed(GetPlayerPed(-1)) > 0.8 then
      calledin = true
      if not isAgro then
       agroNPC()
        if not isPolice then
          TriggerEvent('srp-dispatch:houserobbery')
        end
      end
     end
    end
   end

   if GetEntitySpeed(GetPlayerPed(-1)) > 1.4 then
    local distance, pedcount = closestNPC()
    local alteredsound = 0.1
    if pedcount > 0 then
     alteredsound = alteredsound + (pedcount / 100)
     local distancealter = (8.0 - distance) / 100
     alteredsound = alteredsound + distancealter
    end

    disturbance = disturbance + alteredsound
    if GetEntitySpeed(GetPlayerPed(-1)) > 2.0 then
     disturbance = disturbance + alteredsound
    end

    if GetEntitySpeed(GetPlayerPed(-1)) > 3.0 then
     disturbance = disturbance + alteredsound
    end
   else
    disturbance = disturbance - 0.01
    if disturbance < 0 then
     disturbance = 0
    end
   end
  end
 end
end)








































function buildBasicHouse(generator)
 RequestModel(GetHashKey("clrp_house_1"))
 while not HasModelLoaded(GetHashKey("clrp_house_1")) do
    RequestModel(GetHashKey("clrp_house_1"))
    Citizen.Trace("Loading Model")
    Citizen.Wait(100)
 end

 SetEntityCoords(PlayerPedId(), 347.04724121094, -1000.2844848633, -99.194671630859)
 FreezeEntityPosition(PlayerPedId(), true)
 Citizen.Wait(4500)

 local building = CreateObject(GetHashKey("clrp_house_1"), generator.x, generator.y-0.05, generator.z+1.26253700-89.825, false, false, false)
 FreezeEntityPosition(building, true)

 Citizen.Wait(100)
 SetEntityCoords(PlayerPedId(), generator.x+3.6, generator.y-14.8, generator.z+2.9)
 SetEntityHeading(PlayerPedId(), 358.106)

 local dt = CreateObject(GetHashKey("V_16_DT"), generator.x-1.21854400, generator.y-1.04389600, generator.z+1.39068600, false, false, false)
 local mpmid01 = CreateObject(GetHashKey("V_16_mpmidapart01"), generator.x+0.52447510, generator.y-5.04953700, generator.z+1.32, false, false, false)
 local mpmid09 = CreateObject(GetHashKey("V_16_mpmidapart09"), generator.x+0.82202150, generator.y+2.29612000, generator.z+1.88, false, false, false)
 local mpmid07 = CreateObject(GetHashKey("V_16_mpmidapart07"), generator.x-1.91445900, generator.y-6.61911300, generator.z+1.45, false, false, false)
 local mpmid03 = CreateObject(GetHashKey("V_16_mpmidapart03"), generator.x-4.82565300, generator.y-6.86803900, generator.z+1.14, false, false, false)
 local midData = CreateObject(GetHashKey("V_16_midapartdeta"), generator.x+2.28558400, generator.y-1.94082100, generator.z+1.32, false, false, false)
 local glow = CreateObject(GetHashKey("V_16_treeglow"), generator.x-1.37408500, generator.y-0.95420070, generator.z+1.135, false, false, false)
 local curtins = CreateObject(GetHashKey("V_16_midapt_curts"), generator.x-1.96423300, generator.y-0.95958710, generator.z+1.280, false, false, false)
 local mpmid13 = CreateObject(GetHashKey("V_16_mpmidapart13"), generator.x-4.65580700, generator.y-6.61684000, generator.z+1.259, false, false, false)
 local mpcab = CreateObject(GetHashKey("V_16_midapt_cabinet"), generator.x-1.16177400, generator.y-0.97333810, generator.z+1.27, false, false, false)
 local mpdecal = CreateObject(GetHashKey("V_16_midapt_deca"), generator.x+2.311386000, generator.y-2.05385900, generator.z+1.297, false, false, false)
 local mpdelta = CreateObject(GetHashKey("V_16_mid_hall_mesh_delta"), generator.x+3.69693000, generator.y-5.80020100, generator.z+1.293, false, false, false)
 local beddelta = CreateObject(GetHashKey("V_16_mid_bed_delta"), generator.x+7.95187400, generator.y+1.04246500, generator.z+1.28402300, false, false, false)
 local bed = CreateObject(GetHashKey("V_16_mid_bed_bed"), generator.x+6.86376900, generator.y+1.20651200, generator.z+1.33589100, false, false, false)
 local beddecal = CreateObject(GetHashKey("V_16_MID_bed_over_decal"), generator.x+7.82861300, generator.y+1.04696700, generator.z+1.34753700, false, false, false)
 local bathDelta = CreateObject(GetHashKey("V_16_mid_bath_mesh_delta"), generator.x+4.45460500, generator.y+3.21322800, generator.z+1.21116100, false, false, false)
 local bathmirror = CreateObject(GetHashKey("V_16_mid_bath_mesh_mirror"), generator.x+3.57740800, generator.y+3.25032000, generator.z+1.48871300, false, false, false)

	--props
 local beerbot = CreateObject(GetHashKey("Prop_CS_Beer_Bot_01"), generator.x+1.73134600, generator.y-4.88520200, generator.z+1.91083000, false, false, false)
 local couch = CreateObject(GetHashKey("v_res_mp_sofa"), generator.x-1.48765600, generator.y+1.68100600, generator.z+1.33640500, false, false, false)
 local chair = CreateObject(GetHashKey("v_res_mp_stripchair"), generator.x-4.44770800, generator.y-1.78048800, generator.z+1.21640500, false, false, false)
 local chair2 = CreateObject(GetHashKey("v_res_tre_chair"), generator.x+2.91325400, generator.y-5.27835100, generator.z+1.22746400, false, false, false)
 local plant = CreateObject(GetHashKey("Prop_Plant_Int_04a"), generator.x+2.78941300, generator.y-4.39133900, generator.z+2.12746400, false, false, false)
 local lamp = CreateObject(GetHashKey("v_res_d_lampa"), generator.x-3.61473100, generator.y-6.61465100, generator.z+2.09373700, false, false, false)
 local fridge = CreateObject(GetHashKey("v_res_fridgemodsml"), generator.x+1.90339700, generator.y-3.80026800, generator.z+1.29917900, false, false, false)
 local micro = CreateObject(GetHashKey("prop_micro_01"), generator.x+2.03442400, generator.y-4.64585100, generator.z+2.28995600, false, false, false)
 local sideBoard = CreateObject(GetHashKey("V_Res_Tre_SideBoard"), generator.x+2.84053000, generator.y-4.30947100, generator.z+1.24577300, false, false, false)
 local bedSide = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"), generator.x-3.50363200, generator.y-6.55289400, generator.z+1.30625800, false, false, false)
 local lamp2 = CreateObject(GetHashKey("v_res_d_lampa"), generator.x+2.69674700, generator.y-3.83123500, generator.z+2.09373700, false, false, false)
 local plant2 = CreateObject(GetHashKey("v_res_tre_tree"), generator.x-4.96064800, generator.y-6.09898500, generator.z+1.31631400, false, false, false)
 local table = CreateObject(GetHashKey("V_Res_M_DineTble_replace"), generator.x-3.50712600, generator.y-4.13621600, generator.z+1.29625800, false, false, false)
 local tv = CreateObject(GetHashKey("Prop_TV_Flat_01"), generator.x-5.53120400, generator.y+0.76299670, generator.z+2.17236000, false, false, false)
 local plant3 = CreateObject(GetHashKey("v_res_tre_plant"), generator.x-5.14112800, generator.y-2.78951000, generator.z+1.25950800, false, false, false)
 local chair3 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-3.04652400, generator.y-4.95971200, generator.z+1.19625800, false, false, false)
 local lampStand = CreateObject(GetHashKey("v_res_m_lampstand"), generator.x+1.26588400, generator.y+3.68883900, generator.z+1.35556700, false, false, false)
 local stool = CreateObject(GetHashKey("V_Res_M_Stool_REPLACED"), generator.x-3.23216300, generator.y+2.06159000, generator.z+1.20556700, false, false, false)
 local chair4 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-2.82237200, generator.y-3.59831300, generator.z+1.25950800, false, false, false)
 local chair5 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-4.14955100, generator.y-4.71316600, generator.z+1.19625800, false, false, false)
 local chair6 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-3.80622900, generator.y-3.37648300, generator.z+1.19625800, false, false, false)
 local plant4 = CreateObject(GetHashKey("v_res_fa_plant01"), generator.x+2.97859200, generator.y+2.55307400, generator.z+1.85796300, false, false, false)
 local storage = CreateObject(GetHashKey("v_res_tre_storageunit"), generator.x+8.47819500, generator.y-2.50979300, generator.z+1.19712300, false, false, false)
 local storage2 = CreateObject(GetHashKey("v_res_tre_storagebox"), generator.x+9.75982700, generator.y-1.35874100, generator.z+1.29625800, false, false, false)
 local basketmess = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x+8.70730600, generator.y-2.55503600, generator.z+1.94059590, false, false, false)
 local lampStand2 = CreateObject(GetHashKey("v_res_m_lampstand"), generator.x+9.54306000, generator.y-2.50427700, generator.z+1.30556700, false, false, false)
 local plant4 = CreateObject(GetHashKey("Prop_Plant_Int_03a"), generator.x+9.87521400, generator.y+3.90917400, generator.z+1.20829700, false, false, false)
 local basket = CreateObject(GetHashKey("v_res_tre_washbasket"), generator.x+9.39091500, generator.y+4.49676300, generator.z+1.19625800, false, false, false)
 local wardrobe = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"), generator.x+8.46626300, generator.y+4.53223600, generator.z+1.19425800, false, false, false)
 local basket2 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+8.51593000, generator.y+4.55647300, generator.z+3.46737300, false, false, false)
 local basket3 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x+7.57797200, generator.y+4.55198800, generator.z+3.46737300, false, false, false)
 local basket4 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+7.12286400, generator.y+4.54689200, generator.z+3.46737300, false, false, false)
 local wardrobe2 = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"), generator.x+7.24382000, generator.y+4.53423500, generator.z+1.19625800, false, false, false)
 local basket5 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+8.03364600, generator.y+4.54835500, generator.z+3.46737300, false, false, false)
 local switch = CreateObject(GetHashKey("v_serv_switch_2"), generator.x+6.28086900, generator.y-0.68169880, generator.z+2.30326000, false, false, false)
 local table2 = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"), generator.x+5.84416200, generator.y+2.57377400, generator.z+1.22089100, false, false, false)
 local lamp3 = CreateObject(GetHashKey("v_res_d_lampa"), generator.x+5.84912100, generator.y+2.58001100, generator.z+1.95311890, false, false, false)
 --local laundry = CreateObject(GetHashKey("v_res_mlaundry"), generator.x+5.77729800, generator.y+4.60211400, generator.z+1.19674400, false, false, false)
 local ashtray = CreateObject(GetHashKey("Prop_ashtray_01"), generator.x-1.24716200, generator.y+1.07820500, generator.z+1.87089300, false, false, false)
 local candle1 = CreateObject(GetHashKey("v_res_fa_candle03"), generator.x-2.89289900, generator.y-4.35329700, generator.z+2.02881310, false, false, false)
 local candle2 = CreateObject(GetHashKey("v_res_fa_candle02"), generator.x-3.99865700, generator.y-4.06048500, generator.z+2.02530190, false, false, false)
 local candle3 = CreateObject(GetHashKey("v_res_fa_candle01"), generator.x-3.37733400, generator.y-3.66639800, generator.z+2.02526200, false, false, false)
 local woodbowl = CreateObject(GetHashKey("v_res_m_woodbowl"), generator.x-3.50787400, generator.y-4.11983000, generator.z+2.02589900, false, false, false)
 local tablod = CreateObject(GetHashKey("V_Res_TabloidsA"), generator.x-0.80513000, generator.y+0.51389600, generator.z+1.18418800, false, false, false)
 local tapeplayer = CreateObject(GetHashKey("Prop_Tapeplayer_01"), generator.x-1.26010100, generator.y-3.62966400, generator.z+2.37883200, false, false, false)
 local woodbowl2 = CreateObject(GetHashKey("v_res_tre_fruitbowl"), generator.x+2.77764900, generator.y-4.138297000, generator.z+2.10340100, false, false, false)
 local sculpt = CreateObject(GetHashKey("v_res_sculpt_dec"), generator.x+3.03932200, generator.y+1.62726400, generator.z+3.58363900, false, false, false)
 local jewlry = CreateObject(GetHashKey("v_res_jewelbox"), generator.x+3.04164100, generator.y+0.31671810, generator.z+3.58363900, false, false, false)
 local basket6 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x-1.64906300, generator.y+1.62675900, generator.z+1.39038500, false, false, false)
 local basket7 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x-1.63938900, generator.y+0.91133310, generator.z+1.39038500, false, false, false)
 local basket8 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x-1.19923400, generator.y+1.69598600, generator.z+1.39038500, false, false, false)
 local basket9 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x-1.18293800, generator.y+0.91436380, generator.z+1.39038500, false, false, false)
 local bowl = CreateObject(GetHashKey("v_res_r_sugarbowl"), generator.x-0.26029210, generator.y-6.66716800, generator.z+3.77324900, false, false, false)
 local breadbin = CreateObject(GetHashKey("Prop_Breadbin_01"), generator.x+2.09788500, generator.y-6.57634000, generator.z+2.24041900, false, false, false)
 local knifeblock = CreateObject(GetHashKey("v_res_mknifeblock"), generator.x+1.82084700, generator.y-6.58438500, generator.z+2.27399500, false, false, false)
 local toaster = CreateObject(GetHashKey("prop_toaster_01"), generator.x-1.05790700, generator.y-6.59017400, generator.z+2.26793200, false, false, false)
 local wok = CreateObject(GetHashKey("prop_wok"), generator.x+2.01728800, generator.y-5.57091500, generator.z+2.31793200, false, false, false)
 local plant5 = CreateObject(GetHashKey("Prop_Plant_Int_03a"), generator.x+2.55015600, generator.y+4.60183900, generator.z+1.20829700, false, false, false)
 local tumbler = CreateObject(GetHashKey("p_tumbler_cs2_s"), generator.x-0.90916440, generator.y-4.24099100, generator.z+2.24693200, false, false, false)
 local wisky = CreateObject(GetHashKey("p_whiskey_bottle_s"), generator.x-0.92809300, generator.y-3.99099100, generator.z+2.24693200, false, false, false)
 local tissue = CreateObject(GetHashKey("v_res_tissues"), generator.x+7.95889300, generator.y-2.54847100, generator.z+1.94013400, false, false, false)
 local pants = CreateObject(GetHashKey("V_16_Ap_Mid_Pants4"), generator.x+7.55366500, generator.y-0.25457100, generator.z+1.33009200, false, false, false)
 local pants2 = CreateObject(GetHashKey("V_16_Ap_Mid_Pants5"), generator.x+7.76753200, generator.y+3.00476500, generator.z+1.33052800, false, false, false)
 local hairdryer = CreateObject(GetHashKey("v_club_vuhairdryer"), generator.x+8.12616000, generator.y-2.50562000, generator.z+1.96009390, false, false, false)

 FreezeEntityPosition(dt,true)
 FreezeEntityPosition(mpmid01,true)
 FreezeEntityPosition(mpmid09,true)
 FreezeEntityPosition(mpmid07,true)
 FreezeEntityPosition(mpmid03,true)
 FreezeEntityPosition(midData,true)
 FreezeEntityPosition(glow,true)
 FreezeEntityPosition(curtins,true)
 FreezeEntityPosition(mpmid13,true)
 FreezeEntityPosition(mpcab,true)
 FreezeEntityPosition(mpdecal,true)
 FreezeEntityPosition(mpdelta,true)
 FreezeEntityPosition(couch,true)
 FreezeEntityPosition(chair,true)
 FreezeEntityPosition(chair2,true)
 FreezeEntityPosition(plant,true)
 FreezeEntityPosition(lamp,true)
 FreezeEntityPosition(fridge,true)
 FreezeEntityPosition(micro,true)
 FreezeEntityPosition(sideBoard,true)
 FreezeEntityPosition(bedSide,true)
 FreezeEntityPosition(plant2,true)
 FreezeEntityPosition(table,true)
 FreezeEntityPosition(tv,true)
 FreezeEntityPosition(plant3,true)
 FreezeEntityPosition(chair3,true)
 FreezeEntityPosition(lampStand,true)
 FreezeEntityPosition(chair4,true)
 FreezeEntityPosition(chair5,true)
 FreezeEntityPosition(chair6,true)
 FreezeEntityPosition(plant4,true)
 FreezeEntityPosition(storage2,true)
 FreezeEntityPosition(basket,true)
 FreezeEntityPosition(wardrobe,true)
 FreezeEntityPosition(wardrobe2,true)
 FreezeEntityPosition(table2,true)
 FreezeEntityPosition(lamp3,true)
 -- FreezeEntityPosition(laundry,true)
 FreezeEntityPosition(beddelta,true)
 FreezeEntityPosition(bed,true)
 FreezeEntityPosition(beddecal,true)
 FreezeEntityPosition(tapeplayer,true)
 FreezeEntityPosition(basket7,true)
 FreezeEntityPosition(basket6,true)
 FreezeEntityPosition(basket8,true)
 FreezeEntityPosition(basket9,true)

 if math.random(1, 100) >= 50 then
  CreateSafe(generator.x+6.2,generator.y+4.52972300,generator.z+1.32609800)
 end

 SetEntityHeading(beerbot,GetEntityHeading(beerbot)+90)
 SetEntityHeading(couch,GetEntityHeading(couch)-90)
 SetEntityHeading(chair,GetEntityHeading(chair)+getRotation(0.28045480))
 SetEntityHeading(chair2,GetEntityHeading(chair2)+getRotation(0.3276100))
 SetEntityHeading(fridge,GetEntityHeading(chair2)+160)
 SetEntityHeading(micro,GetEntityHeading(micro)-90)
 SetEntityHeading(sideBoard,GetEntityHeading(sideBoard)+90)
 SetEntityHeading(bedSide,GetEntityHeading(bedSide)+180)
 SetEntityHeading(tv,GetEntityHeading(tv)+90)
 SetEntityHeading(plant3,GetEntityHeading(plant3)+90)
 SetEntityHeading(chair3,GetEntityHeading(chair3)+200)
 SetEntityHeading(chair4,GetEntityHeading(chair3)+100)
 SetEntityHeading(chair5,GetEntityHeading(chair5)+135)
 SetEntityHeading(chair6,GetEntityHeading(chair6)+10)
 SetEntityHeading(storage,GetEntityHeading(storage)+180)
 SetEntityHeading(storage2,GetEntityHeading(storage2)-90)
 SetEntityHeading(table2,GetEntityHeading(table2)+90)
 SetEntityHeading(tapeplayer,GetEntityHeading(tapeplayer)+90)
 SetEntityHeading(knifeblock,GetEntityHeading(knifeblock)+180)
 FreezeEntityPosition(PlayerPedId(),false)
end

function DeleteSpawnedHouse(id)
 local housePosition = robbableHouses[id]
 local handle, ObjectFound = FindFirstObject()
 local success
 repeat
  local pos = GetEntityCoords(ObjectFound)
  local distance = GetDistanceBetweenCoords(housePosition["x"], housePosition["y"], (housePosition["z"] - 24.0), pos, true)
  if distance < 35.0 and ObjectFound ~= PlayerPedId() then
   if IsEntityAPed(ObjectFound) then
    if not IsPedAPlayer(ObjectFound) then
     DeleteObject(ObjectFound)
    end
   else
    DeleteObject(ObjectFound)
   end
  end
  success, ObjectFound = FindNextObject(handle)
 until not success
 EndFindObject(handle)
end


function getRotation(input)
	return 360/(10*input)
end

AddEventHandler('lockpickAnimation', function()
 isLockpicking = true
 loadAnimDict('veh@break_in@0h@p_m_one@')
 while isLockpicking do
  if not IsEntityPlayingAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3) then
   TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
   Citizen.Wait(1500)
   ClearPedTasks(PlayerPedId())
  end
  Citizen.Wait(1)
 end
 ClearPedTasks(PlayerPedId())
end)

function loadAnimDict(dict)
 RequestAnimDict(dict)
 while not HasAnimDictLoaded(dict) do
  Citizen.Wait(5)
 end
end


function showMessage(msg)
 BeginTextCommandDisplayHelp("STRING")
 AddTextComponentScaleform(msg)
 EndTextCommandDisplayHelp(0, false, false, -1)
end

function DrawText3Ds(x,y,z, text)
 local onScreen,_x,_y=World3dToScreen2d(x,y,z)
 local px,py,pz=table.unpack(GetGameplayCamCoords())
 SetTextScale(0.35, 0.35)
 SetTextFont(4)
 SetTextProportional(1)
 SetTextColour(255, 255, 255, 215)
 SetTextEntry("STRING")
 SetTextCentre(1)
 AddTextComponentString(text)
 DrawText(_x,_y)
 local factor = (string.len(text)) / 370
 DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function closestNPC()
 local playerCoords = GetEntityCoords(GetPlayerPed(-1))
 local handle, ped = FindFirstPed()
 local success
 local rped = nil
 local distanceFrom = 999.0
 local pedcount = 0
 repeat
  local pos = GetEntityCoords(ped)
  local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
  if distance < 25.0 and ped ~= GetPlayerPed(-1) and not IsPedAPlayer(ped) then
   pedcount = pedcount + 1
   if (distance < distanceFrom) then
    distanceFrom = distance
    rped = ped
   end
  end
 success, ped = FindNextPed(handle)
 until not success
  EndFindPed(handle)
 return distanceFrom, pedcount
end



local attackDog = nil
local wpns = {
	[1] = "WEAPON_Knife",
	[2] = "WEAPON_HAMMER",
	[3] = "WEAPON_Bat",
	[4] = "WEAPON_Bottle",
	[5] = "WEAPON_Flashlight",
	[6] = "WEAPON_Poolcue"
}

function agroNPC()
 local playerCoords = GetEntityCoords(GetPlayerPed(-1))
 local handle, ped = FindFirstPed()
 local success
 local rped = nil
 local distanceFrom = 999.0
 local pedcount = 0
 repeat
  local pos = GetEntityCoords(ped)
  local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
  if distance < 35.0 and ped ~= GetPlayerPed(-1) and not IsPedAPlayer(ped) then
   ClearPedTasksImmediately(ped)
   SetPedDropsWeaponsWhenDead(ped,false)
   GiveWeaponToPed(ped, GetHashKey(wpns[math.random(6)]), 150, 0, 1)
   TaskCombatPed(ped, GetPlayerPed(-1), 0, 16)
   SetPedKeepTask(ped, true)
   isAgro = true
  end
  success, ped = FindNextPed(handle)
 until not success
 EndFindPed(handle)
end



AddEventHandler('houseRobberies:createDog', function()
 if not DoesEntityExist(attackDog) then
  local model = GetHashKey("A_C_Rottweiler")

  RequestModel(model)
  while not HasModelLoaded(model) do
   RequestModel(model)
   Citizen.Wait(100)
  end
  if not isPolice then
    TriggerEvent('srp-dispatch:houserobbery')
    attackDog = CreatePed(GetPedType(model), model, curHouseCoords.x+3.70339700, curHouseCoords.y+-3.80026800, curHouseCoords.z+2.29917900, 90, 1, 0)
    Citizen.Wait(1500)
    TaskCombatPed(attackDog, GetPlayerPed(-1), 0, 16)
    SetPedKeepTask(attackDog, true)
    Citizen.Wait(45000)
    SetEntityAsNoLongerNeeded(attackDog)
    attackDog = 0
  end
 end
end)


function CreateSafe(x,y,z)
	safespawned = true
	safepos = {["x"] = x, ["y"] = y, ["z"] = z}

	RequestModel(GetHashKey("prop_ld_int_safe_01"))
	while not HasModelLoaded(GetHashKey("prop_ld_int_safe_01")) do
   Citizen.Wait(100)
	end

	safe = CreateObject(GetHashKey("prop_ld_int_safe_01"), x, y, z,true, false, false)
	FreezeEntityPosition(safe,true)
end

RegisterNetEvent('safe:houserobbery')
AddEventHandler('safe:houserobbery', function()
  DeleteEntity(safe)
  DeleteObject(safe)
  SetEntityAsNoLongerNeeded(safe)
  safepos = {["x"] = 0, ["y"] = 0, ["z"] = 0}
 TriggerServerEvent('houseRobberies:giveMoney')
end)

RegisterCommand('breach', function(source)
  local job = exports["isPed"]:isPed("myjob")
  local playerCoords = GetEntityCoords(PlayerPedId(), true)
  if job == "police" then
    for id, v in pairs(robbableHouses) do
      if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then
        TriggerEvent('HouseRobbery:build', id)
        TriggerEvent("doAnim","kickindoor")
        local finished = exports["srp-taskbar"]:taskBar(2000,"Breaching the house")
        if (finished == 100) then
          TriggerEvent('houseRobberies:createHouse', id)
          isPolice = true
        end
      end
    end
  end
end)
