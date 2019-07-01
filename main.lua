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
        farmMobScript()
    end
end

function farmMobScript()
    -- farm mobs menu
    dialogInit()
    addCheckBox("menu_farmMobs_haveFood", "food available", true)
    newRow()
    addTextView("number of battles before/after food")
    addEditNumber("menu_farmMobs_battlesCount", 5)
    dialogShow("farm mobs menu")

    local runningDirection = nil
    local combat = Combat:new(nil) -- setup skill selection
            :next( Turn:new(nil):setAllSkill(4,4,4,3) )
            :next( Turn:new(nil):setSkill(1,1):setSkill(4,2) )
            :next( Turn:new(nil):setSkill(2,1) )
    local battlesCompletedCount = 0
    local foodEaten = false
    local totalBattles = menu_farmMobs_haveFood and 
            2*menu_farmMobs_battlesCount or menu_farmMobs_battlesCount

    toast("farming mobs")
    wait(1)
    while(true) do
        -- check if encounter monster
        if isInState(GameState.inBattle, 1) then
            toast("in combat")
            combat:start()
            battlesCompletedCount = battlesCompletedCount + 1
        end 
        -- eat food after battles if available
        if (menu_farmMobs_haveFood and (not foodEaten) 
                and battlesCompletedCount == menu_farmMobs_battlesCount) then
            wait(2)
            useFood()
            foodEaten = true
        end
        -- exit script
        if (battlesCompletedCount == totalBattles) then
            wait(1)
            keyevent(3)
            scriptExit("script finished")
        end
        wait(0.5)
        -- move left and right
        if runningDirection ~= Direction.left then
            runningDirection = Direction.left
        else
            runningDirection = Direction.right
        end
        move(runningDirection, 2)
    end
end

function move(direction, duration)
    duration = duration or 2
    local startLoc = GameRegion.tapAnyWhere:getCenter()
    local endLoc = startLoc:offset(direction.offset.x, direction.offset.y)
    manualTouch({
        {action = "touchDown", target = startLoc},
        {action = "wait", target = 0.1},
        {action = "touchMove", target = endLoc},
        {action = "wait", target = duration},
        {action = "touchUp", target = endLoc}
    })
end

function swipeTo(direction)
    -- cant get this to work
    -- move(direction, 0.1)
    local startLoc = GameRegion.tapAnyWhere:getCenter()
    local endLoc = startLoc:offset(direction.offset.x, direction.offset.y)
    swipe(startLoc, endLoc)
end

function clickRegion(region)
    click(region:getCenter())
end

function clickButton(button, waitTime)
    waitTime = waitTime or 1
    if button.region:exists(Pattern(button.image), waitTime) then
        clickRegion(button.region)
    end
end

function tapScreen()
    clickRegion(GameRegion.tapAnyWhere)
end

function useFood()
    toast("eating food")
    clickButton(Button.menu)
    clickButton(Button.food)
    clickButton(Button.use)
    wait(2)
    tapScreen()
    wait(2)
    tapScreen()
end

function isInState(gameState, waitTime)
    waitTime = waitTime or 1
    return gameState.region:exists(Pattern(gameState.image), waitTime)
end

main()