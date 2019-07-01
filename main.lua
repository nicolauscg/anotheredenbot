require(scriptPath() .. "commonLib") -- ankulua additional functions
require(scriptPath() .. "constants")
require(scriptPath() .. "combat")

-- vivo v11 pro resolution scaled to 1280px width
scriptWidth = 1280
scriptHeight = 591
Settings:setScriptDimension(true, scriptWidth)
Settings:setCompareDimension(true, scriptWidth)
Settings:set("MinSimilarity", 0.7)
Settings:set("AutoWaitTimeout", 0.3)
setImmersiveMode(true) -- whole screen as script area

-- functions
function main()
    dialogInit()
    addRadioGroup("menu_scriptSelection", 1)
    addRadioButton("farm mobs", 1)
    newRow()
    dialogShow("bot main menu")

    if menu_scriptSelection == 1 then
        farmMobsMenu()
    end
end

function farmMobsMenu()
    -- farm mobs menu
    dialogInit()
    addCheckBox("menu_farmMobs_haveFood", "food available", true)
    newRow()
    addTextView("number of battles before/after food")
    addEditNumber("menu_farmMobs_battlesCount", 5)
    dialogShow("farm mobs menu")

    require(scriptPath() .. "farmMobs")
    farmMobScript()
end

main()