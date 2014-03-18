beaker4Sprite = love.graphics.newImage("images/beaker4.png")

function loadObject(uid)
	local beaker_4 = {
		body = love.physics.newBody(world, 1601,500, "dynamic"),
		shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(beaker4Sprite, objects["beaker_4"][uid].body:getX(), objects["beaker_4"][uid].body:getY(), objects["beaker_4"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,
	}
	beaker_4.fixture = love.physics.newFixture(beaker_4.body, beaker_4.shape)
	beaker_4.fixture:setMask(1)
	return beaker_4
end