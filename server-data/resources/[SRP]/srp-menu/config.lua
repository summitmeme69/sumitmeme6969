local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isDead = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}
local bagged = false

rootMenuConfig =  {
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            return not isDead
        end,
        subMenus = {"general:escort",  "general:checkoverself", "general:emotes", "general:putinvehicle", "general:unseatnearest"}
    },
    {
        id = "police-action",
        displayName = "Police Actions",
        icon = "#police-action",
        enableMenu = function()
            return (isPolice and not isDead)
        end,
        subMenus = {"general:escort", "cuffs:remmask", "cuffs:checkinventory", "police:gsr", "police:dnaswab", "general:checktargetstates", "police:placespike", "police:removespike"}
    },
    {
        id = "police-license",
        displayName = "License Actions",
        icon = "#judge-licenses",
        enableMenu = function()
            return (isPolice and not isDead)
        end,

        subMenus = {"license:grantWeapon", "license:removeweapons", "license:grantHunting", "license:removehunting", "license:grantFishing", "license:removefishing"}
    },
    {
        id = "police-vehicle",
        displayName = "Police Vehicle",
        icon = "#police-vehicle",
        enableMenu = function()
            return (isPolice and not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end,
        subMenus = {"police:runplate", "police:toggleradar"}
    },
    {
        id = "policeDeadA",
        displayName = "10-13A",
        icon = "#police-dead",
        functionName = "police:tenThirteenA",
        enableMenu = function()
            return (isPolice and isDead)
        end
    },
    {
        id = "policeDeadB",
        displayName = "10-13B",
        icon = "#police-dead",
        functionName = "police:tenThirteenB",
        enableMenu = function()
            return (isPolice and isDead)
        end
    },
    {
        id = "emsDeadA",
        displayName = "10-14A",
        icon = "#ems-dead",
        functionName = "police:tenForteenA",
        enableMenu = function()
            return (isMedic and isDead)
        end
    },
    {
        id = "emsDeadB",
        displayName = "10-14B",
        icon = "#ems-dead",
        functionName = "police:tenForteenB",
        enableMenu = function()
            return (isMedic and isDead)
        end
    },
    -- {
    --     id = "k9",
    --     displayName = "K9",
    --     icon = "#k9",
    --     enableMenu = function()
    --         return (isPolice and not isDead)
    --     end,
    --     subMenus = {"k9:follow", "k9:vehicle",  "k9:sniffvehicle", "k9:huntfind", "k9:sit", "k9:stand", "k9:sniff", "k9:lay",  "k9:spawn", "k9:delete", }
    -- },
    {
        id = "animations",
        displayName = "Walking Styles",
        icon = "#walking",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "animations:brave", --[["animations:hurry",]] "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien",
        
        --new
        "animations:arrogant","animations:casual","animations:casual2","animations:casual3","animations:casual4","animations:casual5","animations:casual6","animations:confident","animations:business2","animations:business3","animations:femme","animations:flee","animations:gangster","animations:gangster2","animations:gangster3","animations:gangster4","animations:gangster5","animations:heels","animations:heels2","animations:muscle",--[["animations:quick",]]"animations:wide","animations:scared", }
    },
    {
        id = "expressions",
        displayName = "Expressions",
        icon = "#expressions",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },
    {
        id = "blips",
        displayName = "Blips",
        icon = "#blips",
        enableMenu = function()
            return not isDead
        end,
        subMenus = {"blips:24/7", "blips:gasstations", "blips:garages", "blips:barbershop", "blips:tattooshop", "blips:PD", "blips:EMS", "blips:clothing"}
    },
    -- {
    --     id = "drivinginstructor",
    --     displayName = "Driving Instructor",
    --     icon = "#drivinginstructor",
    --     enableMenu = function()
    --         return (not isDead and isInstructorMode)
    --     end,
    --     subMenus = { "drivinginstructor:drivingtest", "drivinginstructor:submittest", }
    -- },
    -- {
    --     id = "judge-raid",
    --     displayName = "Judge Raid",
    --     icon = "#judge-raid",
    --     enableMenu = function()
    --         return (not isDead and isJudge)
    --     end,
    --     subMenus = { "judge-raid:checkowner", "judge-raid:seizeall", "judge-raid:takecash", "judge-raid:takedm"}
    -- },
    -- {
    --     id = "judge-licenses",
    --     displayName = "Judge Licenses",
    --     icon = "#judge-licenses",
    --     enableMenu = function()
    --         return (not isDead and isJudge)
    --     end,
    --     subMenus = { "police:checklicenses", "judge:grantDriver", "judge:grantBusiness", "judge:grantWeapon", "judge:grantHouse", "judge:grantBar", "judge:grantDA", "judge:removeDriver", "judge:removeBusiness", "judge:removeWeapon", "judge:removeHouse", "judge:removeBar", "judge:removeDA", "judge:denyWeapon", "judge:denyDriver", "judge:denyBusiness", "judge:denyHouse" }
    -- },
    -- {
    --     id = "judge-actions",
    --     displayName = "Judge Actions",
    --     icon = "#judge-actions",
    --     enableMenu = function()
    --         return (not isDead and isJudge)
    --     end,
    --     subMenus = { "police:cuff", "cuffs:uncuff", "general:escort", "police:frisk", "cuffs:checkinventory", "police:checkbank"}
    -- },
    -- {
    --     id = "da-actions",
    --     displayName = "DA Actions",
    --     icon = "#judge-actions",
    --     enableMenu = function()
    --         return (not isDead and exports["srp-base"]:getModule("LocalPlayer"):getVar("job") == "district attorney")
    --     end,
    --     subMenus = { "police:cuff", "cuffs:uncuff", "general:escort", "police:frisk", "cuffs:checkinventory"}
    -- },
    {
        id = "cuff",
        displayName = "Cuff Actions",
        icon = "#cuffs",
        enableMenu = function()
            return (not isDead and not isHandcuffed and not isHandcuffedAndWalking and (exports["srp-inventory"]:hasEnoughOfItem("cuffs",1,false)or (exports["srp-inventory"]:hasEnoughOfItem("key1",1,false))))
        end,
        subMenus = { "cuffs:uncuff", "cuffs:cuff", "cuffs:remmask"}
    },
    {
        id = "bag",
        displayName = "Bag Player",
        icon = "#cuffs-cuff",
        functionName = "blindfolddst",
        enableMenu = function()
            return (not isDead and not isHandcuffed and not isHandcuffedAndWalking and (exports["srp-inventory"]:hasEnoughOfItem("bag",1,false)))
        end
    },
    {
        id = "bagoff",
        displayName = "Remove Bag",
        icon = "#cuffs-cuff",
        functionName = "blindfolddstoff",
        enableMenu = function()
            return (not isDead and not isHandcuffed and not isHandcuffedAndWalking and (exports["srp-inventory"]:hasEnoughOfItem("bag",1,false) or isPolice or bagged))
        end
    },
    {
        id = "medic",
        displayName = "Medical",
        icon = "#medic",
        enableMenu = function()
            return (not isDead and isMedic)
        end,
        subMenus = {"medic:revive", "medic:heal", "general:escort", "general:putinvehicle", "general:unseatnearest", "general:checktargetstates" }
    },
    -- {
    --     id = "doctor",
    --     displayName = "Doctor",
    --     icon = "#doctor",
    --     enableMenu = function()
    --         return (not isDead and isDoctor)
    --     end,
    --     subMenus = { "general:escort", "medic:revive", "medic:stomachpump", "general:checktargetstates", "medic:heal" }
    -- },
     {
         id = "news",
         displayName = "News",
         icon = "#news",
         enableMenu = function()
             return (not isDead and isNews)
         end,
         subMenus = { "news:setCamera", "news:setMicrophone", "news:setBoom" }
     },
    {
        id = "vehicle",
        displayName = "Vehicle",
        icon = "#vehicle-options-vehicle",
        functionName = "veh:options",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    }, 
    {
        id = "oxygentank",
        displayName = "Remove Oxygen Tank",
        icon = "#oxygen-mask",
        functionName = "RemoveOxyTank",
        enableMenu = function()
            return not isDead and hasOxygenTankOn
        end
    },
    {
        id = "mdt",
        displayName = "MDT",
        icon = "#mdt",
        functionName = "srp-mdt:hotKeyOpen",
        enableMenu = function()
            return ((isPolice or exports["isPed"]:isPed("myjob") == "DOJ") and not isDead)
        end
    }



}

