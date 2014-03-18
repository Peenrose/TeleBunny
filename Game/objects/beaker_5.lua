beaker5Sprite = love.graphics.newImage("images/beaker5.png")

function loadObject(uid)
	local beaker_5 = {
		body = love.physics.newBody(world, 1154,225, "dynamic"),
		shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(beaker5Sprite, objects["beaker_5"][uid].body:getX(), objects["beaker_5"][uid].body:getY(), objects["beaker_5"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,
	}
	beaker_5.fixture = love.physics.newFixture(beaker_5.body, beaker_5.shape)
	beaker_5.fixture:setMask(1)
	return beaker_5
end
