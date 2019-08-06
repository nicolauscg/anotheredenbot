require(scriptPath() .. "constants")
require(scriptPath() .. "functions")
require(scriptPath() .. "action")

function dungeonScript(mobsComat, bossCombat, dungeonInfo, currentFloor, isBattlesDone, difficulty, alreadyInDungeon)
  local startingFloor = alreadyInDungeon and currentFloor or 1
  if not alreadyInDungeon then
    getPromisedFruitThenEnterDoor()
    selectSakiDreamWorld(difficulty)
  end

  clearAnotherDungeon(mobsComat, bossCombat, dungeonInfo, startingFloor, isBattlesDone)
end

function clearAnotherDungeon(mobsComat, bossCombat, dungeonInfo, currentFloor, isBattlesDone)
  local willClearMobs = not isBattlesDone

  for floor=currentFloor,3 do
    print("in floor " .. floor)
    if willClearMobs then
      require(scriptPath() .. "farmMobs")
      farmMobScript(mobsComat, 5, false, Direction.right)
      move(Direction.right, 2)
    end
    for _, action in ipairs(dungeonInfo.moves[floor]) do
      action:execute()
    end
    swipeTo(Direction.up)
    willClearMobs = true
  end
  
  print("in floor 4")
  wait(3)
  useFoodInAD()
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

function getPromisedFruitThenEnterDoor()
  clickButton(Button.map)
  wait(3)
  click(Location(640, 395))
  tapScreen()
  clickButton(Button.yes)
  wait(3)
  getFoodFromInn(Location(433, 55), true)
  move(Direction.left, 0.5)
  wait(1)
  clickButton(Button.doorAD)
  wait(2)
end

function selectSakiDreamWorld(difficulty)
  click(Location(319, 118)) -- click future timeline
  wait(2)
  click(Location(645, 418)) -- click IDA school
  wait(1)
  click(Location(649, 504)) -- click saki dream world
  wait(1)
  click(difficulty.location) -- click difficulty
  wait(1)
  clickButton(Button.move)
end

function useFoodInAD()
  clickButton(Button.menu)
  clickButton(Button.foodAD)
  clickButton(Button.use)
  wait(2)
  tapScreen()
  wait(2)
  tapScreen()
  print("AD food used")
end

function takeChest(chest, image)
  local match = chest.region:exists(Pattern(image), 1)
  if match ~= nil then
    click(match:getCenter():offset(0, chest.offsetY))
    wait(1)
    tapScreen()
    print("chest taken")
  else
    print("chest not found")
  end
end

function dismissCongratulationScreen()
  if isInState(GameState.inCongratulationScreen, 5) then
    tapScreen()
  end
  for i=1,2 do -- for dismissing light/shadow and white card
    wait(2)
    if isInState(GameState.inCongratulationScreen, 2) then
      tapScreen()
    end
  end
  wait(2)
  move(Direction.right, 0.2)
  wait(1)
  local congratAtScreen = isInState(GameState.inCongratulationScreen)
  local doorAtScreen = isInState(Button.doorAD)
  if not congratAtScreen and doorAtScreen then
    print("congratulation screen dismissed")
  elseif  congratAtScreen and not doorAtScreen then
    error("congratulation screen not dismissed")
  else
    error("something went wrong in dismissCongratulationScreen()")
  end
end

