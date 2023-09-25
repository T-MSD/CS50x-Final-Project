local love = require("love")

function Scoreboard()
  return {
    drawable = false,
    image = love.graphics.newImage("src/background/scoreboard/score.png"),

    draw = function (self, buttons, score, highscore)
      if self.drawable then
        love.graphics.print("" .. score, 100, 100)
        love.graphics.print("" .. highscore, 100, 200)
        love.graphics.draw(self.image, 810, 290)
        buttons.lostExit:draw(2900, 2340, 0.3)
        buttons.replay:draw(3300, 2340, 0.3)
      end
    end
  }
end

return Scoreboard