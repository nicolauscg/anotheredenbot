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
    yesButton = Region(671, 369, 220, 50),
    minimapInCorner = Region(1041, 35, 198, 103),
    openedMinimap = Region(342, 219, 590, 258),
    -- tap anywhere location
    tapAnyWhere = Region(438, 271, 407, 166),
    -- chests
    leftChestRegion = Region(170, 392, 382, 95),
    rightChestRegion = Region(802, 392, 366, 95),
    middleChestRegion = Region(255, 342, 527, 83),
    -- after battle screen
    rewardRegion = Region(22, 37, 92, 83),
    -- another dungeon complete screen
    congratulationScreen = Region(307, 100, 673, 54)
}
-- direction for swiping actions
Direction = {
    up = {offset = {x=0, y=-250}},
    right = {offset = {x=250, y=0}},
    down = {offset = {x=0, y=250}},
    left = {offset = {x=-250, y=0}}
}
-- buttons to be clicked, unlike GameRegion, 
-- buttons have associated images
Button = {
    attack = {
        region = GameRegion.attackButton,
        image = "attack_button.jpg"
    },
    menu = {
        region = GameRegion.menuButton,
        image = "menu_button.jpg"
    },
    food = {
        region = GameRegion.foodButtonInMenu,
        image = "food_button.jpg"
    },
    foodAD = {
        region = GameRegion.foodButtonInAnotherDungeonMenu,
        image = "AD_food_button.jpg"
    },
    use = {
        region = GameRegion.useButtonInUseFoodPrompt,
        image = "use_food_confirm.jpg"
    },
    yes = {
        region = GameRegion.yesButton,
        image = "yes_button.jpg"
    }
}
-- list of states to check for
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
-- constants for raising exceptions
reportError = {
    toCurrentFunction = 1,
    toCaller = 2
}