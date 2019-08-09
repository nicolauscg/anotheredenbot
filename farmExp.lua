require(scriptPath() .. "constants")
require(scriptPath() .. "functions")
require(scriptPath() .. "farmMobs")

function farmExp(combat, battleCount, durationInSeconds)
  local dialogLocation = Location(293, 53)
  local durationLeft = nil
  local durationTimer = Timer()

  while(true) do
    if durationInSeconds - durationTimer:check() <= 0 then
      print("farm duration finished " .. 
          formatSecondsToMinuteSecondString(durationTimer:check()))
      return
    end
    getFoodFromInn(dialogLocation)
    wait(2)
    fromRindeGoToBeastKingCastle()
    swipeTo(Direction.up)
    wait(0.5)
    swipeTo(Direction.up)
    wait(3)
    farmMobScript(combat, battleCount, true)
    fromBeastKingCastleGoToRinde()
  end
end

function fromRindeGoToBeastKingCastle()
  clickButton(Button.map)
  wait(3)
  click(Location(1146, 375))
  clickButton(Button.yes)
  wait(3)
  print("travelled to beast king castle")
end

function fromBeastKingCastleGoToRinde()
  clickButton(Button.map)
  wait(3)
  click(Location(121, 342))
  clickButton(Button.yes)
  wait(3)
  print("travelled to rinde")
end