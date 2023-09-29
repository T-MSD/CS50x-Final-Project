local love = require("love")
local Scoreboard = require("Scoreboard")
local Highscore = require("Highscore")
local Sound = require("Sound")
local MainMenu = require("MainMenu")
local Button = require("Button")
local Player = require("Player")
local Pipe = require("Pipe")
local Background = require("Background")
local Building = require("Building")

-- All game states
local state = {
  main_menu = true,
  running = false,
  ongoing = false,
  paused = false,
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

-- x and y positions for each pipe, by color
local pipeAttributes = {
  green = {400, 600, 0, 180},
  orange = {900, 180, 0, 600},
  blue = {690, 390, 0, 390},
  red = {800, 280, 0, 500},
  purple = {400, 680, 0, 100}
}

-- buildings table
local buildings = {}



-- Reset game
local function resetGame()
  player:reset()
  initPipes()
end



-- Change states and start game
local function playGame()
  resetGame()
  state.main_menu = false
  state.running = true
  state.ongoing = true
  state.lost = false
  state.paused = false
  Scoreboard.scoreCounterDrawable = true
  buttons.lostExit.drawable = false
  buttons.replay.drawable = false
  Scoreboard.drawable = false
  player.scoreDrawable = true
end



-- Pause game
function pauseGame()
  state.paused = true
  state.ongoing = false
  buttons.paused.drawable = true
  buttons.lostExit.drawable = true
  buttons.replay.drawable = true
  love.audio.pause()
end



-- Resume game
local function resumeGame()
  state.paused = false
  state.ongoing = true
  love.audio.play(Sound.background)
end



-- Make sure the player jumps only when the spacebar is pressed
function love.keypressed(key)
  if key == "space" then
    player:jump()
    Sound:play(Sound.jump)
  elseif key == "escape" and state.ongoing then
    pauseGame()
  end
end



-- Register wich button was pressed, if it was pressed
function love.mousepressed(x, y, pressed)
  if not state.running and pressed == 1 and state.main_menu then
    for button in pairs(buttons) do
      buttons[button]:pressed(x, y)
    end
  end
  if state.lost and pressed == 1 then
    for button in pairs(buttons) do
      if buttons[button]:pressed(x, y) then
        resetGame()
      end
    end
  end
  if state.paused and pressed == 1 then
    for button in pairs(buttons) do
      buttons[button]:pressed(x, y)
      love.audio.play(Sound.background)
    end
  end
end



-- Axis-aligned bounding box (AABB) collision detection
function checkCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end



-- Randomize pipes generation
function randomizePipes()
  local pipeColors = {"green", "orange", "blue", "red", "purple"}
  for i = 1, 9, 2 do
    if pipes[i].x == 1900 and pipes[i+1].x == 1900 then
      local random = math.random(1, 5)
      local randomColor = pipeColors[random]
      pipes[i]:init(1900, pipeAttributes["" .. randomColor][1], pipeAttributes["" .. randomColor][2], "background/pipes/" .. randomColor .. "Pipe1.png")
      pipes[i+1]:init(1900, pipeAttributes["" .. randomColor][3], pipeAttributes["" .. randomColor][4], "background/pipes/" .. randomColor .. "Pipe2.png")
    end
  end
end



-- Initialize all pipes and make sure the scored == false 
-- when the game is restarted
function initPipes()
  local pipe = 1
  local pipeX = 900
  local pipeColors = {"green", "orange", "blue", "red", "purple"}
  for color = 1, 5 do
    pipes[pipe]:init(pipeX, pipeAttributes[pipeColors[color]][1], pipeAttributes[pipeColors[color]][2], "background/pipes/" .. pipeColors[color] .. "Pipe1.png")
    pipes[pipe].scored = false
    pipes[pipe+1]:init(pipeX, pipeAttributes[pipeColors[color]][3], pipeAttributes[pipeColors[color]][4], "background/pipes/" .. pipeColors[color] .. "Pipe2.png")
    pipes[pipe+1].scored = false
    pipe = pipe + 2
    pipeX = pipeX + 400
  end
end



-- Load/init every game object
function love.load()
  Sound.background:setLooping(true)
  Sound:play(Sound.background)
  
  player = Player()
  background = Background()

  buttons.exit = Button(love.event.quit, "Button-sprites/Large-Buttons/Large-Buttons/Exit-Button.png")
  buttons.exit.drawable = true
  buttons.play = Button(playGame, "Button-sprites/Large-Buttons/Large-Buttons/Play-Button.png")
  buttons.play.drawable = true
  buttons.lostExit = Button(love.event.quit, "Button-sprites/Square-Buttons/Square-Buttons/Exit-Button.png")
  buttons.replay = Button(playGame, "Button-sprites/Square-Buttons/Square-Buttons/Replay-Button.png")
  buttons.paused = Button(resumeGame, "Button-sprites/Square-Buttons/Square-Buttons/play-paused.png")

  for i = 1, 10 do
    pipes[i] = Pipe()
  end

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
    end
    randomizePipes()

    for i = 1, 10 do
      if checkCollision(player.x, player.y, 70, 45, pipes[i].x, pipes[i].y, pipes[i].width - 32, pipes[i].height) then
        player.lost = true
        Sound:play(Sound.ended)
      end
    end

    -- update buildings movement
    for i = 1, 12 do
      buildings[i]:update(dt)
    end
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
    Scoreboard:drawCounter()
    player:drawScore()

    if state.paused then
      buttons.paused:draw(860, 440, 1)
      buttons.lostExit:draw(2900, 2340, 0.3)
      buttons.replay:draw(3300, 2340, 0.3)
    end
    
    -- Draw score and restart/exit buttons
    if state.lost then
      player.scoreDrawable = false
      Scoreboard.scoreCounterDrawable = false
      buttons.lostExit.drawable = true
      buttons.replay.drawable = true
      Scoreboard.drawable = true
      Highscore:loadScore()
      if Highscore.highscore < player.score then
        Highscore:saveScore(player.score)
        Sound:play(Sound.newHighscore)
      end
      Scoreboard:draw(buttons, player.score, Highscore.highscore)
    end
  end
end
