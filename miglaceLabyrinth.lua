require(scriptPath() .. "constants")
require(scriptPath() .. "functions")
require(scriptPath() .. "action")

local miglaceLabyrinth = {}

miglaceLabyrinth.chestImages = {
  regular="miglace_castle_chest.jpg",
  boss="miglace_castle_chest_boss.jpg"
}

miglaceLabyrinth.selectDungeon = function()
  wait(1)
  click(Location(640, 360)) -- click unigan
  wait(1)
end

miglaceLabyrinth.moveDirectionAfterCombat = {
  Direction.right,
  Direction.left,
  Direction.right
}

miglaceLabyrinth.moves = {
  {
    Action:new(moveInPixels, Direction.right, 80),
    Action:new(moveInPixels, Direction.left, 166),
    Action:new(swipeTo, Direction.down),
    Action:new(moveInPixels, Direction.right, 77),
    Action:new(swipeTo, Direction.down),
    Action:new(moveInPixels, Direction.right, 83),
    Action:new(takeChest, Chest.rightSide, miglaceLabyrinth.chestImages.regular),
    Action:new(moveInPixels, Direction.left, 83),
    Action:new(swipeTo, Direction.up),
    Action:new(moveInPixels, Direction.left, 358),
    Action:new(swipeTo, Direction.down),
    Action:new(moveInPixels, Direction.left, 82),
    Action:new(takeChest, Chest.leftSide, miglaceLabyrinth.chestImages.regular),
    Action:new(moveInPixels, Direction.right, 82),
    Action:new(swipeTo, Direction.up),
    Action:new(moveInPixels, Direction.right, 53),
    Action:new(swipeTo, Direction.up),
    Action:new(moveInPixels, Direction.right, 102),
    Action:new(swipeTo, Direction.up)
  },
  {
    Action:new(moveInPixels, Direction.left, 190),
    Action:new(moveInPixels, Direction.right, 37),
    Action:new(swipeTo, Direction.up),
    Action:new(moveInPixels, Direction.left, 79),
    Action:new(swipeTo, Direction.up),
    Action:new(moveInPixels, Direction.right, 56),
    Action:new(takeChest, Chest.rightSide, miglaceLabyrinth.chestImages.regular),
    Action:new(moveInPixels, Direction.left, 56),
    Action:new(swipeTo, Direction.down),
    Action:new(moveInPixels, Direction.right, 155),
    Action:new(swipeTo, Direction.up),
    Action:new(moveInPixels, Direction.right, 130),
    Action:new(swipeTo, Direction.down),
    Action:new(moveInPixels, Direction.right, 130),
    Action:new(swipeTo, Direction.up),
    Action:new(moveInPixels, Direction.right, 76),
    Action:new(swipeTo, Direction.down)
  },
  {
    Action:new(moveInPixels, Direction.right, 112),
    Action:new(moveInPixels, Direction.left, 37),
    Action:new(swipeTo, Direction.up),
    Action:new(moveInPixels, Direction.left, 83),
    Action:new(takeChest, Chest.leftSide, miglaceLabyrinth.chestImages.regular),
    Action:new(moveInPixels, Direction.right, 83),
    Action:new(swipeTo, Direction.down),
    Action:new(moveInPixels, Direction.left, 180),
    Action:new(swipeTo, Direction.up),
    Action:new(moveInPixels, Direction.left, 79),
    Action:new(swipeTo, Direction.up),
    Action:new(moveInPixels, Direction.right, 267),
    Action:new(takeChest, Chest.rightSide, miglaceLabyrinth.chestImages.regular),
    Action:new(moveInPixels, Direction.left, 446),
    Action:new(takeChest, Chest.leftSide, miglaceLabyrinth.chestImages.regular),
    Action:new(moveInPixels, Direction.right, 57),
    Action:new(swipeTo, Direction.down),
    Action:new(moveInPixels, Direction.right, 77),
    Action:new(swipeTo, Direction.down),
    Action:new(moveInPixels, Direction.left, 181),
    Action:new(swipeTo, Direction.up),
  },
  {
    Action:new(move, Direction.left, 0.2),
    Action:new(takeChest, Chest.middle, miglaceLabyrinth.chestImages.boss),
    Action:new(move, Direction.left, 2)
  }
}

return miglaceLabyrinth