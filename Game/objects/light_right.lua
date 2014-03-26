lightSprite = love.graphics.newImage("images/light.png")

function loadObject(uid)
	local light = {
		body = love.physics.newBody(world, 1219+300,96+24, "dynamic"),
		shape = love.physics.newRectangleShape(600,42),
		draw = function()
			love.graphics.draw(lightSprite, objects["light_right"][uid].body:getX(), objects["light_right"][uid].body:getY(), objects["light_right"][uid].body:getAngle(), 1, 1, 300, 24)
		end,
		click = function() end,
	}
	light.fixture = love.physics.newFixture(light.body, light.shape)
	light.fixture:setMask(1)
	return light
end
