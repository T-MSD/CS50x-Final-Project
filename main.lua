local love = require("love")
local Button = require("Button")
local Player = require("Player")
local MainMenu = require("MainMenu")
local Pipe = require("Pipe")

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

local pipes = {}




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
  player = Player()
  main_menu = MainMenu()
  -- Create all buttons
  buttons.settings = Button(nil, "src/Button-sprites/Large-Buttons/Large-Buttons/Settings-Button.png")
  buttons.exit = Button(love.event.quit, "src/Button-sprites/Large-Buttons/Large-Buttons/Exit-Button.png")
  buttons.play = Button(playGame, "src/Button-sprites/Large-Buttons/Large-Buttons/Play-Button.png")
  
  -- Create Pipes
  for i = 1, 5 do
    pipes[i] = Pipe()
  end

  --Init Pipes
  pipes[1]:init(900 , "src/greenPipe.png")
  pipes[2]:init(1300 , "src/orangePipe.png")
  pipes[3]:init(1700 , "src/bluePipe.png")
  pipes[4]:init(2100 , "src/greenPipe.png")
  pipes[5]:init(2500 , "src/orangePipe.png")
end



function love.update(dt)
  -- Get mouse position
  -- player.x, player.y = love.mouse.getPosition()
  player:update(dt)

  -- Update pipes position
  for i = 1, 5 do
    pipes[i]:update(dt)
  end
end



function love.keypressed(key)
  player:jump()
end



function love.draw()
  -- Draw all main menu buttons
  if state.main_menu then
    main_menu:init(background, window, buttons)
  end
  if state.running then
    love.graphics.draw(background, 0, 0, 0, love.graphics.getWidth() / background:getWidth(), love.graphics.getHeight() / background:getHeight())
    love.graphics.print("x: " .. player.x .. " y: " .. player.y)
    player:draw(player.x, player.y, player.bird)

    -- Draw pipes in their new position
    for i = 1, 5 do
      pipes[i]:draw()
    end
  end
end
