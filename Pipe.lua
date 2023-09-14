local love = require("love")

function Pipe()
  return {
    x = 0,
    src = "",


    init = function (self, x, src)
      self.x = x
      self.src = src
    end,


    update = function (self, dt)
      self.x = self.x - 300 * dt
      if self.x < -120 then
        self.x = 1920
      end
    end,

    
    draw = function (self)
      love.graphics.draw(love.graphics.newImage(self.src), self.x, 0)
    end
  }
end

return Pipe