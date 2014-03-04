syringeSprite = love.graphics.newImage("images/syringe_full.png")

function loadObject(uid)
	local syringe = {
		body = love.physics.newBody(world, syringeX, syringeY, "dynamic"),
		shape = love.physics.newPolygonShape(39/4,0, 137/4,0, 137/4,489/4, 99/4,499/4, 88/4,620/4, 78/4,500/4, 39/4,488/4),
		draw = function()
			love.graphics.polygon("line", objects["syringe"][uid].body:getWorldPoints(objects["syringe"][uid].shape:getPoints()))
			love.graphics.draw(syringeSprite, objects["syringe"][uid].body:getX(), objects["syringe"][uid].body:getY(), objects["syringe"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,	
	}
	syringe.fixture = love.physics.newFixture(syringe.body, syringe.shape)
	syringe.fixture:setMask(1)
	syringe.body:setAngle(1.5)
	return syringe
end