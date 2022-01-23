local mPlayer = game.Players.LocalPlayer
local mRoot = mPlayer.Character.HumanoidRootPart
local mGui = Instance.new("ScreenGui",game.CoreGui)
local vUser = game:service'VirtualUser'
local mMouse = mPlayer:GetMouse()
local imdie = false
local farmtolook = false
local iscollectDisk = true
local moveFarmSpeed = 80 -- default 100
local useMicro=false

local todoZone = 0 --  0 = tele , 1 = auto farm
local todoMes = 0
local fieldPos = {
    ["Sunflower"] = {Vector3.new(-211,5,185), Vector3.new(-212,5.0093364715576,155), Vector3.new(-212,5.0093364715576,194)},
    ["Dandelion"] = {Vector3.new(-39,5,220),Vector3.new(-55,5.0093364715576,220),Vector3.new(-15,5,220)},
    ["Mushroom"] = {Vector3.new(-92,5,160),Vector3.new(-118,5,106),Vector3.new(-74,5,128)},
    ["Blue Flower"] = {Vector3.new(57,5,99),Vector3.new(186,5,97),Vector3.new(135,5,98)},
    ["Clover Field"] = {Vector3.new(218,34,202),Vector3.new(173,34,175),Vector3.new(173,34,221),Vector3.new(134,34,223),Vector3.new(132,34,173)},
    ["StrawBerry"] = {Vector3.new(-152,21,44), Vector3.new(-196,21,9), Vector3.new(-167,21,-17)},
    ["Spider Field"] = {Vector3.new(-120,28,-15), Vector3.new(-67,21,6), Vector3.new(-22,21,7),Vector3.new(-22,21,-26),Vector3.new(-64,21,-27)},
    ["BamBoo"] = {Vector3.new(69,21,10), Vector3.new(152,21,-26), Vector3.new(95,21,-25)},
    ["Pineapple"] = {Vector3.new(253,69,-159), Vector3.new(229,69,-221), Vector3.new(283,69,-228),Vector3.new(289,69,-188),Vector3.new(228,69,-186)},
    ["Pine Tree"] = {Vector3.new(-267,69,-116), Vector3.new(-342,69,-163), Vector3.new(-339,69,-211),Vector3.new(-307,69,-213),Vector3.new(-313,69,-161)},
    ["Red Rose"] = {Vector3.new(-286,21,171), Vector3.new(-303,21,142), Vector3.new(-355,21,141),Vector3.new(-355,21,111),Vector3.new(-306,21,113)},
    ["Cactus"] = {Vector3.new(-267,69,-116), Vector3.new(-165,69,-103), Vector3.new(-220,69,-105)},
    ["Pumpkin"] = {Vector3.new(-267,69,-116), Vector3.new(-223,69,-185), Vector3.new(-169,69,-188)},
    ["Mountain"] = {Vector3.new(20,177,-190), Vector3.new(88,177,-151), Vector3.new(56,177,-152), Vector3.new(56,177,-193), Vector3.new(93,177,-189)},
    ["Snails"] = {Vector3.new(355,95,-174), Vector3.new(440,97,-192),Vector3.new(440,97,-157),Vector3.new(407,97,-157),Vector3.new(410,97,-195)},
    ["Coconut"] = {Vector3.new(-317,82,452), Vector3.new(-238,72,481), Vector3.new(-281,72,482),Vector3.new(-285,72,447),Vector3.new(-230,72,448)},
    ["Pepper"] = {Vector3.new(-478,124,520), Vector3.new(-500,124,541), Vector3.new(-501,124,495),Vector3.new(-468,124,543),Vector3.new(-468,124,492)}
}
local fieldGo ={
    ["Sunflower"] = {Vector3.new(-217,5,271),Vector3.new(-212,5,168)},
    ["SunflowerJ"] = {false,false},
    ["Dandelion"]=  {Vector3.new(-36.7,5,283.9),Vector3.new(-35,5,229)},
    ["DandelionJ"] = {false,false},
    ["Mushroom"] = {Vector3.new(-115,5,262),Vector3.new(-91,5,114)},
    ["MushroomJ"] = {false,false},
    ["Blue Flower"] = {Vector3.new(-118,5,278),Vector3.new(-117,5,220),Vector3.new(55,5,116),Vector3.new(142,5,100)},
    ["Blue FlowerJ"] = {false,false,false,false},
    ["Clover Field"] = {Vector3.new(-38,5,286),Vector3.new(-25,5,248),Vector3.new(47.5,5,218.5),Vector3.new(90.6,19.7,219.5),Vector3.new(148,34.5,207)},
    ["Clover FieldJ"] = {false,false,false,false,true},
    ["StrawBerry"] = {Vector3.new(-113,5,266),Vector3.new(-126.8,5,82),Vector3.new(-129,21,51.6),Vector3.new(-176.5,21,-6)},
    ["StrawBerryJ"] = {false,false,true,false,false},
    ["Spider Field"] = {Vector3.new(-117.3,5,264.5),Vector3.new(-27.5,5,157.7),Vector3.new(-5.1,22,76.1),Vector3.new(-34.2,21,-4.6)},
    ["Spider FieldJ"] = {false,false,true,false},
    ["BamBoo"] = {Vector3.new(-118,5,267),Vector3.new(-104,5,226),Vector3.new(-30.7,5,142.8),Vector3.new(15,21,37.6),Vector3.new(123.7,21,-24.4)},
    ["BamBooJ"] = {false,false,false,true,false},
    ["Pineapple"] = {Vector3.new(-118,5,274),Vector3.new(-97,5,218.8),Vector3.new(55,5,124),Vector3.new(179,5,71.7),Vector3.new(195.3,21,-5.8),Vector3.new(213.6,42.3,55),
                    Vector3.new(260.5,69,-208.1)},
    ["PineappleJ"] = {false,false,false,false,true,true,false},
    ["Pine Tree"] = {Vector3.new(-114,5,263),Vector3.new(-125.5,5,77),Vector3.new(-137.8,21,55.7),Vector3.new(-226.7,35.5,51),Vector3.new(-242.3,69.7,-59.6),Vector3.new(-315,69,-187)},
    ["Pine TreeJ"] = {false,false,true,false,false,false},
    ["Red Rose"] = {Vector3.new(-220,5,269),Vector3.new(-249,5,229),Vector3.new(-284.7,21,174.6),Vector3.new(-319,21,125.9)},
    ["Red RoseJ"] = {false,false,true,false},
    ["Cactus"] = {Vector3.new(-114,5,263),Vector3.new(-125.5,5,77),Vector3.new(-137.8,21,55.7),Vector3.new(-226.7,35.5,51),Vector3.new(-242.3,69.7,-59.6),Vector3.new(-241,69,-87),Vector3.new(-190,69,-98)},
    ["CactusJ"] = {false,false,true,false,false,false,false},
    ["Pumpkin"] = {Vector3.new(-114,5,263),Vector3.new(-125.5,5,77),Vector3.new(-137.8,21,55.7),Vector3.new(-226.7,35.5,51),Vector3.new(-242.3,69.7,-59.6),Vector3.new(-195,69,-182)},
    ["PumpkinJ"] = {false,false,true,false,false,false},
    ["Snails"] = {Vector3.new(-118,5,274),Vector3.new(-97,5,218.8),Vector3.new(55,5,124),Vector3.new(179,5,71.7),Vector3.new(195.3,21,-5.8),Vector3.new(213.6,42.3,55),
                Vector3.new(251.4,69,-123.8),Vector3.new(318.5,69,-194),Vector3.new(442,97,-179.6)},
    ["SnailsJ"] = {false,false,false,false,true,true,false,false,false},
    ["Coconut"] = {Vector3.new(-184.8,5,330),Vector3.new(-230,18,358),Vector3.new(-271.5,18,341),Vector3.new(-320,33.4,345),Vector3.new(-337,51,378),
                    Vector3.new(-388,51,397.8),Vector3.new(-435.5,60.5,416.5),Vector3.new(-396,72.5,446.5),Vector3.new(-356,82.5,459.3),Vector3.new(-263,72.4,458)},
    ["CoconutJ"] = {false,true,false,true,true,false,true,true,true,false},
    ["Pepper"] = {Vector3.new(-184.8,5,330),Vector3.new(-230,18,358),Vector3.new(-271.5,18,341),Vector3.new(-320,33.4,345),Vector3.new(-337,51,378),
                    Vector3.new(-388,51,397.8),Vector3.new(-435.5,60.5,416.5),Vector3.new(-396,72.5,446.5),Vector3.new(-356,82.5,459.3),Vector3.new(-379,98.5,499),
                    Vector3.new(-424,111.9,535),Vector3.new(-488,124.2,526)},
    ["PepperJ"] = {false,true,false,true,true,false,true,true,true,true,true,true},
    ["Mountain"] = {Vector3.new(-189.5,5,326),Vector3.new(-221.8,18,358.6),Vector3.new(-239.4,18,343.6)},
    ["MountainJ"] = {false,true,false}
}
local redcanon = {Vector3.new(-15,244,-35),Vector3.new(37.5,242.6,-124.6),Vector3.new(64,209.6,-169.2)}
local fieldBack={
    ["Sunflower"] = {Vector3.new(-220,5,236),Vector3.new(-217,5,271)},
    ["SunflowerJ"] = {false,false},
    ["Dandelion"]=  {Vector3.new(-38.7,5,249),Vector3.new(-36.7,5,283.9)},
    ["DandelionJ"] = {false,false},
    ["Mushroom"] = {Vector3.new(-97,5,141),Vector3.new(-115,5,262)},
    ["MushroomJ"] = {true,false},
    ["Blue Flower"] = {Vector3.new(54,5,105),Vector3.new(25,5,134),Vector3.new(-112,5,226),Vector3.new(-117,5,275)},
    ["Blue FlowerJ"] = {false,false,true,false},
    ["Clover Field"] = {Vector3.new(34,5,251),Vector3.new(23,5,270)},
    ["Clover FieldJ"] = {false,false,true},
    ["StrawBerry"] = {Vector3.new(-148.3,21,45.2),Vector3.new(-141.8,5,143.3),Vector3.new(-112,5,236.6),Vector3.new(-115.5,5,262)},
    ["StrawBerryJ"] = {false,false,false,false},
    ["Spider Field"] = {Vector3.new(-17.6,22,38.6),Vector3.new(-5.7,22,84.2),Vector3.new(-110,5,223.6),Vector3.new(-113,5,267.6)},
    ["Spider FieldJ"] = {false,false,false,false},
    ["BamBoo"] = {Vector3.new(54.4,21,-0.4),Vector3.new(3,21,56.5),Vector3.new(-80.2,5,170.5),Vector3.new(-113.6,5,262.6)},
    ["BamBooJ"] = {false,false,true,false},
    ["Pineapple"] = {Vector3.new(237.7,69,-162),Vector3.new(161.8,69,-69.1),Vector3.new(7,21,47.7),Vector3.new(-73.7,5,171.6),Vector3.new(-114,5,267)},
    ["PineappleJ"] = {false,false,false,false,false},
    ["Pine Tree"] = {Vector3.new(-248,69,-78.4),Vector3.new(-230,35.5,59.2),Vector3.new(-121.1,5,208.5),Vector3.new(-114,5,266)},
    ["Pine TreeJ"] = {false,false,false,false},
    ["Red Rose"] = {Vector3.new(-289,21,165.3),Vector3.new(-215,5,269.5)},
    ["Red RoseJ"] = {false,false},
    ["Cactus"] = {Vector3.new(-209,69,-100),Vector3.new(-248,69,-78.4),Vector3.new(-230,35.5,59.2),Vector3.new(-121.1,5,208.5),Vector3.new(-114,5,266)},
    ["CactusJ"] = {false,false,false,false,false},
    ["Pumpkin"] = {Vector3.new(-209,69,-100),Vector3.new(-248,69,-78.4),Vector3.new(-230,35.5,59.2),Vector3.new(-121.1,5,208.5),Vector3.new(-114,5,266)},
    ["PumpkinJ"] = {false,false,false,false,false},
    ["Snails"] = {Vector3.new(324,69,-144.9),Vector3.new(160.5,69,-70.7),Vector3.new(9,21,47.5),Vector3.new(-75,5,170.5),Vector3.new(-115,5,262)},
    ["SnailsJ"] = {true,false,true,false,false},
    ["Coconut"] = {Vector3.new(-221.5,72.5,428.3),Vector3.new(-202,8.3,328.1)},
    ["CoconutJ"] = {false,true},
    ["Pepper"] = {Vector3.new(-376.8,98.5,470.9),Vector3.new(-307.4,82.4,417.4),Vector3.new(-266,18,361.9),Vector3.new(-203.3,10.2,332.7)},
    ["PepperJ"] = {false,false,false,false},
    ["Mountain"] = {Vector3.new(40.8,177,-118.9),Vector3.new(34,189.4,-89),Vector3.new(-7,21,57.7),Vector3.new(-9,22,84.6),Vector3.new(-107.5,5,219.8),Vector3.new(-112,5,269)},
    ["MountainJ"] = {false,true,false,false,false}
}
local fieldSpinkler2={
    ["Sunflower"] = {
        [1]={Vector3.new(-209.724,5.0093364715576,174.907)},
        [2]={Vector3.new(-210.465,5.0093364715576,191.550),Vector3.new(-209.390,5.0093364715576,158.727)},
        [3]={Vector3.new(-210.465,5.0093364715576,191.550),Vector3.new(-209.724,5.0093364715576,174.907),Vector3.new(-209.390,5.0093364715576,158.727)},
        [4]={Vector3.new(-200.465,5.0093364715576,191.550),Vector3.new(-220.465,5.0093364715576,191.550),Vector3.new(-200.465,5.0093364715576,158.550),Vector3.new(-220.465,5.0093364715576,158.550)}
    },
    ["Dandelion"] = {
        [1]={Vector3.new(-31.382,5.0093364715576,220.990)},
        [2]={Vector3.new(-56.925,5.0093364715576,220.990),Vector3.new(-14.496,5.0093364715576,220.990)},
        [3]={Vector3.new(-56.925,5.0093364715576,220.990),Vector3.new(-31.382,5.0093364715576,220.990),Vector3.new(-14.496,5.0093364715576,220.990)},
        [4]={Vector3.new(-56.925,5.0093364715576,230.990),Vector3.new(-56.925,5.0093364715576,210.990),Vector3.new(-14.496,5.0093364715576,230.990),Vector3.new(-14.496,5.0093364715576,210.990)}
    },
    ["Mushroom"] = {
        [1]={Vector3.new(-95.738,5.0093364715576,114.406)},
        [2]={Vector3.new(-116.338,5.0093364715576,111.146),Vector3.new(-71.869,5.0093364715576,132.416)},
        [3]={Vector3.new(-116.338,5.0093364715576,111.146),Vector3.new(-95.738,5.0093364715576,114.406),Vector3.new(-71.869,5.0093364715576,132.416)},
        [4]={Vector3.new(-123.634,5.0093364715576,113.754),Vector3.new(-104.739,5.0093364715576,99.621),Vector3.new(-84.605,5.0093364715576,133.396),Vector3.new(-65.073,5.0093364715576,127.771)}
    },
    ["Blue Flower"] = {
        [1]={Vector3.new(150.995,5.0093364715576,99.468)},
        [2]={Vector3.new(170.412,5.0093364715576,99.468),Vector3.new(130.412,5.0093364715576,99.468)},
        [3]={Vector3.new(170.412,5.0093364715576,99.468),Vector3.new(150.995,5.0093364715576,99.468),Vector3.new(130.412,5.0093364715576,99.468)},
        [4]={Vector3.new(170.412,5.0093364715576,105.468),Vector3.new(170.412,5.0093364715576,95.468),Vector3.new(130.412,5.0093364715576,105.468),Vector3.new(130.412,5.0093364715576,95.468)}
    },
    ["Clover Field"] = {
        [1]={Vector3.new(158.943,34.509334564209,195.189)},
        [2]={Vector3.new(175.507,34.509334564209,208.270),Vector3.new(145.916,34.509334564209,178.618)},
        [3]={Vector3.new(175.507,34.509334564209,208.270),Vector3.new(158.943,34.509334564209,195.189),Vector3.new(145.916,34.509334564209,178.618)},
        [4]={Vector3.new(175.507,34.509334564209,208.270),Vector3.new(145.916,34.509334564209,208.270),Vector3.new(145.916,34.509334564209,178.618),Vector3.new(175.507,34.509334564209,178.618)}
    },
    ["StrawBerry"] = {
        [1]={Vector3.new(-178.206,21.009336471558,-13.598)},
        [2]={Vector3.new(-189.358,21.009336471558,-1.147),Vector3.new(-167.821,21.009336471558,-26.708)},
        [3]={Vector3.new(-189.358,21.009336471558,-1.147),Vector3.new(-178.206,21.009336471558,-13.598),Vector3.new(-167.821,21.009336471558,-26.708)},
        [4]={Vector3.new(-189.358,21.009336471558,-1.147),Vector3.new(-167.821,21.009336471558,-1.147),Vector3.new(-167.821,21.009336471558,-26.708),Vector3.new(-189.358,21.009336471558,-26.708)}
    },
    ["Spider Field"] = {
        [1]={Vector3.new(-43.800,21.009336471558,-6.994)},
        [2]={Vector3.new(-53.800,21.009336471558,-6.994),Vector3.new(-33.800,21.009336471558,-6.994)},
        [3]={Vector3.new(-53.800,21.009336471558,-6.994),Vector3.new(-43.800,21.009336471558,-6.994),Vector3.new(-33.800,21.009336471558,-6.994)},
        [4]={Vector3.new(-53.800,21.009336471558,-6.994),Vector3.new(-53.800,21.009336471558,-1.994),Vector3.new(-33.800,21.009336471558,-1.994),Vector3.new(-33.800,21.009336471558,-6.994)}
    },
    ["BamBoo"] = {
        [1]={Vector3.new(131.760,21.009334671558,-30.120)},
        [2]={Vector3.new(146.760,21.009334671558,-30.120),Vector3.new(116.760,21.009334671558,-30.120)},
        [3]={Vector3.new(146.760,21.009334671558,-30.120),Vector3.new(131.760,21.009334671558,-30.120),Vector3.new(116.760,21.009334671558,-30.120)},
        [4]={Vector3.new(146.760,21.009334671558,-25.120),Vector3.new(146.760,21.009334671558,-35.120),Vector3.new(116.760,21.009334671558,-35.120),Vector3.new(116.760,21.009334671558,-25.120)}
    },
    ["Pineapple"] = {
        [1]={Vector3.new(258.125,69.009338378906,-211.188)},
        [2]={Vector3.new(243.125,69.009338378906,-211.188),Vector3.new(273.125,69.009338378906,-211.188)},
        [3]={Vector3.new(243.125,69.009338378906,-211.188),Vector3.new(258.125,69.009338378906,-211.188),Vector3.new(273.125,69.009338378906,-211.188)},
        [4]={Vector3.new(243.125,69.009338378906,-206.188),Vector3.new(243.125,69.009338378906,-216.188),Vector3.new(273.125,69.009338378906,-216.188),Vector3.new(273.125,69.009338378906,-206.188)}
    },
    ["Pine Tree"] = {
        [1]={Vector3.new(-324.287,69.009338378906,-188.760)},
        [2]={Vector3.new(-324.287,69.009338378906,-198.760),Vector3.new(-324.287,69.009338378906,-178.760)},
        [3]={Vector3.new(-324.287,69.009338378906,-198.760),Vector3.new(-324.287,69.009338378906,-188.760),Vector3.new(-324.287,69.009338378906,-178.760)},
        [4]={Vector3.new(-319.287,69.009338378906,-198.760),Vector3.new(-329.287,69.009338378906,-198.760),Vector3.new(-329.287,69.009338378906,-178.760),Vector3.new(-319.287,69.009338378906,-178.760)}
    },
    ["Red Rose"] = {
        [1]={Vector3.new(-325.370,20.95934677124,126.475)},
        [2]={Vector3.new(-335.370,20.95934677124,126.475),Vector3.new(-315.370,20.95934677124,126.475)},
        [3]={Vector3.new(-335.370,20.95934677124,126.475),Vector3.new(-325.370,20.95934677124,126.475),Vector3.new(-315.370,20.95934677124,126.475)},
        [4]={Vector3.new(-335.370,20.95934677124,121.475),Vector3.new(-335.370,20.95934677124,131.475),Vector3.new(-315.370,20.95934677124,131.475),Vector3.new(-315.370,20.95934677124,121.475)}
    },
    ["Cactus"] = {
        [1]={Vector3.new(-193.797,69.009338378906,-104.870)},
        [2]={Vector3.new(-183.797,69.009338378906,-104.870),Vector3.new(-203.797,69.009338378906,-104.870)},
        [3]={Vector3.new(-183.797,69.009338378906,-104.870),Vector3.new(-193.797,69.009338378906,-104.870),Vector3.new(-203.797,69.009338378906,-104.870)},
        [4]={Vector3.new(-183.797,69.009338378906,-99.870),Vector3.new(-183.797,69.009338378906,-109.870),Vector3.new(-203.797,69.009338378906,-109.870),Vector3.new(-203.797,69.009338378906,-99.870)}
    },
    ["Pumpkin"] = {
        [1]={Vector3.new(-188.810,69.009338378906,-186.916)},
        [2]={Vector3.new(-178.810,69.009338378906,-186.916),Vector3.new(-198.810,69.009338378906,-186.916)},
        [3]={Vector3.new(-178.810,69.009338378906,-186.916),Vector3.new(-188.810,69.009338378906,-186.916),Vector3.new(-198.810,69.009338378906,-186.916)},
        [4]={Vector3.new(-178.810,69.009338378906,-181.916),Vector3.new(-178.810,69.009338378906,-191.916),Vector3.new(-198.810,69.009338378906,-191.916),Vector3.new(-198.810,69.009338378906,-181.916)}
    },
    ["Mountain"] = {
        [1]={Vector3.new(76.272,177.00933837891,-166.929)},
        [2]={Vector3.new(67.774,177.00933837891,-154.932),Vector3.new(90.066,177.00933837891,-180.591)},
        [3]={Vector3.new(67.774,177.00933837891,-154.932),Vector3.new(76.272,177.00933837891,-166.929),Vector3.new(90.066,177.00933837891,-180.591)},
        [4]={Vector3.new(67.774,177.00933837891,-154.932),Vector3.new(90.066,177.00933837891,-154.932),Vector3.new(67.774,177.00933837891,-180.591),Vector3.new(90.066,177.00933837891,-180.591)}
    },
    ["Snails"] = {
        [1]={Vector3.new(426.407,96.988090515137,-177.230)},
        [2]={Vector3.new(426.407,96.988090515137,-167.230),Vector3.new(426.407,96.988090515137,-187.230)},
        [3]={Vector3.new(426.407,96.988090515137,-167.230),Vector3.new(426.407,96.988090515137,-177.230),Vector3.new(426.407,96.988090515137,-187.230)},
        [4]={Vector3.new(436.407,96.988090515137,-167.230),Vector3.new(416.407,96.988090515137,-167.230),Vector3.new(436.407,96.988090515137,-187.230),Vector3.new(416.407,96.988090515137,-187.230)}
    },
    ["Coconut"] = {
        [1]={Vector3.new(-260.569,72.459342956543,465.669)},
        [2]={Vector3.new(-250.569,72.459342956543,465.669),Vector3.new(-270.569,72.459342956543,465.669)},
        [3]={Vector3.new(-250.569,72.459342956543,465.669),Vector3.new(-260.569,72.459342956543,465.669),Vector3.new(-270.569,72.459342956543,465.669)},
        [4]={Vector3.new(-250.569,72.459342956543,460.669),Vector3.new(-250.569,72.459342956543,470.669),Vector3.new(-270.569,72.459342956543,470.669),Vector3.new(-270.569,72.459342956543,460.669)}
    },
    ["Pepper"]={
        [1]={Vector3.new(-481.238,124.21085357666,518.388)},
        [2]={Vector3.new(-489.537,124.21085357666,502.811),Vector3.new(-475.687,124.21085357666,535.584)},
        [3]={Vector3.new(-489.537,124.21085357666,502.811),Vector3.new(-481.238,124.21085357666,518.388),Vector3.new(-475.687,124.21085357666,535.584)},
        [4]={Vector3.new(-489.537,124.21085357666,502.811),Vector3.new(-489.537,124.21085357666,535.584),Vector3.new(-475.687,124.21085357666,535.584),Vector3.new(-475.687,124.21085357666,502.811)}
    }
}
local fieldName={
    ["Sunflower"] = "Sunflower Field",
    ["Dandelion"] = "Dandelion Field",
    ["Mushroom"] = "Mushroom Field",
    ["Blue Flower"] = "Blue Flower Field",
    ["Clover Field"] = "Clover Field",
    ["StrawBerry"] = "Strawberry Field",
    ["Spider Field"] = "Spider Field",
    ["BamBoo"] = "Bamboo Field",
    ["Pineapple"] = "Pineapple Patch",
    ["Pine Tree"] = "Pine Tree Forest",
    ["Red Rose"] = "Rose Field",
    ["Cactus"] = "Cactus Field",
    ["Pumpkin"] = "Pumpkin Patch",
    ["Mountain"] = "Mountain Top Field",
    ["Snails"] = "Stump Field",
    ["Coconut"] = "Coconut Field",
    ["Pepper"]="Pepper Patch"
}

