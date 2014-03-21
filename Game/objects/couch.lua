couchSprite = love.graphics.newImage("images/couch.png")

function loadObject(uid)
	local couch = {
		body = love.physics.newBody(world, 590,651, "dynamic"),
		shape = love.physics.newPolygonShape(66,20, 535,6, 616,102, 610,322, 13,324, 5,101),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(couchSprite, objects["couch"][uid].body:getX(), objects["couch"][uid].body:getY(), objects["couch"][uid].body:getAngle())
		end,
		click = function() end,
	}
	--couch.fixture = love.physics.newFixture(couch.body, couch.shape)
	--couch.fixture:setMask(1)
	return couch
end