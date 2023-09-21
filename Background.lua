local love = require("love")

function Background()
	return {
		background = love.graphics.newImage("src/background/background/background.png"),
		forest = love.graphics.newImage("src/background/background/forest.png"),
		ground = love.graphics.newImage("src/background/background/ground.png"),

		-- Draw the the sky and clouds
		drawBack = function(self)
			local x = 0
			love.graphics.draw(self.background, 0, 0)
		end,

		-- Draw the ground
		drawGround = function(self)
			love.graphics.draw(self.ground, 0, 1010)
		end,

		-- Draw the green bushes
		drawForest = function(self)
			love.graphics.draw(self.forest, 0, 0)
		end,
	}
end

return Background
