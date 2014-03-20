lavaLampSprite = love.graphics.newImage("images/lava.png")

function loadObject(uid)
	local lava_lamp = {
		body = love.physics.newBody(world, 350,274, "dynamic"),
		shape = love.physics.newPolygonShape(18,4, 42,4, 62,192, 2,192),
		draw = function()
			love.graphics.draw(lavaLampSprite, objects["lava_lamp"][uid].body:getX(), objects["lava_lamp"][uid].body:getY(), objects["lava_lamp"][uid].body:getAngle())
		end,
		click = function() end,
	}
	return lava_lamp
end