newSubMenus = {
    ['general:emotes'] = {
        title = "Emotes",
        icon = "#general-emotes",
        functionName = "emotes:OpenMenu"
    },    

    ['general:checkoverself'] = {
        title = "Examine Self",
        icon = "#general-check-over-self",
        functionName = "Evidence:CurrentDamageList"
    },
    ['general:checktargetstates'] = {
        title = "Examine Target",
        icon = "#general-check-over-target",
        functionName = "requestWounds"
    },
    ['general:checkvehicle'] = {
        title = "Examine Vehicle",
        icon = "#general-check-vehicle",
        functionName = "veh:requestUpdate"
    },
    ['general:escort'] = {
        title = "Escort",
        icon = "#general-escort",
        functionName = "escortPlayer"
    },
    ['general:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:forceEnter"
    },
    ['general:unseatnearest'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "unseatPlayer"
    },    
    ['general:flipvehicle'] = {
        title = "Flip Vehicle",
        icon = "#general-flip-vehicle",
        functionName = "FlipVehicle"
    },
    
    ['animations:joy'] = {
        title = "Joy",
        icon = "#animation-joy",
        functionName = "AnimSet:Joy"
    },
    ['animations:sexy'] = {
        title = "Sexy",
        icon = "#animation-sexy",
        functionName = "AnimSet:Sexy"
    },
    ['animations:moon'] = {
        title = "Moon",
        icon = "#animation-moon",
        functionName = "AnimSet:Moon"
    },
    ['animations:tired'] = {
        title = "Tired",
        icon = "#animation-tired",
        functionName = "AnimSet:Tired"
    },
    ['animations:arrogant'] = {
        title = "Arrogant",
        icon = "#animation-arrogant",
        functionName = "AnimSet:Arrogant"
    },
    
    ['animations:casual'] = {
        title = "Casual",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual"
    },
    ['animations:casual2'] = {
        title = "Casual 2",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual2"
    },
    ['animations:casual3'] = {
        title = "Casual 3",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual3"
    },
    ['animations:casual4'] = {
        title = "Casual 4",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual4"
    },
    ['animations:casual5'] = {
        title = "Casual 5",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual5"
    },
    ['animations:casual6'] = {
        title = "Casual 6",
        icon = "#animation-casual",
        functionName = "AnimSet:Casual6"
    },
    ['animations:confident'] = {
        title = "Confident",
        icon = "#animation-confident",
        functionName = "AnimSet:Confident"
    },
    
    ['animations:business2'] = {
        title = "Business 2",
        icon = "#animation-business",
        functionName = "AnimSet:Business2"
    },
    ['animations:business3'] = {
        title = "Business 3",
        icon = "#animation-business",
        functionName = "AnimSet:Business3"
    },
    
    ['animations:femme'] = {
        title = "Femme",
        icon = "#animation-female",
        functionName = "AnimSet:Femme"
    },
    ['animations:flee'] = {
        title = "Flee",
        icon = "#animation-flee",
        functionName = "AnimSet:Flee"
    },
    ['animations:gangster'] = {
        title = "Gangster",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster"
    },
    ['animations:gangster2'] = {
        title = "Gangster 2",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster2"
    },
    ['animations:gangster3'] = {
        title = "Gangster 3",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster3"
    },
    ['animations:gangster4'] = {
        title = "Gangster 4",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster4"
    },
    ['animations:gangster5'] = {
        title = "Gangster 5",
        icon = "#animation-gangster",
        functionName = "AnimSet:Gangster5"
    },
    
    ['animations:heels'] = {
        title = "Heels",
        icon = "#animation-female",
        functionName = "AnimSet:Heels"
    },
    ['animations:heels2'] = {
        title = "Heels 2",
        icon = "#animation-female",
        functionName = "AnimSet:Heels2"
    },
    
    ['animations:hipster'] = {
        title = "Hipster",
        icon = "#animation-hipster",
        functionName = "AnimSet:Hipster"
    },
    ['animations:hiking'] = {
        title = "Hiking",
        icon = "#animation-hiking",
        functionName = "AnimSet:Hiking"
    },
    
    ['animations:jog'] = {
        title = "Jog",
        icon = "#animation-jog",
        functionName = "AnimSet:Jog"
    },
    
    ['animations:muscle'] = {
        title = "Muscle",
        icon = "#animation-tough",
        functionName = "AnimSet:Muscle"
    },
    
    -- ['animations:quick'] = {
    --     title = "Quick",
    --     icon = "#animation-quick",
    --     functionName = "AnimSet:Quick"
    -- },
    ['animations:wide'] = {
        title = "Wide",
        icon = "#animation-wide",
        functionName = "AnimSet:Wide"
    },
    ['animations:scared'] = {
        title = "Scared",
        icon = "#animation-scared",
        functionName = "AnimSet:Scared"
    },
    ['animations:guard'] = {
        title = "Guard",
        icon = "#animation-guard",
        functionName = "AnimSet:Guard"
    },
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    -- ['animations:hurry'] = {
    --     title = "Hurry",
    --     icon = "#animation-hurry",
    --     functionName = "AnimSet:Hurry"
    -- },
    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },
    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:nonchalant'] =
    {
        title = "Nonchalant",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },
    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Man Eater",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "ChiChi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },

    -- ['k9:spawn'] = {
    --     title = "Summon",
    --     icon = "#k9-spawn",
    --     functionName = "K9:Create"
    -- },
    -- ['k9:delete'] = {
    --     title = "Dismiss",
    --     icon = "#k9-dismiss",
    --     functionName = "K9:Delete"
    -- },
    -- ['k9:follow'] = {
    --     title = "Follow",
    --     icon = "#k9-follow",
    --     functionName = "K9:Follow"
    -- },
    -- ['k9:vehicle'] = {
    --     title = "Get in/out",
    --     icon = "#k9-vehicle",
    --     functionName = "K9:Vehicle"
    -- },
    -- ['k9:sit'] = {
    --     title = "Sit",
    --     icon = "#k9-sit",
    --     functionName = "K9:Sit"
    -- },
    -- ['k9:lay'] = {
    --     title = "Lay",
    --     icon = "#k9-lay",
    --     functionName = "K9:Lay"
    -- },
    -- ['k9:stand'] = {
    --     title = "Stand",
    --     icon = "#k9-stand",
    --     functionName = "K9:Stand"
    -- },
    -- ['k9:sniff'] = {
    --     title = "Sniff Person",
    --     icon = "#k9-sniff",
    --     functionName = "K9:Sniff"
    -- },
    -- ['k9:sniffvehicle'] = {
    --     title = "Sniff Vehicle",
    --     icon = "#k9-sniff-vehicle",
    --     functionName = "sniffVehicle"
    -- },
    -- ['k9:huntfind'] = {
    --     title = "Hunt nearest",
    --     icon = "#k9-huntfind",
    --     functionName = "K9:Huntfind"
    -- },
    ['blips:gasstations'] = {
        title = "Gas Stations",
        icon = "#blips-gasstations",
        functionName = "CarPlayerHud:ToggleGas"
    },    
    ['blips:24/7'] = {
        title = "24/7 Stores",
        icon = "#blips-24/7",
        functionName = "shops:showshops"
    },
    ['blips:PD'] = {
        title = "Police Departments",
        icon = "#police-action",
        functionName = "srp-spawnveh:showPD"
    },
    ['blips:EMS'] = {
        title = "Hospitals",
        icon = "#hospital-hospital",
        functionName = "srp-spawnveh:EMS"
    },
    ['blips:clothing'] = {
        title = "Clothing Store",
        icon = "#blips-clothing",
        functionName = "clothing:blips"
    },
    ['blips:garages'] = {
        title = "Garages",
        icon = "#blips-garages",
        functionName = "Garages:ToggleGarageBlip"
    },
    ['blips:barbershop'] = {
        title = "Barber Shop",
        icon = "#blips-barbershop",
        functionName = "hairDresser:ToggleHair"
    },    
    ['blips:tattooshop'] = {
        title = "Tattoo Shop",
        icon = "#blips-tattooshop",
        functionName = "tattoo:ToggleTattoo"
    },
   
    ['cuffs:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "civ:cuffFromMenu"
    },
    ['cuffs:uncuff'] = {
        title = "Uncuff",
        icon = "#cuffs-uncuff",
        functionName = "police:uncuffMenu"
    },
    ['cuffs:remmask'] = {
        title = "Remove Mask Hat",
        icon = "#cuffs-remove-mask",
        functionName = "police:remmask"
    },
    ['cuffs:checkinventory'] = {
        title = "Search Person",
        icon = "#cuffs-check-inventory",
        functionName = "police:checkInventory"
    },
    ['cuffs:unseat'] = {
        title = "Unseat",
        icon = "#cuffs-unseat-player",
        functionName = "unseatPlayerCiv"
    },
    ['cuffs:checkphone'] = {
        title = "Read Phone",
        icon = "#cuffs-check-phone",
        functionName = "police:checkPhone"
    },
    ['medic:revive'] = {
        title = "Revive",
        icon = "#medic-revive",
        functionName = "revive"
    },
    ['medic:heal'] = {
        title = "Heal",
        icon = "#medic-heal",
        functionName = "ems:heal"
    },
    ['medic:stomachpump'] = {
        title = "Stomach pump",
        icon = "#medic-stomachpump",
        functionName = "ems:stomachpump"
    },
    ['police:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:cuffFromMenu"
    },
    ['police:checkbank'] = {
        title = "Check Bank",
        icon = "#police-check-bank",
        functionName = "police:checkBank"
    },

    ['police:removeweapons'] = {
        title = "Remove Weapons License",
        icon = "#police-action-remove-weapons",
        functionName = "police:removeWeapon"
    },

    ['bag:onhead'] = {
        title = "Bag Someone",
        icon = "#police-action-remove-weapons",
        functionName = "blindfolddst"
    },

    ['police:gsr'] = {
        title = "GSR Test",
        icon = "#police-action-gsr",
        functionName = "police:gsr"
    },
    ['police:dnaswab'] = {
        title = "DNA Swab",
        icon = "#police-action-dna-swab",
        functionName = "evidence:dnaSwab"
    },
    ['police:placespike'] = {
        title = "Place Spikes",
        icon = "#vehicle-options",
        functionName = "placespikes"
    },
    ['police:removespike'] = {
        title = "Remove Spikes",
        icon = "#vehicle-options",
        functionName = "removespikes"
    },
    ['police:barriers'] = {
        title = "Place Cones",
        icon = "#police-cone",
        functionName = "barriers:cone"
    },
    ['police:barrier'] = {
        title = "Remove Barriers",
        icon = "#vehicle-options",
        functionName = "barriers:pickup"
    },
    ['police:toggleradar'] = {
        title = "Toggle Radar",
        icon = "#police-vehicle-radar",
        functionName = "startSpeedo"
    },
    ['police:runplate'] = {
        title = "Run Plate",
        icon = "#police-vehicle-plate",
        functionName = "clientcheckLicensePlate"
    },
    ['news:setCamera'] = {
        title = "Camera",
        icon = "#news-job-news-camera",
        functionName = "camera:setCamera"
    },
    ['news:setMicrophone'] = {
        title = "Microphone",
        icon = "#news-job-news-microphone",
        functionName = "camera:setMic"
    },
    ['news:setBoom'] = {
        title = "Microphone Boom",
        icon = "#news-job-news-boom",
        functionName = "camera:setBoom"
    },
    ['weed:currentStatusServer'] = {
        title = "Request Status",
        icon = "#weed-cultivation-request-status",
        functionName = "weed:currentStatusServer"
    },   
    ['weed:weedCrate'] = {
        title = "Remove A Crate",
        icon = "#weed-cultivation-remove-a-crate",
        functionName = "weed:weedCrate"
    },
    ['cocaine:currentStatusServer'] = {
        title = "Request Status",
        icon = "#meth-manufacturing-request-status",
        functionName = "cocaine:currentStatusServer"
    },
    ['cocaine:methCrate'] = {
        title = "Remove A Crate",
        icon = "#meth-manufacturing-remove-a-crate",
        functionName = "cocaine:methCrate"
    },
    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },
    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },
    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },
    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },
    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },
    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },
    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },
    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },
    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },
    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },
    ["expressions:oneeye"]  = {
        title="One Eye",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },
    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },
    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },
    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },
    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },
    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },
    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },
    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },
    ["expressions:weird2"]  = {
        title="Weird 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
    },

    ["license:grantWeapon"]  = {
        title="Grant Firearms License",
        icon="#judge-licenses-grant-weapon",
        functionName = "police:giveweapon",
    },
    ["license:removeweapons"]  = {
        title="Revoke Firearms License",
        icon="#judge-licenses-remove-weapon",
        functionName = "police:removeweapon",
    },


    ["license:grantHunting"]  = {
        title="Grant Hunting License",
        icon="#judge-licenses-grant-weapon",
        functionName = "police:givehunting",
    },

    ["license:removehunting"]  = {
        title="Revoke Hunting License",
        icon="#judge-licenses-remove-weapon",
        functionName = "police:removehunting",
    },


    ["license:grantFishing"]  = {
        title="Grant Fishing License",
        icon="#judge-licenses-grant-weapon",
        functionName = "police:givefishing",
    },

    ["license:removefishing"]  = {
        title="Revoke Fishing License",
        icon="#judge-licenses-remove-weapon",
        functionName = "police:removefishing",
    }
}

RegisterNetEvent("menu:setCuffState")
AddEventHandler("menu:setCuffState", function(pTargetId, pState)
    cuffStates[pTargetId] = pState
end)


RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent("srp-jobmanager:playerBecameJob")
AddEventHandler("srp-jobmanager:playerBecameJob", function(job, name, notify)
    if isMedic and job ~= "ems" then isMedic = false end
    if isPolice and job ~= "police" then isPolice = false end
    if isDoctor and job ~= "doctor" then isDoctor = false end
    if isNews and job ~= "news" then isNews = false end
    if job == "police" then isPolice = true end
    if job == "ems" then isMedic = true end
    if job == "news" then isNews = true end
    if job == "doctor" then isDoctor = true end
    myJob = job
end)

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)


RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffedAndWalking = pIsHandcuffedAndWalking
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank")
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)

RegisterNetEvent('enablegangmember')
AddEventHandler('enablegangmember', function(pGangNum)
    gangNum = pGangNum
end)

RegisterNetEvent("makenews")
AddEventHandler("makenews", function()
    isNews = true
    print(isNews)
end)

RegisterNetEvent("bagged")
AddEventHandler("bagged", function()
    bagged = true
end)