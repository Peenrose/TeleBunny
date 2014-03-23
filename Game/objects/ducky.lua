duckySprite = love.graphics.newImage("images/ducky.png")

function loadObject(uid)
	local ducky = {
		body = love.physics.newBody(world, 450,810 , "dynamic"),
		shape = love.physics.newPolygonShape(16,37, 90,2, 135,25, 133,129, 236,136, 220,217, 33,236, 2,193),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(duckySprite, objects["ducky"][uid].body:getX(), objects["ducky"][uid].body:getY(), objects["ducky"][uid].body:getAngle())
		end,
		click = function() end,
	}
	--ducky.fixture = love.physics.newFixture(ducky.body, ducky.shape)
	--ducky.fixture:setMask(1)
	return ducky
end