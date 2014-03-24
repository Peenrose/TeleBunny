shieldSprite = love.graphics.newImage("images/shield.png")

function loadObject(uid)
	local shield = {
		body = love.physics.newBody(world, shieldX, shieldY, "dynamic"),
		shape = love.physics.newPolygonShape(-3,20, 75,-1, 113,327, 45,348),
		draw = function()
			--love.graphics.polygon("line", objects["shield"][uid].body:getWorldPoints(objects["shield"][uid].shape:getPoints()))
			love.graphics.draw(shieldSprite, objects["shield"][uid].body:getX(), objects["shield"][uid].body:getY(), objects["shield"][uid].body:getAngle())
		end,
		click = function() end,
	}
	shield.fixture = love.physics.newFixture(shield.body, shield.shape)
	shield.body:setAngle(shieldAngle)
	shield.fixture:setDensity(10)
	return shield
end