require(scriptPath() .. "constants")
require(scriptPath() .. "functions")
require(scriptPath() .. "action")

function dungeonScript(mobsComat, bossCombat, dungeonInfo, currentFloor, isBattlesDone)
  local willClearMobs = not isBattlesDone

  for floor=currentFloor,3 do
    if willClearMobs then
      require(scriptPath() .. "farmMobs")
      farmMobScript(mobsComat, 5, false, true)
      move(Direction.right, 2)
    end
    for _, action in ipairs(dungeonInfo.moves[currentFloor]) do
      action:execute()
    end
    swipeTo(Direction.up)
    willClearMobs = true
  end

  useFoodInAD()
  for _, action in ipairs(dungeonInfo.moves[4]) do
    action:execute()
  end
  clickButton(Button.yes)
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

