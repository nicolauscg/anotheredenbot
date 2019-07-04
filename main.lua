require(scriptPath() .. "commonLib") -- ankulua additional functions
require(scriptPath() .. "constants")
require(scriptPath() .. "functions")
require(scriptPath() .. "combat")

-- vivo v11 pro resolution scaled to 1280px width
scriptWidth = 1280
scriptHeight = 591
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
    newRow()
    dialogShow("bot main menu")

    if menu_scriptSelection == 1 then
        farmMobsMenu()
    elseif  menu_scriptSelection == 2 then
        anotherDungeonMenu()
    elseif  menu_scriptSelection == 3 then
        combatMenu()
    end
end

function farmMobsMenu()
    dialogInit()
    addCheckBox("menu_farmMobs_haveFood", "food available", true)
    newRow()
    addTextView("number of battles before/after food")
    addEditNumber("menu_farmMobs_battlesCount", 5)
    dialogShow("farm mobs menu")

    require(scriptPath() .. "farmMobs")
    farmMobScript(globalMobsCombat, menu_farmMobs_battlesCount, menu_farmMobs_haveFood)
    scriptExit("farm mobs finished")
end

function anotherDungeonMenu()
    dialogInit()
    addRadioGroup("menu_anotherDungeon_scriptSelection", 1)
    addRadioButton("man eating marsh", 1)
    addRadioButton("saki dream world", 2)
    newRow()
    dialogShow("another dungeon menu")

    scriptExit("not implemented yet")
end

function combatMenu()
    dialogInit()
    addTextView("moves for mobs")
    addEditText("menu_combat_mobsStrategy", "")
    newRow()
    addTextView("moves for boss")
    addEditText("menu_combat_bossStrategy", "")
    dialogShow("combat menu")
    globalMobsCombat:setWithString(menu_combat_mobsStrategy)
    globalBossCombat:setWithString(menu_combat_bossStrategy)
    -- go back to main menu
    main()
end

main()