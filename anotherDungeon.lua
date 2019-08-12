require(scriptPath() .. "constants")
require(scriptPath() .. "functions")
require(scriptPath() .. "action")

function dungeonScript(mobsComat, bossCombat, dungeonInfo, currentFloor, 
      isBattlesDone, difficulty, repeatTimes)
  print("dungeonScript start")
  local ADTimer = Timer()
  local repeatTimes = repeatTimes or 1
  for i=1,repeatTimes do
    print("starting run #" .. i)
    ADTimer:set()
    if i ~= 1 then
      isBattlesDone = false
      currentFloor = 1
      print("travel by map")
      retravelToSpacetimeRift()
      getPromisedFruitThenEnterDoor()
      dungeonInfo.selectDungeon()
      selectDifficulty(difficulty)
    end

    clearAnotherDungeon(mobsComat, bossCombat, dungeonInfo, 
        currentFloor, isBattlesDone)
    print(string.format("finished run #%s in %s", 
        i, formatSecondsToMinuteSecondString(ADTimer:check())))
  end
end

function clearAnotherDungeon(mobsComat, bossCombat, dungeonInfo, 
      currentFloor, isBattlesDone)
  local willClearMobs = not isBattlesDone

  for floor=currentFloor,3 do
    local moveDirection = dungeonInfo.moveDirectionAfterCombat[floor]
    print("in floor " .. floor)
    if willClearMobs then
      require(scriptPath() .. "farmMobs")
      farmMobScript(mobsComat, 5, false, moveDirection)
      move(moveDirection, 2)
    end
    for _, action in ipairs(dungeonInfo.moves[floor]) do
      action:execute()
    end
    wait(1)
    willClearMobs = true
  end
  
  print("in floor 4")
  wait(3)
  useFood(true)
  for _, action in ipairs(dungeonInfo.moves[4]) do
    action:execute()
  end
  clickButton(Button.yes)
  print("boss fight started")
  wait(2)
  bossCombat:start()
  wait(2)
  dismissCongratulationScreen()
end

function selectDifficulty(difficulty)
  click(difficulty.location)
  wait(1)
  clickButton(Button.move)
  wait(1)
end

function getPromisedFruitThenEnterDoor()
  getFoodFromInn(Location(433, 55), true)
  move(Direction.left, 0.5)
  wait(1)
  clickButton(Button.doorAD)
  wait(2)
end

function takeChest(chest, image)
  local match = chest.region:exists(Pattern(image), 1)
  if match ~= nil then
    click(match:getCenter():offset(0, chest.offsetY))
    wait(1.5)
    tapScreen()
    print("chest taken")
  else
    print("chest not found")
  end
end

function dismissCongratulationScreen()
  -- assumes events goes (not checked): 
  -- congratulation -> light/shadow -> white key

  -- dismiss congratulation screen 
  wait(4)
  waitUntilInState(GameState.inCongratulationScreen, 4)
  wait(2)
  tapScreen()
  wait(2)
  -- dismiss shadow/light gain screen
  if isInState(GameState.inCongratulationScreen, 2) then
    print("got light/shadow")
    wait(2)
    tapScreen()
    wait(2)
  end
  -- dismiss white key
  if isInState(GameState.inObtainedWhiteKeyScreen, 2) then
    print("got white key")
    wait(2)
    tapScreen()
    wait(2)
  end

  if isInState(GameState.inDefaultScreen, 1) and 
      not isInState(GameState.inCongratulationScreen, 1) and 
      not isInState(GameState.inObtainedWhiteKeyScreen, 1) then
    print("congratulation screen dismissed")
  else
    error("something went wrong when dismissing congratulation screen")
  end
end

function retravelToSpacetimeRift()
  clickButton(Button.map)
  wait(3)
  click(Location(629, 384))
  clickButton(Button.yes)
  wait(3)
  print("retravelled to spacetime rift")
end