local safePos = {Vector3.new(21,175,-103),Vector3.new(-76,4,170),Vector3.new(97,22,159),Vector3.new(64,19,15),
                Vector3.new(319,71,-128),Vector3.new(-138,19,48),Vector3.new(-262,67,-154),Vector3.new(-263,19,162),
                Vector3.new(-322,82,441),Vector3.new(-474,139,458)}
local namePos = {"Sunflower","Dandelion","Mushroom","Blue Flower","Clover Field","StrawBerry","Spider Field",
                "BamBoo","Pineapple","Pine Tree","Red Rose","Cactus","Pumpkin","Mountain","Snails","Coconut","Pepper"}
local vecPos = {Vector3.new(-211,5,185),Vector3.new(-39,5,220),Vector3.new(-93,5,117),Vector3.new(142,5,99),Vector3.new(152,34,192),
            Vector3.new(-176,21,-11),Vector3.new(-46,21,7),Vector3.new(120,21,-28),Vector3.new(252,69,-209),Vector3.new(-324,69,-184),
            Vector3.new(-330,21,126),Vector3.new(-195,69,-101),Vector3.new(-201,69,-182),Vector3.new(82,177,-167), Vector3.new(426,97,-176),
            Vector3.new(-265,72,471), Vector3.new(-478,124,520)}
local NpcShop ={
    ["Spawn"]=Vector3.new(-112.38806152344,5.0107364654541,299.43991088867),

    ["Noob Shop"]=Vector3.new(86.151268005371,4.9883108139038,292.70559692383),
    ["Pro Shop"]=Vector3.new(162.36358642578,69.474014282227,-167.28425597145),
    ["Planter Shop"]=Vector3.new(540.6,138.8,-322),
    ["BuckoBee Shop"]=Vector3.new(279.6162109175,4.5740194320679,92.537857055664),
    ["RileyBee Shop"]=Vector3.new(-321.95462036133,20.684385299683,216.20065307617),
    ["Top Shop"]=Vector3.new(-18.051517486572,176.47401428223,-157.97866821289),
    ["Petal Shop"]=Vector3.new(-499.90594482422,52.044067382813,461.19171142578),
    ["Coconut Shop"]=Vector3.new(-157.6414185703,71.92399597168,496.07672119141),
    ["Ticket Shop"]=Vector3.new(-233.27253723145,18.112655639648,394.63687133789),
    ["Boost Market"]=Vector3.new(172.38362121582,176.12022399902,-291.98254394531),
    ["Sprinkler Shop"]=Vector3.new(-388.68353271484,69.862831115723,0.5359275331268),
    ["HoneyMask Shop"]=Vector3.new(-474.07424926758,69.862815856934,0.4805856347084),
    ["Gummy Shop"]=Vector3.new(267.31390380859,25266.404296875,-769.20520019531),
    ["Diamond Mask"]=Vector3.new(-338.489,133.33815002441,-390.359),
    ["Demon Mask"]=Vector3.new(295.061,27.947402954102,273.018),

    ["HoneyStorm"]=Vector3.new(238.36628723145,34.400466918945,165.52825927734),
    ["Ant Challenge"]=Vector3.new(90.461868286133,33.980560302734,499.64270019531),
    ["King Beetle"]=Vector3.new(187.7048034668,5.1093425750732,183.22807312012),
    ["Tunnel Bear"]=Vector3.new(281.80355834961,7.3451633453369,-39.458263397217),
    ["Commando Chick"]=Vector3.new(533.53381347656,47.544235229492,164.14442443848),

    ["Black Bear"]=Vector3.new(-257.27612304688,5.4990787506104,298.38717651367),
    ["Mother Bear"]=Vector3.new(-179.81562805176,5.6392560005188,89.567375183105),
    ["Brown Bear"]=Vector3.new(279.70153808594,46.117855072021,236.66903686523),
    ["Stick Bug"]=Vector3.new(-128.3441619873,50.069065093994,148.94953918457),
    ["Panda Bear"]=Vector3.new(101.68869018555,35.85717010498,47.335586547852),
    ["Science Bear"]=Vector3.new(267.41567993164,103.14083862305,19.857267379761),
    ["Polar Bear"]=Vector3.new(-107.82255554199,119.54635620117,-75.816192626953),
    ["RileyBee"]=Vector3.new(-359.17672729492,73.748970031738,209.70021057129),
    ["BuckoBee"]=Vector3.new(304.18856811523,61.929039001465,105.76292419434),
    ["HoneyBee"]=Vector3.new(-3918053894043,89.77214050293,-227.4983215332),
    ["Spirit Bear"]=Vector3.new(-365.66036987305,98.377197265625,477.65615844727),
    ["Dapper Bear"]=Vector3.new(551.9,143,-363.4),
    ["Onett"]=Vector3.new(-10.150609016418,232.78939819336,-516.97375488281),
    ["Bubble Bee"]=Vector3.new(90.981,312.19345041016,-277.313)
}
local EventPos={
    ["Honey Wreath"]=Vector3.new(-281.724487, 19.153322219849, 344.882782),
    ["Gringerbread House"]=Vector3.new(-205.300598, 6.0833115577698, 93.6090851),
    ["Honeydays Candle"]=Vector3.new(-374.069397, 47.693309783936, 280.252197),
    ["Stocking"]=Vector3.new(235.246811, 35.602855682373, 232.883942),
    ["Beesmas Feast"]=Vector3.new(-106.040604, 126.202087, -113.750931),
    ["Snowbear boss"]=Vector3.new(43.179821, 21.633310317993, 35.2696381),
    ["Snow Machine"]=Vector3.new(277.956085, 93.840469360352, 103.317726),
    ["Onett's Lid Art"]=Vector3.new(34.1292305, 235.94728088379, -512.368103),

    ["Giftbox 3"]=Vector3.new(34.64525604248,5.3106245994568,93.098258972168),
    ["Giftbox 4"]=Vector3.new(-277.1584777832,17.868772506714,383.50106811523),
    ["Giftbox 5"]=Vector3.new(187.63641357422,21.230619430542,39.606861114502),
    ["Giftbox 6"]=Vector3.new(-500.3779296875,90.488388061523,-202.04595947266),
    ["Giftbox 7"]=Vector3.new(-55.58451461792,41.493618011475,715.09509277344),
    ["Giftbox 8"]=Vector3.new(282.40438842773,168.1905369902,-228.83505249023),
    ["Giftbox 9"]=Vector3.new(-405.34561157227,92.42057800293,342.11932373047),
    ["Giftbox 10"]=Vector3.new(-1.0014477968216,33.420475006104,436.92559814453),
    ["Giftbox 11"]= Vector3.new(438.408508, 82.6049789, -528.203064),
    ["Giftbox 12"]=Vector3.new(-19.854454, 232.157254, -121.191879)
}
-- Quest List --
local questBadge = {"Pepper","Coconut","Playtime","Honey","Quest","Battle","Ability","Goo","Sunflower","Dandelion","Mushroom","Blue Flower",
            "Clover","Spider","Bamboo","Strawberry","Pineapple","Pumpkin","Cactus","Rose","Pine Tree","Stump"}
