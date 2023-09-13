local love = require("love")

function MainMenu()
  return {
    init = function (self, background, window, buttons)
      love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth() / background:getWidth(), love.graphics.getHeight() / background:getHeight())
      love.graphics.push()
      love.graphics.scale(0.5)
      buttons.exit:draw(window.width - 300, window.height + 250)
      buttons.play:draw(window.width - 300, window.height - 350)
      buttons.settings:draw(window.width - 300, window.height - 50)
      love.graphics.pop()
    end
  }
end

return MainMenu