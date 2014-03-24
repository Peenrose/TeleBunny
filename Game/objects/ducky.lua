duckySprite = love.graphics.newImage("images/ducky.png")

function loadObject(uid)
	local ducky = {
		body = love.physics.newBody(world, 450,810 , "dynamic"),
		shape = love.physics.newPolygonShape(16/3,37/3, 90/3,2/3, 135/3,25/3, 133/3,129/3, 236/3,136/3, 220/3,217/3, 33/3,236/3, 2/3,193/3),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(duckySprite, objects["ducky"][uid].body:getX(), objects["ducky"][uid].body:getY(), objects["ducky"][uid].body:getAngle(), 1/3, 1/3)
		end,
		click = function() end,
	}
	ducky.fixture = love.physics.newFixture(ducky.body, ducky.shape)
	ducky.fixture:setDensity(0.1)
	return ducky
end