local questToy = {"Glue Dispenser","Free Royal Jelly Dispenser","Blueberry Dispenser","Strawberry Dispenser","Treat Dispenser","Wealth Clock"}
local questPool ={"Brown Bear","Polar Bear","Honey Bee","Black Bear","Bucko Bee","Riley Bee"}
local questNormal ={"Treat Tutorial","Bonding With Bees","Search For A Sunflower Seed","The Gist Of Jellies","Search For Strawberries",
            "Binging On Blueberries","Royal Jelly Jamboree","Search For Sunflower Seeds","Picking Out Pineapples","Seven To Seven",
            "Mother Bears Midterm","Eight To Eight","Sights On The Stars","The Family Final","Preliminary Research","Biology Study",
            "Proving The Hypothesis","Bear Botany","Kingdom Collection","Defensive Adaptions","Benefits Of Technology","Spider Study",
            "Roses And Weeds","Blue Review","Ongoing Progress","Red / Blue Duality","Costs Of Computation","Pollination Practice",
            "Optimizing Abilities","Ready For Infrared","Breaking Down Badges","Subsidized Agriculture","Meticulously Crafted",
            "Smart, Not Hard","Limits of Language","Patterns and Probability","Chemical Analysis","Mark Mechanics","Meditating On Phenomenon",
            "Beesperanto","Hive Minded Bias","Mushroom Measurement Monotony","The Power Of Information","Testing Teamwork",
            "Epistemological Endeavor","Egg Hunt: Panda Bear","Lesson On Ladybugs","Rhino Rumble","Beetle Battle","Spider Slayer",
            "Ladybug Bonker","Spider Slayer 2","Rhino Wrecking","Final Showdown","Werewolf Hunter","Skirmish with Scorpions","Mantis Massacre",
            "The REAL Final Showdown","Ant Arrival","Winged Wack Attack","Fire Fighter","Army Ant Assault","Colossal Combat",
            "Eager Exterminator","Leaper Lickin'","Colossal Combat 2","Outrageous Onslaught","Royal Rumble","Ultimate Ant Annihilation 1",
            "Ultimate Ant Annihilation 2","Ultimate Ant Annihilation 3","Ultimate Ant Annihilation 4","Ultimate Ant Annihilation 5",
            "Star Journey 1","Star Journey 2","Star Journey 3","Star Journey 4","Star Journey 5","Egg Hunt: Riley Bee","Egg Hunt: Bucko Bee",
            "Sunflower Start","Dandelion Deed","Pollen Fetcher","Red Request","Into The Blue","Variety Fetcher","Bamboo Boogie","Red Request 2",
            "Cobweb Sweeper","Leisure Loot","White Pollen Wrangler","Pineapple Picking","Pollen Fetcher 2","Weed Wacker","Red + Blue = Gold",
            "Colorless Collection","Spirit of Springtime","Weed Wacker 2","Pollen Fetcher 3","Lucky Landscaping","Azure Adventure",
            "Pink Pineapples","Blue Mushrooms","Cobweb Sweeper 2","Rojo-A-Go-Go","Pumpkin Plower","Pollen Fetcher 4","Bouncing Around Biomes",
            "Blue Pineapples","Rose Request","Search For The White Clover","Stomping Grounds","Collecting Cliffside","Mountain Meandering",
            "Quest Of Legends","High Altitude","Blissfully Blue","Rouge Round-up","White As Snow","Solo On The Stump","Colorful Craving",
            "Pumpkins, Please!","Smorgasbord","Pollen Fetcher 5","White Clover Redux","Strawberry Field Forever","Tasting The Sky",
            "Whispy and Crispy","Walk Through The Woods","Get Red-y","One Stop On The Tip Top","Blue Mushrooms 2","Pretty Pumpkins",
            "Black Bear, Why?","Bee A Star","Spirit's Starter","The First Offering","Rules of The Road","QR Quest","Pleasant Pastimes",
            "Nature's Lessons","The Gifts Of Life","Out-Questing Questions","Forcefully Friendly","Sway Away","Memories of Memories",
            "Beans Becoming","Do You Bee-lieve In Magic?","The Ways Of The Winds / The Wind And Its Way","Beauty Duty","Witness Grandeur",
            "Beeternity","A Breath Of Blue","Glory Of Goo","Tickle The Wind","Rhubarb That Could Have Been","Dreams Of Being A Bee",
            "The Sky Over The Stump","Space Oblivion","Pollenpalooza","Dancing With Stick Bug","Bean Bug Busser",
            "Bombs, Blueberries, and Bean Bugs","Bean Bugs And Boosts","Make It Hasty","Total Focus","On Your Marks","Look In The Leaves",
            "What About Sprouts","Bean Bug Beatdown","Bear Without Despair","Spirit Spree","Echoing Call","Spring Out Of The Mountain",
            "Riley Bee: Goo","Riley Bee: Medley","Riley Bee: Mushrooms","Riley Bee: Picnic","Riley Bee: Pollen","Riley Bee: Rampage",
            "Riley Bee: Roses","Riley Bee: Scavenge","Riley Bee: Skirmish","Riley Bee: Strawberries","Riley Bee: Tango","Riley Bee: Tour",
            "Riley Bee: Tour"}
-- Auto Dispenser --
local listDispenser = {"Glue Dispenser","Wealth Clock","Coconut Dispenser","Strawberry Dispenser","Treat Dispenser","Free Ant Pass Dispenser",
            "Blueberry Dispenser","Honey Dispenser","Free Royal Jelly Dispenser","Gingerbread House"}
-- Auto Speed --
local hSpeed = false
local oldSpeed = 0
local newSpeed = 0
-- Auto Jump --
local hJump = false
local oldJump = 0
local newJump = 0
-- Auto Farm --
local hFarm = false
local hSelling = false
-- Vicious --
local hVicious = false
local mVicious = false
local hKillVic = false
-- Sprout --
local hSprout = false
local mSprout = false
-- Windy --
local hWindy = false
local mWindy = false
local hKillWindy = false
-- Auto kill --
local hKillMod = false
local hKillSpr = false

local hBuildSprikler = true
local hModFarm = false
local hSafe = false
local tempSafe = false
local noclip = false
local hTest = false
local hToken= false
local hWaitingDisk = false
local h15Colect = false
local hWalk = false
local hWalking = false
--==========================================--
--           FUNCTION GLOBAL                --
--==========================================--
game:service'Players'.LocalPlayer.Idled:connect(function()
	vUser:CaptureController()
	vUser:ClickButton2(Vector2.new())
end)

game:GetService('RunService').Stepped:connect(function()
    if noclip then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    end
end)

function setColor(txt, clor)
    txt.TextColor3 = Color3.fromRGB(14,14,14)
    if clor==10 then
        txt.BackgroundTransparency = 1
        txt.BorderSizePixel = 0
    else
        txt.BackgroundTransparency = 0
        txt.BorderSizePixel = 1
        if clor == 0 then
            txt.BackgroundColor3 = Color3.fromRGB(100,150,250)
            txt.BorderColor3 = Color3.fromRGB(30,90,200)
        elseif clor == 1 then
            txt.BackgroundColor3 = Color3.fromRGB(255, 153, 153)
            txt.BorderColor3 = Color3.fromRGB(194, 89, 89)
        elseif clor == 2 then
            txt.BackgroundColor3 = Color3.fromRGB(135, 255, 243)
            txt.BorderColor3 = Color3.fromRGB(70, 189, 177)
        end
    end
end

function setFont(txt, tsize)
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = tsize
end

function setLocation(txt,left,right,width,height)
    txt.Position = UDim2.new(0,left,0,right)
    txt.Size = UDim2.new(0,width,0,height)
end
--==========================================--
--           USER INTERFACE                 --
--==========================================--
local testBar = Instance.new("Frame",mGui)
local testLabel1 = Instance.new("TextLabel",testBar)
local testLabel2 = Instance.new("TextLabel",testBar)
local testLabel3 = Instance.new("TextLabel",testBar)
local testLabel4 = Instance.new("TextLabel",testBar)
local testbutton = Instance.new("TextButton",testBar)
local testclose = Instance.new("TextButton",testBar)

local miniBar = Instance.new("Frame", mGui)
local miniClose = Instance.new("TextButton",miniBar)
local miniSpeed = Instance.new("TextButton", miniBar)
local miniJump = Instance.new("TextButton",miniBar)
local miniTele = Instance.new("TextButton",miniBar)
local miniFarm = Instance.new("TextButton",miniBar)
local miniMobs = Instance.new("TextButton",miniBar)
local miniLabel = Instance.new("TextLabel",miniBar)

local npcZone = Instance.new("Frame",miniBar)
local npctitle = Instance.new("TextLabel",npcZone)

local fieldBSp = Instance.new("Frame",miniBar)
local BSpTitle =Instance.new("TextLabel",fieldBSp)
local BSpcmd = Instance.new("TextButton",fieldBSp)
local BSpLabel =Instance.new("TextLabel",fieldBSp)
local BSpNum = Instance.new("TextBox",fieldBSp)
local BSpFalling = Instance.new("TextButton",fieldBSp)
local BSpLook = Instance.new("TextButton",fieldBSp)
local BSpMicro = Instance.new("TextButton",fieldBSp)

local fieldZone = Instance.new("Frame",miniBar)
local fieldtitle = Instance.new("TextLabel",fieldZone)

local shopZone = Instance.new("Frame",miniBar)
local shoptitle = Instance.new("TextLabel", shopZone)
local shopso1 = Instance.new("TextButton",shopZone)

local eventZone=Instance.new("Frame",miniBar)
local eventTitle=Instance.new("TextLabel",eventZone)

local miscZone = Instance.new("Frame", miniBar)
local misctitle = Instance.new("TextLabel", miscZone)
local miscboard = Instance.new("TextButton",miscZone)
local miscmobs = Instance.new("TextButton",miscZone)
local miscso1 = Instance.new("TextButton",miscZone)
local miscso2 = Instance.new("TextButton",miscZone)
local miscso3 = Instance.new("TextButton",miscZone)
local miscso4 = Instance.new("TextButton",miscZone)
local miscso5 = Instance.new("TextButton",miscZone)
local miscso6 = Instance.new("TextButton",miscZone)
local miscso7 = Instance.new("TextButton",miscZone)
local miscso8 = Instance.new("TextButton",miscZone)
local miscso9 = Instance.new("TextButton",miscZone)

local boardZone = Instance.new("Frame",miscZone)
local boardtitle = Instance.new("TextLabel",boardZone)
local boardtp = Instance.new("TextLabel",boardZone)
local boardth = Instance.new("TextLabel",boardZone)
local boardtz = Instance.new("TextLabel",boardZone)
local boardp1 = Instance.new("TextLabel",boardZone)
local boardh1 = Instance.new("TextLabel",boardZone)
local boardz1 = Instance.new("TextLabel",boardZone)
local boardp2 = Instance.new("TextLabel",boardZone)
local boardh2 = Instance.new("TextLabel",boardZone)
local boardz2 = Instance.new("TextLabel",boardZone)
local boardp3 = Instance.new("TextLabel",boardZone)
local boardh3 = Instance.new("TextLabel",boardZone)
local boardz3 = Instance.new("TextLabel",boardZone)
local boardp4 = Instance.new("TextLabel",boardZone)
local boardh4 = Instance.new("TextLabel",boardZone)
local boardz4 = Instance.new("TextLabel",boardZone)
local boardp5 = Instance.new("TextLabel",boardZone)
local boardh5 = Instance.new("TextLabel",boardZone)
local boardz5 = Instance.new("TextLabel",boardZone)
local boardp6 = Instance.new("TextLabel",boardZone)
local boardh6 = Instance.new("TextLabel",boardZone)
local boardz6 = Instance.new("TextLabel",boardZone)

local mobsZone = Instance.new("Frame",miscZone)
local mobsTitle = Instance.new("TextLabel",mobsZone)
local mobsso1 = Instance.new("TextLabel",mobsZone)
local mobsso2 = Instance.new("TextLabel",mobsZone)
local mobsso3 = Instance.new("TextLabel",mobsZone)
local mobsso4 = Instance.new("TextLabel",mobsZone)
local mobsso5 = Instance.new("TextLabel",mobsZone)
local mobsso6 = Instance.new("TextLabel",mobsZone)
local mobsso7 = Instance.new("TextLabel",mobsZone)
local mobsso8 = Instance.new("TextLabel",mobsZone)
local mobsso9 = Instance.new("TextLabel",mobsZone)
local mobsso10 = Instance.new("TextLabel",mobsZone)
local mobsso11 = Instance.new("TextLabel",mobsZone)
local mobsso12 = Instance.new("TextLabel",mobsZone)
local mobsso13 = Instance.new("TextLabel",mobsZone)
local mobsso14 = Instance.new("TextLabel",mobsZone)
local mobsso15 = Instance.new("TextLabel",mobsZone)
local mobsso16 = Instance.new("TextLabel",mobsZone)
local mobsso17 = Instance.new("TextLabel",mobsZone)
local mobsso18 = Instance.new("TextLabel",mobsZone)
local mobsso19 = Instance.new("TextLabel",mobsZone)
local mobsso20 = Instance.new("TextLabel",mobsZone)
local mobsso21 = Instance.new("TextLabel",mobsZone)

local noticeZone = Instance.new("Frame", mGui)
local noticeVicious = Instance.new("Frame",noticeZone)
local vicLabel = Instance.new("TextLabel",noticeVicious)
local vicTele = Instance.new("TextButton",noticeVicious)
local vicKill = Instance.new("TextButton",noticeVicious)
local vicCancel = Instance.new("TextButton",noticeVicious)
local noticeSprout = Instance.new("Frame",noticeZone)
local sprLabel = Instance.new("TextLabel",noticeSprout)
local sprTele = Instance.new("TextButton",noticeSprout)
local sprKill = Instance.new("TextButton",noticeSprout)
local sprCancel = Instance.new("TextButton",noticeSprout)
local noticeWindy = Instance.new("Frame",noticeZone)
local windyLabel = Instance.new("TextLabel",noticeWindy)
local windyTele = Instance.new("TextButton",noticeWindy)
local windyKill = Instance.new("TextButton",noticeWindy)
local windyCancel = Instance.new("TextButton",noticeWindy)

