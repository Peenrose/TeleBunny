beakerSprite = love.graphics.newImage("images/beaker1.png")

function loadObject(uid)
	local beaker = {
		body = love.physics.newBody(world, 1426,253, "dynamic"),
		shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(beakerSprite, objects["beaker"][uid].body:getX(), objects["beaker"][uid].body:getY(), objects["beaker"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,
	}
	return beaker
end

beakerSprite = love.graphics.newImage("images/beaker2.png")

function loadObject(uid)
	local beaker = {
		body = love.physics.newBody(world, 1639,262, "dynamic"),
		shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(beakerSprite, objects["beaker"][uid].body:getX(), objects["beaker"][uid].body:getY(), objects["beaker"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,
	}
	return beaker
end

beakerSprite = love.graphics.newImage("images/beaker3.png")

function loadObject(uid)
	local beaker = {
		body = love.physics.newBody(world, 1442,521, "dynamic"),
		shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(beakerSprite, objects["beaker"][uid].body:getX(), objects["beaker"][uid].body:getY(), objects["beaker"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,
	}
	return beaker
end

beakerSprite = love.graphics.newImage("images/beaker4.png")

function loadObject(uid)
	local beaker = {
		body = love.physics.newBody(world, 1601,390, "dynamic"),
		shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(beakerSprite, objects["beaker"][uid].body:getX(), objects["beaker"][uid].body:getY(), objects["beaker"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,
	}
	return beaker
end

beakerSprite = love.graphics.newImage("images/beaker5.png")

function loadObject(uid)
	local beaker = {
		body = love.physics.newBody(world, 1154,225, "dynamic"),
		shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(beakerSprite, objects["beaker"][uid].body:getX(), objects["beaker"][uid].body:getY(), objects["beaker"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,
	}
	return beaker
end

beakerSprite = love.graphics.newImage("images/beaker4.png")

function loadObject(uid)
	local beaker = {
		body = love.physics.newBody(world, 930,287, "dynamic"),
		shape = love.physics.newPolygonShape(155/4,11/4, 240/4,11/4, 240/4,209/4, 403/4,581/4, 0,581/4, 155/4,209/4),
		draw = function()
			--love.graphics.polygon("line", objects["beaker"][uid].body:getWorldPoints(objects["beaker"][uid].shape:getPoints()))
			love.graphics.draw(beakerSprite, objects["beaker"][uid].body:getX(), objects["beaker"][uid].body:getY(), objects["beaker"][uid].body:getAngle(), 1/4, 1/4)
		end,
		click = function() end,
	}
	return beaker
end
