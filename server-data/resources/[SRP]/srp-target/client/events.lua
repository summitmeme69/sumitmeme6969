Citizen.CreateThread(
    function()
        -------- Police --------

        AddBoxZone("duty_police", vector3(441.87, -981.92, 30.69), 0.9, 0.5, {
            name="duty_police",
            heading=0,
            --debugPoly=true,
            minZ=30.49,
            maxZ=31.24
        }, {
            options = {
                {
                    event = "Police:duty",
                    icon = "far fa-clipboard",
                    label = "Sign On/Off Duty"
                },
            },
            job = {"all"},
            distance = 1.5
        })

        AddBoxZone("duty_police2", vector3(361.42, -1598.41, 29.29), 2.2, 1, {
            name="duty_police2",
            heading=320,
            --debugPoly=true,
            minZ=28.29,
            maxZ=29.89
        }, {
            options = {
                {
                    event = "Police:duty",
                    icon = "far fa-clipboard",
                    label = "Sign On/Off Duty"
                },
            },
            job = {"all"},
            distance = 1.5
        })

        AddBoxZone("lspd_evidence",vector3(475.78, -993.94, 26.27), 0.8, 2, {
            name="lspd_evidence",
            heading=90,
            --debugPoly=true,
            minZ=25.27,
            maxZ=27.62
        }, {
            options = {
                {
                    event = "evidence:general",
                    icon = "fas fa-trash",
                    label = "Trash Locker (Clears On Tsunami)"
                },
            },
            job = {"police"},
            distance = 1.5
        })


        AddBoxZone("lspd_armory", vector3(483.47, -994.7, 30.69), 7.2, 1, {
            name="lspd_armory",
            heading=90,
            --debugPoly=true,
            minZ=29.49,
            maxZ=32.49
        }, {
            options = {
                {
                    event = "police:general",
                    icon = "fas fa-clipboard",
                    label = "PD Armory"
                },
            },
            job = {"police"},
            distance = 2.5
        })

        AddBoxZone("lspd_armory2", vector3(369.36, -1598.7, 29.29), 2.6, 1, {
            name="lspd_armory2",
            heading=50,
            --debugPoly=true,
            minZ=29.09,
            maxZ=30.49
        }, {
            options = {
                {
                    event = "police:general",
                    icon = "fas fa-clipboard",
                    label = "Davis Armory     "
                },
                {
                    event = "evidence:general",
                    icon = "fas fa-trash",
                    label = "Trash Locker"
                },
                {
                    event = "serial:search",
                    icon = "fas fa-hand-holding",
                    label = "Search Weapon Serial"
                },
            },
            job = {"police"},
            distance = 2.5
        })


        AddBoxZone("serial_search", vector3(485.5, -989.33, 30.69), 0.5, 0.5, {
            name="serial_search",
            heading=290,
            --debugPoly=true,
            minZ=30.69,
            maxZ=31.29
        }, {
            options = {
                {
                    event = "serial:search",
                    icon = "fas fa-hand-holding",
                    label = "Search Weapon Serial"
                },
            },
            job = {"police"},
            distance = 1.5
        })

        local doors = {
            "bonnet"
        }

        AddTargetVehicle(doors,
            {
                options = {
                    {
                        event = "police:forceEnter",
                        icon = "fas fa-sign-in-alt",
                        label = "Seat Player!"
                    },
                    {
                        event = "unseatPlayer",
                        icon = "fas fa-sign-out-alt",
                        label = "Unseat Player!"
                    },
                    {
                        event = "keys:give",
                        icon = "fas fa-key",
                        label = "Give The Car Key!"
                    },
                    {
                        event = "FlipVehicle",
                        icon = "fas fa-undo",
                        label = "Flip the Vehicle!"
                    },
                    {
                        event = "clean:cleanvehicle",
                        icon = "fas fa-hand-sparkles",
                        label = "Clean the car!"
                    },
                    {
                        event = "veh:requestUpdate",
                        icon = "fas fa-wrench",
                        label = "Examine Internals!"
                    },
                    {
                        event = "impoundVeh",
                        icon = "fas fa-truck",
                        label = "Impound Vehicle!"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )


        local Payphones = {
            1158960338,
            -78626473,
           1281992692,
           -1058868155,
           -429560270,
           -2103798695,
            295857659,
           -1559354806
        }

        AddTargetModel(Payphones,
            {
                options = {
                    {
                        event = "payphone:ui",
                        icon = "fas fa-phone-square-alt",
                        label = "Make a call! (Anonymous)"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        
        -------- EMS --------

        AddCircleZone(
            "emsdutys",
            vector3(310.22, -597.56, 43.28),
            0.2,
            {
                name = "emsdutys",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "emsduty",
                        icon = "far fa-clipboard",
                        label = "Sign On/Off Duty"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )

        AddCircleZone(
            "pillbox",
            vector3(306.54, -602.32, 43.53),
            1.11,
            {
                name = "pillbox",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "ems:general",
                        icon = "fas fa-shopping-basket",
                        label = "Use"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )

        -------- Check In --------

        AddCircleZone(
            "checkin",
            vector3(307.53, -595.28, 43.08),
            0.33,
            {
                name = "checkin",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "srp-hospitalization:checkin",
                        icon = "far fa-clipboard",
                        label = "Check In"
                    }
                },
                job = {"all"},
                distance = 2.5
            }
        )

        -------- ATMS --------

        local atms = {
            -1126237515,
            506770882,
            -870868698,
            150237004,
            -239124254,
            -1364697528,
            506770882
        }
        AddTargetModel(
            atms,
            {
                options = {
                    {
                        event = "bank:checkATM",
                        icon = "fas fa-credit-card",
                        label = "Use ATM"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )

        -------- Vending Machines --------

        local food = {
            -654402915,
            -1034034125
        }
        local coffee = {
            690372739,
            -1318035530,
            -2015792788
        }
        local water = {
            1099892058
        }
        local soda = {
            1114264700,
            -504687826,
            992069095,
            -1741437518,
            -1317235795
        }
        AddTargetModel(
            food,
            {
                options = {
                    {
                        event = "shops:food",
                        icon = "fas fa-cookie-bite",
                        label = "Buy your self a nice snack!"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddTargetModel(
            coffee,
            {
                options = {
                    {
                        event = "shops:coffee",
                        icon = "fas fa-mug-hot",
                        label = "Make a nice cup of Coffee!"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddTargetModel(
            water,
            {
                options = {
                    {
                        event = "shops:water",
                        icon = "fas fa-tint",
                        label = "Drink a Refreshing Bottle Of Water!"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddTargetModel(
            soda,
            {
                options = {
                    {
                        event = "shops:soda",
                        icon = "fas fa-wine-bottle",
                        label = "Drink a Refreshing Can of Soda!"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )

        --------  General Stores --------
        AddCircleZone(
            "Store1",
            vector3(25.08, -1347.41, 29.5),
            0.55,
            {
                name = "Store1",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store1s",
            vector3(25.11, -1345.0, 29.5),
            0.55,
            {
                name = "Store1s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store2",
            vector3(-706.7, -915.54, 19.22),
            0.55,
            {
                name = "Store2",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store2s",
            vector3(-706.68, -913.55, 19.22),
            0.55,
            {
                name = "Store2s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store3",
            vector3(-1222.31, -907.74, 12.33),
            0.55,
            {
                name = "Store3",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store4",
            vector3(-47.22, -1757.5, 29.42),
            0.55,
            {
                name = "Store4",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store4s",
            vector3(-48.42, -1759.02, 29.42),
            0.55,
            {
                name = "Store4s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store5",
            vector3(1134.9, -982.46, 46.42),
            0.55,
            {
                name = "Store5",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Use"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store6",
            vector3(1164.08, -322.73, 69.21),
            0.55,
            {
                name = "Store6",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store6s",
            vector3(1164.49, -324.74, 69.21),
            0.55,
            {
                name = "Store6s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store7",
            vector3(373.12, 326.21, 103.57),
            0.55,
            {
                name = "Store7",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store7s",
            vector3(373.62, 328.58, 103.57),
            0.55,
            {
                name = "Store7s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store8",
            vector3(-1820.68, 793.82, 138.14),
            0.55,
            {
                name = "Store8",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store8s",
            vector3(-1819.29, 792.38, 138.14),
            0.55,
            {
                name = "Store8s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store9",
            vector3(-2967.1, 390.97, 15.04),
            0.55,
            {
                name = "Store9",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store10",
            vector3(-3039.1, 585.11, 7.91),
            0.55,
            {
                name = "Store10",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store10s",
            vector3(-3041.36, 584.35, 7.91),
            0.55,
            {
                name = "Store10s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store11",
            vector3(-3242.17, 1000.57, 12.83),
            0.55,
            {
                name = "Store11",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store11s",
            vector3(-3244.56, 1000.69, 12.83),
            0.55,
            {
                name = "Store11s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )

        AddCircleZone(
            "Store12",
            vector3(2557.28, 381.38, 108.62),
            0.55,
            {
                name = "Store12",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store12s",
            vector3(2554.88, 381.49, 108.62),
            0.55,
            {
                name = "Store12s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store13",
            vector3(548.46, 2671.31, 42.16),
            0.55,
            {
                name = "Store13",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store13s",
            vector3(548.81, 2668.96, 42.16),
            0.55,
            {
                name = "Store13s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store14",
            vector3(1165.89, 2710.13, 38.16),
            0.55,
            {
                name = "Store14",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store15",
            vector3(1393.04, 3605.85, 34.98),
            0.55,
            {
                name = "Store15",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store16",
            vector3(1960.62, 3740.19, 32.34),
            0.55,
            {
                name = "Store16",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store16s",
            vector3(1959.34, 3742.35, 32.34),
            0.55,
            {
                name = "Store16s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store17",
            vector3(1696.83, 4924.53, 42.06),
            0.55,
            {
                name = "Store17",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store17s",
            vector3(1698.46, 4923.44, 42.06),
            0.55,
            {
                name = "Store17s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store18",
            vector3(1728.38, 6414.87, 35.04),
            0.55,
            {
                name = "Store18",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "Store18s",
            vector3(1729.47, 6417.11, 35.04),
            0.55,
            {
                name = "Store18s",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "shop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Goods"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )

        -------- Mega Mall --------

        local megamall = {
            [1] = -1453933154
        }

        AddTargetModel(
            megamall,
            {
                options = {
                    {
                        event = "toolshop:general",
                        icon = "fas fa-shopping-basket",
                        label = "Purchase Tools"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )

        -------- Burger Shot --------

        AddBoxZone("burger_tray_1", vector3(-1195.29, -892.31, 14.0), 1.05, 1, {
            name="burger_tray_1",
            heading=35,
            --debugPoly=true,
            minZ=13.8,
            maxZ=14.3
        }, {
            options = {
                {
                    event = "open:tray",
                    parms = "burger_shot_tray_1",
                    icon = "fas fa-hand-holding",
                    label = "Take the Items",
                },
            },
            job = {"all"},
            distance = 1.5
        })
        
        AddBoxZone("burger_tray_2", vector3(-1193.87, -894.38, 14.0), 0.5, 0.7, {
            name="burger_tray_2",
            heading=318,
            --debugPoly=true,
            minZ=14.0,
            maxZ=14.4
        }, {
            options = {
                {
                    event = "open:tray",
                    parms = "burger_shot_tray_2",
                    icon = "fas fa-hand-holding",
                    label = "Take the Items",
                },
            },
            job = {"all"},
            distance = 1.5
        })
            

        AddBoxZone("burger_tray_3", vector3(-1193.88, -906.98, 14.0), 1, 1, {
            name="burger_tray_3",
            heading=350,
            --debugPoly=true,
            minZ=13.2,
            maxZ=14.2
        }, {
            options = {
                {
                    event = "burgershot:get:receipt",
                    parms = "4",
                    icon = "fas fa-cash-register",
                    label = "Make Payment",
                },
                {
                    event = "open:tray",
                    parms = "burger_shot_tray_3",
                    icon = "fas fa-hand-holding",
                    label = "Take the Items",
                },
            },
            job = {"all"},
            distance = 3.5
        })

        AddBoxZone("burgershotcooker2 ", vector3(-1202.94, -897.38, 14.0), 1.7, 1, {
            name="burgershotcooker2 ",
            heading=34,
            --debugPoly=true,
            minZ=13.0,
            maxZ=14.3
        }, {
            options = {
                {
                    event = "srp-burgershot:startprocess3",
                    icon = "fas fa-hamburger",
                    label = "Cook Burger",
                },
             },
             job = {"burger_shot"},
            distance = 2.5
        })

        AddBoxZone("burgershotcooker", vector3(-1200.54, -900.92, 14.0), 1.8, 1.0, {
            name="burgershotcooker",
            heading=34,
            --debugPoly=true,
            minZ=13.0,
            maxZ=14.4
        }, {
            options = {
                {
                    event = "srp-burgershot:startprocess3",
                    icon = "fas fa-hamburger",
                    label = "Cook Burger",
                },
             },
             job = {"burger_shot"},
            distance = 2.5
        })
    
        AddBoxZone("burgershotfryer", vector3(-1202.01, -899.27, 14.0), 2.5, 1.5, {
            name="burgershotfryer",
            heading=35,
            --debugPoly=true,
            minZ=13.0,
            maxZ=14.4
        }, {
            options = {
                {
                    event = "srp-burgershot:startfryer",
                    icon = "fas fa-utensils",
                    label = "Make Fries",
                },
             },
             job = {"burger_shot"},
            distance = 2.5
        })
            
        AddBoxZone("burgershotself", vector3(-1199.54, -895.52, 14.0), 2.2, 0.6, {
            name="burgershotself",
            heading=34,
            --debugPoly=true,
            minZ=13.8,
            maxZ=14.8
        }, {
            options = {
                {
                    event = "srp-burgershot:makeshake",
                    icon = "fas fa-hand-holding",
                    label = "Make a Nice Cold Mike Shake",

                },
                {
                    event = "srp-burgershot:getcola",
                    icon = "fas fa-hand-holding",
                    label = "Make a Cup of Coca Cola",
                },
             },
             job = {"burger_shot"},
            distance = 2.5
        })

        AddBoxZone("burgershotself2", vector3(-1189.08, -905.28, 14.0), 1.15, 0.7, {
            name="burgershotself2",
            heading=33,
            --debugPoly=true,
            minZ=13.8,
            maxZ=14.8
        }, {
            options = {
                {
                    event = "srp-burgershot:makeshake",
                    icon = "fas fa-hand-holding",
                    label = "Make a Nice Cold Mike Shake",

                },
                {
                    event = "srp-burgershot:getcola",
                    icon = "fas fa-hand-holding",
                    label = "Make a Cup of Coca Cola",
                },
             },
             job = {"burger_shot"},
            distance = 2.5
        })
    
        AddBoxZone("burgerfridge", vector3(-1203.71, -895.86, 14.0), 1.6, 1, {
            name="burgerfridge",
            heading=35,
            --debugPoly=true,
            minZ=13.0,
            maxZ=15.6
        }, {
            options = {
                {
                    event = "open:storage",
                    parms = "burger_shot",
                    icon = "fas fa-search",
                    label = "Open Fridge",
                    
                },
                {
                    event = "burgershot:order",
                    icon = "fas fa-laptop",
                    label = "Order Ingredients!",
                },
             },
             job = {"burger_shot"},
            distance = 2.5
        })

        AddBoxZone("burgershotdisplay", vector3(-1197.78, -894.45, 14.0), 4.6, 1.2, {
            name="burgershotdisplay",
            heading=34,
            --debugPoly=true,
            minZ=13.0,
            maxZ=14.8
        }, {
            options = {
                {
                    event = "open:storage",
                    parms = "burger_shot_front",
                    icon = "fas fa-hand-holding",
                    label = "Put the Food on the Rack!",

                },
             },
             job = {"burger_shot"},
            distance = 2.5
        })
    
    
        AddBoxZone("craftburger", vector3(-1197.57, -899.41, 14.0), 1.8, 0.7, {
            name="craftburger",
            heading=304,
            --debugPoly=true,
            minZ=13.0,
            maxZ=14.4
        }, {
            options = {
                {
                    event = "burgershot:craft",
                    icon = "fas fa-hamburger",
                    label = "Make Burger",
                },
             },
             job = {"burger_shot"},
            distance = 3.5
        })
        
        AddBoxZone("burger_shot_register_1", vector3(-1196.01, -891.34, 14.0), 0.5, 0.4, {
            name="burger_shot_register_1",
            heading=125,
            minZ=14.0,
            maxZ=14.5
        }, {
            options = {
                {
                    event = "burgershot:get:receipt",
                    parms = "1",
                    icon = "fas fa-cash-register",
                    label = "Make Payment",
                },
                {
                    event = "burgershot:register",
                    parms = "1",
                    icon = "fas fa-credit-card",
                    label = "Charge Customer",
                },
             },
             job = {"all"},
            distance = 1.5
        })


        AddBoxZone("burger_shot_register_2", vector3(-1194.65, -893.3, 14.0), 0.6, 0.5, {
            name="burger_shot_register_2",
            heading=302,
            minZ=14.1,
            maxZ=14.5
        }, {
            options = {
                {
                    event = "burgershot:get:receipt",
                    parms = "2",
                    icon = "fas fa-cash-register",
                    label = "Make Payment",
                },
                {
                    event = "burgershot:register",
                    parms = "2",
                    icon = "fas fa-credit-card",
                    label = "Charge Customer",
                },
             },
             job = {"all"},
            distance = 1.5
        })

        AddBoxZone("burger_shot_register_3", vector3(-1193.39, -895.22, 14.0), 0.6, 0.4, {
            name="burger_shot_register_3",
            heading=125,
            minZ=14.0,
            maxZ=14.4
        }, {
            options = {
                {
                    event = "burgershot:get:receipt",
                    parms = "3",
                    icon = "fas fa-cash-register",
                    label = "Make Payment",
                },
                {
                    event = "burgershot:register",
                    parms = "3",
                    icon = "fas fa-credit-card",
                    label = "Charge Customer",
                },
             },
             job = {"all"},
            distance = 1.5
        })
        
        AddBoxZone("burger_shot_register_4", vector3(-1192.52, -906.65, 14.0), 0.5, 0.5, {
            name="burger_shot_register_4",
            heading=0,
            --debugPoly=true,
            minZ=13.8,
            maxZ=14.2
        }, {
            options = {
                {
                    event = "burgershot:register",
                    parms = "4",
                    icon = "fas fa-credit-card",
                    label = "Charge Customer",
                },
             },
             job = {"burger_shot"},
            distance = 1.5
        })
        
        AddBoxZone("burger_shot_trade_receipts", vector3(-1192.01, -900.95, 14.0), 1.6, 1, {
            name="burger_shot_trade_receipts",
            heading=35,
            --debugPoly=true,
            minZ=13.8,
            maxZ=14.6
        }, {
            options = {
                {
                    event = "burgershot:cash:in",
                    icon = "fas fa-cash-register",
                    label = "Cash in receipts",
                },
             },
             job = {"burger_shot"},
            distance = 1.5
        })


        -------- Weapon Shop --------

        -- local weaponshop = {
        --     [1] = -1643617475
        -- }

        -- AddTargetModel(
        --     weaponshop,
        --     {
        --         options = {
        --             {
        --                 event = "weapon:general",
        --                 icon = "fas fa-wrench",
        --                 label = "Purchase Weapons"
        --             }
        --         },
        --         job = {"all"},
        --         distance = 3
        --     }
        -- )

        AddBoxZone("weapon_shop_1", vector3(20.22, -1106.09, 29.8), 2, 2, {
            name="weapon_shop_1",
            heading=340,
            --debugPoly=true,
            minZ=28.8,
            maxZ=30.8
        }, {
            options = {
                {
                    event = "weapon:general",
                    icon = "fas fa-wrench",
                    label = "Purchase Weapons"
                }
            },
            job = {"all"},
            distance = 1.5
        })


        AddBoxZone("weapon_shop_2", vector3(253.23, -48.21, 69.94), 2, 2, {
            name="weapon_shop_2",
            heading=340,
            --debugPoly=true,
            minZ=68.94,
            maxZ=70.94
        }, {
            options = {
                {
                    event = "weapon:general",
                    icon = "fas fa-wrench",
                    label = "Purchase Weapons"
                }
            },
            job = {"all"},
            distance = 1.5
        })


        AddBoxZone("weapon_shop_3", vector3(-1305.11, -392.29, 36.7), 2.0, 2, {
            name="weapon_shop_3",
            heading=345,
            --debugPoly=true,
            minZ=35.7,
            maxZ=37.7
        }, {
            options = {
                {
                    event = "weapon:general",
                    icon = "fas fa-wrench",
                    label = "Purchase Weapons"
                }
            },
            job = {"all"},
            distance = 1.5
        })


        AddBoxZone("weapon_shop_4", vector3(-664.26, -934.41, 21.83), 2.0, 1, {
            name="weapon_shop_4",
            heading=90,
            --debugPoly=true,
            minZ=20.83,
            maxZ=22.83
        }, {
            options = {
                {
                    event = "weapon:general",
                    icon = "fas fa-wrench",
                    label = "Purchase Weapons"
                }
            },
            job = {"all"},
            distance = 1.5
        })


        AddBoxZone("weapon_shop_4", vector3(-664.26, -934.41, 21.83), 2.0, 1, {
            name="weapon_shop_4",
            heading=90,
            --debugPoly=true,
            minZ=20.83,
            maxZ=22.83
        }, {
            options = {
                {
                    event = "weapon:general",
                    icon = "fas fa-wrench",
                    label = "Purchase Weapons"
                }
            },
            job = {"all"},
            distance = 1.5
        })


        AddBoxZone("weapon_shop_5", vector3(844.4, -1034.54, 28.19), 2.0, 1, {
            name="weapon_shop_5",
            heading=90,
            --debugPoly=true,
            minZ=27.19,
            maxZ=28.99
        }, {
            options = {
                {
                    event = "weapon:general",
                    icon = "fas fa-wrench",
                    label = "Purchase Weapons"
                }
            },
            job = {"all"},
            distance = 1.5
        })

        AddBoxZone("weapon_shop_6", vector3(812.24, -2158.1, 29.62), 1.8, 1, {
            name="weapon_shop_6",
            heading=90,
            --debugPoly=true,
            minZ=28.62,
            maxZ=30.42
        }, {
            options = {
                {
                    event = "weapon:general",
                    icon = "fas fa-wrench",
                    label = "Purchase Weapons"
                }
            },
            job = {"all"},
            distance = 1.5
        })


        AddBoxZone("weapon_shop_7", vector3(2569.96, 293.18, 108.73), 1.8, 1, {
            name="weapon_shop_7",
            heading=90,
            --debugPoly=true,
            minZ=107.73,
            maxZ=109.53
        }, {
            options = {
                {
                    event = "weapon:general",
                    icon = "fas fa-wrench",
                    label = "Purchase Weapons"
                }
            },
            job = {"all"},
            distance = 1.5
        })

        AddBoxZone("weapon_shop_8", vector3(1691.51, 3758.9, 34.71), 1.65, 1, {
            name="weapon_shop_8",
            heading=135,
            --debugPoly=true,
            minZ=33.71,
            maxZ=35.51
        }, {
            options = {
                {
                    event = "weapon:general",
                    icon = "fas fa-wrench",
                    label = "Purchase Weapons"
                }
            },
            job = {"all"},
            distance = 1.5
        })

        AddBoxZone("weapon_shop_9", vector3(-1119.85, 2697.74, 18.55), 1.6, 1, {
            name="weapon_shop_9",
            heading=310,
            --debugPoly=true,
            minZ=17.55,
            maxZ=19.35
        }, {
            options = {
                {
                    event = "weapon:general",
                    icon = "fas fa-wrench",
                    label = "Purchase Weapons"
                }
            },
            job = {"all"},
            distance = 1.5
        })


        AddBoxZone("weapon_shop_10", vector3(-3173.59, 1086.26, 20.84), 1.6, 1, {
            name="weapon_shop_10",
            heading=335,
            --debugPoly=true,
            minZ=19.84,
            maxZ=21.64
        }, {
            options = {
                {
                    event = "weapon:general",
                    icon = "fas fa-wrench",
                    label = "Purchase Weapons"
                }
            },
            job = {"all"},
            distance = 1.5
        })


        AddBoxZone("weapon_shop_11", vector3(-332.5, 6083.09, 31.45), 1.8, 1, {
            name="weapon_shop_11",
            heading=315,
            --debugPoly=true,
            minZ=30.45,
            maxZ=32.25
        }, {
            options = {
                {
                    event = "weapon:general",
                    icon = "fas fa-wrench",
                    label = "Purchase Weapons"
                }
            },
            job = {"all"},
            distance = 1.5
        })

        -------- Banks --------
        AddCircleZone(
            "bank1",
            vector3(149.66, -1041.52, 29.38),
            0.9,
            {
                name = "bank1",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "bank:openbank",
                        icon = "fas fa-university",
                        label = "Open Bank"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "bank2",
            vector3(313.99, -279.77, 54.17),
            0.9,
            {
                name = "bank2",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "bank:openbank",
                        icon = "fas fa-university",
                        label = "Open Bank"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "bank3",
            vector3(241.61, 226.15, 106.29),
            0.9,
            {
                -- Add Payhecks to this
                name = "bank3",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "bank:openbank",
                        icon = "fas fa-university",
                        label = "Open Bank"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "bank4",
            vector3(243.43, 225.42, 106.29),
            0.9,
            {
                -- Add Payhecks to this
                name = "bank4",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "bank:openbank",
                        icon = "fas fa-university",
                        label = "Open Bank"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "bank5",
            vector3(-351.21, -50.77, 49.04),
            0.9,
            {
                name = "bank5",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "bank:openbank",
                        icon = "fas fa-university",
                        label = "Open Bank"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "bank6",
            vector3(-1212.27, -331.37, 37.78),
            0.9,
            {
                name = "bank6",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "bank:openbank",
                        icon = "fas fa-university",
                        label = "Open Bank"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "bank7",
            vector3(-2961.81, 482.95, 15.7),
            0.9,
            {
                name = "bank7",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "bank:openbank",
                        icon = "fas fa-university",
                        label = "Open Bank"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "bank8",
            vector3(-112.09, 6470.12, 31.63),
            0.9,
            {
                name = "bank8",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "bank:openbank",
                        icon = "fas fa-university",
                        label = "Open Bank"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "bank9",
            vector3(1175.0703125, 2706.7980957031, 38.0940284729),
            0.9,
            {
                name = "bank8",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "bank:openbank",
                        icon = "fas fa-university",
                        label = "Open Bank"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
            -------- Prison --------
        AddCircleZone(
            "prison1",
            vector3(1778.73, 2558.14, 46.12),
            0.81,
            {
                name = "prison1",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "slushy:general",
                        icon = "fas fa-ice-cream",
                        label = "Make Slushy"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "prison2",
            vector3(1783.13, 2558.37, 45.67),
            0.44,
            {
                name = "prison2",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "pfood:general",
                        icon = "fas fa-bread-slice",
                        label = "Prison Food"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "prisonmeth",
            vector3(1765.89, 2496.09, 49.61),
            0.5,
            {
                name = "prisonmeth",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "pmeth:general",
                        icon = "fas fa-hand-sparkles",
                        label = "Clean this toilet"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "prison3",
            vector3(1663.67, 2513.63, 44.81),
            0.5,
            {
                name = "prison3",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "prisonap:general",
                        icon = "fas fa-question",
                        label = "What?"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "prison4",
            vector3(1776.9, 2565.0, 45.67),
            0.5,
            {
                name = "prison4",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "prisonlp:general",
                        icon = "fas fa-question",
                        label = "What ?"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )
        AddCircleZone(
            "reclaim",
            vector3(1840.28, 2579.91, 46.01),
            1.0,
            {
                name = "reclaim",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "jailbreak:reclaimitems",
                        icon = "fas fa-undo",
                        label = "Reclaim Possessions"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )


        -- Bean Machine
        AddBoxZone("bean_register", vector3(-634.24, 235.53, 81.88), 0.35, 0.1, {
                name="bean_register",
                heading=275,
                --debugPoly=true,
                minZ=82.08,
                maxZ=82.28
            }, {
                options = {
                    {
                        event = "bean:get:receipt",
                        parms = "1",
                        icon = "fas fa-cash-register",
                        label = "Make Payment",
                    },
                    {
                        event = "bean:register",
                        parms = "1",
                        icon = "fas fa-credit-card",
                        label = "Charge Customer",
                    },
                 },
                 job = {"all"},
                distance = 1.5
        })


        AddBoxZone("bean_tray", vector3(-634.69, 236.56, 81.91), 0.6, 1, {
            name="bean_tray",
            heading=5,
            --debugPoly=true,
            minZ=82.11,
            maxZ=82.51
        }, {
            options = {
                {
                    event = "open:tray",
                    parms = "bean_tray",
                    icon = "fas fa-hand-holding",
                    label = "Take the Items",
                },
            },
                job = {"all"},
                distance = 1.5
        })

        AddBoxZone("bean_storage", vector3(-633.06, 224.93, 81.88), 1.6, 1, {
            name="bean_storage",
            heading=180,
            --debugPoly=true,
            minZ=82.43,
            maxZ=83.43
        }, {
            options = {
                {
                    event = "open:storage",
                    parms = "bean_machine",
                    icon = "fas fa-box-open",
                    label = "Open Bean Machine's Stash!"
                },
             },
             job = {"bean_machine"},
            distance = 2.5
        })

        
        AddBoxZone("bean_frig", vector3(-635.64, 232.93, 81.88), 1.4, 1, {
            name="bean_frig",
            heading=65,
            --debugPoly=true,
            minZ=80.88,
            maxZ=82.93
        }, {
            options = {
                {
                    event = "bean:order",
                    icon = "fas fa-box-open",
                    label = "Open Bean Machine's Fridge!"
                },
             },
             job = {"bean_machine"},
            distance = 2.5
        })
       

                
        AddBoxZone("bean_craft", vector3(-635.69, 236.42, 81.88), 1.1, 0.5, {
            name="bean_craft",
            heading=270,
            --debugPoly=true,
            minZ=82.08,
            maxZ=82.63
        }, {
            options = {
                {
                    event = "bean:craft",
                    icon = "fas fa-box-open",
                    label = "Make Food!"
                },
             },
             job = {"bean_machine"},
            distance = 2.5
        })


        AddBoxZone("bean_trade_receipts",vector3(-627.41, 225.75, 81.88), 0.5, 0.5, {
            name="bean_trade_receipts",
            heading=270,
            --debugPoly=true,
            minZ=81.68,
            maxZ=81.88
        }, {
            options = {
                {
                    event = "bean:cash:in",
                    icon = "fas fa-cash-register",
                    label = "Cash in receipts",
                },
             },
             job = {"bean_machine"},
            distance = 2.5
        })


        -------- Courthouse (TELEPORTERS) --------

        AddCircleZone(
            "courthouseenter",
            vector3(235.26, -412.24, 48.11),
            5.0,
            {
                name = "courthouseenter",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "courthouse:enter",
                        icon = "fas fa-door-open",
                        label = "Enter the Courthouse"
                    }
                },
                job = {"all"},
                distance = 10.0
            }
        )

        AddCircleZone(
            "courthouseexit",
            vector3(269.21, -371.89, -44.14),
            1.5,
            {
                name = "courthouseexit",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "courthouse:exit",
                        icon = "fas fa-door-open",
                        label = "Exit the Courthouse"
                    }
                },
                job = {"all"},
                distance = 10.0
            }
        )

        AddCircleZone(
            "courtroomenter",
            vector3(249.17, -364.77, -44.14),
            1.5,
            {
                name = "courtroomenter",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "courtroom:enter",
                        icon = "fas fa-door-open",
                        label = "Enter the Courtroom"
                    }
                },
                job = {"all"},
                distance = 10.0
            }
        )

        AddCircleZone(
            "courtroomexit",
            vector3(313.18, -1611.2, -66.79),
            1.5,
            {
                name = "courtroomexit",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "courtroom:exit",
                        icon = "fas fa-door-open",
                        label = "Exit the Courtroom"
                    }
                },
                job = {"all"},
                distance = 10.0
            }
        )

        AddBoxZone(
            "TacoCraft",
            vector3(16.27, -1597.89, 29.38),
            2.6,
            0.8,
            {
                name = "TacoCraft",
                heading = 230,
                debugPoly = false,
                minZ = 28.18,
                maxZ = 29.58
            },
            {
                options = {
                    {
                        event = "taco:craft",
                        icon = "fas fa-utensils",
                        label = "Cook up some grub!"
                    }
                },
                job = {"all"},
                distance = 3.5
            }
        )

        AddBoxZone(
            "TacoList",
            vector3(8.17, -1607.24, 29.37),
            0.4,
            0.2,
            {
                name = "TacoList",
                heading = 230,
                debugPoly = false,
                minZ = 29.52,
                maxZ = 29.92
            },
            {
                options = {
                    {
                        event = "taco:list",
                        icon = "fas fa-laptop",
                        label = "Check the Suber Eats Orders!"
                    }
                },
                job = {"all"},
                distance = 3.5
            }
        )

        AddBoxZone(
            "Tacodelivery",
            vector3(10.33, -1605.26, 29.39),
            2.4,
            1.0,
            {
                name = "Tacodelivery",
                heading = 320,
                debugPoly = false,
                minZ = 28.69,
                maxZ = 31.29
            },
            {
                options = {
                    {
                        event = "taco:deliver2",
                        icon = "fas fa-shopping-bag",
                        label = "Collect the Suber Order!"
                    }
                },
                job = {"all"},
                distance = 3.5
            }
        )

        -------- Auto Exotics --------

        AddBoxZone(
            "AutoExoticsStorage",
            vector3(546.61, -165.82, 54.49),
            2.8,
            1,
            {
                name = "Storage",
                heading = 91,
                debugPoly = false,
                minZ = 51.69,
                maxZ = 55.69
            },
            {
                options = {
                    {
                        event = "mech:check:internal:storage",
                        parms = "auto_exotics",
                        icon = "fas fa-hammer",
                        label = "Check AutoExotic's Internals's Supply"
                    },
                    {
                        event = "open:storage",
                        parms = "auto_exotics",
                        icon = "fas fa-box-open",
                        label = "Open AutoExotic's Stash!"
                    },
                    {
                        event = "mech:craft",
                        icon = "fas fa-wrench",
                        label = "Open AutoExotic's Crafting Book!"
                    }
                },
                job = {"auto_exotics"},
                distance = 3
            }
        )
        
        -------- Auto Bodies --------

        AddBoxZone(
            "AutoBodies",
            vector3(-1421.2340087891, -455.22863769531, 35.909713745117),
            4.65,
            1,
            {
                name = "AutoBodies",
                heading = 302,
                debugPoly = false,
                minZ = 34.86,
                maxZ = 37.26
            },
            {
                options = {
                    {
                        event = "mech:check:internal:storage",
                        parms = "auto_bodies",
                        icon = "fas fa-hammer",
                        label = "Check Hayes's Internals's Supply"
                    },
                    {
                        event = "open:storage",
                        parms = "auto_bodies",
                        icon = "fas fa-box-open",
                        label = "Open Hayes's Stash!"
                    },
                    {
                        event = "mech:craft",
                        icon = "fas fa-wrench",
                        label = "Open Hayes's Crafting Book!"
                    }
                },
                job = {"auto_bodies"},
                distance = 3
            }
        )
        -------- Auto Bodies --------

        AddBoxZone(
            "Tuner",
            vector3(948.03, -969.7, 39.5),
            3.9,
            1,
            {
                name = "Tuner",
                heading = 4,
                debugPoly = false,
                minZ = 38.5,
                maxZ = 40.1
            },
            {
                options = {
                    {
                        event = "mech:check:internal:storage",
                        parms = "tuner_shop",
                        icon = "fas fa-hammer",
                        label = "Check Tuner Shop's Internals's Supply"
                    },
                    {
                        event = "open:storage",
                        parms = "Tuner",
                        icon = "fas fa-box-open",
                        label = "Open Tuner Shop's Stash!"
                    },
                    {
                        event = "mech:craft",
                        icon = "fas fa-wrench",
                        label = "Open Tuner Shop's Crafting Book!"
                    }
                },
                job = {"tuner_shop"},
                distance = 3
            }
        )

        AddBoxZone(
            "Paletoperf",
            vector3(106.16, 6629.43, 31.79),
            3.8,
            1,
            {
                name = "Paletoperf",
                heading = 315,
                debugPoly = false,
                minZ = 30.79,
                maxZ = 32.59
            },
            {
                options = {
                    {
                        event = "mech:check:internal:storage",
                        parms = "Paletoperf",
                        icon = "fas fa-hammer",
                        label = "Check Paleto Performance's Internals's Supply"
                    },
                    {
                        event = "open:storage",
                        parms = "Paletoperf",
                        icon = "fas fa-box-open",
                        label = "Open Paleto Performance's Stash!"
                    },
                    {
                        event = "mech:craft",
                        icon = "fas fa-wrench",
                        label = "Open Paleto Performance's Crafting Book!"
                    }
                },
                job = {"paleto_mech"},
                distance = 3
            }
        )

        -------- Best Buds --------

        AddCircleZone(
            "bestbudsstorage", vector3(-618.47, -293.86, 35.34), 0.8,
            {
                name = "bestbudsstorage",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "open:storage",
                        parms = "best_buds",
                        icon = "fas fa-box-open",
                        label = "Open Bestbuds Storage"
                    }
                },
                job = {"best_buds"},
                distance = 1.5
            }
        )

        AddBoxZone("best_buds_shop", vector3(-625.83, -294.99, 35.34), 2.75, 1, {
            name="best_buds_shop",
            heading=30,
            --debugPoly=true,
            minZ=34.34,
            maxZ=35.54
        }, {
         
            options = {
                {
                    event = "bestbuds:shop",
                    icon = "fas fa-shopping-basket",
                    label = "Open BestBuds Weed Shop"
                }
            },
         
             job = {"best_buds"},
            distance = 3.5
        })

        AddBoxZone("best_buds_register_1", vector3(-621.45, -294.6, 35.34), 0.6, 1, {
            name="best_buds_register_1",
            heading=300,
            --debugPoly=true,
            minZ=35.34,
            maxZ=35.74
        }, {
            options = {
                {
                    event = "Best_buds:get:receipt",
                    parms = "1",
                    icon = "fas fa-cash-register",
                    label = "Make Payment",
                },
                {
                    event = "Best_buds:register",
                    parms = "1",
                    icon = "fas fa-credit-card",
                    label = "Charge Customer",
                },
             },
             job = {"all"},
            distance = 1.5
        })


        AddBoxZone("best_buds_register_2", vector3(-627.01, -292.7, 35.34), 0.6, 1, {
            name="best_buds_register_2",
            heading=30,
            --debugPoly=true,
            minZ=35.34,
            maxZ=35.74
        }, {
            options = {
                {
                    event = "Best_buds:get:receipt",
                    parms = "2",
                    icon = "fas fa-cash-register",
                    label = "Make Payment",
                },
                {
                    event = "Best_buds:register",
                    parms = "2",
                    icon = "fas fa-credit-card",
                    label = "Charge Customer",
                },
             },
             job = {"all"},
            distance = 1.5
        })


        AddBoxZone("best_buds_receipts", vector3(-618.93, -288.63, 35.34), 2.15, 1, {
            name="best_buds_receipts",
            heading=30,
            --debugPoly=true,
            minZ=35.19,
            maxZ=35.49
        }, {
            options = {
                {
                    event = "Best_buds:cash:in",
                    icon = "fas fa-cash-register",
                    label = "Cash in receipts",
                },
             },
             job = {"best_buds"},
            distance = 1.5
        })
        
        AddBoxZone("best_buds_counter", vector3(-623.5, -295.81, 35.34), 2.15, 1, {
            name="best_buds_counter",
            heading=120,
            --debugPoly=true,
            minZ=34.34,
            maxZ=35.54
        }, {
            options = {
                {
                    event = "open:tray",
                    parms = "best_buds_counter",
                    icon = "fas fa-hand-holding",
                    label = "Take the Items",
                },
             },
             job = {"all"},
            distance = 3.5
        })
        
        -------- Tequaila --------

        AddCircleZone("Tequila", vector3(-562.31, 287.77, 82.18), 2.2,
            {
                name = "Tequila ",
                debugPoly = false,
                useZ = true
            },
            {
                options = {
                    {
                        event = "tequila:shop",
                        icon = "fas fa-shopping-basket",
                        label = "Open the Bar's Menu"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )

        -------- Smelter --------

        AddCircleZone(
            "smelter",
            vector3(1109.83, -2008.2, 31.06),
            2.0,
            {
                name = "smelter",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "smelter-smelt",
                        icon = "fas fa-shopping-basket",
                        label = "Smelt yo goods"
                    }
                },
                job = {"all"},
                distance = 10.0
            }
        )

        -------- Hospital (TELEPORTERS) --------


        AddBoxZone("hospitalroof1", vector3(332.35, -597.32, 43.28), 0.2, 1, {
            name="hospitalroof2",
            heading=340,
            --debugPoly=true,
            minZ=43.48,
            maxZ=43.78
        }, {
            options = {
                {
                    event = "hospital:roof",
                    icon = "fas fa-arrow-alt-circle-up",
                    label = "Enter the Elevator to the Roof"
                },
            },
            job = {"all"},
            distance = 5.0
        })

        AddBoxZone("hospitalroof", vector3(330.3, -602.77, 43.28), 0.2, 1, {
            name="hospitalroof",
            heading=340,
            --debugPoly=true,
            minZ=43.48,
            maxZ=43.88
        }, {
            options = {
                {
                    event = "hospital:lower",
                    icon = "fas fa-arrow-alt-circle-down",
                    label = "Enter the Elevator to the Bottom Floor"
                }
            },
            job = {"all"},
            distance = 10.0
        })


        AddBoxZone("hospitallowerup", vector3(344.32, -584.58, 28.8), 0.15, 1, {
            name="hospitallowerup",
            heading=340,
            --debugPoly=true,
            minZ=29.0,
            maxZ=29.25
        }, {
            options = {
                {
                    event = "hospital:elevatorup",
                    icon = "fas fa-arrow-alt-circle-up",
                    label = "Enter the Elevator to the Main Hospital"
                }
            },
            job = {"all"},
            distance = 5.0
        })

        AddBoxZone("hospitalroof2", vector3(345.71, -580.91, 28.8), 0.2, 1, {
            name="hospitalroof2",
            heading=340,
            --debugPoly=true,
            minZ=29.0,
            maxZ=29.35
        }, {
            options = {
                {
                    event = "hospital:roof",
                    icon = "fas fa-arrow-alt-circle-up",
                    label = "Enter the Elevator to the Roof"
                }
            },
            job = {"all"},
            distance = 5.0
        })

        AddBoxZone("hospitalrooftomain", vector3(338.23, -583.74, 74.16), 3.0, 1, {
            name="hospitalrooftomain",
            heading=340,
            --debugPoly=true,
            minZ=73.16,
            maxZ=75.36
        }, {
            options = {
                {
                    event = "hospital:roofexit",
                    icon = "fas fa-arrow-alt-circle-down",
                    label = "Enter the Door to elevator to leave the roof!"
                }
            },
            job = {"all"},
            distance = 5.0
        })
    
        local pdheliped = {
            [1] = -1422914553
        }

        AddTargetModel(
            pdheliped,
            {
                options = {
                    {
                        event = "spawn:hei:pd",
                        icon = "fas fa-helicopter",
                        label = "Police Air Garage"
                    }
                },
                job = {"police"},
                distance = 1.5
            }
        )

        local emsheliped = {
            [1] = -163714847
        }

        AddTargetModel(
            emsheliped,
            {
                options = {
                    {
                        event = "spawn:hei:ems",
                        icon = "fas fa-helicopter",
                        label = "EMS Air Garage"
                    }
                },
                job = {"ems"},
                distance = 1.5
            }
        )

        local emsvehped = {
            [1] = 2139205821
        }

        AddTargetModel(
            emsvehped,
            {
                options = {
                    {
                        event = "EMSSpawnVeh",
                        icon = "fas fa-car",
                        label = "EMS Garage"
                    }
                },
                job = {"ems"},
                distance = 1.5
            }
        )

        local pdvehped = {
            [1] = -994634286
        }

        AddTargetModel(
            pdvehped,
            {
                options = {
                    {
                        event = "PDSpawnVeh",
                        icon = "fas fa-car",
                        label = "Police Garage"
                    }
                },
                job = {"police"},
                distance = 1.5
            }
        )

        local newsStands = {
            [1] = 1211559620,
            [2] = -1186769817,
            [3] = -756152956,
            [4] = 720581693,
            [5] = -838860344
        }

        AddTargetModel(
            newsStands,
            {
                options = {
                    {
                        event = "NewsStandCheck",
                        icon = "fas fa-newspaper",
                        label = "Read The News!"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )

        local CHAIRS = {
            [1] = -99500382,
            [2] = -1118419705,
            [3] = 538002882,
            [4] = 525667351,
            [5] = 1805980844,
            [6] = 826023884,
            [7] = 764848282,
            [8] = -741944541,
            [9] = -377849416,
            [10] = -992710074,
            [11] = 867556671,
            [12] = 1716133836,
            [13] = 146905321,
            [14] = 603897027
        }

        AddTargetModel(
            CHAIRS,
            {
                options = {
                    {
                        event = "animation:Chair",
                        icon = "fas fa-chair",
                        label = "Sit Down!"
                    }
                },
                job = {"all"},
                distance = 1.5
            }
        )

        AddBoxZone("jail_options", vector3(1832.03, 2592.68, 46.01), 0.5, 0.5, {
            name="jail_options",
            heading=0,
            --debugPoly=true,
            minZ=46.21,
            maxZ=46.81
        }, {
            options = {
                {
                    event = "check:time",
                    icon = "fas fa-clock",
                    label = "Check Remaining Time"
                },
                {
                    event = "swappingCharsLoop",
                    icon = "fas fa-exchange-alt",
                    label = "Change Characters"
                }
            },
            job = {"all"},
            distance = 2.0
        })

        AddCircleZone(
            "civ-mdt",
            vector3(260.5163269043, -371.86566162109, -44.137672424316),
            0.5,
            {
                name = "civ-mdt",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "civ:mdt:open",
                        icon = "fas fa-laptop",
                        label = "Public Records"
                    }
                },
                job = {"all"},
                distance = 2.0
            }
        )

      
        AddBoxZone(
            "Jewel Robbery",
            vector3(-636.11, -213.18, 53.54),
            2.3,
            0.5,
            {
                name = "Jewel Robbery",
                heading = 119,
                debugPoly = false,
                minZ = 49.99,
                maxZ = 54.39
            },
            {
                options = {
                    {
                        event = "jewel:thermite",
                        icon = "fas fa-bomb",
                        label = "Place Thermite"
                    }
                },
                job = {"all"},
                distance = 3
            }
        )


        AddBoxZone(
            "recycle",
            vector3(995.19, -3100.02, -39.0),
            0.4,
            0.5,
            {
                name = "recycle",
                heading = 0,
             --   debugPoly = true,
                minZ = -39.2,
                maxZ = -38.9
            },
            {
                options = {
                    {
                        event = "recycle:trade",
                        icon = "far fa-clipboard",
                        label = "Trade Your Materials!"
                    }
                },
                job = {"all"},
                distance = 3
            }
        )


        local GasPumps = {
            [1] = 1694452750,
            [2] = -2007231801,
            [3] = 1933174915,
            [4] = 1339433404,
            [5] = -462817101
        }

        AddTargetModel(
            GasPumps,
            {
                options = {
                    {
                        event = "IHATETHIS",
                        icon = "fas fa-gas-pump",
                        label = "Fuel Up Your Car!"
                    }
                },
                job = {"all"},
                distance = 5
            }
        )

        AddCircleZone(
            "methstart",
            vector3(1005.750793457, -3200.4038085938, -38.519329071045),
            0.5,
            {
                name = "methstart",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "meth:start",
                        icon = "fas fa-prescription",
                        label = "Turn The Cooker On!"
                    }
                },
                job = {"all"},
                distance = 2.5
            }
        )

        AddBoxZone("towstart", vector3(409.07, -1623.01, 29.29), 0.6, 1, {
            name="towstart",
            heading=51,
            debugPoly=true,
            minZ=28.29,
            maxZ=30.09
        }, 
        {
            options = {
                {
                    event = "start:tow",
                    icon = "far fa-clipboard",
                    label = "Pull out a tow truck!"
                },
                {
                    event = "end:tow",
                    icon = "far fa-clipboard",
                    label = "Put away your tow truck!"
                },
            },
            job = {"tow"},
            distance = 1.5
        }
    )

        AddCircleZone(
            "methsell",
            vector3(203.00288391113, -2016.6826171875, 17.5706615448),
            0.5,
            {
                name = "methsell",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "meth:sell",
                        label = "Hand Something Over"
                    }
                },
                job = {"all"},
                distance = 2.5
            }
        )
        AddCircleZone(
            "methsell2",
            vector3(225.73658752441, -1760.8559570312, 27.695140838623),
            0.5,
            {
                name = "methsell",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "meth:sell",
                        label = "Hand Something Over"
                    }
                },
                job = {"all"},
                distance = 2.5
            }
        )
        AddCircleZone(
            "methsell3",
            vector3(-255.40719604492, -1542.0688476562, 30.936147689819),
            0.5,
            {
                name = "methsell",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "meth:sell",
                        label = "Hand Something Over"
                    }
                },
                job = {"all"},
                distance = 2.5
            }
        )
        AddCircleZone(
            "methsell4",
            vector3(1235.3387451172, -413.82913208008, 67.928161621094),
            0.5,
            {
                name = "methsell",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "meth:sell",
                        label = "Hand Something Over"
                    }
                },
                job = {"all"},
                distance = 2.5
            }
        )
        
        AddCircleZone(
            "gangbouncer",
            vector3(114.94241333008, 170.44744873047, 112.45175933838),
            0.5,
            {
                name = "gangbouncer",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "gangteleport",
                        icon = "fas fa-question",
                        label = "Request Access To Enter"
                    }
                },
                job = {"all"},
                distance = 2.5
            }
        )

        AddCircleZone(
            "gangleave",
            vector3(-1570.5743408203, -3017.6284179688, -75.406188964844),
            0.5,
            {
                name = "gangleave",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "gangleave",
                        icon = "fas fa-question",
                        label = "Leave The Club"
                    }
                },
                job = {"all"},
                distance = 2.5
            }
        )

        AddCircleZone(
            "talktoboss",
            vector3(-1610.1271972656, -3012.0046386719, -75.205032348633),
            0.5,
            {
                name = "talktoboss",
                debugPoly = false,
                useZ = false
            },
            {
                options = {
                    {
                        event = "boss1",
                        icon = "fas fa-question",
                        label = "Talk To Boss"
                    }
                },
                job = {"all"},
                distance = 2.5
            }
        )
    end
)
