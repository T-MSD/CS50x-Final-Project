local love = require("love")
local Button = require("Button")
local Player = require("Player")
local MainMenu = require("MainMenu")
local Pipe = require("Pipe")
local Background = require("Background")
local Building = require("Building")

-- All game states
local state = {
  main_menu = true,
  running = false,
  ongoing = false,
  paused = false,
  settings = false,
  lost = false,
}

local window = {
  height = love.graphics.getHeight(),
  width = love.graphics.getWidth()
}

-- large buttons 600x200
-- square buttons 200x200
local buttons = {}

local pipes = {}

local buildings = {}


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
  state.ongoing = true
end



function love.load()
  player = Player()
  main_menu = MainMenu()
  background = Background()

  buttons.exit = Button(love.event.quit, "src/Button-sprites/Large-Buttons/Large-Buttons/Exit-Button.png")
  buttons.play = Button(playGame, "src/Button-sprites/Large-Buttons/Large-Buttons/Play-Button.png")
  
  for i = 1, 10 do
    pipes[i] = Pipe()
  end

  local building_x = 0
  for i = 1, 12 do
    buildings[i] = Building()
    buildings[i]:init(building_x)
    building_x = building_x + 180
  end

  pipes[1]:init(900, 480,"src/background/pipes/greenPipe1.png")
  pipes[2]:init(900, 0,"src/background/pipes/greenPipe2.png")
  pipes[3]:init(1300, 900, "src/background/pipes/orangePipe1.png")
  pipes[4]:init(1300, 0, "src/background/pipes/orangePipe2.png")
  pipes[5]:init(1700, 690, "src/background/pipes/bluePipe1.png")
  pipes[6]:init(1700, 0, "src/background/pipes/bluePipe2.png")
  pipes[7]:init(2100, 800, "src/background/pipes/redPipe1.png")
  pipes[8]:init(2100, 0, "src/background/pipes/redPipe2.png")
  pipes[9]:init(2500, 400, "src/background/pipes/purplePipe1.png")
  pipes[10]:init(2500, 0, "src/background/pipes/purplePipe2.png")
end



function love.update(dt)
  -- Get mouse position
  -- player.x, player.y = love.mouse.getPosition()
  if state.ongoing then
    if player.lost then
      state.lost = true
      state.ongoing = false
    end

    player:update(dt)

    for i = 1, 10 do
      pipes[i]:update(dt)
    end

    for i = 1, 12 do
      buildings[i]:update(dt)
    end
  end
  
end



function love.keypressed(key)
  if key == "space" then
    player:jump()
  end
end



function love.draw()
  -- Draw all main menu buttons
  if state.main_menu then
    background:drawBack()
    for i = 1, 12 do
      buildings[i]:draw()
    end
    background:drawForest()
    background:drawGround()
    main_menu:init(window, buttons)
  end

  if state.running then
    background:drawBack()
    for i = 1, 12 do
      buildings[i]:draw()
    end
    background:drawForest()
    player:draw(player.x, player.y, player.bird)
    -- Draw pipes in their new position
    for i = 1, 10 do
      pipes[i]:draw()
    end
    background:drawGround()

    if state.ongoing then
      love.graphics.print("x: " .. player.x .. " y: " .. player.y)
    end

    if state.lost then
      love.graphics.print("You lost")
    end
end
end
