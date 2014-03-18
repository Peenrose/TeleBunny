beaker3Sprite = love.graphics.newImage("images/beaker3.png")

function loadObject(uid)
	local beaker_3 = {
		body = love.physics.newBody(world, 1442,500, "dynamic"),
		shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(beaker3Sprite, objects["beaker_3"][uid].body:getX(), objects["beaker_3"][uid].body:getY(), objects["beaker_3"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,
	}
	beaker_3.fixture = love.physics.newFixture(beaker_3.body, beaker_3.shape)
	beaker_3.fixture:setMask(1)
	return beaker_3
end