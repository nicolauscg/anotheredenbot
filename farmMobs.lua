require(scriptPath() .. "constants")
require(scriptPath() .. "functions")

function farmMobScript(combat, battleCount, willUseFood, alwaysMoveRightAfterBattle)
  local runningDirection = nil
  local battlesCompleted = 0
  local foodEaten = false
  local totalBattles = willUseFood and 
          2*battleCount or battleCount
  local noMoreEnemyTimeout = 45

  local timer = Timer()
  while(true) do
    -- exit farming if timeout
    if timer:check() > noMoreEnemyTimeout then
      if alwaysMoveRightAfterBattle then
        move(Direction.right, 2)
      else
        move(Direction.left, 2)
      end
      print("no more enemy found, battled " .. battlesCompleted .. " times")
      return
    end
    -- determine running direction
    if runningDirection ~= Direction.right then
      runningDirection = Direction.right
    else
      runningDirection = Direction.left
    end
    -- check monster encounter then battle
    if isInState(GameState.inBattle, 1) then
      -- toast("in combat")
      combat:start()
      battlesCompleted = battlesCompleted + 1
      if alwaysMoveRightAfterBattle then
        runningDirection = Direction.right
      end
      timer:set()
    end 
    -- use food if available
    if (menu_farmMobs_haveFood and (not foodEaten) 
        and battlesCompleted == menu_farmMobs_battlesCount) then
      print("food consumed")
      wait(2)
      useFood()
      foodEaten = true
    end
    -- move left and right
    wait(0.5)
    move(runningDirection, 2)
    -- exit script if all battle completed
    if (battlesCompleted == totalBattles) then
      print("battled " .. battlesCompleted .. "times")
      wait(1)
      return
    end
  end
end