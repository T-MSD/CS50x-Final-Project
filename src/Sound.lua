local love = require('love')

local Sound = {
  newHighscore = love.audio.newSource("sounds/new-highscore.mp3", "static"),
  jump = love.audio.newSource('sounds/jump.mp3', 'static'),
  scored = love.audio.newSource('sounds/point.mp3', 'static'),
  ended = love.audio.newSource('sounds/die.mp3', 'static'),
  
  -- https://www.youtube.com/watch?v=dm4kGvOxmjE&list=PLdsGes2mFh92eHpOZVJQgoubb6rF0CcvU&index=2&ab_channel=Pix
  background = love.audio.newSource('sounds/background-music.mp3', 'stream'),
}

-- This func allows the game to play the sound every time space key is pressed
function Sound:play(source)
  local clone = source:clone()
  if source == Sound.scored then
    clone:setVolume(0.1)
  end
  clone:play()
end
return Sound