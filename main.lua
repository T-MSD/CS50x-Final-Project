local love = require("love")
local Button = require("Button")
local Player = require("Player")


-- All game states
local state = {
  main_menu = true,
  running = false,
  settings = false,
}


local window = {
  height = love.graphics.getHeight(),
  width = love.graphics.getWidth()
}


local background = love.graphics.newImage("src/background.jpg")


-- large buttons 600x200
-- square buttons 200x200
local buttons = {}


-- Check for mouse presses
function love.mousepressed(x, y, button, istouch, presses)
  if not state.running then
    if button == 1 then
      if state.main_menu then
        for button in pairs(buttons) do
          buttons[button]:pressed(x, y)
        end
      end
    end
  end
end


-- Change state
local function playGame()
  state.main_menu = false
  state.running = true
end



function love.load()
  -- Create player
  player = Player("src/Flappy-bird/Player/bird1.png")
  -- Create all buttons
  buttons.settings = Button(nil, "src/Button-sprites/Large-Buttons/Large-Buttons/Settings-Button.png")
  buttons.exit = Button(love.event.quit, "src/Button-sprites/Large-Buttons/Large-Buttons/Exit-Button.png")
  buttons.play = Button(playGame, "src/Button-sprites/Large-Buttons/Large-Buttons/Play-Button.png")
end



function love.update(dt)
  -- Get mouse position
  player.x, player.y = love.mouse.getPosition()
end



function love.draw()
  love.graphics.print("x: " .. player.x .. " y: " .. player.y)

  -- Draw all main menu buttons
  if state.main_menu then
    love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth() / background:getWidth(), love.graphics.getHeight() / background:getHeight())
    love.graphics.scale(0.5)
    buttons.exit:draw(window.width - 300, window.height + 250)
    buttons.play:draw(window.width - 300, window.height - 350)
    buttons.settings:draw(window.width - 300, window.height - 50)
  end
  if state.running then
    player:draw(player.x, player.y)
  end
end
