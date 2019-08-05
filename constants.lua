GameRegion = {
    -- character location
    characters = {
        Region(32, 606, 134, 99),
        Region(201, 606, 134, 99),
        Region(371, 606, 134, 99),
        Region(571, 606, 134, 99)
    },
    -- skill location
    skills = {
        Region(51, 536, 198, 23),
        Region(293, 536, 198, 23),
        Region(543, 536, 198, 23),
        Region(787, 536, 198, 23)
    },
    -- button location
    attackButton = Region(1122, 575, 92, 92),
    menuButton = Region(45, 609, 83, 78),
    foodButtonInMenu = Region(984, 567, 60, 62),
    foodButtonInAnotherDungeonMenu = Region(541, 572, 81, 77),
    useButtonInUseFoodPrompt = Region(674, 401, 220, 50),
    yesButton = Region(655, 253, 248, 253),
    mapButton = Region(252, 638, 50, 49),
    -- tap anywhere location
    tapAnyWhere = Region(802, 182, 216, 248),
    -- chests
    leftChestRegion = Region(170, 392, 382, 95),
    rightChestRegion = Region(802, 392, 366, 95),
    middleChestRegion = Region(255, 342, 527, 83),
    -- after battle screen
    rewardRegion = Region(22, 37, 92, 83),
    -- another dungeon complete screen
    congratulationScreen = Region(307, 100, 673, 54),
    -- minimap
    minimapInCorner = Region(1041, 35, 198, 103),
    openedMinimap = Region(342, 219, 590, 258)
}

-- direction for movement and swiping actions
-- used in func move, moveInPixel, swipeTo
Direction = {
    up = {offset = {x=0, y=-250}},
    right = {offset = {x=250, y=0}},
    down = {offset = {x=0, y=250}},
    left = {offset = {x=-250, y=0}}
}

-- buttons to be clicked, unlike GameRegion, 
-- buttons have associated images
-- used in func clickButton
Button = {
    attack = {
        region = GameRegion.attackButton,
        image = "attack_button.jpg",
        name = "attack"
    },
    menu = {
        region = GameRegion.menuButton,
        image = "menu_button.jpg",
        name = "menu"
    },
    map = {
        region = GameRegion.mapButton,
        image = "map_button.jpg",
        name = "map"
    },
    food = {
        region = GameRegion.foodButtonInMenu,
        image = "food_button.jpg",
        name = "food"
    },
    foodAD = {
        region = GameRegion.foodButtonInAnotherDungeonMenu,
        image = "AD_food_button.jpg",
        name = "foodAD"
    },
    -- use button prompt when eating food
    use = {
        region = GameRegion.useButtonInUseFoodPrompt,
        image = "use_food_confirm.jpg",
        name = "use"
    },
    -- yes button prompt when getting food, travel in map, start boss in AD
    yes = {
        region = GameRegion.yesButton,
        image = "yes_button.jpg",
        name = "yes"
    }
}

-- region and associated region for state check
-- used in func isInState
GameState = {
    inBattle = {
        region = GameRegion.attackButton,
        image = "attack_button.jpg"
    },
    inRewardScreen = {
        region = GameRegion.rewardRegion,
        image = "combat_end.jpg"
    },
    inCongratulationScreen = {
        region = GameRegion.congratulationScreen,
        image = "congratulation.jpg"
    }
}

-- chests region for another dungeon
-- used  in func takeChest
Chest = {
    leftSide = {
        region = GameRegion.leftChestRegion,
        offsetY = -193
    },
    rightSide = {
        region = GameRegion.rightChestRegion,
        offsetY = -193
    },
    middle = {
        region = GameRegion.middleChestRegion,
        offsetY = -154
    }
}

-- lua language, constants for raising exceptions
reportError = {
    toCurrentFunction = 1,
    toCaller = 2
}