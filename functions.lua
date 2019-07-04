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

function swipeTo(direction)
  -- cant get this to work
  -- move(direction, 0.1)
  local startLoc = GameRegion.tapAnyWhere:getCenter()
  local endLoc = startLoc:offset(direction.offset.x, direction.offset.y)
  swipe(startLoc, endLoc)
end

function clickRegion(region)
  click(region:getCenter())
end

function clickButton(button, waitTime)
  waitTime = waitTime or 1
  if button.region:exists(Pattern(button.image), waitTime) then
      clickRegion(button.region)
  end
end

function tapScreen()
  clickRegion(GameRegion.tapAnyWhere)
end

function useFood()
  toast("eating food")
  clickButton(Button.menu)
  clickButton(Button.food)
  clickButton(Button.use)
  wait(2)
  tapScreen()
  wait(2)
  tapScreen()
end

function isInState(gameState, waitTime)
  waitTime = waitTime or 1
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