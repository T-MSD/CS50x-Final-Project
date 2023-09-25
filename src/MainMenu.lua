local love = require("love")

local MainMenu = {}

-- Init main menu/draw buttons
function MainMenu:init(window, buttons)
  buttons.exit:draw(window.width - 300, window.height + 250, 0.5)
  buttons.play:draw(window.width - 300, window.height - 350, 0.5)
end


return MainMenu