tableSprite = love.graphics.newImage("images/table.png")

function loadObject(uid)
	local table = {
		body = love.physics.newBody(world, 1220,750, "dynamic"),
		shape = love.physics.newPolygonShape(4,31, 189,1, 317,51, 316,220, 4,220),
		draw = function()
			--love.graphics.polygon("line", objects["table"][uid].body:getWorldPoints(objects["table"][uid].shape:getPoints()))
			love.graphics.draw(tableSprite, objects["table"][uid].body:getX(), objects["table"][uid].body:getY(), objects["table"][uid].body:getAngle())
		end,
		click = function() end,
	}
	return table
end