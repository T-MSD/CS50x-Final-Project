local love = require("love")

local MainMenu = {}

-- Init main menu/draw buttons
function MainMenu:init(window, buttons)
  buttons.exit:draw(window.width - 300, window.height, 0.5)
  buttons.play:draw(window.width - 300, window.height - 250, 0.5)

  local font = love.graphics.newFont("font.ttf", 150)
  love.graphics.setFont(font)
  local txt = "Flappy Bird"
  love.graphics.print(txt, 960 - font:getWidth(txt)/2, 150)

  font = love.graphics.newFont("font1.ttf", 30)
  love.graphics.setFont(font)
  txt = "Press 'space' to jump"
  love.graphics.print(txt, 960 - font:getWidth(txt)/2, 825)

  txt = "Press 'ESC' to pause"
  love.graphics.print(txt, 960 - font:getWidth(txt)/2, 875)
end


return MainMenu