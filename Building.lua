local love = require("love")

function Building()
  return {
    x = 0,
    y = 620,
    src = "src/background/background/buildings.png",

    init = function (self, x)
      self.x = x
    end,

    draw = function (self)
      if self.x <= 1920 then
        love.graphics.draw(love.graphics.newImage(self.src), self.x, self.y)
      end
    end,

    update = function (self, dt)
      self.x = self.x - 60 * dt
      if self.x <= -180 then
        self.x = 1980
      end
    end
  }
end

return Building