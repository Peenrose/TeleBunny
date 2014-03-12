function getGroundHeight()
	if currentLevel == "2" then return 1020 end
	return 980
end
ground = {
	body = love.physics.newBody(world, settings.window.width, getGroundHeight(), "static"),
	shape = love.physics.newRectangleShape(10000, 10),
	draw = function()
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("line", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
	end,
}
rightwall = {
	body = love.physics.newBody(world, settings.window.width, settings.window.height/2, "static"),
	shape = love.physics.newRectangleShape(0, settings.window.height),
}
topwall = {
	body = love.physics.newBody(world, 0,0, "static"),
	shape = love.physics.newRectangleShape(settings.window.width*2, 0),
}

if currentLevel == 1 then
	leftwall = {
		body = love.physics.newBody(world, 0, 0, "static"),
		shape = love.physics.newRectangleShape(0, 850),
	}
	leftwall.fixture = love.physics.newFixture(leftwall.body, leftwall.shape)
	shelf = {
		body = love.physics.newBody(world, 240, 375, "static"),
		shape = love.physics.newRectangleShape(355, 12)
	}
	shelf.fixture = love.physics.newFixture(shelf.body, shelf.shape)
	--shelf.fixture:setMask(2)
elseif currentLevel == 2 then
	shelf1 = {
		body = love.physics.newBody(world, 1590, 390, "static"),
		shape = love.physics.newRectangleShape(355, 12)
	}
	shelf1.fixture = love.physics.newFixture(shelf1.body, shelf1.shape)

	shelf2 = {
		body = love.physics.newBody(world, 1590, 520, "static"),
		shape = love.physics.newRectangleShape(355, 12)
	}
	shelf2.fixture = love.physics.newFixture(shelf2.body, shelf2.shape)

	shelf3 = {
		body = love.physics.newBody(world, 1590, 655, "static"),
		shape = love.physics.newRectangleShape(355, 12)
	}
	shelf3.fixture = love.physics.newFixture(shelf3.body, shelf3.shape)


end

ground.fixture = love.physics.newFixture(ground.body, ground.shape)
rightwall.fixture = love.physics.newFixture(rightwall.body, rightwall.shape)
topwall.fixture = love.physics.newFixture(topwall.body, topwall.shape)

topwall.fixture:setRestitution(0.1)
rightwall.fixture:setRestitution(0.1)
--leftwall.fixture:setRestitution(0.1)
ground.fixture:setFriction(1.2)

loadObject = function() end