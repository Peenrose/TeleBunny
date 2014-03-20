beaker1Sprite = love.graphics.newImage("images/beaker1.png")
error("no.")
function loadObject(uid)
	local beaker_1 = {
		shape = love.physics.newPolygonShape(),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(beaker1Sprite, objects["beaker_1"][uid].body:getX(), objects["beaker_1"][uid].body:getY(), objects["beaker_1"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,
	}
	return beaker_1
end