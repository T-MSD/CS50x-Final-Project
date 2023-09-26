local love = require("love")

function Button(func, src)
  return {
    func = func,
    scale = 0,
    x = 0,
    y = 0,
    drawable = false,
    button_image = love.graphics.newImage(src),


    -- Draw button only if it is drawable
    -- Change scale so the button doesnt get too big
    draw = function (self, x, y, scale)
      if self.drawable then
        self.x = x
        self.y = y
        self.scale = scale
        love.graphics.push()
        love.graphics.scale(self.scale)
        love.graphics.draw(self.button_image, x, y)
        love.graphics.pop()
      end
    end,


    -- If the button was pressed execute button func
    -- Mousex and mousey * 1/scale because the hitbox depends on the scale
    pressed = function (self, mousex, mousey)
      if self.drawable and mousex * (1/self.scale) >= self.x and mousex * (1/self.scale) <= self.x + self.button_image:getWidth()
      and mousey * (1/self.scale) >= self.y and mousey * (1/self.scale) <= self.y + self.button_image:getHeight() then
        self.func()
        return true
      else
        return false
      end
    end
  }
end

return Button