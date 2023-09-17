local love = require("love")

function Pipe()
  return {
    x = 0,
    src = "",


    init = function (self, x, y, src)
      self.x = x
      self.y = y
      self.src = src
    end,


    update = function (self, dt)
      self.x = self.x - 300 * dt
      if self.x < -150 then
        self.x = 1900
      end
    end,

    
    draw = function (self)
      love.graphics.draw(love.graphics.newImage(self.src), self.x, self.y)
    end
  }
end

return Pipe