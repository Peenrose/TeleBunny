eightBallSprite = love.graphics.newImage("images/8ball.png")

function loadObject(uid)
	local eightBall = {
		body = love.physics.newBody(world, 1514,440, "dynamic"),
		shape = love.physics.newCircleShape(23),
		draw = function()
			--love.graphics.circle("line", objects["8_ball"][uid].body:getX(), objects["8_ball"][uid].body:getY(), 25)
			love.graphics.draw(eightBallSprite, objects["8_ball"][uid].body:getX(), objects["8_ball"][uid].body:getY(), objects["8_ball"][uid].body:getAngle(), 0.35, 0.35, 69, 69)
		end,
		click = function() end,
	}
	return eightBall
end