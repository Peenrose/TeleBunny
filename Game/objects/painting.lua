paintingSprite = love.graphics.newImage("images/painting.png")

function loadObject(uid)
	local painting = {
		body = love.physics.newBody(world, 212,206, "dynamic"),
		shape = love.physics.newPolygonShape(0,0, 423,0, 423,525, 0,525),
		draw = function()
			love.graphics.draw(paintingSprite, objects["painting"][uid].body:getX(), objects["painting"][uid].body:getY(), objects["painting"][uid].body:getAngle())
		end,
		click = function() end,
	}
	painting.fixture = love.physics.newFixture(painting.body, painting.shape)
	painting.fixture:setMask(1)
	return painting
end