local mesZone = Instance.new("Frame",mGui)
local mesTitle = Instance.new("TextLabel",mesZone)
local mesText = Instance.new("TextLabel",mesZone)
local mesOK = Instance.new("TextButton",mesZone)
local mesCancel = Instance.new("TextButton",mesZone)

----------- TEST BAR -------------
testBar.BackgroundColor3 = Color3.fromRGB(255,255,255)
testBar.BorderColor3 = Color3.fromRGB(5,5,5)
setLocation(testBar,0,0,150,10+5*20)
testBar.Active = true
testBar.Draggable = true
testBar.ClipsDescendants = false
function setupTEST(txt,rw,vname)
    txt.Text = vname
    setFont(txt,10) 
    setColor(txt,2)
    setLocation(txt,5,5+20*rw,140,20)
end
setupTEST(testLabel1,0," ")
setupTEST(testLabel2,1," ")
setupTEST(testLabel3,2," ")
setupTEST(testLabel4,3," ")
setupTEST(testbutton,4,"Test")
setColor(testbutton,0)

testclose.Text = "X"
setFont(testclose,10)
setColor(testclose,1)
setLocation(testclose,testBar.Size.Width.Offset-10,0,10,10)
testclose.MouseButton1Click:Connect(function()
    testBar.Visible = false
end)

-------- MINI BAR ---------------
miniBar.BackgroundTransparency= 0
miniBar.BorderSizePixel = 1
miniBar.BackgroundColor3 = Color3.fromRGB(255,255,255)
miniBar.BorderColor3 = Color3.fromRGB(5,5,5)
setLocation(miniBar,110,-30,270,30)
miniBar.Active = true
miniBar.Draggable = true
miniBar.ClipsDescendants = false

setLocation(miniClose,miniBar.Size.Width.Offset-30,0,30,30)
setFont(miniClose,12)
setColor(miniClose,1)
miniClose.Text = "X"

setLocation(miniSpeed,0,0,60,15)
setFont(miniSpeed,10)
setColor(miniSpeed,0)
miniSpeed.Text = "Speed: 0"
setLocation(miniJump,0,15,60,15)
setFont(miniJump,10)
setColor(miniJump,0)
miniJump.Text = "Jump: 0"

setLocation(miniTele,65,5,50,20)
setFont(miniTele,10)
setColor(miniTele,0)
miniTele.Text = "Teleport"

miniFarm.Text = "Farm"
setLocation(miniFarm,115,5,50,20)
setFont(miniFarm,10)
setColor(miniFarm,0)

miniMobs.Text = "Misc."
setLocation(miniMobs,165,5,50,20)
setFont(miniMobs,10)
setColor(miniMobs,0)

miniLabel.Text = "Teleport me to:"
setLocation(miniLabel,0,35,270,25)
setFont(miniLabel,15)
miniLabel.BackgroundColor3 = Color3.fromRGB(255,255,255)
miniLabel.BorderColor3 = Color3.fromRGB(5,5,5)
miniLabel.TextColor3 = Color3.fromRGB(5,4,4)
miniLabel.Visible = false

------------- NPC ----------------
npcZone.BackgroundColor3 = Color3.fromRGB(255,255,255)
npcZone.BorderColor3 = Color3.fromRGB(5,5,5)
setLocation(npcZone,0,60,90,10+20*14)
npcZone.Active = true
npcZone.Draggable = false
npcZone.Visible = false
npcZone.ClipsDescendants = false

setLocation(npctitle,0,5,90,20)
setFont(npctitle,12)
npctitle.BorderSizePixel = 0
npctitle.BackgroundTransparency = 1
npctitle.Text = "NPC"
npctitle.TextColor3 = Color3.fromRGB(5,5,5)

------------- Field -------------
fieldZone.BackgroundColor3= Color3.fromRGB(255,255,255)
fieldZone.BorderColor3 = Color3.fromRGB(5,5,5)
setLocation(fieldZone,90,60,90,10+20*18)
fieldZone.Active = true
fieldZone.Draggable = false
fieldZone.Visible = false
fieldZone.ClipsDescendants = false

fieldtitle.Text = "Field"
fieldtitle.BorderSizePixel =0
fieldtitle.BackgroundTransparency = 1
fieldtitle.TextColor3 = Color3.fromRGB(5,5,5)
setLocation(fieldtitle,0,5,90,20)
setFont(fieldtitle,12)

-------------- Bild Sprinkler ------------
fieldBSp.BackgroundColor3 = Color3.fromRGB(255,255,255)
fieldBSp.BorderColor3 = Color3.fromRGB(5,5,5)
setLocation(fieldBSp,0,60,90,150)
fieldBSp.Active = true
fieldBSp.Draggable = false
fieldBSp.Visible = false
fieldBSp.ClipsDescendants = false

BSpTitle.Text = "Sprinkler"
setLocation(BSpTitle,0,5,90,20)
setFont(BSpTitle,10)
setColor(BSpTitle,10)

BSpcmd.Text = "Build Sprinkler"
setLocation(BSpcmd,5,25,80,20)
setFont(BSpcmd,10)
setColor(BSpcmd,2)

BSpLabel.Text = "Number:"
setLocation(BSpLabel,5,45,55,20)
setFont(BSpLabel,10)
setColor(BSpLabel,10)

BSpNum.Text = "1"
setLocation(BSpNum,60,45,20,20)
setFont(BSpNum,10)
BSpNum.TextColor3 = Color3.fromRGB(5,5,5)
BSpNum.BorderColor3 = Color3.fromRGB(5,5,5)
BSpNum.BackgroundColor3 = Color3.fromRGB(255,255,255)

BSpFalling.Text = "Catch Falling"
setLocation(BSpFalling,5,70,80,20)
setFont(BSpFalling,10)
setColor(BSpFalling,2)

BSpLook.Text = "Dont Move"
setLocation(BSpLook,5,95,80,20)
setFont(BSpLook,10)
setColor(BSpLook,1)

BSpMicro.Text = "Use Micro-Cver"
setLocation(BSpMicro,5,120,80,20)
setFont(BSpMicro,10)
setColor(BSpMicro,1)

--------------- Shop -------------
shopZone.BackgroundColor3 = Color3.fromRGB(255,255,255)
shopZone.BorderColor3 = Color3.fromRGB(5,5,5)
setLocation(shopZone,180,60,90,10+20*16)
shopZone.Active = true
shopZone.Draggable = false
shopZone.Visible = false
shopZone.ClipsDescendants = false

shoptitle.Text = "SHOP"
shoptitle.BorderSizePixel = 0
shoptitle.BackgroundTransparency = 1
shoptitle.TextColor3 = Color3.fromRGB(5,5,5)
setLocation(shoptitle,0,5,90,20)
setFont(shoptitle,12)

shopso1.Text = "Spawn"
setLocation(shopso1,5,25,80,20)
setFont(shopso1,10)
setColor(shopso1,0)

----------------Events -----------
eventZone.BackgroundColor3 = Color3.fromRGB(255,200,200)
eventZone.BorderColor3 = Color3.fromRGB(5,5,5)
setLocation(eventZone,270,60,110,10+20*20)
eventZone.Active = true
eventZone.Draggable = false
eventZone.Visible = false
eventZone.ClipsDescendants = false

eventTitle.Text = "EVENT"
eventTitle.BorderSizePixel = 0
eventTitle.BackgroundTransparency=1
eventTitle.TextColor3 = Color3.fromRGB(5,5,5)
setLocation(eventTitle,0,5,110,20)
setFont(eventTitle,12)


--------------- Misc ---------------
miscZone.BackgroundColor3 = Color3.fromRGB(255,255,255)
miscZone.BorderColor3 = Color3.fromRGB(5,5,5)
setLocation(miscZone,0,35,380,285)
miscZone.Active= true
miscZone.Visible = false
miscZone.Draggable = false
miscZone.ClipsDescendants = false

misctitle.Text = "Misc"
misctitle.BackgroundTransparency = 1
misctitle.BorderSizePixel =0
setLocation(misctitle,0,5,miscZone.Size.Width.Offset,20)
setFont(misctitle,12)
misctitle.TextColor3 = Color3.fromRGB(5,5,5)

--------------- Player Board -------------------
boardZone.BackgroundColor3 = Color3.fromRGB(255,255,255)
boardZone.BorderSizePixel = 0
setLocation(boardZone,0,120,380,140)
boardZone.Active = true
boardZone.Visible = true
boardZone.Draggable = false
boardZone.ClipsDescendants = false

boardtitle.Text = "Player Board"
boardtitle.BackgroundTransparency = 1
boardtitle.BorderSizePixel = 0
setLocation(boardtitle,0,0,boardZone.Size.Width.Offset,20)
setFont(boardtitle,12)
boardtitle.TextColor3 = Color3.fromRGB(5,5,5)

boardtp.Text = "Player Name"
setLocation(boardtp,5,20,125,20)
setFont(boardtp,10)
boardtp.TextColor3 = Color3.fromRGB(5,5,5)
boardtp.BackgroundColor3 = Color3.fromRGB(200,200,200)
boardtp.BorderColor3 = Color3.fromRGB(5,5,5)

boardth.Text = "Honey"
setLocation(boardth,130,20,125,20)
setFont(boardth,10)
boardth.TextColor3 = Color3.fromRGB(5,5,5)
boardth.BackgroundColor3 = Color3.fromRGB(200,200,200)
boardth.BorderColor3 = Color3.fromRGB(5,5,5)

boardtz.Text = "Position"
setLocation(boardtz,255,20,120,20)
setFont(boardtz,10)
boardtz.TextColor3 = Color3.fromRGB(5,5,5)
boardtz.BackgroundColor3 = Color3.fromRGB(200,200,200)
boardtz.BorderColor3 = Color3.fromRGB(5,5,5)

---------- Mobs Timer ----------
setLocation(mobsZone,0,120,380,140)
mobsZone.BorderSizePixel =0
mobsZone.BackgroundTransparency = 0
mobsZone.BackgroundColor3 = Color3.fromRGB(255,255,255)
mobsZone.Draggable = false
mobsZone.Active = true
mobsZone.Visible = false
mobsZone.ClipsDescendants = false

mobsTitle.Text = "--Mobs Timer--"
setLocation(mobsTitle,5,0,370,20)
setFont(mobsTitle,12)
mobsTitle.TextColor3 = Color3.fromRGB(5,5,5)
mobsTitle.BorderSizePixel = 0
mobsTitle.BackgroundTransparency = 1

----------- Notice ------------
setLocation(noticeZone,(workspace.Camera.ViewportSize.X-320)/2,35,320,35*3)
noticeZone.BorderSizePixel = 0
noticeZone.BackgroundTransparency = 1
noticeZone.Active = true
noticeZone.Draggable = false
noticeZone.Visible = false

----------- Message -----------
setLocation(mesZone,(workspace.Camera.ViewportSize.X-400)/2,35,400,150)
mesZone.BorderColor3 = Color3.fromRGB(200,200,200)
mesZone.BackgroundColor3 = Color3.fromRGB(255,255,255)
mesZone.Draggable = true
mesZone.Active = true
mesZone.Visible = false

mesTitle.Text = "PTNET Farm"
mesTitle.BorderSizePixel = 0
mesTitle.BackgroundTransparency = 1
setLocation(mesTitle,5,5,390,20)
setFont(mesTitle,12)
mesTitle.TextColor3 = Color3.fromRGB(15,54,117)
mesTitle.TextXAlignment = 0

mesText.Text = "This is a message!"
mesText.BorderSizePixel = 0
mesText.BackgroundTransparency = 1
setLocation(mesText,10,30,380,35)
setFont(mesText,10)
mesText.TextColor3 = Color3.fromRGB(5,5,5)
--mesText.TextWrapped = true

mesOK.Text = "OK"
setColor(mesOK,0)
setLocation(mesOK,230,70,80,25)
setFont(mesOK,10)

mesCancel.Text = "Cancel(5)"
setFont(mesCancel,10)
setColor(mesCancel,2)
setLocation(mesCancel,315,70,80,25)

--======================================--
--               SCRIPTS                --
--======================================--

function reBuildAll()
    mPlayer = game.Players.LocalPlayer
    mRoot = mPlayer.Character.HumanoidRootPart
end
game:service'Players'.LocalPlayer.Character.Humanoid.Died:connect(function()
    imdie = true
    hSpeed = false
    hJump = false
    setColor(miniSpeed,0)
    setColor(miniJump,0)
    miniSpeed.Text = "Speed: 0"
    miniJump.Text = "Jump: 0"
    wait(3)
    mPlayer = game.Players.LocalPlayer
    mRoot = mPlayer.Character:WaitForChild("HumanoidRootPart")
    mMouse = mPlayer:GetMouse()
    imdie = false
end)

function showMsg(tit,msg)
	game.StarterGui:SetCore('SendNotification', {
        Title = tit,
        Text = msg,
        Duration = 5
    })
end

function safeTele(toPos)
    local cur = safePos[1]
    local des = (toPos - cur).magnitude
    local nes
    for i=2,#safePos do
        nes = (toPos - safePos[i]).magnitude
        if nes < des then
            des = nes
            cur = safePos[i]
        end
    end
    mRoot.CFrame = CFrame.new(cur)
end

function isInZone(vpos)
    if vpos.X>-543 and vpos.X<596 then
        if vpos.Y>0 and vpos.Y<417 then
            if vpos.Z>-592 and vpos.Z<769 then
                return true
            end
        end
    end
    return false
end

function getNameZone(vpos,npc)
    --miniSpeed.Text = tostring(vpos)
    local curp =0
    local nearp =1000
    local curn = ""
    for i=1,#vecPos do
        curp = (vecPos[i]-vpos).magnitude
        if curp < nearp then
            nearp = curp
            curn = namePos[i]
        end
    end
    --miniSpeed.Text = curn
    if npc then
        for k,v in pairs(NpcShop) do
            curp = (v-vpos).magnitude
            if curp < nearp then
                nearp = curp
                curn = k
            end
        end
    end
    --if nearp > 200 then return false end -- qua' xa
    return curn
end

function collectTokenSlow()
    mRoot=mPlayer.Character.HumanoidRootPart
    hToken = true
    local nearme = false
    local cnear = 0
    local vpos = 0
    local tmove = 0
    local looptokenslow=coroutine.wrap(function()
        while hToken do
            vpos = false
            nearme = 60
            for _,v in pairs(workspace.Collectibles:GetChildren()) do
                if tostring(v)=="C" then
                    cnear = (v.Position-mRoot.Position).magnitude
                    if cnear <nearme then
                        nearme = cnear
                        vpos = v
                    end
                end
            end
            if vpos and nearme >3 then
                vpos.Name = "V"
                tmove = nearme/100
                tmove = moveMeTo(CFrame.new(vpos.Position.X,mRoot.Position.Y,vpos.Position.Z),tmove)
                tmove.Completed:wait()
            else
                wait(.1)
            end
        end
    end)
    looptokenslow()
end

