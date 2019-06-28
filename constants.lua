GameRegion = {
    -- character location
    characters = {
        Region(181, 512, 73, 44),
        Region(317, 505, 87, 55),
        Region(468, 504, 76, 57),
        Region(595, 507, 78, 46)
    },
    -- skill location
    skills = {
        Region(212, 437, 92, 25),
        Region(392, 433, 117, 26),
        Region(606, 436, 118, 25),
        Region(813, 439, 123, 23)
    },
    -- button location
    attackButton = Region(1055, 471, 85, 81),
    menuButton = Region(169, 508, 78, 60),
    foodButtonInMenu = Region(948, 466, 48, 49),
    useButtonInUseFoodPrompt = Region(693, 329, 160, 43),
    -- tap anywhere location
    tapAnyWhere = Region(880, 204, 137, 121),
    -- others
    rewardRegion = Region(62, 29, 64, 70)
}
-- direction for swiping actions
Direction = {
    up = {offset = {x=0, y=-150}},
    right = {offset = {x=100, y=0}},
    down = {offset = {x=0, y=150}},
    left = {offset = {x=-100, y=0}}
}
-- buttons to be clicked, unlike GameRegion, 
-- buttons have associated images
Button = {
    attack = {
        region = GameRegion.attackButton,
        image = "attackButton.jpg"
    },
    menu = {
        region = GameRegion.menuButton,
        image = "menuButton.jpg"
    },
    food = {
        region = GameRegion.foodButtonInMenu,
        image = "foodButton.jpg"
    },
    use = {
        region = GameRegion.useButtonInUseFoodPrompt,
        image = "useInUseFood.jpg"
    }
}
-- list of states to check for
GameState = {
    inBattle = {
        region = GameRegion.attackButton,
        image = "attackButton.jpg"
    },
    inRewardScreen = {
        region = GameRegion.rewardRegion,
        image = "rewardScreen.jpg"
    }
}
-- constants for raising exceptions
reportError = {
    toCurrentFunction = 1,
    toCaller = 2
}