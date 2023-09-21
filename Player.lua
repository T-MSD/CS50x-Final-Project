local love = require("love")

function Player()
  return {
    x = 400,
    y = 100,
    score = 0,
    gravity = 0,
    bird = love.graphics.newImage("src/background/bird/bird1.png"),   
    playing = true,
    lost = false,


    -- Draw the plyer
    draw = function (self, x, y)
      self.x = x
      self.y = y
      love.graphics.draw(self.bird, x, y)
    end,

    -- Update the player position and gravity
    -- The use of gravity and dt allows the player to have a smooth movement
    update = function (self, dt)
      self.gravity = self.gravity + 1000 * dt
      self.y = self.y + self.gravity * dt
      if self.y + 46 >= 1080 then
        self.lost = true  
      end
    end,

    -- Update gravity value to "jumpify" the movement
    jump = function (self)
      self.gravity = -400
    end, 

    -- Reset the player, used when the game is restarted
    reset = function (self)
      self.x = 400
      self.y = 100
      self.score = 0
      self.gravity = 0
      self.playing = true
      self.lost = false
    end
  }
end

return Player