local love = require("love")

function MainMenu()
  return {
    init = function (self, window, buttons)
      love.graphics.push()
      love.graphics.scale(0.5)
      buttons.exit:draw(window.width - 300, window.height + 250)
      buttons.play:draw(window.width - 300, window.height - 350)
      love.graphics.pop()
    end
  }
end

return MainMenu