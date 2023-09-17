local love = require("love")

function Background()
  return {
    background = love.graphics.newImage("src/background/background/background.png"),
    forest = love.graphics.newImage("src/background/background/forest.png"),
    ground = love.graphics.newImage("src/background/background/ground.png"),

    drawBack = function (self)
      local x = 0
      love.graphics.draw(self.background, 0, 0)
    end,

    drawGround = function (self)
      love.graphics.draw(self.ground, 0, 1010)
    end,

    drawForest = function (self)
      love.graphics.draw(self.forest, 0, 0)
    end,
  }
end

return Background