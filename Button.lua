local love = require("love")

function Button(func, src)
  return {
    func = func,
    x = 0,
    y = 0,
    button_image = love.graphics.newImage(src),


    draw = function (self, x, y)
      self.x = x
      self.y = y
      love.graphics.draw(self.button_image, x, y)
    end,

    
    -- If the button was pressed execute button func
    pressed = function (self, mousex, mousey)
      -- mousex and mousey * 2 because the scale is 0.5
      if mousex * 2 >= self.x and mousex * 2 <= self.x + 600 then
        if mousey * 2 >= self.y and mousey * 2 <= self.y + 200 then
          self.func()
        end
      end
    end
  }
end

return Button