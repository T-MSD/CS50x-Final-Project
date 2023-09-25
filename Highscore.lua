local json = require("lunajson")

function Highscore()
  return {
    highscore = 0,

    loadScore = function(self)
      local file = io.open("score.json", "r")
      if file then
        local contents = file:read( "*a" )
        io.close( file )
        self.highscore = json.decode(contents)
      end
    end,

    saveScore = function(self, score)
      local file = io.open("score.json", "w")
      if file then
        file:write(json.encode(score))
        io.close(file)
      end
    end
  }
end

return Highscore
