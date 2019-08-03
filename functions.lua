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
  waitTime = waitTime or 2
  if button.region:exists(Pattern(button.image), waitTime) then
      clickRegion(button.region)
  else
    error("button not found", reportError.toCaller)
  end
end

function tapScreen()
  clickRegion(GameRegion.tapAnyWhere)
end

function useFood()
  clickButton(Button.menu)
  clickButton(Button.food)
  clickButton(Button.use)
  wait(2)
  tapScreen()
  wait(2)
  tapScreen()
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

function takeChest(chest, image)
  chest.region:highlight(2)
  local match = chest.region:exists(Pattern(image), 1)
  if match ~= nil then
    click(match:getCenter():offset(0, chest.offsetY))
    wait(1)
    tapScreen()
  else
    print("chest not found")
  end
end

function isInState(gameState, waitTime)
  waitTime = waitTime or 2
  return gameState.region:exists(Pattern(gameState.image), waitTime)
end

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