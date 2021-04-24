Config = {}

-- priority list can be any identifier. (hex steamid, steamid34, ip) Integer = power over other people with priority
-- a lot of the steamid converting websites are broken rn and give you the wrong steamid. I use https://steamid.xyz/ with no problems.
-- you can also give priority through the API, read the examples/readme.
Config.Priority = {
    -- High Staff 100--
    ["steam:110000117ccac15"] = 100, -- Droopies - 
    ["steam:11000011a32f847"] = 100, -- Bakerx - 

    ["steam:110000114e35069"] = 99, -- Sef - 
    ["steam:1100001000d44bf"] = 99, -- Arty - 
    ["steam:11000010f364387"] = 99, -- Coyote - 
    ["steam:110000109766817"] = 99, -- Lil Alpaca - 
    ["steam:110000105e19b99"] = 99, -- Trey - 
    ["steam:110000105ec10c8"] = 99, -- Kekky - 
    ["steam:110000118e95cb4"] = 99, -- Kalxie - 
    ["steam:11000013257a357"] = 99, -- Toxic - 
    ["steam:11000013dee49bf"] = 98, -- Piru - 
    ["steam:110000104080c98"] = 98, -- Skyla - 
    
    -- Low Staff 90 --
    ["steam:11000010643eaac"] = 90, -- Frost - 
    ["steam:110000102b93502"] = 90, -- Wolf - 
    ["steam:110000114d7a231"] = 90, -- BojiSnow - 
    ["steam:1100001015437ae"] = 90, -- Marshal | Berkhardt
    ["steam:110000109a898de"] = 90, -- Declan

    -- Superior? --
    ["steam:110000114df296d"] = 89, -- Will Smith - ENDS 5/15
    ["steam:110000114c6aaaa"] = 89, -- Connor - lIFETIME PRIO
    ["steam:110000105c8f6e1"] = 85, -- CosmicExploit - ENDS 5/10
    ["steam:110000118b2660e"] = 85, -- Bisante - ENDS - 4/26
    ["steam:11000013e55788a"] = 84, -- EA bowling - Chief of EMS
    ["steam:11000011c9fe467"] = 84, -- Barryyyyyyyy - ENDS - 10/25

    -- High 80 --
    ["steam:11000011c796c28"] = 80, -- parallel ski - DONT REMOVE
    ["steam:110000140086685"] = 80, -- BlzdkakashiTTV - ENDS 5/2
    ["steam:110000107d1717a"] = 80, -- IShortyyyI - ENDS 5/3
    ["steam:11000014435e600"] = 80, -- Kingkilla89 - ENDS 6/2
    ["steam:110000143662c4d"] = 80, -- xoxo shiggy - Cop/Streamer Prio
    ["steam:11000010469db5f"] = 80, -- John Clark/Harris - Steamer Prio
    ["steam:11000013ec18f16"] = 80, -- DaddyToast - ENDS 5/22
    ["steam:11000010d50e121"] = 80, -- Squinntee#0666 - ENDS - 5/22 
    ["steam:11000013f78e19d"] = 80, -- Yeti - ENDS - 5/10 
    ["steam:110000112627aa8"] = 80, -- EZehMedia - Cop/Streamer Prio
    ["steam:11000013535048d"] = 80, -- Kevo - ENDS 4/24
    ["steam:1100001159d7e16"] = 80, -- YaBoyPenut - ENDS 5/26
    ["steam:110000143a4b2f5"] = 80, -- CharmingLemur - ENDS - 5/7
    ["steam:110000103af931b"] = 80, -- Kneely - ENDS - 5/22
    ["steam:110000108461678"] = 80, -- Blazed - ENDS - 5/25
    ["steam:11000010bf57e56"] = 80, -- ImThatGuy43 - ENDS - 5/25
    ["steam:11000010d926443"] = 80, -- Nicole - ENDS - 5/27
    ["steam:11000010aed51f6"] = 80, -- tr3man814 - ENDS 5/25
    ["steam:11000011525a96c"] = 80, -- HippieLIP - ENDS - 4/25
    ["steam:110000118daff6b"] = 80, -- Tooty_Hole - ENDS - 4/25
    ["steam:11000010320c790"] = 80, -- Vinn - ENDS - 4/25
    ["steam:1100001473020ff"] = 80, -- Nightmarefae87 - ENDS - 4/26
    ["steam:1100001335f380d"] = 80, -- Boma - ENDS - STREAMER
    ["steam:110000116bf1bf9"] = 80, -- Karrsons - ENDS - STREAMER
    ["steam:1100001079189ba"] = 80, -- Bipod - ENDS - STREAMER
    ["steam:110000108511e06"] = 80, -- RoidBean - ENDS - STREAMER
    ["steam:1100001121b4fb2"] = 80, -- Premium - ENDS - STREAMER
    ["steam:11000010a49849f"] = 80, -- Stokele - ENDS - STREAMER
    ["steam:110000108be0498"] = 80, -- Kojo - ENDS - STREAMER
    ["steam:1100001071d1dc3"] = 80, -- Contraban - ENDS - STREAMER
    ["steam:11000011731dd19"] = 80, -- tylerm174 - ENDS - 4/26
    ["steam:1100001048f637a"] = 80, -- Doctormedic - ENDS - 4/26
    ["steam:11000010d7134a5"] = 80, -- TPosey - ENDS - 4/26
    ["steam:11000010b8ac22f"] = 80, -- RobbyQuest - ENDS - 4/28
    ["steam:110000132331c9a"] = 80, -- Winter Reaper - ENDS - 4/28
    ["steam:11000010692cc63"] = 80, -- Hypersloth369 - ENDS - 4/29
    ["steam:11000014296253f"] = 80, -- Miranda - ENDS - 5/20
    ["steam:11000011c78bd56"] = 80, -- JJ/PJ || TheLimitt - ENDS - 4/28
    ["steam:11000013e249fd8"] = 80, -- Hoon - ENDS - 4/25
    ["steam:11000013d48a9a2"] = 80, -- itsToxic - ENDS - 4/29
    ["steam:110000101d709d9"] = 80, -- DrizzeyDrazz - ENDS - 4/29
    ["steam:110000144e4c645"] = 80, -- Davey jones - ENDS - 4/29
    ["steam:110000145853734"] = 80, -- im black - ENDS - 4/29
    ["steam:110000114c9dfcb"] = 80, -- Milani - ENDS - 4/30
    ["steam:110000114290f24"] = 80, -- MistaMoneyTalk - ENDS - 4/30
    ["steam:1100001113536a2"] = 80, -- Jamal | Nigerian Warlord - ENDS - 4/30
    ["steam:1100001179e46d0"] = 80, -- MVRRS - ENDS - 4/31
    ["steam:110000117d2dea4"] = 80, -- smokinDiesel - ENDS - 5/2
    ["steam:11000010eab46bb"] = 80, -- Lournky - ENDS - 5/2
    ["steam:11000010337cddf"] = 80, -- Rachel Kubo - ENDS - 5/2
    ["steam:1100001065e0844"] = 80, -- DJay - ENDS - 5/2
    ["steam:11000013f9701ee"] = 80, -- Solaecisme - ENDS - 5/2
    ["steam:110000101b198fa"] = 80, -- donny - ENDS - 5/2
    ["steam:11000014075517a"] = 80, -- Disco - ENDS - 5/2
    ["steam:11000014731ded4"] = 80, -- Smashedpotatoes - ENDS - 5/2
    ["steam:1100001089cbd2d"] = 80, -- Ben.L - ENDS - 5/2
    ["steam:110000106ecc364"] = 80, -- PoptartMadness - ENDS - 5/2
    ["steam:11000011b5dc242"] = 80, -- Chumtastic - ENDS - 5/2
    ["steam:11000014716a1ae"] = 80, -- TheWastedClown - ENDS - 6/25
    ["steam:110000107304e14"] = 80, -- Maythegamers - ENDS - 5/3
    ["steam:1100001358232a7"] = 80, -- Broski - COP PRIO
    ["steam:11000010bf190a3"] = 80, -- Jerebear - ENDS - 5/3
    ["steam:11000010eeb7744"] = 80, -- DizzyDrake | Don | Gerald T. - ENDS - 5/3
    ["steam:110000142ee5d06"] = 80, -- MakesnoCents - ENDS - 5/3
    ["steam:11000013511cf5f"] = 80, -- Cass - ENDS - 5/6
    ["steam:110000104f99fde"] = 80, -- Kaiosuke - ENDS - 5/3
    ["steam:110000105156691"] = 80, -- arexandel - ENDS - 5/3
    ["steam:1100001010a251c"] = 80, -- Dean Hepcat - ENDS - 5/27
    ["steam:11000011b2fdfe7"] = 80, -- ItsGrubs
    ["steam:11000010ee37c6b"] = 80, -- Sonic
    ["steam:110000113d4a332"] = 80, -- xFissionx - ENDS - 5/4
    ["steam:11000011a612892"] = 80, -- Lorenzo lurk ENDS 5/11
    ["steam:1100001177a8d66"] = 80, -- PatarHD - ENDS - 5/5
    ["steam:110000107797626"] = 80, -- Phil Fairfax - ENDS - 5/7
    ["steam:11000013f5df7fa"] = 80, -- HoldDaBeef - ENDS - 5/18
    ["steam:1100001181044c4"] = 80, -- cConjo - ENDS - 5/20
    ["steam:11000010a538ad1"] = 80, -- ! (A) Joshua Bradley | Batman - ENDS - 5/21
    ["steam:1100001473c76b8"] = 80, -- Malcolm Wright | TunezOnTheGame - ENDS - 5/21
    ["steam:110000136b2f89b"] = 80, -- DIFFY  - ENDS - 5/21
    ["steam:110000146ea68a0"] = 80, -- chelseyw24 - ENDS - 5/21
    ["steam:11000011d577e56"] = 80, -- smario - ENDS - 5/25
    ["steam:110000116332d9b"] = 80, -- foop - ENDS - 5/25
    ["steam:110000104d53a52"] = 80, -- robodev1 - ENDS - 5/25
    ["steam:11000013e8b1f59"] = 80, -- Redux - ENDS - 5/25
    ["steam:110000106195f32"] = 80, -- JayRutt - ENDS - 5/25
    ["steam:1100001192b99d2"] = 80, -- Dantastic - ENDS - 5/25
    ["steam:1100001337ae8c9"] = 80, -- Fencegate - ENDS - 5/25
    ["steam:110000133279535"] = 80, -- schwiftyy__ - ENDS - 5/25
    ["steam:11000010457db6d"] = 80, -- Stones - ENDS - 5/25
    ["steam:1100001184e1383"] = 80, -- jFray - ENDS - 5/25
    ["steam:11000013c2642f7"] = 80, -- Herdon12 - ENDS - 5/25
    ["steam:11000010b622e40"] = 80, -- vVvLifelessvVv - ENDS - 5/25
    ["steam:110000105f8134b"] = 80, -- AJWesty - ENDS - 5/25
    ["steam:11000010d3a3f6f"] = 80, -- Joshh - ENDS - 5/25
    ["steam:11000010308c0c7"] = 80, -- POWNER7805 - ENDS - 5/26
    ["steam:11000010c83373b"] = 80, -- Nexx - ENDS - 5/26
    ["steam:110000103843914"] = 80, -- Viper081 - ENDS - 5/26
    ["steam:1100001086db1c0"] = 80, -- Jinx - ENDS - 5/26
    ["steam:1100001088dac08"] = 80, -- Dirty - ENDS - 5/27
    ["steam:11000013cfc1326"] = 80, -- bizquik20 - ENDS - 5/27
    ["steam:11000010221199d"] = 80, -- Rogues - ENDS - 5/27
    ["steam:110000106fede57"] = 80, -- OMGITSDerek - Streamer/Content Creator Prio
    ["steam:1100001428e946f"] = 80, -- TommyDimelli - ENDS - 5/28
    ["steam:110000111b3a3c1"] = 80, -- Purified - ENDS - 5/28
    ["steam:11000011ba46006"] = 80, -- KingKryptyk - ENDS - 5/29
    ["steam:1100001335be97d"] = 80, -- Rafiki - ENDS - 5/30
    ["steam:11000013ea4022c"] = 80, -- JustSkitzo - whitelist mod- 

    -- Med 70 -- 
    ["steam:1100001058c90dc"] = 70, -- Rayner - ENDS 5/1
    ["steam:11000013efae656"] = 70, -- cwopp - ENDS 4/29
    ["steam:11000010c237fd3"] = 70, -- CrozzoveR - ENDS 4/25
    ["steam:11000010aed34d6"] = 70, -- Paulkillz - ENDS - 4/24
    ["steam:1100001473076e7"] = 70, -- Dee - ENDS - 4/26
    ["steam:110000134eb47e0"] = 70, --  RaZzZor - ENDS - 4/28
    ["steam:11000013bd5964e"] = 70, -- chillidogg26 - ENDS - 4/28
    ["steam:1100001097e5b95"] = 70, -- Ziplion  - ENDS - EMS PRIO
    ["steam:11000010a08c795"] = 70, -- lilpete  - ENDS - EMS PRIO
    ["steam:1100001184e1383"] = 70, -- jFray  - ENDS - EMS PRIO
    ["steam:110000104d4d56f"] = 70, -- Codeman_Bill  - ENDS - EMS PRIO
    ["steam:110000109c17f12"] = 70, -- xXDozerXx2958  - ENDS - EMS PRIO
    ["steam:1100001028c8357"] = 70, -- hummingbird  - ENDS - EMS PRIO
    ["steam:110000115c72cd9"] = 70, -- RipByPeter   - ENDS - EMS PRIO
    ["steam:110000100094144"] = 70, -- skimmer    - ENDS - EMS PRIO
    ["steam:11000013470dcfe"] = 70, -- Swivvel13   - ENDS - EMS PRIO
    ["steam:11000011d52b651"] = 70, -- Kazu   - ENDS - EMS PRIO
    ["steam:11000010b4bbdaa"] = 70, -- Bean_Cracker - ENDS - 4/26
    ["steam:110000139f1994f"] = 70, -- Jimbo - ENDS - 4/26
    ["steam:1100001121e86f8"] = 70, -- 𝓚𝔦𝔶𝔤𝓟𝔯𝔦𝔫𝔠𝔢 - ENDS - 4/27
    ["steam:110000106514d07"] = 70, -- MattRatz - ENDS - 4/27
    ["steam:110000115160fd0"] = 70, -- Tiz - ENDS - 4/27
    ["steam:11000010a08c795"] = 70, -- lilpete - ENDS - 4/27
    ["steam:110000113deb242"] = 70, -- Blixky - ENDS - 4/27
    ["steam:11000010cf68e25"] = 70, -- RedRhino - ENDS - 4/28
    ["steam:1100001395d9867"] = 70, -- zexopher - ENDS - 4/28
    ["steam:110000104f22bda"] = 70, -- August - ENDS - 4/28
    ["steam:11000010930f23e"] = 70, -- t_shorey - ENDS - 4/28
    ["steam:110000117791144"] = 70, -- ~Remy - ENDS - 4/28
    ["steam:1100001178e4109"] = 70, -- Audacity™ - ENDS - 4/29
    ["steam:11000011368fa9d"] = 70, -- Croth - ENDS - 4/29
    ["steam:11000013bfc88b5"] = 70, -- SBZ | EYCE - ENDS - 4/29
    ["steam:110000106d667bf"] = 70, -- Thepooner - ENDS - 4/29
    ["steam:11000013b597b93"] = 70, -- Kaigs - ENDS - 4/29
    ["steam:11000010ef35475"] = 70, -- Cbattag20 - ENDS - 4/29
    ["steam:11000010442202e"] = 70, -- Houston - ENDS - 4/29
    ["steam:11000010d713389"] = 70, -- cKlaas - ENDS - 5/7
    ["steam:110000134bbf555"] = 70, -- XGooglyxMooglyX - ENDS - 4/29
    ["steam:11000011bde7b55"] = 70, -- Zarkqa - ENDS - 4/29
    ["steam:110000104ca79a3"] = 70, -- BUZZ - ENDS - 5/25
    ["steam:11000010872227e"] = 70, -- Lil Puto - ENDS - 4/29
    ["steam:11000010b1cc5c4"] = 70, -- Fizzy. - ENDS - 4/29
    ["steam:110000133913518"] = 70, -- Chip "CJ" Jordan - ENDS - 4/29
    ["steam:11000013f72f042"] = 70, -- KillerStrainz » (AFO) - ENDS - 4/29
    ["steam:1100001025900a6"] = 70, -- Bobus - ENDS - 4/30
    ["steam:1100001096636af"] = 70, -- Lyro - ENDS - 4/30
    ["steam:110000141693931"] = 70, -- Gunnii - ENDS - 4/30
    ["steam:1100001140031C9"] = 70, -- TStressed - ENDS - 4/30
    ["steam:1100001114c81da"] = 70, -- 𝗤𝘄𝘅𝗲𝘆 - ENDS - 4/30
    ["steam:110000119c32f5d"] = 70, -- R Tard - ENDS - 4/30
    ["steam:110000100f50b93"] = 70, -- -Lapret - ENDS - 4/30
    ["steam:11000010cb72851"] = 70, -- NateTheGreat - ENDS - 4/30
    ["steam:110000102c03f1c"] = 70, -- HamMEE - ENDS - 4/30
    ["steam:110000105406387"] = 70, -- MrRich - ENDS - 4/30
    ["steam:11000010d77dc57"] = 70, -- [KT] Michael1 - ENDS - 4/31
    ["steam:1100001097af687"] = 70, -- MXGirl - ENDS - 4/31
    ["steam:110000118dfa1ff"] = 70, -- Future - ENDS - 4/31
    ["steam:11000013469dd28"] = 70, -- Dongerlord - ENDS - 5/1
    ["steam:11000013d72f0c1"] = 70, -- Jagger - ENDS - 5/1
    ["steam:110000118f49ee2"] = 70, -- VonzVital - ENDS - 5/1
    ["steam:11000010ba1dc4c"] = 70, -- ANTN3E - ENDS - 5/1
    ["steam:11000010b46d7dc"] = 70, -- DemonsIvy ★ - ENDS - 5/1
    ["steam:110000102c4eb32"] = 70, -- Big Moose - ENDS - 5/2
    ["steam:11000010a742e65"] = 70, -- Lanco - ENDS - 5/2
    ["steam:11000014668b996"] = 70, -- Z3IT3R - ENDS - 5/2
    ["steam:11000013bdc36d8"] = 70, -- Skywalker - ENDS - 5/2
    ["steam:11000013ec7f9b5"] = 70, -- Blankz - ENDS - 5/2
    ["steam:1100001434ce8ef"] = 70, -- Auctrix - ENDS - 5/2
    ["steam:1100001454eef60"] = 70, -- crxnkified - ENDS - 5/2
    ["steam:11000010ac04163"] = 70, -- Wacky_tobacky - ENDS - 5/2
    ["steam:110000144704af5"] = 70, -- Kold - ENDS - 5/2
    ["steam:11000010c20663c"] = 70, -- DoriTheDrunkBori - ENDS - 5/2
    ["steam:11000013e42ff87"] = 70, -- JDM Addicted - ENDS - 5/2
    ["steam:110000117968245"] = 70, -- ! FannyPack Leon - ENDS - 5/2
    ["steam:110000109435a9f"] = 70, -- Ac aka Happiness - ENDS - 5/2
    ["steam:11000010c823779"] = 70, -- shermy452 - ENDS - 5/2
    ["steam:11000010742954e"] = 70, -- bennylaudone20 - ENDS - 5/2
    ["steam:11000011cb9257e"] = 70, -- Crypt - ENDS - 5/3
    ["steam:110000108cf8d61"] = 70, -- iDevilsdocry - ENDS - 5/3
    ["steam:1100001057d9799"] = 70, -- vnm - ENDS - 5/3
    ["steam:11000010acbad25"] = 70, -- Studioo - ENDS - 5/3
    ["steam:110000103dc5f91"] = 70, -- Jean Faux - ENDS - 5/3
    ["steam:110000133f3d4d5"] = 70, -- GroveGb - ENDS - 5/3
    ["steam:110000100808b7d"] = 70, -- Faction - ENDS - 5/3
    ["steam:11000010a15747b"] = 70, -- invertedd - ENDS - 5/3
    ["steam:110000104fd7929"] = 70, -- Specs - ENDS - 5/4
    ["steam:110000103858563"] = 70, -- Ricky Durango - ENDS - 5/4
    ["steam:11000011734ae1a"] = 70, -- Devtro - ENDS - 5/4
    ["steam:110000145e53774"] = 70, -- Brandon742 - ENDS - 5/4
    ["steam:11000011a1afc13"] = 70, -- natespray - ENDS - 5/9
    ["steam:110000145f2e50a"] = 70, -- MonarchMe - ENDS - 5/9
    ["steam:110000145c0f5b1"] = 70, -- Tkn - ENDS - 5/10
    ["steam:11000013605a68f"] = 70, -- PlaguedProtohype - ENDS - 5/19
    ["steam:11000010a1295ca"] = 70, -- metta - ENDS - 5/19
    ["steam:1100001049f946c"] = 70, -- zEn - ENDS - 5/19
    ["steam:110000102857ebe"] = 70, -- Jaden - ENDS - 5/19
    ["steam:110000107acabbf"] = 70, -- TKOxMachine - ENDS - 5/25
    ["steam:1100001090055a9"] = 70, -- Spammerforlife - ENDS - 5/25
    ["steam:110000115dbc02a"] = 70, -- Shui - ENDS - 5/25
    ["steam:110000113968eaa"] = 70, -- ZxssT - ENDS - 5/25
    ["steam:11000011a18bcf7"] = 70, -- Wipp - ENDS - 5/25
    ["steam:11000010d35cd33"] = 70, -- ThiccEwok - ENDS - 5/25
    ["steam:1100001115ba704"] = 70, -- !Alex - ENDS - 5/25
    ["steam:110000109963a8e"] = 70, -- holden0 - ENDS - 5/25
    ["steam:11000010c9103eb"] = 70, -- Aguaaa - ENDS - 5/25
    ["steam:1100001071d62c7"] = 70, -- Mattydc - ENDS - 5/25
    ["steam:11000010707bb07"] = 70, -- Frecks - ENDS - 5/25
    ["steam:11000010918664d"] = 70, -- Leo - ENDS - 5/25
    ["steam:11000013fd155a3"] = 70, -- Caspur - ENDS - 5/25
    ["steam:1100001143f6951"] = 70, -- extasee - ENDS - 5/25
    ["steam:1100001092e54d7"] = 70, -- DoomsdayFlu - ENDS - 5/25
    ["steam:110000109a56283"] = 70, -- ROLO - ENDS - 6/25
    ["steam:1100001414c2ddb"] = 70, -- ArctiC - ENDS - 5/26
    ["steam:11000010c9021ad"] = 70, -- speedy - ENDS - 5/26
    ["steam:1100001000056ba"] = 70, -- Ethan North - ENDS - 5/26
    ["steam:110000135f88cfd"] = 70, -- MadClapper - ENDS - 5/26
    ["steam:110000103829fc3"] = 70, -- flyerbyday - ENDS - 5/26
    ["steam:11000010bd890f9"] = 70, -- ValorMVP - ENDS - 5/26
    ["steam:110000119b7450f"] = 70, -- Day - ENDS - 5/26
    ["steam:11000010724137c"] = 70, -- PinkEye - ENDS - 5/26
    ["steam:110000106449919"] = 70, -- Bronson - ENDS - 5/26
    ["steam:11000010ba3eb1f"] = 70, -- BlueB - ENDS - 5/26
    ["steam:1100001078b836e"] = 70, -- Ethan North - ENDS - 5/27
    ["steam:1100001050743de"] = 70, -- Ishabae - ENDS - 5/27
    ["steam:110000133b77aee"] = 70, -- Dukeez - ENDS - 5/27
    ["steam:1100001066cc09d"] = 70, -- Ray_Finkle - ENDS - 5/28
    ["steam:11000013b1c692e"] = 70, -- Slashaholic - ENDS - 5/29
    ["steam:11000010672fddb"] = 70, -- Paxtoninc - ENDS - 5/30

    -- Low 60 --
    ["steam:110000109b18046"] = 60, -- jbmoneyy - ENDS - 4/29
    ["steam:1100001136a2d4a"] = 60, -- scary_larry13 - ENDS - 4/23
    ["steam:110000100094144"] = 60, -- skimmer - ENDS - 4/25   
    ["steam:110000105adbc43"] = 60, -- Nimble - ENDS - 4/25
    ["steam:11000011c78bd56"] = 60, -- JJ/PJ || TheLimitt - ENDS - 4/25
    ["steam:1100001124fcae1"] = 60, -- SnackLord - ENDS - 4/28
    ["steam:11000010c00c05e"] = 60, -- Jubia - ENDS - 4/28
    ["steam:110000108649a60"] = 60, -- DemiGod - ENDS - 4/27
    ["steam:110000113fc6897"] = 60, -- ChickenBilly - ENDS - 4/27
    ["steam:110000105c8f6e1"] = 60, -- CosmicExploit - ENDS - 4/27
    ["steam:110000136dcee60"] = 60, -- Chug / Wing Ching - ENDS - 4/27
    ["steam:11000013cda5de2"] = 60, -- skies - ENDS - 4/28
    ["steam:11000013f981abb"] = 60, -- JNabs - ENDS - 4/29
    ["steam:11000010a312455"] = 60, -- La Li Lu Le Lo - ENDS - 4/29
    ["steam:110000103d18619"] = 60, -- Jayfly - ENDS - 4/29
    ["steam:1100001080874b1"] = 60, -- ruben - ENDS - 4/29
    ["steam:11000010c832977"] = 60, -- Pierce123 - ENDS - 4/29
    ["steam:11000011344bf22"] = 60, -- Gavin123 - ENDS - 4/29
    ["steam:110000134771e50"] = 60, -- Daxton - ENDS - 4/29
    ["steam:11000010af8056b"] = 60, -- Pierce_603 - ENDS - 4/30
    ["steam:110000131ec6e54"] = 60, -- Lgnuke1 - ENDS - 4/30
    ["steam:11000010bae2064"] = 60, -- Braybro - ENDS - 4/30
    ["steam:1100001170b19a3"] = 60, -- LEGOMYJAGO - ENDS - 4/30
    ["steam:110000106ecc364"] = 60, -- PoptartMadness - ENDS - 4/31
    ["steam:110000106b2431d"] = 60, -- Hodzic - ENDS - 4/31
    ["steam:110000146d19f91"] = 60, -- Dem0nata - ENDS - 4/31
    ["steam:11000010b0fd5ac"] = 60, -- Alioth - ENDS - 4/31
    ["steam:1100001071d62c7"] = 60, -- Mattydc1808 - ENDS - 4/31
    ["steam:110000132621db3"] = 60, -- Dave - ENDS - 4/31
    ["steam:1100001399406c3"] = 60, -- T̶̎̌m̶̂̑0̵́̚k̷̞̇ - ENDS - 4/31
    ["steam:110000109d03c02"] = 60, -- FrodoSwaggins39 - ENDS - 5/2
    ["steam:110000100bc68c4"] = 60, -- Rich - ENDS - 5/2
    ["steam:110000107360acc"] = 60, -- Mason - ENDS - 5/3
    ["steam:1100001119042ec"] = 60, -- Corbin - ENDS - 5/3
    ["steam:1100001192c9bb1"] = 60, -- tawska - ENDS - 5/3
    ["steam:11000011b36d3c1"] = 60, -- elpis - ENDS - 5/4
    ["steam:110000109fa4f61"] = 60, -- GyroGaming - ENDS - 5/4
    ["steam:110000132e4e45e"] = 60, -- hammyham58 - ENDS - 5/7
    ["steam:110000140a1bcf0"] = 60, -- Trumps my 2016 - ENDS - 5/7
    ["steam:110000133c37330"] = 60, -- shotz - ENDS - 5/9
    ["steam:11000013274e315"] = 60, -- CAZER - ENDS - 5/9
    ["steam:11000010aa081f2"] = 60, -- Dawson - ENDS - 5/9
    ["steam:1100001366d8b50"] = 60, -- Belockaye - ENDS - 5/9
    ["steam:11000010848b1c5"] = 60, -- little jay - ENDS - 5/9
    ["steam:110000145ba3729"] = 60, -- Alexis Fae - ENDS - 5/25
    ["steam:11000013c3c1eb1"] = 60, -- Nova? - ENDS - 5/25
    ["steam:1100001052118de"] = 60, -- Kennn - ENDS - 5/25
    ["steam:1100001413f6257"] = 60, -- Madison Queer - ENDS - 5/25
    ["steam:1100001124a5d05"] = 60, -- Gravaro - ENDS - 5/25
    ["steam:110000145b6d377"] = 60, -- secrets - ENDS - 5/25
    ["steam:1100001065bc026"] = 60, -- JamoRog - ENDS - 5/26
    ["steam:11000010886db42"] = 60, -- Evan Glansby - ENDS - 5/26
    ["steam:1100001070cf5f8"] = 60, -- Lindsey - ENDS - 5/26
    ["steam:11000010c8170b7"] = 60, -- zrni - ENDS - 5/26
    ["steam:110000108894762"] = 60, -- Frost0852 - ENDS - 5/27
    ["steam:1100001445aadf0"] = 60, -- CaptnBeeBop - ENDS - 5/27
    ["steam:1100001426ec717"] = 60, -- BobLeeSchwagger - ENDS - 5/30
 
     
    -- Whitelisted 45 --

    
}

