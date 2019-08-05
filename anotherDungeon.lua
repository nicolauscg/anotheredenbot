require(scriptPath() .. "constants")
require(scriptPath() .. "functions")
require(scriptPath() .. "action")

function dungeonScript(mobsComat, bossCombat, dungeonInfo, currentFloor, isBattlesDone)
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
    wait(2)
    -- tap again if get light/shadow
    if isInState(GameState.inCongratulationScreen, 2) then
      tapScreen()
    end
  end
end

