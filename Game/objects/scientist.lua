function joinScientist()
	local joints = {}
	joints.head = love.physics.newRevoluteJoint(objects.scientist_torso.body, objects.scientist_head.body, wx, wy, true)
	joints.leftarm = love.physics.newRevoluteJoint(objects.scientist_torso.body, objects.scientist_leftarm.body, wx, wy, true)
	joints.rightarm = love.physics.newRevoluteJoint(objects.scientist_torso.body, objects.scientist_rightarm.body, wx, wy, true)
	joints.leftleg = love.physics.newRevoluteJoint(objects.scientist_torso.body, objects.scientist_leftleg.body, wx, wy, true)
	joints.rightleg = love.physics.newRevoluteJoint(objects.scientist_torso.body, objects.scientist_rightleg.body, wx, wy, true)
	objects.scientist_torso.joints = joints
end

objects.scientist_torso = {
	body = love.physics.newBody(world, 300, settings.window.height-500, "dynamic"),
	shape = love.physics.newPolygonShape(16,0, 161,23, 249,23, 295,212, 176,239, 0,230),
	draw = function()
		--love.graphics.draw(scientistSprite, objects.scientist_torso.body:getX(), objects.scientist_torso.body:getY(), objects.scientist_torso.body:getAngle(), 0.1, 0.1, scientistSprite:getWidth()/2, scientistSprite:getHeight()/2)
		love.graphics.polygon("line", objects.scientist_torso.body:getWorldPoints(objects.scientist_torso.shape:getPoints()))
	end,
	click = function() end,
}
objects.scientist_head = {
	body = love.physics.newBody(world, 300, settings.window.height-500, "dynamic"),
	shape = love.physics.newPolygonShape(43.0,4.7, 95.0,6.3, 124.5,37.1, 117.0,117.9, 81.6,120.5, 30.8,111.3, 19.6,100.3, 19.4,27.7),
	draw = function()
		love.graphics.polygon("line", objects.scientist_head.body:getWorldPoints(objects.scientist_head.shape:getPoints()))
	end,
	click = function() end,
}
objects.scientist_leftarm = {
	body = love.physics.newBody(world, 300, settings.window.height-500, "dynamic"),
	shape = love.physics.newPolygonShape(20.4,7.2, 78.6,0, 79.4,28.3, 35.0,39.5, 17.6,45.3, 2.0,33.9, .8,24.0, 12.5,9.8),
	draw = function()
		love.graphics.polygon("line", objects.scientist_leftarm.body:getWorldPoints(objects.scientist_leftarm.shape:getPoints()))
	end,
	click = function() end,
}
objects.scientist_rightarm = {
	body = love.physics.newBody(world, 300, settings.window.height-500, "dynamic"),
	shape = love.physics.newPolygonShape(10.3,.9, 61.2,27.6, 70.1,46.2, 66.0,55.8, 51.7,60.8, 0,29.0),
	draw = function()
		love.graphics.polygon("line", objects.scientist_rightarm.body:getWorldPoints(objects.scientist_rightarm.shape:getPoints()))
	end,
	click = function() end,
}
objects.scientist_leftleg = {
	body = love.physics.newBody(world, 300, settings.window.height-500, "dynamic"),
	shape = love.physics.newPolygonShape(4.2,2.8, 42.3,.6, 41.4,44.3, 45.3,50.8, 46.8,63.3, 9.4,64.2, .5,61.1, 7.9,27.5),
	draw = function()
		love.graphics.polygon("line", objects.scientist_leftleg.body:getWorldPoints(objects.scientist_leftleg.shape:getPoints()))
	end,
	click = function() end,
}
objects.scientist_rightleg = {
	body = love.physics.newBody(world, 300, settings.window.height-500, "dynamic"),
	shape = love.physics.newPolygonShape(.9,3.8, 28.4,.7, 38.5,21.6, 44.3,43.3, 47.8,48.3, 52.6,66.2, 11.4,67.9, 10.7,31.3),
	draw = function()
		love.graphics.polygon("line", objects.scientist_rightleg.body:getWorldPoints(objects.scientist_rightleg.shape:getPoints()))
	end,
	click = function() end,
}
--joinScientist()