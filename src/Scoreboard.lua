local love = require("love")

local Scoreboard = {
  drawable = false,
  image = love.graphics.newImage("background/scoreboard/score.png"),
}

-- Draw scoreboard
function Scoreboard:draw(buttons, score, highscore)
  if Scoreboard.drawable then
    local font = love.graphics.newFont(70)
    local black = {0, 0, 0}
    love.graphics.setFont(font)

    love.graphics.draw(Scoreboard.image, 810, 290)
    buttons.lostExit:draw(2900, 2340, 0.3)
    buttons.replay:draw(3300, 2340, 0.3)

    local txtScore = "".. score
    local txtHighscore = "" .. highscore
    love.graphics.print({black, txtScore}, 960 - font:getWidth(txtScore)/2, 480)
    love.graphics.print({black, txtHighscore}, 960 - font:getWidth(txtHighscore)/2, 610)
  end
end

return Scoreboard