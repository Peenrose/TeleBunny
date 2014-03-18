beaker1Sprite = love.graphics.newImage("images/beaker1.png")

function loadObject(uid)
	local beaker_1 = {
		shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(beaker1Sprite, objects["beaker_1"][uid].body:getX(), objects["beaker_1"][uid].body:getY(), objects["beaker_1"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,
	}
	if currentLevel == 1 then
		beaker_1.body = love.physics.newBody(world, 264,223, "dynamic")
	else
		beaker_1.body = love.physics.newBody(world, 1426,238, "dynamic")
	end
	return beaker_1
end