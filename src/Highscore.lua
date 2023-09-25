local json = require("lunajson")

local Highscore = {highscore = 0}

-- Load highscore from json file
function Highscore:loadScore()
  local file = io.open("score.json", "r")
  if file then
    local contents = file:read( "*a" )
    io.close( file )
    Highscore.highscore = json.decode(contents)
  end
end

-- Save highscore to json file
function Highscore:saveScore(score)
  local file = io.open("score.json", "w")
  if file then
    file:write(json.encode(score))
    io.close(file)
  end
end


return Highscore
