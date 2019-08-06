require(scriptPath() .. "commonLib")
require(scriptPath() .. "constants")

function move(direction, duration)
  duration = duration or 2
  local startLoc = GameRegion.tapAnyWhere:getCenter()
  local endLoc = startLoc:offset(direction.offset.x, direction.offset.y)
  manualTouch({
      {action = "touchDown", target = startLoc},
      {action = "wait", target = 0.1},
      {action = "touchMove", target = endLoc},
      {action = "wait", target = duration},
      {action = "touchUp", target = endLoc}
  })
end

function moveInPixels(direction, length)
  local duration = (length-10)/45
  move(direction, duration)
end

function swipeTo(direction)
  local startLoc = GameRegion.tapAnyWhere:getCenter()
  local endLoc = startLoc:offset(direction.offset.x, direction.offset.y)
  swipe(startLoc, endLoc)
end

function clickRegion(region)
  click(region:getCenter())
end

function clickButton(button, waitTime)
  local waitTime = waitTime or 2
  local match = button.region:exists(Pattern(button.image), waitTime)
  if match ~= nil then
      clickRegion(match)
  else
    error("button " .. button.name .." not found", reportError.toCaller)
  end
end

function tapScreen()
  clickRegion(GameRegion.tapAnyWhere)
end

function repeatedTap(times, interval)
  tapScreen()
  for i=1,(times-1) do
    wait(interval)
    tapScreen()
  end
end

function getFoodFromInn(dialogLocation, isPromisedFruit)
  if not isPromisedFruit then
    swipeTo(Direction.up)
    wait(1)
  end
  click(dialogLocation)
  wait(0.5)
  tapScreen()
  wait(0.5)
  clickButton(Button.yes)
  if isPromisedFruit then
    wait(4)
    repeatedTap(3, 1)
  else
    wait(10)
    repeatedTap(5, 1)
  end
  wait(2)
  print("got food from inn")
end

function useFood()
  clickButton(Button.menu)
  clickButton(Button.food)
  clickButton(Button.use)
  wait(2)
  tapScreen()
  wait(2)
  tapScreen()
  print("food used")
end

-- sometimes does not get marker's position
function getPositionInMinimap()
  clickRegion(GameRegion.minimapInCorner)
  local index, id, match = regionWaitMulti({
    {region=GameRegion.openedMinimap, image="marker_left.png"},
    {region=GameRegion.openedMinimap, image="marker_right.png"}
  }, 5)
  tapScreen()
  if index ~= -1 then
    return match:getCenter()
  else
    return nil
  end
end

function isInState(gameState, waitTime)
  local waitTime = waitTime or 2
  local match = gameState.region:exists(Pattern(gameState.image), waitTime)
  if match ~= nil then
    return true
  else
    return false
  end
end

-- helper function to split string
function split(inputstr, sep)
  if sep == nil then
          sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
          table.insert(t, str)
  end
  return t
end