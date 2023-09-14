local love = require("love")

function Player()
  return {
    x = 400,
    y = 100,
    gravity = 0,
    bird = love.graphics.newImage("src/bird.png"),   


    draw = function (self, x, y, bi)
      self.x = x
      self.y = y
      love.graphics.push()
      love.graphics.draw(self.bird, x, y)
      love.graphics.pop()
    end,


    update = function (self, dt)
      self.gravity = self.gravity + 1000 * dt
      self.y = self.y + self.gravity * dt
    end,


    jump = function (self)
      self.gravity = -400
    end
  }
end

return Player