-- require people to run steam
Config.RequireSteam = true

-- "whitelist" only server
Config.PriorityOnly = false

-- disables hardcap, should keep this true
Config.DisableHardCap = true

-- will remove players from connecting if they don't load within: __ seconds; May need to increase this if you have a lot of downloads.
-- i have yet to find an easy way to determine whether they are still connecting and downloading content or are hanging in the loadscreen.
-- This may cause session provider errors if it is too low because the removed player may still be connecting, and will let the next person through...
-- even if the server is full. 10 minutes should be enough
Config.ConnectTimeOut = 600

-- will remove players from queue if the server doesn't recieve a message from them within: __ seconds
Config.QueueTimeOut = 120

-- will give players temporary priority when they disconnect and when they start loading in
Config.EnableGrace = true

-- how much priority power grace time will give
Config.GracePower = 85

-- how long grace time lasts in seconds
Config.GraceTime = 120

-- on resource start, players can join the queue but will not let them join for __ milliseconds
-- this will let the queue settle and lets other resources finish initializing
Config.JoinDelay = 60000

-- will show how many people have temporary priority in the connection message
Config.ShowTemp = false

-- simple localization
Config.Language = {
    joining = "\xF0\x9F\x8E\x89Joining SummitRP...",
    connecting = "\xE2\x8F\xB3Connecting to SummitRP...",
    idrr = "\xE2\x9D\x97[SRPQueue] Error: Couldn't retrieve any of your id's, try restarting.",
    err = "\xE2\x9D\x97[SRPQueue] There was an error",
    pos = "\xF0\x9F\x90\x8CYou are %d/%d in queue \xF0\x9F\x95\x9C%s",
    connectingerr = "\xE2\x9D\x97[SRPQueue] Error: Error adding you to connecting list",
    timedout = "\xE2\x9D\x97[SRPQueue] Error: Timed out?",
    wlonly = "\xE2\x9D\x97[SRPQueue] You must be whitelisted to join this server. To apply, head to : https://discord.gg/9XfXH2zwf9",
    steam = "\xE2\x9D\x97 [SRPQueue] Error: Steam must be running"
}
