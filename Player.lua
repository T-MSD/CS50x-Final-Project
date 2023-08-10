local love = require("love")

function Player(src)
  return {
    x = 0,
    y = 0,
    player_image = love.graphics.newImage(src),

    draw = function (self, x, y)
      self.x = x
      self.y = y
      love.graphics.draw(self.player_image, x, y)
    end,
  }
end

return Player