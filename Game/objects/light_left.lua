lightSprite = love.graphics.newImage("images/light.png")

function loadObject(uid)
	local light = {
		body = love.physics.newBody(world, 350,124, "dynamic"),
		shape = love.physics.newRectangleShape(600,42),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(lightSprite, objects["light_left"][uid].body:getX(), objects["light_left"][uid].body:getY(), objects["light_left"][uid].body:getAngle())
		end,
		click = function() end,
	}
	light.fixture = love.physics.newFixture(light.body, light.shape)
	light.fixture:setMask(1)
	return light
end
