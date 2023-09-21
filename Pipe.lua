local love = require("love")

-- large buttons 600x200
-- square buttons 200x200

function Pipe()
  return {
    x = 0,
    y = 0,
    width = 144,
    height = 0,
    src = "",
    scored = false,

    -- Init pipe in the desired position with the desired image
    init = function (self, x, y, height, src)
      self.x = x
      self.y = y
      self.height = height
      self.src = src
    end,

    -- Pipe movement and score update
    -- When the pipe is out of the screen, reset it to the right side with scored == false
    -- If the whole is behind the player, update the score
    update = function (self, dt, player)
      self.x = self.x - 300 * dt
      if self.x < -150 then
        self.x = 1900
        self.scored = false
      end
      if self.x + 144 < player.x and not self.scored then
        self.scored = true
        player.score = player.score + 1/2
      end
    end,

    -- Draw the pipe
    draw = function (self)
      love.graphics.draw(love.graphics.newImage(self.src), self.x, self.y)
    end,

  }
end

return Pipe