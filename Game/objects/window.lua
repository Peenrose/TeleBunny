windowSprite = love.graphics.newImage("images/window.png")

function loadObject(uid)
	local window = {
		body = love.physics.newBody(world, 550,125, "static"),
		shape = love.physics.newRectangleShape(1092, 348),
		draw = function()
			--love.graphics.polygon("line", objects["window"][uid].body:getWorldPoints(objects["window"][uid].shape:getPoints()))
			love.graphics.draw(windowSprite, objects["window"][uid].body:getX(), objects["window"][uid].body:getY(), objects["window"][uid].body:getAngle())
		end,
		click = function() end,
	}
	window.fixture = love.physics.newFixture(window.body, window.shape)
	window.fixture:setMask(1)
	return window
end