binSprite = love.graphics.newImage("images/bin.png")

function loadObject(uid)
	local bin = {
		body = love.physics.newBody(world, x, y, "dynamic"),
		shape = love.physics.newPolygonShape(14,14, 58,260, 148,260, 194,0, 166,285, 38,285),
		draw = function()
			--love.graphics.polygon("line", objects["bin"][uid].body:getWorldPoints(objects["bin"][uid].shape:getPoints()))
			love.graphics.draw(binSprite, objects["bin"][uid].body:getX(), objects["bin"][uid].body:getY(), objects["bin"][uid].body:getAngle())
		end,
		click = function() end,	
	}
	return bin
end