local love = require("love")

local Scoreboard = {
  drawable = false,
  scoreboardImage = love.graphics.newImage("background/scoreboard/score.png"),
  scoreCounter = love.graphics.newImage("background/scoreboard/score-counter.png"),
  scoreCounterDrawable = false,
}


-- Draw score counter
function Scoreboard:drawCounter()
  if Scoreboard.scoreCounterDrawable then
    love.graphics.draw(Scoreboard.scoreCounter, 50, 50)
  end
end


-- Draw scoreboard
function Scoreboard:draw(buttons, score, highscore)
  if Scoreboard.drawable then
    local font = love.graphics.newFont(70)
    local black = {0, 0, 0}
    love.graphics.setFont(font)

    love.graphics.draw(Scoreboard.scoreboardImage, 810, 290)
    buttons.lostExit:draw(2900, 2340, 0.3)
    buttons.replay:draw(3300, 2340, 0.3)

    local txtScore = "".. score
    local txtHighscore = "" .. highscore
    love.graphics.print({black, txtScore}, 960 - font:getWidth(txtScore)/2, 480)
    love.graphics.print({black, txtHighscore}, 960 - font:getWidth(txtHighscore)/2, 610)
  end
end

return Scoreboard