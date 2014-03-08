pipeSprite = love.graphics.newImage("images/pipe.png")

function loadObject(uid)
	local pipe = {
		body = love.physics.newBody(world, 950,-14, "dynamic"),
		shape = love.physics.newPolygonShape(2,46, 338,22, 555,66, 828,3, 873,3, 799,73, 554,90, 14,71),
		draw = function()
			--love.graphics.polygon("line", objects["pipe"][uid].body:getWorldPoints(objects["pipe"][uid].shape:getPoints()))
			love.graphics.draw(pipeSprite, objects["pipe"][uid].body:getX(), objects["pipe"][uid].body:getY(), objects["pipe"][uid].body:getAngle())
		end,
		click = function() end,
	}
	pipe.fixture = love.physics.newFixture(pipe.body, pipe.shape)
	pipe.fixture:setMask(1)
	return pipe
end