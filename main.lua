require(scriptPath() .. "commonLib") -- ankulua additional functions
require(scriptPath() .. "constants")
require(scriptPath() .. "functions")
require(scriptPath() .. "combat")

-- script built for 1280x720 resolution
scriptWidth = 1280
Settings:setScriptDimension(true, scriptWidth)
Settings:setCompareDimension(true, scriptWidth)
Settings:set("MinSimilarity", 0.7)
Settings:set("AutoWaitTimeout", 0.3)
setImmersiveMode(true) -- whole screen as script area

globalMobsCombat = Combat:new(nil)
globalBossCombat = Combat:new(nil)

-- functions
function main()
    dialogInit()
    addRadioGroup("menu_scriptSelection", 1)
    addRadioButton("farm mobs", 1)
    addRadioButton("do another dungeon", 2)
    addRadioButton("set combat", 3)
    addRadioButton("test", 4)
    newRow()
    dialogShowFullScreen("bot main menu")

    if menu_scriptSelection == 1 then
        farmMobsMenu()
    elseif  menu_scriptSelection == 2 then
        anotherDungeonMenu()
    elseif  menu_scriptSelection == 3 then
        combatMenu()
    elseif  menu_scriptSelection == 4 then
        test()
    end
end

function farmMobsMenu()
    dialogInit()
    addCheckBox("menu_farmMobs_haveFood", "food available", true)
    newRow()
    addTextView("number of battles before/after food")
    addEditNumber("menu_farmMobs_battlesCount", 5)
    dialogShowFullScreen("farm mobs menu")

    require(scriptPath() .. "farmMobs")
    -- toast("farming mobs")
    farmMobScript(globalMobsCombat, menu_farmMobs_battlesCount, menu_farmMobs_haveFood)
    scriptExit("farm mobs finished")
end

function anotherDungeonMenu()
    dialogInit()
    addCheckBox("menu_anotherDungeon_battlesDone", "5 battles done?", false)
    addTextView("current floor")
    addEditNumber("menu_anotherDungeon_currentFloor", 1)
    newRow()
    addRadioGroup("menu_anotherDungeon_scriptSelection", 1)
    addRadioButton("saki dream world", 1)
    newRow()
    dialogShowFullScreen("another dungeon menu")
    
    local dungeonMenuSelectionToFileName = {
        "sakiDreamWorld"
    }
    require(scriptPath() .. "action")
    require(scriptPath() .. "anotherDungeon")
    
    local anotherDungeonInfo = require(scriptPath() .. 
            dungeonMenuSelectionToFileName[menu_anotherDungeon_scriptSelection])
    dungeonScript(globalMobsCombat, globalBossCombat, anotherDungeonInfo, 
        menu_anotherDungeon_currentFloor, menu_anotherDungeon_battlesDone)
    scriptExit("another dungeon finished")
end

function combatMenu()
    dialogInit()
    addTextView("moves for mobs")
    addEditText("menu_combat_mobsStrategy", "")
    newRow()
    addTextView("moves for boss")
    addEditText("menu_combat_bossStrategy", "")
    dialogShowFullScreen("combat menu")
    globalMobsCombat:setWithString(menu_combat_mobsStrategy)
    globalBossCombat:setWithString(menu_combat_bossStrategy)
    -- go back to main menu
    main()
end

function test()
    globalBossCombat:start()
end

main()