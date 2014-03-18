beaker2Sprite = love.graphics.newImage("images/beaker2.png")

function loadObject(uid)
	local beaker_2 = {
		body = love.physics.newBody(world, 1639,238, "dynamic"),
		shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(beaker2Sprite, objects["beaker_2"][uid].body:getX(), objects["beaker_2"][uid].body:getY(), objects["beaker_2"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,
	}
	return beaker_2
end