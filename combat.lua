require(scriptPath() .. "constants")
require(scriptPath() .. "functions")

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
                wait(1)
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
function Turn:new()
    newObj = {
        charactersSkill = {nil,nil,nil,nil},
        DELAY_BETWEEN_ACTION = 0.2
    }
    self.__index = self
    return setmetatable(newObj, self)
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
            tapScreen()
            wait(self.DELAY_BETWEEN_ACTION)
        end
    end
    clickButton(Button.attack)
end