require(scriptPath() .. "constants")
require(scriptPath() .. "functions")

function farmMobScript(combat, battleCount, willUseFood)
  local runningDirection = nil
  local battlesCompleted = 0
  local foodEaten = false
  local totalBattles = willUseFood and 
          2*battleCount or battleCount

  toast("farming mobs")
  wait(1)
  while(true) do
      -- check if encounter monster
      if isInState(GameState.inBattle, 1) then
          toast("in combat")
          combat:start()
          battlesCompleted = battlesCompleted + 1
      end 
      -- eat food after battles if available
      if (menu_farmMobs_haveFood and (not foodEaten) 
              and battlesCompleted == menu_farmMobs_battlesCount) then
          wait(2)
          useFood()
          foodEaten = true
      end
      -- exit script
      if (battlesCompleted == totalBattles) then
          wait(1)
          return
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