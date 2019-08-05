require(scriptPath() .. "constants")
require(scriptPath() .. "functions")

local sakiDreamWorld = {}

sakiDreamWorld.chestImages = {
  regular="saki_chest.jpg",
  boss="saki_chest_boss.jpg"
}

sakiDreamWorld.moves = {
  {
    Action:new(nil, moveInPixels, Direction.right, 102),
    Action:new(nil, moveInPixels, Direction.left, 102),
    Action:new(nil, swipeTo, Direction.up),
    Action:new(nil, moveInPixels, Direction.left, 78),
    Action:new(nil, swipeTo, Direction.up),
    Action:new(nil, moveInPixels, Direction.right, 72),
    Action:new(nil, takeChest, Chest.rightSide, sakiDreamWorld.chestImages.regular),
    Action:new(nil, moveInPixels, Direction.left, 71),
    Action:new(nil, swipeTo, Direction.down),
    Action:new(nil, moveInPixels, Direction.left, 307),
    Action:new(nil, swipeTo, Direction.down),
    Action:new(nil, moveInPixels, Direction.left, 47),
    Action:new(nil, takeChest, Chest.leftSide, sakiDreamWorld.chestImages.regular),
    Action:new(nil, moveInPixels, Direction.right, 47),
    Action:new(nil, swipeTo, Direction.up),
    Action:new(nil, moveInPixels, Direction.right, 87),
    Action:new(nil, swipeTo, Direction.up),
    Action:new(nil, moveInPixels, Direction.right, 64)
  },
  {
    Action:new(nil, moveInPixels, Direction.right, 160),
    Action:new(nil, moveInPixels, Direction.left, 437),
    Action:new(nil, swipeTo, Direction.up),
    Action:new(nil, moveInPixels, Direction.left, 51),
    Action:new(nil, swipeTo, Direction.up),
    Action:new(nil, moveInPixels, Direction.left, 86),
    Action:new(nil, takeChest, Chest.leftSide, sakiDreamWorld.chestImages.regular),
    Action:new(nil, moveInPixels, Direction.right, 315)
  },
  {
    Action:new(nil, moveInPixels, Direction.right, 55),
    Action:new(nil, moveInPixels, Direction.left, 104),
    Action:new(nil, swipeTo, Direction.up),
    Action:new(nil, moveInPixels, Direction.right, 70),
    Action:new(nil, takeChest, Chest.rightSide, sakiDreamWorld.chestImages.regular),
    Action:new(nil, moveInPixels, Direction.left, 122),
    Action:new(nil, swipeTo, Direction.up),
    Action:new(nil, moveInPixels, Direction.left, 156),
    Action:new(nil, swipeTo, Direction.down),
    Action:new(nil, moveInPixels, Direction.left, 52),
    Action:new(nil, swipeTo, Direction.down),
    Action:new(nil, moveInPixels, Direction.right, 69),
    Action:new(nil, takeChest, Chest.rightSide, sakiDreamWorld.chestImages.regular),
    Action:new(nil, moveInPixels, Direction.left, 69),
    Action:new(nil, swipeTo, Direction.up),
    Action:new(nil, moveInPixels, Direction.left, 200),
    Action:new(nil, takeChest, Chest.leftSide, sakiDreamWorld.chestImages.regular),
    Action:new(nil, moveInPixels, Direction.right, 72),
    Action:new(nil, swipeTo, Direction.up),
    Action:new(nil, moveInPixels, Direction.right, 53)
  },
  {
    Action:new(nil, move, Direction.left, 0.5),
    Action:new(nil, takeChest, Chest.middle, sakiDreamWorld.chestImages.boss),
    Action:new(nil, move, Direction.left, 2)
  }
}

return sakiDreamWorld