miniClose.MouseButton1Click:Connect(function()
    hSpeed = false
    if hJump then
        mPlayer.Character.Humanoid.JumpPower = oldJump
    end
    hFarm = false
    miscZone.Visible = false
    hVicious= false
    hSprout =false
    hWindy=false
    hSafe = false
    noclip = false
    hTest = false
    hWalk = false
    hWalking = false
    fieldPos = nil
    fieldGo = nil
    fieldBack = nil
    fieldZone = nil
    fieldSpinkler2=nil
    fieldName = nil
    namePos = nil
    vecPos = nil
    NpcShop = nil
    EventPos = nil
    questBadge = nil
    questToy = nil
    questNormal = nil
    questPool = nil
    listDispenser = nil
    mGui:Remove()
    mMouse:Destroy()
end)

miniSpeed.MouseButton1Click:Connect(function()
    if miniSpeed.Text == "Speed: 0" then
        oldSpeed = mPlayer.Character.Humanoid.WalkSpeed
        newSpeed = 40
        hSpeed = true
        setColor(miniSpeed,2)
        miniSpeed.Text = "Speed: 1"
    elseif miniSpeed.Text == "Speed: 1" then
        newSpeed = 60
        miniSpeed.Text = "Speed: 2"
    elseif miniSpeed.Text == "Speed: 2" then
        newSpeed = 100
        miniSpeed.Text = "Speed: 3"
    elseif miniSpeed.Text == "Speed: 3" then
        newSpeed = 150
        miniSpeed.Text = "Speed: 4"
    else
        hSpeed = false
        mPlayer.Character.Humanoid.WalkSpeed = oldSpeed 
        setColor(miniSpeed,0)
        miniSpeed.Text = "Speed: 0"
    end
    while hSpeed do
        --miniJump.Text = "OK ".. mPlayer.Character.Humanoid.WalkSpeed .."|".. newSpeed
        if mPlayer.Character.Humanoid.WalkSpeed < newSpeed then mPlayer.Character.Humanoid.WalkSpeed = newSpeed end
        wait(.1)
    end
end)

miniJump.MouseButton1Click:Connect(function()
    if miniJump.Text == "Jump: 0" then
        oldJump = mPlayer.Character.Humanoid.JumpPower
        newJump = 100
        hJump = true
        if oldJump < 80 then oldJump = 80 end
        setColor(miniJump,2)
        miniJump.Text = "Jump: 1"
    elseif miniJump.Text == "Jump: 1" then
        newJump = 130
        miniJump.Text = "Jump: 2"
    elseif miniJump.Text == "Jump: 2" then
        newJump = 180
        miniJump.Text = "Jump: 3"
    else
        hJump = false
        mPlayer.Character.Humanoid.JumpPower = oldJump
        setColor(miniJump,0)
        miniJump.Text = "Jump: 0"
    end
    if hJump then
        mPlayer.Character.Humanoid.JumpPower = newJump
    end
end)

function inMyZone(toV,vmax,vmin)
    if vmax == false or vmin == false then return true end
    if (toV.X>=vmin.X and toV.x<=vmax.x) then
        if (toV.y>=vmin.y and toV.y<=vmax.y) then
            if toV.z>=vmin.z and toV.z<=vmax.z then return true end
        end
    end
    return false
end

function keepMeSafe()
    local vtarget = ""
    local oldpos = false
    local islife = false
    local vmax = false
    local vmin = false
    hSafe = true
    local loopkeepsafe=coroutine.wrap(function()
        reBuildAll()
        while hSafe do 
            for _,v in pairs(workspace.Monsters:GetChildren()) do
                if v.Target.Value==nil or tostring(v.Target.Value) == mPlayer.Name then
                    if string.find(v.Name,"Snail") then

                    elseif (v.PrimaryPart.Position - mRoot.Position).magnitude < 32 then
                        oldpos = mRoot.CFrame
                        islife = true
                        noclip= true
                        hKillMod = true
                        if string.find(v.Name,"Vicious") or string.find(v.Name,"Gifted") or string.find(v.Name,"Windy") then
                            if string.find(v.Name,"Vicious") then 
                                mRoot.CFrame = v.PrimaryPart.CFrame
                                wait(.1)
                            end
                            vtarget = getNameZone(v.PrimaryPart.Position,false)
                            vmax = fieldName[vtarget]
                            vmin = false
                            vtarget = workspace.FlowerZones:FindFirstChild(vmax)
                            if vtarget then
                                vmin = Vector3.new(vtarget.CFrame.x -1- vtarget.Size.x/2,vtarget.CFrame.Y-2,vtarget.CFrame.z -1- vtarget.Size.z/2)
                                vmax = Vector3.new(vtarget.CFrame.x +1+ vtarget.Size.x/2,vtarget.CFrame.Y+30,vtarget.CFrame.z +1+ vtarget.Size.z/2)
                            end
                            while hSafe and islife do
                                islife = false
                                vtarget = workspace.Monsters:FindFirstChild(v.Name)
                                if vtarget then
                                    if inMyZone(vtarget.PrimaryPart.Position,vmax,vmin) then
                                        islife = true
                                        mRoot.CFrame = CFrame.new(vtarget.PrimaryPart.Position) * CFrame.new(0,15,0)
                                    else
                                        break
                                    end
                                end
                                wait()
                            end
                        elseif string.find(v.Name, "Snow") then
                            local isball = false
                            while hSafe and islife do
                                islife = table.find(workspace.Monsters:GetChildren(),v)
                                isball = workspace.Particles:FindFirstChild("Snowball")
                                if isball then
                                    oldpos = mRoot.CFrame
                                    noclip = true
                                    while isball and hSafe do
                                        mRoot.CFrame = oldpos * CFrame.new(0,25,0)
                                        isball = workspace.Particles:FindFirstChild("Snowball")
                                        wait()
                                    end
                                    noclip = false
                                    mRoot.CFrame = oldpos
                                end
                                wait()
                            end
                        else
                            while hSafe and islife do
                                islife = false
                                for _,varv in pairs(workspace.Monsters:GetChildren()) do
                                    if varv == v then
                                        if (varv.PrimaryPart.Position - oldpos.Position).magnitude <32 then
                                            islife = true
                                            mRoot.CFrame = varv.PrimaryPart.CFrame * CFrame.new(0,20,0)
                                            break
                                        end
                                    end
                                end
                                wait()
                                if imdie then
                                    islife = false
                                end
                            end
                        end
                        noclip = false
                        --miniSpeed.Text = tostring(v)
                        hKillMod = false
                        mRoot.CFrame = oldpos
                        wait(.5)
                    end
                end
            end
            wait(.5)
        end
    end)
    loopkeepsafe()
end

--===============================--
--=========   Messager  =========--
--===============================--

function showMesg(tit,txt)
    local tcount = 5
    mesText.Text = txt
    mesTitle.Text = tit
    mesZone.Visible = true
    --mesZone.Position = UDim2.new(0,(workspace.Camera.ViewportSize.X-400)/2,0,35)
    setLocation(mesZone,(workspace.Camera.ViewportSize.X-400)/2,35,400,100)
    local loopdem = coroutine.wrap(function()
        while tcount > 0 and mesZone.Visible do
            mesCancel.Text = "Cancel (".. tcount ..")"
            tcount = tcount-1
            wait(1)
        end
        mesZone.Visible = false
    end)
    loopdem()
end

mesOK.MouseButton1Click:Connect(function()
    if todoMes ==0 then
        mesZone.Visible = false
        tempSafe = true
        hSafe = true
        setColor(miscso7,2)
        keepMeSafe()
    end
end)
mesCancel.MouseButton1Click:Connect(function()
    mesZone.Visible = false
end)

function nextPoint(toPos)
    if toPos.Position.X == mRoot.Position.X then
        if toPos.Position.Z > mRoot.Position.Z then
            return Vector3.new(toPos.Position.X,mRoot.Position.Y,toPos.Position.Z + 10)
        else
            return Vector3.new(toPos.Position.X,mRoot.Position.Y,toPos.Position.Z - 10)
        end
    elseif toPos.Position.Z == mRoot.Position.Z then
        if toPos.Position.X > mRoot.Position.X then
            return Vector3.new(toPos.Position.X + 10,mRoot.Position.Y,toPos.Position.Z)
        else
            return Vector3.new(toPos.Position.X - 10,mRoot.Position.Y,toPos.Position.Z)
        end
    else
        local varm = (toPos.Position.Z-mRoot.Position.Z)/(toPos.Position.X-mRoot.Position.X)
        local nX = toPos.Position.X -1
        if toPos.Position.X > mRoot.Position.X then nX = toPos.Position.X + 1 end
        local nY =toPos.Position.Z + (nX - toPos.Position.X)*varm
        return Vector3.new(nX, mRoot.Position.Y,nY)
    end
