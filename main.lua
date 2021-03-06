require(scriptPath() .. "commonLib") -- ankulua additional functions
require(scriptPath() .. "constants")
require(scriptPath() .. "functions")
require(scriptPath() .. "combat")

-- script built for 1280x720 resolution
scriptWidth = 1280
Settings:setScriptDimension(true, scriptWidth)
Settings:setCompareDimension(true, scriptWidth)
Settings:set("MinSimilarity", 0.7)
Settings:set("AutoWaitTimeout", 0.3)
setImmersiveMode(true) -- whole screen as script area

function main()
  dialogInit()
  addRadioGroup("menu_scriptSelection", 1)
  addRadioButton("farm mobs", 1)
  addRadioButton("farm exp", 2)
  addRadioButton("do another dungeon", 3)
  addRadioButton("test (for development)", 4)
  newRow()
  dialogShowFullScreen("bot main menu")

  if menu_scriptSelection == 1 then
    farmMobsMenu()
  elseif  menu_scriptSelection == 2 then
    farmExpMenu()
  elseif  menu_scriptSelection == 3 then
    anotherDungeonMenu()
  elseif  menu_scriptSelection == 4 then
    test()
  end
end

function farmMobsMenu()
  dialogInit()
  addCheckBox("menu_farmMobs_haveFood", "food available", true)
  newRow()
  addTextView("number of battles before/after food")
  addEditNumber("menu_farmMobs_battlesCount", 5)
  dialogShowFullScreen("farm mobs menu")

  local mobsCombat = combatSetterMenu(true)
  require(scriptPath() .. "farmMobs")
  farmMobScript(mobsCombat, menu_farmMobs_battlesCount, menu_farmMobs_haveFood)
  scriptExit("farm mobs finished")
end

function farmExpMenu()
  dialogInit()
  addTextView("no of battles before/after food")
  addEditNumber("menu_farmExp_battleCount", 5)
  newRow()
  addTextView("approx farm duration in minutes")
  addEditNumber("menu_farmExp_farmDuration", 30)
  dialogShowFullScreen("Farm EXP")
  
  local mobsCombat = combatSetterMenu(true)
  require(scriptPath() .. "farmExp")
  farmExp(mobsCombat, menu_farmExp_battleCount, menu_farmExp_farmDuration*60)
end

function anotherDungeonMenu()
  dialogInit()
  addTextView("number of dungeon runs")
  addEditNumber("menu_anotherDungeon_repeatTimes", 1)
  newRow()
  addTextView("another dungeon")
  newRow()
  addRadioGroup("menu_anotherDungeon_scriptSelection", 1)
  addRadioButton("saki dream world", 1)
  addRadioButton("miglace labyrinth", 2)
  newRow()
  addTextView("difficulty")
  addRadioGroup("menu_anotherDungeon_difficulty", 1)
  addRadioButton("hard", 1)
  addRadioButton("very hard", 2)
  newRow()
  addTextView("-- if error happened during run --")
  newRow()
  addCheckBox("menu_anotherDungeon_battlesDone", "5 battles done?", false)
  newRow()
  addTextView("current floor")
  addEditNumber("menu_anotherDungeon_currentFloor", 1)
  newRow()
  dialogShowFullScreen("another dungeon menu")
  
  local mobsCombat, bossCombat = combatSetterMenu(false)
  -- dictionary of menu_anotherDungeon_scriptSelection to
  -- respective AD info files
  local dungeonMenuSelectionToFileName = {
    "sakiDreamWorld",
    "miglaceLabyrinth"
  }
  local difficulty = nil
  if menu_anotherDungeon_difficulty == 1 then
    difficulty = AnotherDungeonDifficulty.hard
  elseif menu_anotherDungeon_difficulty == 2 then
    difficulty = AnotherDungeonDifficulty.veryHard
  end

  require(scriptPath() .. "action")
  require(scriptPath() .. "anotherDungeon")
  local anotherDungeonInfo = require(scriptPath() .. 
      dungeonMenuSelectionToFileName[menu_anotherDungeon_scriptSelection])
  dungeonScript(mobsCombat, bossCombat, anotherDungeonInfo, 
      menu_anotherDungeon_currentFloor, menu_anotherDungeon_battlesDone, 
      difficulty, menu_anotherDungeon_repeatTimes)
  scriptExit("another dungeon finished")
end

function combatSetterMenu(willSetMobsOnly)
  dialogInit()
  addTextView("moves for mobs")
  addEditText("menu_combat_mobsStrategy", "")
  if not willSetMobsOnly then
    newRow()
    addTextView("moves for boss")
    addEditText("menu_combat_bossStrategy", "")
  end
  dialogShowFullScreen("Combat")
  mobsCombat = Combat:new()
  mobsCombat:setWithString(menu_combat_mobsStrategy)
  if not willSetMobsOnly then
    bossCombat = Combat:new()
    bossCombat:setWithString(menu_combat_bossStrategy)
  end
  return mobsCombat, bossCombat
end

function test()
  print("for debugging purposes during development")
end

main()