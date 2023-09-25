local love = require("love")

function Scoreboard()
  return {
    drawable = false,
    image = love.graphics.newImage("src/background/scoreboard/score.png"),

    draw = function (self, buttons, score, highscore)
      if self.drawable then
        local font = love.graphics.newFont(70)
        local black = {0, 0, 0}
        love.graphics.setFont(font)

        love.graphics.draw(self.image, 810, 290)
        buttons.lostExit:draw(2900, 2340, 0.3)
        buttons.replay:draw(3300, 2340, 0.3)

        local txtScore = "".. score
        local txtHighscore = "" .. highscore
        love.graphics.print({black, txtScore}, 960 - font:getWidth(txtScore)/2, 480)
        love.graphics.print({black, txtHighscore}, 960 - font:getWidth(txtHighscore)/2, 610)
      end
    end
  }
end

return Scoreboard