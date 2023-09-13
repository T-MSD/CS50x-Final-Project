local love = require("love")

function Player()
  return {
    x = 100,
    y = 100,
    gravity = 0,

    -- 64x16
    sprite = love.graphics.newImage("src/Flappy-bird/Player/bird2.png"),
    sprite_width = 64,
    sprite_height = 16,
    quad_width = 16,
    quad_height = 16,

    quads = {},

    animation = {
      goingUp = false,
      goingDown = true
    },

    setQuads = function (self)
      for i = 0, 3 do
        self.quads[i] = love.graphics.newQuad(self.quad_width * i, 0, self.quad_width, self.quad_height, self.sprite_width, self.sprite_height)
      end
    end,
    

    draw = function (self, x, y, quad)
      self.x = x
      self.y = y
      love.graphics.push()
      love.graphics.scale(5, 5)
      love.graphics.draw(self.sprite, quad, x / 5, y / 5)
      love.graphics.pop()
    end,


    update = function (self, dt)
      self.gravity = self.gravity + 516 * dt
      self.y = self.y + self.gravity * dt
    end,


    jump = function (self)
      self.gravity = -400
    end
  }
end

return Player