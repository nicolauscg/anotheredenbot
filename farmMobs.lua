require(scriptPath() .. "constants")
require(scriptPath() .. "functions")

function farmMobScript()
  local runningDirection = nil
  local combat = Combat:new(nil) -- setup skill selection
          :next( Turn:new(nil):setAllSkill(4,4,4,3) )
          :next( Turn:new(nil):setSkill(1,1):setSkill(4,2) )
          :next( Turn:new(nil):setSkill(2,1) )
  local battlesCompletedCount = 0
  local foodEaten = false
  local totalBattles = menu_farmMobs_haveFood and 
          2*menu_farmMobs_battlesCount or menu_farmMobs_battlesCount

  toast("farming mobs")
  wait(1)
  while(true) do
      -- check if encounter monster
      if isInState(GameState.inBattle, 1) then
          toast("in combat")
          combat:start()
          battlesCompletedCount = battlesCompletedCount + 1
      end 
      -- eat food after battles if available
      if (menu_farmMobs_haveFood and (not foodEaten) 
              and battlesCompletedCount == menu_farmMobs_battlesCount) then
          wait(2)
          useFood()
          foodEaten = true
      end
      -- exit script
      if (battlesCompletedCount == totalBattles) then
          wait(1)
          keyevent(3)
          scriptExit("script finished")
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