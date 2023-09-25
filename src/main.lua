local love = require("love")
local Button = require("Button")
local Player = require("Player")
local MainMenu = require("MainMenu")
local Pipe = require("Pipe")
local Background = require("Background")
local Building = require("Building")
local Scoreboard = require("Scoreboard")
local Highscore = require("Highscore")

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

-- buttons table
local buttons = {}

-- pipes table
local pipes = {}

-- buildings table
local buildings = {}



-- Register wich button was pressed, if it was pressed
function love.mousepressed(x, y, pressed)
  if not state.running then
    if pressed == 1 then
      if state.main_menu then
        for button in pairs(buttons) do
          buttons[button]:pressed(x, y)
        end
      end
    end
  end
  if state.lost then
    if pressed == 1 then
      for button in pairs(buttons) do
        if buttons[button]:pressed(x, y) then
          player:reset()
          initPipes()
        end
      end
    end
  end
end



-- Change states and start game
local function playGame()
  state.main_menu = false
  state.running = true
  state.ongoing = true
  state.lost = false
  buttons.lostExit.drawable = false
  buttons.replay.drawable = false
  Scoreboard.drawable = false
end



-- Axis-aligned bounding box (AABB) collision detection
function CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end



-- Initialize all pipes and make sure the scored == false 
-- when the game is restarted
initPipes = function()
  pipes[1]:init(900, 480, 600,"background/pipes/greenPipe1.png")
  pipes[2]:init(900, 0, 180, "background/pipes/greenPipe2.png")
  pipes[3]:init(1300, 900, 180, "background/pipes/orangePipe1.png")
  pipes[4]:init(1300, 0, 600, "background/pipes/orangePipe2.png")
  pipes[5]:init(1700, 690, 390, "background/pipes/bluePipe1.png")
  pipes[6]:init(1700, 0, 390, "background/pipes/bluePipe2.png")
  pipes[7]:init(2100, 800, 500, "background/pipes/redPipe1.png")
  pipes[8]:init(2100, 0, 280, "background/pipes/redPipe2.png")
  pipes[9]:init(2500, 400, 680, "background/pipes/purplePipe1.png")
  pipes[10]:init(2500, 0, 100, "background/pipes/purplePipe2.png")

  for i = 1, 10 do
    pipes[i].scored = false
  end
end



-- Load/init every game object
function love.load()
  player = Player()
  background = Background()

  buttons.exit = Button(love.event.quit, "Button-sprites/Large-Buttons/Large-Buttons/Exit-Button.png")
  buttons.exit.drawable = true
  buttons.play = Button(playGame, "Button-sprites/Large-Buttons/Large-Buttons/Play-Button.png")
  buttons.play.drawable = true
  buttons.lostExit = Button(love.event.quit, "Button-sprites/Square-Buttons/Square-Buttons/Exit-Button.png")
  buttons.replay = Button(playGame, "Button-sprites/Square-Buttons/Square-Buttons/Replay-Button.png")

  for i = 1, 10 do
    pipes[i] = Pipe()
  end
  initPipes()

  local building_x = 0
  for i = 1, 12 do
    buildings[i] = Building()
    buildings[i]:init(building_x)
    building_x = building_x + 180
  end
end



-- Update all game objects
-- Check wich state the game is in
function love.update(dt)
  if state.ongoing then
    if player.lost then
      state.lost = true
      state.ongoing = false
    end

    -- update player movement
    player:update(dt)

    -- update pipes movement and check for collisions
    for i = 1, 10 do
      pipes[i]:update(dt, player)
      if CheckCollision(player.x, player.y, 70, 45, pipes[i].x, pipes[i].y, pipes[i].width - 32, pipes[i].height) then
        player.lost = true
      end
    end

    -- update buildings movement
    for i = 1, 12 do
      buildings[i]:update(dt)
    end
  end
end



-- Make sure the player jumps only when the spacebar is pressed
function love.keypressed(key)
  if key == "space" then
    player:jump()
  end
end



-- Draw all game objects
function love.draw()
  -- Draw the main menu/background
  if state.main_menu then
    background:drawBack()
    for i = 1, 12 do
      buildings[i]:draw()
    end
    background:drawForest()
    background:drawGround()
    MainMenu:init(window, buttons)
  end

  -- Remove main menu buttons
  -- Draw the background, player and pipes
  -- Drawing order is important
  if state.running then
    buttons.exit.drawable = false
    buttons.play.drawable = false

    background:drawBack()
    for i = 1, 12 do
      buildings[i]:draw()
    end
    background:drawForest()
    player:draw(player.x, player.y)
    for i = 1, 10 do
      pipes[i]:draw()
    end
    background:drawGround()

    -- Draw score and restart/exit buttons
    if state.lost then
      buttons.lostExit.drawable = true
      buttons.replay.drawable = true
      Scoreboard.drawable = true
      Highscore:loadScore()
      if Highscore.highscore < player.score then
        Highscore:saveScore(player.score)
      end
      Scoreboard:draw(buttons, player.score, Highscore.highscore)
    end
  end
end