end
function moveMeTo(toPos,tmr)
    local ts = game:GetService("TweenService")
    local goal = {}
    goal.CFrame = toPos
    local twinfo = TweenInfo.new(tmr,Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tween = ts:Create(mPlayer.Character.HumanoidRootPart,twinfo, goal)
    tween:Play()
    return tween
end
function moveMeToLook(toPos,tmr)
    local ts = game:GetService("TweenService")
    local nextv = nextPoint(toPos)
    mRoot.CFrame = CFrame.lookAt(mRoot.Position,nextv)
    local goal = {}
    goal.CFrame = CFrame.lookAt(toPos.Position,nextv)
    local twinfo = TweenInfo.new(tmr,Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tween = ts:Create(mPlayer.Character.HumanoidRootPart,twinfo, goal)
    tween:Play()
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(8)
    return tween
end
BSpcmd.MouseButton1Click:Connect(function()
    if hBuildSprikler then
        hBuildSprikler = false
        BSpcmd.Text = "Dont Build"
        setColor(BSpcmd,1)
    else
        hBuildSprikler = true
        BSpcmd.Text = "Build Sprinkler"
        setColor(BSpcmd,2)
    end
end)
BSpFalling.MouseButton1Click:Connect(function()
    if iscollectDisk then
        iscollectDisk = false
        setColor(BSpFalling,1)
    else
        iscollectDisk = true
        setColor(BSpFalling,2)
    end
end)
BSpLook.MouseButton1Click:Connect(function()
    if farmtolook then
        farmtolook = false
        setColor(BSpLook,1)
    else
        farmtolook = true
        setColor(BSpLook,2)
    end
end)
BSpMicro.MouseButton1Click:Connect(function()
    if useMicro then
        useMicro = false
        setColor(BSpMicro,1)
    else
        useMicro = true
        setColor(BSpMicro,2)
    end
end)
function showTelePort(vbool)
    miniLabel.Visible = vbool
    npcZone.Visible = vbool
    fieldZone.Visible = vbool
    shopZone.Visible = vbool
    eventZone.Visible =vbool
    if vbool then
        setColor(miniTele,2)
    else
        fieldBSp.Visible = false
        setColor(miniTele,0)
    end
end

miniTele.MouseButton1Click:Connect(function()
    if miniLabel.Visible and todoZone == 0 then
        showTelePort(false)
    else
            miscZone.Visible = false
            fieldBSp.Visible = false
            setColor(miniMobs,0)
            if hFarm==false then setColor(miniFarm,0) end
            todoZone = 0
            setLocation(miniLabel,0,35,380,25)
            miniLabel.Text = "Teleport me to:"
            showTelePort(true)
    end
end)

miniFarm.MouseButton1Click:Connect(function()
    if miniLabel.Visible and todoZone == 1 then
        setColor(miniFarm,0)
        miniLabel.Visible = false
        fieldZone.Visible = false
        fieldBSp.Visible = false
    else
        if hFarm then
            setColor(miniFarm,0)
            hSelling = false
            hFarm = false
            hWalking = false
            if tempSafe then hSafe = false end
        else
            showTelePort(false)
            fieldZone.Visible = true
            fieldBSp.Visible = true
            miniLabel.Text = "Farm on:"
            miniLabel.Visible = true
            todoZone = 1
            setLocation(miniLabel,90,35,90,25)
            setColor(miniFarm,2)
            setColor(miniMobs,0)
            miscZone.Visible = false
        end
    end
end)

function teleportToShop(vname)
    if NpcShop[vname] then
        mRoot.CFrame = CFrame.new(NpcShop[vname])
    end
end
function setupNPCList()
    local lstNPC={
        [1]="Black Bear",
        [2]="Mother Bear",
        [3]="Brown Bear",
        [4]="Stick Bug",
        [5]="Panda Bear",
        [6]="Science Bear",
        [7]="Polar Bear",
        [8]="RileyBee",
        [9]="BuckoBee",
        [10]="Dapper Bear",
        [11]="HoneyBee",
        [12]="Spirit Bear",
        [13]="Onett",
        [14]="Bubble Bee"
    }
    for i=1,#lstNPC do
        local txt = Instance.new("TextButton",npcZone)
        txt.Text = lstNPC[i]
        setLocation(txt,5,i*20+5,80,20)
        setFont(txt,10)
        setColor(txt,0)
        txt.MouseButton1Click:Connect(function()
            teleportToShop(txt.Text)
            showTelePort(false)
        end)
    end
end
function setupNPC(txt,tid,std)
        txt.Text = std
        setLocation(txt,5,(tid-0)*20+5,80,20)
        setFont(txt,10)
        setColor(txt,0)
        txt.MouseButton1Click:Connect(function()
            --miniFarm.Text = txt.Text
            teleportToShop(txt.Text)
            showTelePort(false)
        end)
end
setupNPCList()

function teleportToField(vname)
    if fieldPos[vname] then
        moveMeTo(CFrame.new((fieldPos[vname])[1]),.1)
    end
end


function getNumberMicro()
    local k = 0
    local tmp = ""
    local allE = game.Players.LocalPlayer.PlayerGui.ScreenGui.Menus.Children.Eggs.Content.EggRows:GetChildren()
    for _,v in pairs(allE) do
        if v:IsA("Frame") then
            if v.TypeName.Text == "Micro-Converter" then
                if v.EggSlot.Count then
                    tmp = v.EggSlot.Count.Text
                    if string.find(tmp,"/") then
                        tmp = string.sub(tmp,1,string.find(tmp,"/")-1)
                    end
                    k = tonumber(tmp)
                end
                break
            end
        end
    end
    return k
end
function inMyZone(toV,vmax,vmin)
    if vmax == false or vmin == false then return true end
    if (toV.X>=vmin.X and toV.x<=vmax.x) then
        if (toV.y>=vmin.y and toV.y<=vmax.y) then
            if toV.z>=vmin.z and toV.z<=vmax.z then return true end
        end
    end
    return false
end
function isfarSnail(vpos)
    local kq = true
    for _,v in pairs(workspace.Monsters:GetChildren()) do
        if string.find(v.Name,"Snail") and tostring(v.Target.Value)==mPlayer.Name then
            kq = ((vpos-v.PrimaryPart.Position).magnitude > 15)
            break
        end
    end
    return kq
end
function findToken2Dig2(lsPos)
    if hFarm then
        workspace.Collectibles:ClearAllChildren()
        if hKillMod then
            while hKillMod do wait(.1) end
        end
        moveMeTo(CFrame.new(lsPos[2]),.1)
        wait(0.5)
    end
    local thisY = mRoot.CFrame.Y
    local findnear=coroutine.wrap(function()
        local cnear
        local nearme
        local thisV
        local vpos
        while hFarm and (hSelling == false) do
            if imdie then break end
            while hKillMod and hFarm do wait(1) end
            nearme=80
            thisV = false
            for _,v in pairs(workspace.Collectibles:GetChildren()) do
                if (tostring(v)=="C" or tostring(v)=="V") and isfarSnail(v.Position) then
                    cnear = (v.Position-mRoot.Position).magnitude
                    if cnear < nearme then
                        nearme = cnear
                        thisV = v
                    end
                end
            end
            if thisV then
                vpos = thisV.Position
                if tostring(thisV)=="C" then
                    thisV.Name = "V"
                else
                    thisV.Name = "L"
                end
            else
                cnear=math.random(2,#lsPos)
                vpos = lsPos[cnear]
                nearme = (vpos-mRoot.Position).magnitude
            end
            if hFarm then
                cnear = nearme/moveFarmSpeed
                if farmtolook then
                    cnear = moveMeToLook(CFrame.new(vpos.X,thisY,vpos.Z),cnear)
                else
                    cnear = moveMeTo(CFrame.new(vpos.X,thisY,vpos.Z),cnear)
                end
                cnear.Completed:wait()
            end
            if thisV==false then wait(.5) end
        end
    end)
    local loopdig=coroutine.wrap(function()
        for _,v in pairs(workspace[mPlayer.Name]:GetChildren()) do
            if v.ClassName == "Tool" then
                while hFarm and (hSelling == false) do
                    if imdie then break end
                    v.ClickEvent:FireServer()
                    wait(.1)
                end
                break
            end
        end
    end)
    loopdig()
    findnear()
end
function autoFarmSnail(lsPos)
    mRoot = mPlayer.Character.HumanoidRootPart
    hSafe =false
    setColor(miscso7,0)
    hFarm = true

    local plmove = 0
    if hBuildSprikler then
        plmove = tonumber("0".. BSpNum.Text)
        if plmove < 0 then plmove = 0 end
        if plmove > 4 then plmove = 4 end
        local lsSprinkler = fieldSpinkler2["Snails"]
        local Sprinkler = {["Name"] = "Sprinkler Builder"}
        if plmove > 0 and hFarm then
            local arrNum = lsSprinkler[plmove]
            local jpm
            for _,i in pairs(arrNum) do
                if hFarm then
                    while hKillMod do wait(1) end
                    moveMeTo(CFrame.new(i),.1)
                    wait(.5)
                    jpm = moveMeTo(CFrame.new(i)*CFrame.new(0,17,0),.3)
                    wait(.15)
                    game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer(Sprinkler)
                    jpm.Completed:wait()
                    wait(1.2)
                end
            end
        end
    end
    local ctime = 0
    local oldpollen = 0
    local loopsell=coroutine.wrap(function()
        while hFarm do
            wait()
            if mPlayer.CoreStats.Pollen.Value >= mPlayer.CoreStats.Capacity.Value then
                if useMicro then
                    local A = {["Name"] = "Micro-Converter"}
                    local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
                    Event:FireServer(A)
                    wait(1)
                    if mPlayer.CoreStats.Pollen.Value >= mPlayer.CoreStats.Capacity.Value then 
                        useMicro = false
                        setColor(BSpMicro,1)
                    end
                else
                    hSelling = true
                    ctime =0
                    moveMeTo(mPlayer.SpawnPos.Value,.1)
                    wait(3)
                    oldpollen = mPlayer.CoreStats.Pollen.Value
                    plmove = 0
                    game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
                    while mPlayer.CoreStats.Pollen.Value > 10 and plmove < 30 do
                        wait(1)
                        plmove = (mRoot.CFrame.p-mPlayer.SpawnPos.Value.p).Magnitude
                        ctime = ctime + 1
                        if ctime >=10 then
                            if mPlayer.CoreStats.Pollen.Value > oldpollen then
                                break
                            else
                                oldpollen = mPlayer.CoreStats.Pollen.Value
                            end
                            ctime = 0
                        end
                    end
                    wait(7)
                    hSelling = false
                    wait()
                    if hFarm then
                        wait(.5)
                        findToken2Dig2(lsPos)
                    end
                end
            end
            if imdie then
                while imdie do wait(1) end
                if hFarm then
                    mRoot.CFrame = mPlayer.SpawnPos.Value
                    wait(2)
                    findToken2Dig2(lsPos)
                end
            end
        end
    end)
    findToken2Dig2(lsPos)
    loopsell()
end

function dofieldJob(vname)
    if todoZone == 0 then
        teleportToField(vname)
        showTelePort(false)
    else
        miniLabel.Visible = false
        fieldZone.Visible = false
        fieldBSp.Visible = false
        setColor(miniFarm,1)
        autoFarmWalk(vname)
    end
end
function setupField(txt,tid,vname)
    txt.Text = vname
    setLocation(txt,5,(tid-0)*20+5,80,20)
    setFont(txt,10)
    setColor(txt,0)
    txt.MouseButton1Click:Connect(function()
        dofieldJob(txt.Text)
    end)
end
function setupFieldList()
    local listFd = {
        [1]="Sunflower",
        [2]="Dandelion",
        [3]="Mushroom",
        [4]="Blue Flower",
        [5]="Clover Field",
        [6]="StrawBerry",
        [7]="Spider Field",
        [8]="BamBoo",
        [9]="Pineapple",
        [10]="Pine Tree",
        [11]="Red Rose",
        [12]="Cactus",
        [13]="Pumpkin",
        [14]="Mountain",
        [15]="Snails",
        [16]="Coconut",
        [17]="Pepper"}
    for i=1,#listFd do
        local txt = Instance.new("TextButton",fieldZone)
        txt.Text = listFd[i]
        setLocation(txt,5,i*20+5,80,20)
        setFont(txt,10)
        setColor(txt,0)
        txt.MouseButton1Click:Connect(function()
            dofieldJob(txt.Text)
        end)
    end
end
setupFieldList()

function setupShopList()
    local listSL={
        [2]="Noob Shop",
        [3]="Pro Shop",
        [4]="Planter Shop",
        [5]="BuckoBee Shop",
        [6]="RileyBee Shop",
        [7]="Sprinkler Shop",
        [8]="HoneyMask Shop",
        [9]="Top Shop",
        [10]="Petal Shop",
        [11]="Coconut Shop",
        [12]="Ticket Shop",
        [13]="Boost Market",
        [14]="Gummy Shop",
        [15]="Diamond Mask",
        [16]="Demon Mask"
    }
    for i=2,15 do
        local txt = Instance.new("TextButton",shopZone)
        txt.Text = listSL[i]
        setLocation(txt,5,i*20+5,80,20)
        setFont(txt,10)
        setColor(txt,0)
        txt.MouseButton1Click:Connect(function()
            teleportToShop(txt.Text)
            showTelePort(false)
        end)
    end
end 
setupShopList()

shopso1.MouseButton1Click:Connect(function()
    moveMeTo(mPlayer.SpawnPos.Value,.1)
    showTelePort(false)
end)

--===================================--
--              EVENTS               --
--===================================--
function setupEvents(lstE)
    local listEV={
        [1]="Honey Wreath",
        [2]="Gringerbread House",
        [3]="Honeydays Candle",
        [4]="Stocking",
        [5]="Beesmas Feast",
        [6]="Snowbear boss",
        [7]="Snow Machine",
        [8]="Onett's Lid Art",
        [9]="",
        [10]="Giftbox 3",
        [11]="Giftbox 4",
        [12]="Giftbox 5",
        [13]="Giftbox 6",
        [14]="Giftbox 7",
        [15]="Giftbox 8",
        [16]="Giftbox 9",
        [17]="Giftbox 10",
        [18]="Giftbox 11",
        [19]="Giftbox 12"
    }
    for i=1,19 do
        local btn = Instance.new("TextButton",eventZone)
        btn.Text = listEV[i]
        setLocation(btn,5,i*20+5,100,20)
        setFont(btn,10)
        if i~=9 then
            setColor(btn,0)
            btn.MouseButton1Click:Connect(function()
                if EventPos[btn.Text] then
                    moveMeTo(CFrame.new(EventPos[btn.Text]),.1)
                end
                showTelePort(false)
            end)
        else
            setColor(btn,10)
        end
    end
end
setupEvents(EventPos)
--===================================--
--              NOTICES              --
--===================================--
function resortNotice()
    local ns = false
    noticeZone.Visible = true
    if noticeVicious.Visible then
        ns = 30
        if noticeSprout.Visible then
            setLocation(noticeSprout,0,35,300,30)
            ns = 65
            if noticeWindy.Visible then
                setLocation(noticeWindy,0,70,300,30)
                ns = 100
            end
        elseif noticeWindy.Visible then
            setLocation(noticeWindy,0,35,300,30)
            ns= 65
        end
    else
        if noticeSprout.Visible then
            ns = 30
            setLocation(noticeSprout,0,0,300,30)
            if noticeWindy.Visible then
                ns = 65
                setLocation(noticeWindy,0,35,300,30)
            end
        elseif noticeWindy.Visible then
            ns = 30
            setLocation(noticeWindy,0,0,300,30)
        else
            noticeZone.Visible = false
        end
    end
    if noticeZone.Visible then setLocation(noticeZone,(workspace.Camera.ViewportSize.X-320)/2,35,320,ns) end
end
function showNoticeVic(vic)
    noticeVicious.Visible = true
    vicLabel.Text = "Found Vicious at ".. getNameZone(vic.Position,false)
    mVicious = vic.Position
    resortNotice()
end
function showNoticeSpr(spr)
    noticeSprout.Visible = true
    sprLabel.Text = "Found Sprout at ".. getNameZone(spr.Position,false)
    mSprout = spr.Position
    resortNotice()
end
function showNoticeWindy(windy)
    local vark  = getNameZone(windy.Position,false)
    if vark == false then
        noticeWindy.Visible = false
        resortNotice()
        mWindy = false
        return
    end
    noticeWindy.Visible = true
    windyLabel.Text = "Found Windy at ".. vark
    mWindy = windy.Position
    resortNotice()
end
function setupNotice(txt,lbl,bttele,btkill,btcan)
    local mw = noticeZone.Size.Width.Offset
    txt.BackgroundColor3 = Color3.fromRGB(5,5,5)
    txt.BorderColor3 = Color3.fromRGB(200,200,200)
    setLocation(txt,0,0,mw,30)
    lbl.Text = "Loading..."
    lbl.BackgroundTransparency = 1
    lbl.BorderSizePixel = 0
    setFont(lbl,10)
    lbl.TextColor3 = Color3.fromRGB(255,100,100)
    setLocation(lbl,5,5,mw-130,20)
    btcan.Text = "X"
    setColor(btcan,1)
    setFont(btcan,12)
    setLocation(btcan,mw-25,5,20,20)
    bttele.Text = "Tele"
    setColor(bttele,0)
    setFont(bttele,10)
    setLocation(bttele,mw-75,5,50,20)
    btkill.Text = "Kill"
    setColor(btkill,0)
    setColor(btkill,10)
    setLocation(btkill,mw-125,5,50,20)
    txt.Visible= false
end

setupNotice(noticeVicious,vicLabel,vicTele,vicKill,vicCancel)
setupNotice(noticeSprout,sprLabel,sprTele,sprKill,sprCancel)
setupNotice(noticeWindy,windyLabel,windyTele,windyKill,windyCancel)
sprKill.Text = "Farm"
vicCancel.MouseButton1Click:Connect(function()
    noticeVicious.Visible = false
    hVicious = false
    setColor(miscso5,0)
end)
vicTele.MouseButton1Click:Connect(function()
    if mVicious then safeTele(mVicious) end
end)

vicKill.MouseButton1Click:Connect(function()
    if mVicious then
        if hKillVic then
            hKillVic = false
        else
            if hFarm then 
                hFarm = false
                setColor(miniFarm,0)
            end
            if hSafe then
                hSafe = false
                setColor(miscso7,0)
            end
            hKillVic = true
            local loopkillvic=coroutine.wrap(function()
                local vic = game.workspace.Particles:FindFirstChild("Vicious")
                if vic==nil then vic =workspace.Particles.WTs:FindFirstChild("WaitingThorn") end
                if vic then
                    moveMeTo(vic.CFrame,.1)
                    wait(.1)
                    local vname = false
                    for _,v in pairs(workspace.Monsters:GetChildren()) do
                        if string.find(v.Name,"Vicious") or string.find(v.Name, "Gifted") then
                            vname = v.Name
                            break
                        end
                    end
                    if vname then
                        noclip = true
                        while hKillVic do
                            vic = workspace.Monsters:FindFirstChild(vname)
                            if vic then
                                mRoot.CFrame = vic.PrimaryPart.CFrame * CFrame.new(0, 13, 0)
                            else
                                break
                            end
                            wait()
                        end
                        noclip = false
                        safeTele(mRoot.Position)
                        hKillVic = false
                    end
                end
            end)
            loopkillvic()
        end
    end
end)

sprCancel.MouseButton1Click:Connect(function()
    noticeSprout.Visible = false
    hSprout = false
    setColor(miscso4,0)
end)
sprTele.MouseButton1Click:Connect(function()
    if mSprout then safeTele(mSprout) end
end)
sprKill.MouseButton1Click:Connect(function()
    if hKillSpr then
        hKillSpr = false
    else
        if hFarm then
            hFarm = false
            setColor(miniFarm,0)
        end
        if hSafe == false then
            hSafe = true
            keepMeSafe()
        end

        hKillSpr = true
        local looptokenspr=coroutine.wrap(function()
            while hKillSpr do
                collect15Token()
                wait(2)
            end
        end)
        local loopkillspr=coroutine.wrap(function()
            local vname = false
            local spr = workspace.Particles.Folder2:FindFirstChild("Sprout")
            local newspr = spr
            if spr then
                vname = getNameZone(spr.Position,false)
                --autoFarmSlow(fieldPos[vname],vname)
                autoFarmWalk(vname)
                while newspr and hKillSpr do
                    newspr = workspace.Particles.Folder2:FindFirstChild("Sprout")
                    if newspr ~= spr then break end
                    wait(.1)
                end
                hFarm = false
                hSafe = false
                looptokenspr()
                wait(30)
                hKillSpr = false
            else
                showMsg("PTNET Farm","Sorry!! we dont found sprout now!")
            end
        end)
        loopkillspr()
    end
end)

windyCancel.MouseButton1Click:Connect(function()
    noticeWindy.Visible = false
    hWindy = false
    setColor(miscso6,0)
end)
windyTele.MouseButton1Click:Connect(function()
    if mWindy then safeTele(mWindy) end
end)
windyKill.MouseButton1Click:Connect(function()
    if hKillWindy then
        hKillWindy = false
    else
        if hFarm  then
            hFarm = false
            setColor(miniFarm,0)
        end
        hSafe = false
        setColor(miscso7,0)

        hKillWindy = true
        local loopkillwindy=coroutine.wrap(function()
            
        end)
    end
end)

--======================================--
--               MISC                   --
--======================================--
function setupMISC(txt,rw,cl,tname)
    txt.Text = tname
    setLocation(txt,5+(cl-1)*125,rw*25,120,20)
    setFont(txt,10)
    setColor(txt,0)
end

setupMISC(miscso1,1,1,"Sell Pollen")
setupMISC(miscso2,1,2,"Auto Quest")
setupMISC(miscso3,1,3,"Auto Dispenser")
setupMISC(miscso4,2,1,"Find Sprout")
setupMISC(miscso5,2,2,"Find Vicious")
setupMISC(miscso6,2,3,"Find Windybee")
setupMISC(miscso7,3,1,"Keep Me Safe")
setupMISC(miscso8,3,2,"Farm All Mobs")
setupMISC(miscso9,3,3,"Toggle Mask")

setupMISC(miscboard,4,1,"Player Board")
setColor(miscboard,2)
setupMISC(miscmobs,4,2,"Mobs Timer")
miscso1.MouseButton1Click:Connect(function()
    hFarm = false
    if tempSafe then hSafe = false end
    setColor(miniFarm,0)
    miscZone.Visible=false
    setColor(miniMobs,0)
    moveMeTo(mPlayer.SpawnPos.Value,.1)
    wait(2)
    game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")
end)
miscso2.MouseButton1Click:Connect(function()
    miscZone.Visible=false
    setColor(miniMobs,0)
    for k,v in pairs(questBadge) do
        game.ReplicatedStorage.Events.BadgeEvent:FireServer("Collect", v)
    end
    for k,v in pairs(questToy) do
        game.ReplicatedStorage.Events.ToyEvent:FireServer(v)
    end
    for k,v in pairs(questPool) do
        game.ReplicatedStorage.Events.CompleteQuestFromPool:FireServer(v)
        game.ReplicatedStorage.Events.GiveQuestFromPool:FireServer(v)
    end
    for k,v in pairs(questNormal) do
        game.ReplicatedStorage.Events.CompleteQuest:FireServer(v)
        game.ReplicatedStorage.Events.GiveQuest:FireServer(v)
    end
end)

miscso3.MouseButton1Click:Connect(function()
    miscZone.Visible=false
    setColor(miniMobs,0)
    for k,v in pairs(listDispenser) do
        game.ReplicatedStorage.Events.ToyEvent:FireServer(v)
    end
end )

miscso5.MouseButton1Click:Connect(function()
    if hVicious then
        hVicious = false
        setColor(miscso5,0)
        if noticeVicious.Visible then
            noticeVicious.Visible = false
            resortNotice()
        end
    else
        hVicious = true
        setColor(miscso5,2)
        local loopvicious=coroutine.wrap(function()
            local v = false
            while hVicious do
                v = game.workspace.Particles:FindFirstChild("Vicious")
                if v==nil then v =workspace.Particles.WTs:FindFirstChild("WaitingThorn") end
                if v==nil then
                    for vark,varv in pairs(workspace.Monsters:GetChildren()) do
                        if string.find(varv.Name, "Vicious") or string.find(varv.Name,"Gifted") then
                            v = varv
                            break
                        end
                    end
                end
                if v then
                    if noticeVicious.Visible then
                        if (v.Position - mVicious).magnitude >60 then
                            showNoticeVic(v)
                        end
                    else
                        showNoticeVic(v)
                    end
                    mVicious = v.Position
                else   
                    if noticeVicious.Visible then
                        noticeVicious.Visible = false
                        resortNotice()
                    end
                end
                if noticeVicious.Visible then
                    wait(2)
                else
                    wait(1)
                end
            end
        end)
        loopvicious()
    end
end)

miscso4.MouseButton1Click:Connect(function()
    if hSprout then
        hSprout = false
        setColor(miscso4,0)
        if noticeSprout.Visible then
            noticeSprout.Visible = false
            resortNotice()
        end
    else
        hSprout = true
        setColor(miscso4,2)
        local loopsprout = coroutine.wrap(function()
            local v = false
            while hSprout do
                v = game.workspace.Particles.Folder2:FindFirstChild("Sprout")
                if v then
                    if noticeSprout.Visible then
                        if (v.Position - mSprout).magnitude >30 then
                            showNoticeSpr(v)
                        end
                    else
                        showNoticeSpr(v)
                    end
                    mSprout = v.Position
                else
                    if noticeSprout.Visible then
                        noticeSprout.Visible = false
                    end
                end
                if noticeSprout.Visible then
                    wait(2)
                else
                    wait(1)
                end
            end
        end)
        loopsprout()
    end
end)
miscso6.MouseButton1Click:Connect(function()
    if hWindy then
        hWindy = false
        setColor(miscso6,0)
        if noticeWindy.Visible then
            noticeWindy.Visible = false
            resortNotice()
        end
    else
        hWindy = true
        setColor(miscso6,2)
        local loopfindwindy = coroutine.wrap(function()
            local v = false
            while hWindy do
                v=workspace.NPCBees:FindFirstChild("Windy")
                if v==nil then
                    for vark,varv in pairs(workspace.Monsters:GetChildren()) do
                        if string.find(varv.Name,"Windy") then
                            v = varv
                            break
                        end
                    end
                end
                if v then
                    if isInZone(v.Position) then
                        if noticeWindy.Visible then
                            if (v.Position - mWindy).magnitude >20 then
                                showNoticeWindy(v)
                                mWindy = v.Position
                            end
                        else
                            mWindy = v.Position
                            showNoticeWindy(v)
                        end
                    else
                        noticeWindy.Visible = false
                    end
                else
                    noticeWindy.Visible = false
                end
                if noticeWindy.Visible then
                    wait(.5)
                end
                wait(.5)
            end
        end)
        loopfindwindy()
    end
end)

miscso7.MouseButton1Click:Connect(function()
    miscZone.Visible=false
    setColor(miniMobs,0)
    if hSafe then
        if tempSafe then
            tempSafe = false
            setColor(miscso7,2)
        else
            hSafe = false
            setColor(miscso7,0)
            noclip = false
        end
    else
        hSafe = true
        keepMeSafe()
        setColor(miscso7,2)
    end
end)
function isBossSpawn(vname)
    local v = workspace.MonsterSpawners:FindFirstChild(vname)
    local att = v:FindFirstChild("Attachment")
    if att == nil then att = v:FindFirstChild("TimerAttachment") end
    if att then
        if att.TimerGui.TimerLabel.Visible then
            return false
        end
    end
    return true
end
miscso8.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://pastebin.com/raw/NcZpNPtS"))()
end)

miscso9.MouseButton1Click:Connect(function()
    miscZone.Visible = false
    setColor(miniMobs,0)
    local newF = Instance.new("Frame",mGui)
    local maskGum = Instance.new("TextButton",newF)
    local maskDem = Instance.new("TextButton",newF)
    local maskDai = Instance.new("TextButton",newF)
    local closeF = Instance.new("TextButton",newF)
    --workspace.Camera.ViewportSize.X
    setLocation(newF,workspace.Camera.ViewportSize.X/2 - 55,workspace.Camera.ViewportSize.Y/2 - 45,110,95)
    newF.BackgroundColor3 = Color3.fromRGB(255,255,255)
    newF.BorderColor3 = Color3.fromRGB(5,5,5)
    newF.Active = false
    newF.ClipsDescendants = false

    setLocation(maskGum,5,15,100,20)
    setFont(maskGum,10)
    setColor(maskGum,0)
    maskGum.Text = "Gummy Mask"

    setLocation(maskDem,5,40,100,20)
    setFont(maskDem,10)
    setColor(maskDem,0)
    maskDem.Text = "Demon Mask"

    setLocation(maskDai,5,65,100,20)
    setFont(maskDai,10)
    setColor(maskDai,0)
    maskDai.Text = "Diamond Mask"

    setLocation(closeF,100,0,10,10)
    setFont(closeF,10)
    setColor(closeF,1)
    closeF.Text = "x"
    closeF.MouseButton1Click:Connect(function()
        newF:Destroy()
    end)

    local EQ = "Equip"
    maskGum.MouseButton1Click:Connect(function()
        local Mask = {
            ["Mute"] = true,
            ["Type"] = "Gummy Mask",
            ["Category"] = "Accessory"
        }
        local Event = game:GetService("ReplicatedStorage").Events.ItemPackageEvent
        Event:InvokeServer(EQ, Mask)
        newF:Destroy()
    end)
    maskDem.MouseButton1Click:Connect(function()
        local Mask = {
            ["Mute"] = true,
            ["Type"] = "Demon Mask",
            ["Category"] = "Accessory"
        }
        local Event = game:GetService("ReplicatedStorage").Events.ItemPackageEvent
        Event:InvokeServer(EQ, Mask)
        newF:Destroy()
    end)
    maskDai.MouseButton1Click:Connect(function()
        local Mask = {
            ["Mute"] = true,
            ["Type"] = "Diamond Mask",
            ["Category"] = "Accessory"
        }
        local Event = game:GetService("ReplicatedStorage").Events.ItemPackageEvent
        Event:InvokeServer(EQ, Mask)
        newF:Destroy()
    end)
end)
--======================================--
--            Player Board              --
--======================================--

function setupBoard(txt,rw,cl,tname,ilast)
    txt.Text = tname
    if ilast then
        setLocation(txt,5+(cl-1)*125,(rw+1)*20,120,20)
    else
        setLocation(txt,5+(cl-1)*125,(rw+1)*20,125,20)
    end
    setFont(txt,10)
    txt.BackgroundColor3 = Color3.fromRGB(255,255,255)
    txt.BorderColor3 = Color3.fromRGB(5,5,5)
    txt.TextColor3 = Color3.fromRGB(5,5,5)
    txt.TextXAlignment = cl-1
end
setupBoard(boardp1,1,1," ",false)
setupBoard(boardh1,1,2," ",false)
setupBoard(boardz1,1,3," ",true)
setupBoard(boardp2,2,1," ",false)
setupBoard(boardh2,2,2," ",false)
setupBoard(boardz2,2,3," ",true)
setupBoard(boardp3,3,1," ",false)
setupBoard(boardh3,3,2," ",false)
setupBoard(boardz3,3,3," ",true)
setupBoard(boardp4,4,1," ",false)
setupBoard(boardh4,4,2," ",false)
setupBoard(boardz4,4,3," ",true)
setupBoard(boardp5,5,1," ",false)
setupBoard(boardh5,5,2," ",false)
setupBoard(boardz5,5,3," ",true)
setupBoard(boardp6,6,1," ",false)
setupBoard(boardh6,6,2," ",false)
setupBoard(boardz6,6,3," ",true)

function converNumString(num)
    local s = "".. num
    local k = ""
    while s ~= "" do
        if string.len(s)<3 then
            k = s ..".".. k
            break
        else
            k = string.sub(s,-3) ..".".. k
            s = string.sub(s,1, string.len(s)-3)
        end
    end
    k = string.sub(k,1,string.len(k)-1)
    return k .. " "
end
function updatePlayer(vpl, txtp, txth, txtz)
    if vpl == false then
        txtp.Text = " "
        txth.Text = " "
        txtz.Text = " "
        return
    end
    txtp.Text = " ".. vpl.Name
    if vpl.Name == mPlayer.Name then
        txtp.TextColor3 = Color3.fromRGB(5,5,250)
        txth.TextColor3 = Color3.fromRGB(5,5,250)
        txtz.TextColor3 = Color3.fromRGB(5,5,250)
    else
        txtp.TextColor3 = Color3.fromRGB(5,5,5)
        txth.TextColor3 = Color3.fromRGB(5,5,5)
        txtz.TextColor3 = Color3.fromRGB(5,5,5)
    end
    txth.Text = converNumString(vpl.CoreStats.Honey.Value) .." "
    txtz.Text = tostring(getNameZone(workspace[vpl.Name].HumanoidRootPart.Position,true))
end
function showPlayerInfo()
    local vari = 0
    local lnum = 0
    updatePlayer(false,boardp1,boardh1,boardz1)
    updatePlayer(false,boardp2,boardh2,boardz2)
    updatePlayer(false,boardp3,boardh3,boardz3)
    updatePlayer(false,boardp4,boardh4,boardz4)
    updatePlayer(false,boardp5,boardh5,boardz5)
    updatePlayer(false,boardp6,boardh6,boardz6)
    while miscZone.Visible and boardZone.Visible do
        vari = 0
        for k,v in pairs(game.Players:GetChildren()) do
            if v.ClassName == "Player" then
                vari = vari + 1
                if vari == 1 then
                    updatePlayer(v,boardp1,boardh1,boardz1)
                elseif vari==2 then
                    updatePlayer(v,boardp2,boardh2,boardz2)
                elseif vari==3 then
                    updatePlayer(v,boardp3,boardh3,boardz3)
                elseif vari==4 then
                    updatePlayer(v,boardp4,boardh4,boardz4)
                elseif vari==5 then
                    updatePlayer(v,boardp5,boardh5,boardz5)
                elseif vari==6 then
                    updatePlayer(v,boardp6,boardh6,boardz6)
                end
            end
        end
        if lnum > vari then
            for vark=vari+1,lnum do
                if vark==2 then
                    updatePlayer(false,boardp2,boardh2,boardz2)
                elseif vark==3 then
                    updatePlayer(false,boardp3,boardh3,boardz3)
                elseif vark==4 then
                    updatePlayer(false,boardp4,boardh4,boardz4)
                elseif vark==5 then
                    updatePlayer(false,boardp5,boardh5,boardz5)
                elseif vark==6 then
                    updatePlayer(false,boardp6,boardh6,boardz6)
                end
            end
        end
        lnum = vari
        wait(1)
    end

end
miniMobs.MouseButton1Click:Connect(function()
    if miscZone.Visible then
        miscZone.Visible = false
        setColor(miniMobs,0)
    else
        showTelePort(false)
        miscZone.Visible = true
        setColor(miniMobs,2)
        if hFarm~=true then setColor(miniFarm,0) end
        showPlayerInfo()
    end
end)
miscboard.MouseButton1Click:Connect(function()
    if boardZone.Visible == false then
        boardZone.Visible = true
        setColor(miscboard,2)
        mobsZone.Visible = false
        setColor(miscmobs,0)
        showPlayerInfo()
    end
end)
function collect15Token(mback)
    mRoot = mPlayer.Character.HumanoidRootPart
    local tnum =0
    local oldpos = mRoot.CFrame
    h15Colect = true
    for k,v in pairs(workspace.Collectibles:GetChildren()) do
        if (v.Position - oldpos.Position).magnitude <=60 then
            moveMeTo(CFrame.new(v.Position.X,mRoot.Position.y,v.Position.Z),.1)
            wait(.1)
            tnum = tnum + 1
            if tnum == 15 then break end
        end
    end
    h15Colect = false
    if mback then moveMeTo(oldpos,.1) end
end


--======================================--
--             Mobs Timer               --
--======================================--
function setupMobs(txt,rw,cl,vname)
    txt.Text = vname
    setLocation(txt, (cl-1)*185 +5, (rw-1)*12 +20, 184, 12)
    setFont(txt,10)
    txt.BackgroundTransparency = 1
    txt.BorderSizePixel = 0
    txt.TextColor3 = Color3.fromRGB(5,5,5)
    txt.TextXAlignment = 0
end
-- ladybug
setupMobs(mobsso1,1,1," ")
setupMobs(mobsso2,1,2," ")
setupMobs(mobsso3,2,1," ")
setupMobs(mobsso4,2,2," ")
-- bhrino beetle
setupMobs(mobsso5,3,1," ")
setupMobs(mobsso6,3,2," ")
setupMobs(mobsso7,4,1," ")
setupMobs(mobsso8,4,2," ")
setupMobs(mobsso9,5,1," ")
-- mantis 
setupMobs(mobsso10,5,2," ")
setupMobs(mobsso11,6,1," ")
setupMobs(mobsso12,6,2," ")
-- Scorpion
setupMobs(mobsso13,7,1," ")
setupMobs(mobsso14,7,2," ")

setupMobs(mobsso15,8,1," ")-- spider
setupMobs(mobsso16,8,2," ")-- werewolf
setupMobs(mobsso17,9,1," ")-- tunnel bear
setupMobs(mobsso18,9,2," ")-- king beetle
setupMobs(mobsso19,10,1," ")-- commando chick
setupMobs(mobsso20,11,1," ")-- coconut Crab
setupMobs(mobsso21,11,2," ")-- snail

function joinString(b)
    local v
    for i=2,#b do
        v = v ..":".. b[i]
    end
    return v
end
function checkMobs(txt,vname,mname)
    local v = workspace.MonsterSpawners:FindFirstChild(mname)
    if v then
        local att = v:FindFirstChild("Attachment")
        if att == nil then att = v:FindFirstChild("TimerAttachment") end
        if att == nil then
            txt.Text = vname ..": timer err"
            txt.TextColor3 = Color3.fromRGB(150, 123, 24)
        else
            if att.TimerGui.TimerLabel.Visible then
                v = att.TimerGui.TimerLabel.Text
                txt.Text = vname .. string.sub(v,string.find(v,":")+1)
                txt.TextColor3 = Color3.fromRGB(250,100,100)
            else
                txt.Text = vname ..": Spawned"
                txt.TextColor3 = Color3.fromRGB(5,5,5)
            end
        end
    else
        txt.Text = vname .. ": mob err"
        txt.TextColor3 = Color3.fromRGB(150, 123, 24)
    end
end
function showMobsTimer()
    local looptimer=coroutine.wrap(function()
        while mobsZone.Visible do
            --ladybug
            checkMobs(mobsso1,"Ladybug Mushroom","MushroomBush")
            checkMobs(mobsso2,"Ladybug Clover","Ladybug Bush")
            checkMobs(mobsso3,"Ladybug Strawbery","Ladybug Bush 2")
            checkMobs(mobsso4,"Ladybug Strawbery","Ladybug Bush 3")
            -- bhrino
            checkMobs(mobsso5,"Rhino Clover","Rhino Bush")
            checkMobs(mobsso6,"Rhino Blue","Rhino Cave 1")
            checkMobs(mobsso7,"Rhino Bammbo","Rhino Cave 2")
            checkMobs(mobsso8,"Rhino Bammbo","Rhino Cave 3")
            checkMobs(mobsso9,"Rhino Pinapple","PineappleBeetle")
            -- mantis
            checkMobs(mobsso10,"Mantis Pinapple","PineappleMantis1")
            checkMobs(mobsso11,"Mantis PineTree","ForestMantis1")
            checkMobs(mobsso12,"Mantis PineTree","ForestMantis2")
            -- scorpion
            checkMobs(mobsso13,"Scorpion","RoseBush")
            checkMobs(mobsso14,"Scorpion","RoseBush2")

            checkMobs(mobsso15,"Spider","Spider Cave")
            checkMobs(mobsso16,"Werewolf","WerewolfCave")
            checkMobs(mobsso17,"Tunnel Bear","TunnelBear")
            checkMobs(mobsso18,"King Beetle","King Beetle Cave")
            checkMobs(mobsso19,"Commando Chick","Commando Chick")
            checkMobs(mobsso20,"Coconut Crab","CoconutCrab")
            checkMobs(mobsso21,"Stump Snail","StumpSnail")
            wait(5)
        end
    end)
    looptimer()
end
miscmobs.MouseButton1Click:Connect(function()
    if mobsZone.Visible==false then
        mobsZone.Visible = true
        boardZone.Visible = false
        setColor(miscboard,0)
        setColor(miscmobs,2)
        showMobsTimer()
    end
end)

mMouse.KeyDown:Connect(function(key)
    if key=="t" then
        if hFarm == false and h15Colect == false then
            --collect15Token(true)
            --collectTokenSlow()
            local crun = mPlayer.Character.Humanoid.WalkSpeed
            local cpos = mRoot.Position
            mPlayer.Character.Humanoid.WalkSpeed = 100
            collectTokenWalk()
            wait(5)
            walkTo(cpos,false)
            while hWalk do wait(.1) end
            mPlayer.Character.Humanoid.WalkSpeed = crun
            hToken =false
        end
    end
end)
mMouse.Button1Down:Connect(function()
    if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
    mRoot.CFrame = mMouse.Hit * CFrame.new(0,2,0)
end)

-------------------------------------------
--    AUTO WALK 
------------------------------------------

function walkTo(tpos,jjump)
    hWalk = true
    local h = mPlayer.Character:FindFirstChild("Humanoid")
    if h then
        local cc=0
        local dp=(mRoot.Position-tpos).magnitude
        h:MoveTo(tpos)
        if jjump then h.Jump = true end
        while (mRoot.Position-tpos).magnitude>5 and hWalk do
            cc=cc+1
            if cc==5 then
                cc=(mRoot.Position-tpos).magnitude
                if cc>=dp then moveMeTo(CFrame.new(tpos), .1) end
                cc=0
                dp=(mRoot.Position-tpos).magnitude
            end
            wait(.1)
        end
    end
    hWalk = false
end

function collectTokenWalk()
    mRoot=mPlayer.Character.HumanoidRootPart
    hToken = true
    local nearme = false
    local cnear = 0
    local vpos = 0
    local tmove = 0
    local looptokens=coroutine.wrap(function()
        while hToken do
            vpos = false
            nearme = 60
            for _,v in pairs(workspace.Collectibles:GetChildren()) do
                if tostring(v)=="C" then
                    cnear = (v.Position-mRoot.Position).magnitude
                    if cnear <nearme then
                        nearme = cnear
                        vpos = v
                    end
                end
            end
            if vpos and nearme >3 then
                vpos.Name = "V"
                walkTo(Vector3.new(vpos.Position.x, mRoot.Position.y, vpos.Position.z), false)
                while hWalk do wait(.1) end
            else
                wait(.1)
            end
        end
    end)
    looptokens()
end

function gotoNearLine(go)
    local len = (mRoot.Position-go[1]).magnitude
    local cpos = 1
    local temp = nil
    for i=2,#go do
        temp = (mRoot.Position-go[i]).Magnitude
        if temp < len then
            len = temp
            cpos = i
        end
    end
    return cpos
end

function walktoFarm(fname,back,near)
    local h = mPlayer.Character:FindFirstChild("Humanoid")
    if h then
        hWalking = true
        local cjump = h.JumpPower
        local crun = h.WalkSpeed
        local cspeed = hSpeed
        hSpeed = false
        h.WalkSpeed = 80
        h.JumpPower = 80
        local go
        local goj
        if back then
            go = fieldBack[fname]
            goj = fieldBack[fname.."J"]
        else
            go = fieldGo[fname]
            goj = fieldGo[fname.."J"]
        end

        local bg = 1
        if near then bg = gotoNearLine(go) end
        for i=bg,#go do
            h.WalkSpeed = 80
            if goj[i] then wait(.2) end
            walkTo(go[i],goj[i])
            while hWalk do wait(.1) end
        end
        if back then
            walkTo(mPlayer.SpawnPos.Value.p,false)
        elseif fname=="Mountain" then
            fireCanon()
        end
        h.JumpPower = cjump
        if cspeed then
            hSpeed = true
            local loopspeed = coroutine.wrap(function()
                while hSpeed do
                    if mPlayer.Character.Humanoid.WalkSpeed < newSpeed then mPlayer.Character.Humanoid.WalkSpeed = crun end
                    wait(.1)
                end
            end)
            loopspeed()
        end
        h.WalkSpeed = crun
        hWalking = false
    end
end

function autoDigWalk(fname)
    -- get zone farm location
    local lsPos = fieldPos[fname]
    local fmax = false
    local vmax = fieldName[fname]
    local vmin = false
    fmax = workspace.FlowerZones:FindFirstChild(vmax)
    if hFarm then
        workspace.Collectibles:ClearAllChildren()
        walkTo(lsPos[2],false)
        while hWalk do wait(.1) end
        if hFarm then
            vmin = Vector3.new(fmax.CFrame.X -1- fmax.Size.x /2, mRoot.CFrame.Y-2, fmax.CFrame.Z -1- fmax.Size.z /2)
            vmax = Vector3.new(fmax.CFrame.X +1+ fmax.Size.x /2, mRoot.CFrame.Y+10, fmax.CFrame.Z +1+ fmax.Size.z /2)
        end
    end
    local thisY = mRoot.CFrame.Y

    local findfalling = coroutine.wrap(function()
        local diskColor = Color3.new(0.19607843458652,1,0.19607843458652)
        local vstar = false
        local vtran 
        local cnear
        local fstar = false
        while hFarm and iscollectDisk and (hSelling==false) do
            vtran = 80
            fstar = false
            for _,v in pairs(workspace.Particles:GetChildren()) do
                if v.Name=="WarningDisk" and v.Color==diskColor then
                    cnear=(v.Position-mRoot.Position).magnitude
                    if cnear<vtran then
                        vtran = cnear
                        fstar = v
                    end
                end
            end
            if fstar then
                hWaitingDisk=true
                hWalk = false
                wait(.2)
                walkTo(Vector3.new(fstar.Position.x,mRoot.Position.y,fstar.Position.z),false)
                while hWalk do wait(.1) end
                vstar = true
                while vstar  and hFarm do
                    vstar = false
                    for _,vs in pairs(workspace.Particles:GetChildren()) do
                        if vs==fstar then
                            vstar = true
                            break
                        end
                    end
                    wait(.1)
                end
                wait(.3)
                hWaitingDisk=false
            end
            wait(.1)
        end
    end)

    local findnear=coroutine.wrap(function()
        while hFarm and (hSelling == false) do
            while hWaitingDisk and hFarm do wait(.1) end
            if imdie then break end
            if hKillMod then
                while hKillMod and hFarm do
                    wait(1)
                end
            end
            nearme = 80
            thisV = false
            if fname == "Snails" then
                for _,v in pairs(workspace.Collectibles:GetChildren()) do
                    if (tostring(v)=="C" or tostring(v)=="V") and isfarSnail(v.Position) then
                        curvp = (v.Position-mRoot.Position).magnitude
                        if curvp < nearme then
                            nearme = curvp
                            thisV =v
                        end
                    end
                end
            else
                for _,v in pairs(workspace.Collectibles:GetChildren()) do
                    if (tostring(v)=="C" or tostring(v)=="V") and inMyZone(v.Position,vmax,vmin) then
                        curvp = (v.Position - mRoot.Position).magnitude
                        if curvp < nearme then
                            nearme = curvp
                            thisV = v
                        end
                    end
                end
            end
            if thisV then
                nextpos = thisV.Position
                if tostring(thisV)=="C" then
                    thisV.Name = "V"
                else
                    thisV.Name = "L"
                end
            else
                curvp=math.random(2,#lsPos)
                nextpos = lsPos[curvp]
            end
            if hFarm then
                local h = mPlayer.Character:FindFirstChild("Humanoid")
                if h then
                    nextpos = Vector3.new(nextpos.x,thisY,nextpos.z)
                    walkTo(nextpos, false)
                end
            end
            if thisV == false then wait(.5) end
        end
    end)
    local loopdig=coroutine.wrap(function()
        for k,v in pairs(workspace[mPlayer.Name]:GetChildren()) do
            if v.ClassName == "Tool" then
                while hFarm and (hSelling == false) do
                    if imdie then break end
                    v.ClickEvent:FireServer()
                    wait(.1)
                end
                break
            end
        end
    end)
    local loopwalk=coroutine.wrap(function()
        local h = mPlayer.Character:FindFirstChild("Humanoid")
        local crun = h.WalkSpeed
        local cspeed = hSpeed
        hSpeed = false
        while hFarm and (hWalking==false) do
            if h.WalkSpeed < 60 then h.WalkSpeed = 60 end
            wait(.1)
        end
        if cspeed then
            hSpeed = true
            while hSpeed do
                if h.WalkSpeed < crun then h.WalkSpeed = crun end
                wait(.1)
            end
        else
            h.WalkSpeed = crun
        end
    end)
    loopwalk()
    loopdig()
    findnear()
    if fname~="Snails" then findfalling() end
end

function autoFarmWalk(fname)
    mRoot = mPlayer.Character.HumanoidRootPart
    hFarm = true
    local plmove
    -- Go to Farmzone
    walktoFarm(fname,false,true)
    while hWalking do wait(.1) end
    -- Set up sprinlker
    if hBuildSprikler then
        plmove = tonumber("0".. BSpNum.Text)
        if plmove >= 0 and hFarm then
            if plmove > 4 then plmove = 4 end
            local ds = fieldSpinkler2[fname]
            ds = ds[plmove]
            local Sprinkler = {["Name"] = "Sprinkler Builder"}
            for i=1,#ds do
                if hFarm then
                    walkTo(ds[i],false)
                    while hWalk do wait(.1) end
                    wait(.3)
                    mPlayer.Character:FindFirstChild("Humanoid").Jump = true
                    wait(0.3)
                    game:GetService("ReplicatedStorage").Events.PlayerActivesCommand:FireServer(Sprinkler)
                    wait(2)
                end
            end
        end
    end
    --
    local loopsell=coroutine.wrap(function()
        while hFarm do
            if mPlayer.CoreStats.Pollen.Value >= mPlayer.CoreStats.Capacity.Value then
                if useMicro then
                    local A = {
                        ["Name"] = "Micro-Converter"
                    }
                    local Event = game:GetService("ReplicatedStorage").Events.PlayerActivesCommand
                    Event:FireServer(A)
                    wait(1)
                    if mPlayer.CoreStats.Pollen.Value >= mPlayer.CoreStats.Capacity.Value then 
                        useMicro = false
                        setColor(BSpMicro,1)
                    end
                else
                    hSelling = true
                    hWalk = false
                    wait(.3)
                    -- go back to hive
                    walktoFarm(fname,true,false)
                    while hWalking do wait(.1) end

                    if (mRoot.Position-mPlayer.SpawnPos.Value.p).magnitude>30 then moveMeTo(mPlayer.SpawnPos.Value,.1) end
                    wait(.3)
                    local oldpollen = mPlayer.CoreStats.Pollen.Value
                    game:GetService("ReplicatedStorage").Events.PlayerHiveCommand:FireServer("ToggleHoneyMaking")

                    plmove=0
                    while mPlayer.CoreStats.Pollen.Value>10 and (mRoot.Position-mPlayer.SpawnPos.Value.p).magnitude<30 do
                        plmove = plmove + 1
                        if plmove >= 10 then
                            if mPlayer.CoreStats.Pollen.Value > oldpollen then break end
                            oldpollen=mPlayer.CoreStats.Pollen.Value
                            plmove = 0
                        end
                        wait(1)
                    end
                    wait(3)
                    hSelling = false
                    if hFarm then
                        wait(.3)
                        walktoFarm(fname,false,false)
                        while hWalking do wait(.1) end
                        autoDigWalk(fname)
                    end
                end
            end
            if imdie then
                hFarm = false
            end
            wait(.1)
        end
    end)
    autoDigWalk(fname)
    loopsell()
end

function fireCanon()
    moveMeTo(CFrame.new(-239.4,18,343.6),.1)
    wait(.1)
    for i=1,#redcanon do
        local tmp = moveMeToLook(CFrame.new(redcanon[i]),.3 * i)
        tmp.Completed:wait()
    end
    moveMeTo(CFrame.new(redcanon[#redcanon]),.1)
    wait(.1)
end

testLabel1.Text = ""
testLabel2.Text = ""
testLabel3.Text = ""
testLabel4.Text = ""
testBar.Visible = true
testbutton.MouseButton1Click:Connect(function()
    testLabel1.Text = mRoot.Position.X
    testLabel2.Text = mRoot.Position.Y
    testLabel3.Text = mRoot.Position.Z
    return
end)