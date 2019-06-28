require(scriptPath() .. "commonLib") -- ankulua additional functions

-- vivo v11 pro resolution scaled to 1280px width
scriptWidth = 1280
scriptHeight = 591
Settings:setScriptDimension(true, scriptWidth)
Settings:setCompareDimension(true, scriptWidth)
Settings:set("MinSimilarity", 0.7)
Settings:set("AutoWaitTimeout", 0.3)
setImmersiveMode(true) -- whole screen as script area

local GameRegion = {
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
local Direction = {
    up = {offset = {x=0, y=-150}},
    right = {offset = {x=100, y=0}},
    down = {offset = {x=0, y=150}},
    left = {offset = {x=-100, y=0}}
}
-- buttons to be clicked, unlike GameRegion, 
-- buttons have associated images
local Button = {
    attack = {
        region = GameRegion.attackButton,
        image = "attackButton.jpg"
    }
}
-- list of states to check for
local GameState = {
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
local reportError = {
    toCurrentFunction = 1,
    toCaller = 2
}

-- functions
function main()
    dialogInit()
    addRadioGroup("radioSelection", 1)
    addRadioButton("test script", 1)
    newRow()
    dialogShow("farming bot")

    if radioSelection == 1 then
        testScript()
    end
end

function testScript()
    local runningDirection = nil
    local combat = Combat:new(nil) -- setup skill selection
            :next( Turn:new(nil):setAllSkill(4,4,4,3) )
            :next( Turn:new(nil):setSkill(1,1):setSkill(4,2) )
            :next( Turn:new(nil):setSkill(2,1) )

    toast("starting")
    wait(1)
    -- swipeTo(Direction.down)
    -- wait(2)

    while(true) do
        -- check if encounter monster
        if isInState(GameState.inBattle, 1) then
            toast("in combat")
            combat:start()
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


function isInState(gameState, waitTime)
    waitTime = waitTime or 1
    return gameState.region:exists(Pattern(gameState.image), waitTime)
end

-- class Combat, represents sequence of actions done from start until end of combat
Combat = {}
function Combat:new (o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   self.turns = {}
   self.turn = 1
   self.TIMEOUT = 10
   return o
end
function Combat:start()
    if not isInState(GameState.inBattle, 1) then
        error("currently not in battle state", reportError.toCaller)
    end
    self.turn = 1
    do -- a block just to provide scope
        local index = 1 -- array starts at index 1
        local turn = nil
        while(true) do
            toast("turn " .. self.turn)
            turn = self.turns[index]
            turn:execute() -- keep executing last turn if battle not yet finished
            currentState = regionWaitMulti({GameState.inBattle, GameState.inRewardScreen}, self.TIMEOUT)
            if currentState == -1 then
                error("cannot determine if in battle or reward screen", 
                        reportError.toCurrentFunction)
            elseif currentState == 2 then -- if in rewardScreen
                -- dismiss reward screen, combat finished
                tapScreen()
                break
            end
            -- increment until last index
            if index < #self.turns then index = index + 1 end
            self.turn = self.turn + 1
        end
    end
end
function Combat:next(turn)
    table.insert(self.turns, turn)
    return self
end

-- class Turn, represents skill selection of every character
-- and pressing attack in one turn during combat
Turn = {}
function Turn:new (o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   -- index denotes character, value denotes which skill to use
   -- nil indicates no change
   self.charactersSkill = {nil, nil, nil, nil}
   self.DELAY_BETWEEN_ACTION = 0.5
   return o
end
function Turn:setSkill(characterNumber, skillNumber)
    if not (1 <= characterNumber and characterNumber <= 4 and
            1 <= skillNumber and skillNumber <= 4) then
        error("characterNumber and skillNumber must be 1 to 4 inclusive", reportError.toCaller)
    end
    self.charactersSkill[characterNumber] = skillNumber
    return self
end
function Turn:setAllSkill(firstSkill, secondSkill, thirdSkill, fourthSkill)
    self.charactersSkill = {firstSkill, secondSkill, thirdSkill, fourthSkill}
    return self
end
function Turn:execute()
    for i=1, 4 do
        local characterNumber = i
        local skillNumber = self.charactersSkill[characterNumber]
        if skillNumber ~= nil then
            clickRegion(GameRegion.characters[characterNumber])
            wait(self.DELAY_BETWEEN_ACTION)
            clickRegion(GameRegion.skills[skillNumber])
            wait(self.DELAY_BETWEEN_ACTION)
        end
    end
    clickButton(Button.attack)
end

main()