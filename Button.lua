local love = require("love")

function Button(func, src)
  return {
    func = func,
    x = 0,
    y = 0,
    drawable = false,
    button_image = love.graphics.newImage(src),

    -- Draw button only if it is drawable
    -- Change scale so the button doesnt get too big
    draw = function (self, x, y)
      if self.drawable then
        self.x = x
        self.y = y
        love.graphics.push()
        love.graphics.scale(0.5)
        love.graphics.draw(self.button_image, x, y)
        love.graphics.pop()
      end
    end,

    
    -- If the button was pressed execute button func
    -- Mousex and mousey * 2 because the scale is 0.5
    pressed = function (self, mousex, mousey)
      if self.drawable and mousex * 2 >= self.x and mousex * 2 <= self.x + self.button_image:getWidth()
      and mousey * 2 >= self.y and mousey * 2 <= self.y + self.button_image:getHeight() then
        self.func()
        return true
      else
        return false
      end
    end
  }
end

return Button