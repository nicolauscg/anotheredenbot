require(scriptPath() .. "constants")
require(scriptPath() .. "functions")

-- class Combat
-- represents sequence of actions done from start until end of combat
Combat = {}
function Combat:new()
  newObj = {
    turns = {},
    turn = 1,
    TURN_TIMEOUT = 30
  }
  self.__index = self
  return setmetatable(newObj, self)
end
-- start executing skills in self.turns until battle is finished
function Combat:start()
  if not isInState(GameState.inBattle, 1) then
    error("currently not in battle state", reportError.toCaller)
  end
  if #self.turns == 0 then
    self:addNextTurn(Turn:new(nil))
  end
  self.turn = 1
  do
    local index = 1
    local turn = nil
    while(true) do
      print("turn " .. self.turn)
      turn = self.turns[index]
      turn:execute() -- keep executing last turn if battle not yet finished
      wait(2)
      currentState = regionWaitMulti(
        {GameState.inBattle, GameState.inRewardScreen}, 
        self.TURN_TIMEOUT
      )
      if currentState == -1 then
        error("cannot determine if in battle or reward screen", 
            reportError.toCurrentFunction)
      -- if in reward screen, dismiss prompt, combat finished
      elseif currentState == 2 then
        print("battle finished")
        wait(2)
        tapScreen()
        break
      end
      -- increment until last index
      if index < #self.turns then index = index + 1 end
      self.turn = self.turn + 1
    end
  end
end
-- set next turn of combat
function Combat:addNextTurn(turn)
  table.insert(self.turns, turn)
  return self
end
-- set multiple next turns of combat, use space to seperate turns
-- format of one turn: [0-4][0-4][0-4][0-4]
-- valid example: "1234 0003 0010"
function Combat:setWithString(string)
  self:validateCombatStringInput(string)
  for _, move in ipairs(split(string)) do
    self:addNextTurn(Turn:new(nil):setAllSkill(
      tonumber(move:sub(1,1)), tonumber(move:sub(2,2)), 
      tonumber(move:sub(3,3)), tonumber(move:sub(4,4))
    ))
  end
end
function Combat:validateCombatStringInput(string)
  for _, move in ipairs(split(string)) do
    if #move ~= 4 then
      error("each turn must be 4 digits")
    end
    if string.match(move, "[0-4][0-4][0-4][0-4]") == nil then
      error("each turn consist of only digits 0 to 4")
    end
  end
end
function Combat:toString()
    local string = ""
    for _, turn in ipairs(self.turns) do
        string = string .. string.format("%s\n", turn:toString())
    end
    return string
end

-- class Turn, represents skill selection of every character
-- and pressing attack in one turn during combat
Turn = {}
function Turn:new()
  newObj = {
    charactersSkill = {0,0,0,0}
  }
  self.__index = self
  return setmetatable(newObj, self)
end
-- set character to use certain skill when executed
function Turn:setSkill(characterNumber, skillNumber)
  if not (1 <= characterNumber and characterNumber <= 4) then
    error("characterNumber must be 1 to 4 inclusive", reportError.toCaller)
  end
  if not (0 <= skillNumber and skillNumber <= 4) then
    error("skillNumber must be 0 to 4 inclusive", reportError.toCaller)
  end
  self.charactersSkill[characterNumber] = skillNumber
  return self
end
-- set all characters skills
function Turn:setAllSkill(firstSkill, secondSkill, thirdSkill, fourthSkill)
  for _, skill in ipairs({firstSkill, secondSkill, thirdSkill, fourthSkill}) do
    if not (0 <= skill and skill <= 4) then
      error("skillNumber must be 0 to 4 inclusive", reportError.toCaller)
    end
  end
  self.charactersSkill = {firstSkill, secondSkill, thirdSkill, fourthSkill}
  return self
end
-- execute clicks for skill selection of characters
function Turn:execute()
  if not isInState(GameState.inBattle) then
    error("trying to call Turn:execute() while not in battle", 
        reportError.toCurrentFunction)
  end
  for i=1, 4 do
    local characterNumber = i
    local skillNumber = self.charactersSkill[characterNumber]
    if skillNumber ~= 0 then
      clickRegion(GameRegion.characters[characterNumber])
      clickRegion(GameRegion.skills[skillNumber])
      tapScreen()
    end
  end
  wait(0.2)
  clickButton(Button.attack, 3)
end
function Turn:toString()
  local string = ""
  for char, skill in ipairs(self.charactersSkill) do
    string = string .. string.format("%s[%s] ", char, skill)
  end
  return string
end