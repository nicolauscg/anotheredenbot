require(scriptPath() .. "constants")
require(scriptPath() .. "functions")

function farmMobScript(combat, battleCount, willUseFood, 
      moveDirectionAfterBattle)
  local runningDirection = nil
  local battlesCompleted = 0
  local isFoodAvailable = willUseFood
  local totalBattles = willUseFood and 
          2*battleCount or battleCount
  local noMoreEnemyTimeout = 45
  -- true if moveDirectionAfterBattle is not nil else false
  local willOverwriteDirection = moveDirectionAfterBattle and true or false

  local timer = Timer()
  while(true) do
    -- determine running direction
    if willOverwriteDirection and moveDirectionAfterBattle ~= nil then
      runningDirection = moveDirectionAfterBattle
    else
      if runningDirection ~= Direction.right then
        runningDirection = Direction.right
      else
        runningDirection = Direction.left
      end
    end
    willOverwriteDirection = false
    -- move left and right
    wait(0.1)
    move(runningDirection, 2)
    -- check monster encounter then battle
    if isInState(GameState.inBattle, 1) then
      combat:start()
      wait(2)
      willOverwriteDirection = true
      battlesCompleted = battlesCompleted + 1
      timer:set() -- reset timer
    end
    -- use food if available
    if (isFoodAvailable and battlesCompleted == battleCount) then
      print("consuming food")
      useFood()
      isFoodAvailable = false
    end
    -- exit script if all battle completed
    if (battlesCompleted == totalBattles) then
      print("battled " .. battlesCompleted .. " times")
      return
    end
    -- exit farming if timeout
    if timer:check() > noMoreEnemyTimeout then
      print("no more enemy found, battled " .. battlesCompleted .. " times")
      return
    end
  end
end