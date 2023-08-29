local love = require("love")

function Player(src)
  return {
    x = 0,
    y = 0,
    player_image = love.graphics.newImage(src),

    draw = function (self, x, y)
      self.x = x
      self.y = y
      love.graphics.draw(self.player_image, x, y)
    end,

    move = function (self)
      if love.keyboard.isDown("a") then
        if self.x - 10 >= 0 then
          self.x = self.x - 10
        else
          self.x = 0
        end
      end
      if love.keyboard.isDown("d") then
        if self.x + 10 <= 1920 then
          self.x = self.x + 10
        else
          self.x = 1920
        end
      end
      if love.keyboard.isDown("s") then
        if self.y + 10 <= 1080 then
          self.y = self.y + 10
        else
          self.y = 1080
        end
      end
      if love.keyboard.isDown("w") then
        if self.y - 10 >= 0 then
          self.y = self.y - 10
        else
          self.y = 0
        end
      end
-- falta ajustar de acordo com o tamanho do sprite em pixeis!!!
    end
  }
end

return Player