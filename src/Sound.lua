local love = require('love')

local Sound = {
  newHighscore = love.audio.newSource("sounds/new-highscore.mp3", "static"),
  jump = love.audio.newSource('sounds/jump.mp3', 'static'),
  scored = love.audio.newSource('sounds/point.mp3', 'static'),
  ended = love.audio.newSource('sounds/die.mp3', 'static'),
}

-- This func allows the game to play the sound every time space key is pressed
function Sound:play(source)
  local clone = source:clone()
  clone:play()
end
return Sound