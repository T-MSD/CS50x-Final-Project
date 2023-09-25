local love = require("love")

function Scoreboard()
  return {
    drawable = false,
    image = love.graphics.newImage("src/background/scoreboard/score.png"),

    draw = function (self)
      if self.drawable then
        love.graphics.draw(self.image, 810, 290)
      end
    end
  }
end

return Scoreboard