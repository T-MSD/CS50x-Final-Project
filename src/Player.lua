local love = require("love")
local Sound = require("Sound")

function Player()
  return {
    x = 400,
    y = 100,
    score = 0,
    gravity = 0,
    bird = love.graphics.newImage("background/bird/bird1.png"),   
    playing = true,
    lost = false,
    scoreDrawable = false,
    angle = 0,


    -- Draw the plyer
    draw = function (self, x, y)
      self.x = x
      self.y = y
      love.graphics.draw(self.bird, x, y)
    end,

    drawScore = function (self)
      if self.scoreDrawable then
        local font = love.graphics.newFont(40)
        local black = {0, 0, 0}
        love.graphics.setFont(font)
        local txtScore = "".. self.score
        love.graphics.print({black, txtScore}, 100 - font:getWidth(txtScore)/2, 52.5)
      end
    end,

    -- Update the player position and gravity
    -- The use of gravity and dt allows the player to have a smooth movement
    update = function (self, dt)
      self.gravity = self.gravity + 1000 * dt
      self.y = self.y + self.gravity * dt
      if self.y + 46 >= 1000 then
        self.lost = true
        Sound:play(Sound.ended) 
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