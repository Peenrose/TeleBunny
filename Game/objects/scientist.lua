function joinScientist()
	local joints = {}
	joints.head = love.physics.newRevoluteJoint(objects.scientist_torso.body, objects.scientist_head.body, 349, 585, false)
	joints.leftarm = love.physics.newRevoluteJoint(objects.scientist_torso.body, objects.scientist_leftarm.body, 305, 594, false)
	joints.rightarm = love.physics.newRevoluteJoint(objects.scientist_torso.body, objects.scientist_rightarm.body, 379, 596, false)
	joints.leftleg = love.physics.newRevoluteJoint(objects.scientist_torso.body, objects.scientist_leftleg.body, 329, 649, false)
	joints.rightleg = love.physics.newRevoluteJoint(objects.scientist_torso.body, objects.scientist_rightleg.body, 375, 649, false)
	objects.scientist_torso.joints = joints
end

function drawScientistOutline()
	love.graphics.polygon("line", objects.scientist_leftleg.body:getWorldPoints(objects.scientist_leftleg.shape:getPoints()))
	love.graphics.polygon("line", objects.scientist_rightleg.body:getWorldPoints(objects.scientist_rightleg.shape:getPoints()))
	love.graphics.polygon("line", objects.scientist_leftarm.body:getWorldPoints(objects.scientist_leftarm.shape:getPoints()))
	love.graphics.polygon("line", objects.scientist_rightarm.body:getWorldPoints(objects.scientist_rightarm.shape:getPoints()))
	love.graphics.polygon("line", objects.scientist_torso.body:getWorldPoints(objects.scientist_torso.shape:getPoints()))
	love.graphics.polygon("line", objects.scientist_head.body:getWorldPoints(objects.scientist_head.shape:getPoints()))
end

function drawScientist()
	love.graphics.draw(scientistSprites.leftleg, objects.scientist_leftleg.body:getX(), objects.scientist_leftleg.body:getY(), objects.scientist_leftleg.body:getAngle(), 0.078*2, 0.078*2)
	love.graphics.draw(scientistSprites.rightleg, objects.scientist_rightleg.body:getX(), objects.scientist_rightleg.body:getY(), objects.scientist_rightleg.body:getAngle(), 0.078*2, 0.078*2)
	love.graphics.draw(scientistSprites.leftarm, objects.scientist_leftarm.body:getX(), objects.scientist_leftarm.body:getY(), objects.scientist_leftarm.body:getAngle(), 0.078*2, 0.078*2)
	love.graphics.draw(scientistSprites.rightarm, objects.scientist_rightarm.body:getX(), objects.scientist_rightarm.body:getY(), objects.scientist_rightarm.body:getAngle(), 0.078*2, 0.078*2)
	love.graphics.draw(scientistSprites.torso, objects.scientist_torso.body:getX(), objects.scientist_torso.body:getY(), objects.scientist_torso.body:getAngle(), 0.078*2, 0.078*2)
	love.graphics.draw(scientistSprites.head, objects.scientist_head.body:getX(), objects.scientist_head.body:getY(), objects.scientist_head.body:getAngle(), 0.078*2, 0.078*2)
end

function isScientistPart(fixture)
	if fixture == objects.scientist_torso.fixture then return true end
	if fixture == objects.scientist_head.fixture then return true end
	if fixture == objects.scientist_leftarm.fixture then return true end
	if fixture == objects.scientist_rightarm.fixture then return true end
	if fixture == objects.scientist_leftleg.fixture then return true end
	if fixture == objects.scientist_rightleg.fixture then return true end

	return false
end

scientistWidth = 277*2
scientistHeight = 329*2


scientistSprites = {
	torso = love.graphics.newImage("images/Scientist/torso.png"),
	head = love.graphics.newImage("images/Scientist/head.png"),
	leftarm = love.graphics.newImage("images/Scientist/left_arm.png"),
	rightarm = love.graphics.newImage("images/Scientist/right_arm.png"),
	leftleg = love.graphics.newImage("images/Scientist/left_leg.png"),
	rightleg = 	love.graphics.newImage("images/Scientist/right_leg.png"),
}

objects.scientist_torso = {
	body = love.physics.newBody(world, 300, settings.window.height-500, "dynamic"),
	shape = love.physics.newPolygonShape(4.99*2,0, 50.23*2,71.76*2, 77.69*2,7.18*2, 92.04*2,66.14*2, 54.9*2,74.5*2, 0,71.76*2),
	draw = function()
		drawScientist()
	end,
	click = function() end,
}
objects.scientist_head = {
	body = love.physics.newBody(world, 270, settings.window.height-615, "dynamic"),
	shape = love.physics.newPolygonShape(43.0*2,4.7*2, 95.0*2,6.3*2, 124.5*2,37.1*2, 117.0*2,117.9*2, 81.6*2,120.5*2, 30.8*2,111.3*2, 19.6*2,100.3*2, 19.4*2,27.7*2),
	draw = function() end,
	click = function() end,
}
objects.scientist_leftarm = {
	body = love.physics.newBody(world, 300-70, settings.window.height-500, "dynamic"),
	shape = love.physics.newPolygonShape(20.4*2,7.2*2, 78.6*2,0, 79.4*2,28.3*2, 35.0*2,39.5*2, 17.6*2,45.3*2, 2.0*2,33.9*2, .8*2,24.0*2, 12.5*2,9.8*2),
	draw = function() end,
	click = function() end,
}
objects.scientist_rightarm = {
	body = love.physics.newBody(world, 300+70, settings.window.height-500, "dynamic"),
	shape = love.physics.newPolygonShape(10.3*2,.9*2, 61.2*2,27.6*2, 70.1*2,46.2*2, 66.0*2,55.8*2, 51.7*2,60.*28, 0,29.0*2),
	draw = function() end,
	click = function() end,
}
objects.scientist_leftleg = {
	body = love.physics.newBody(world, 300, settings.window.height-435, "dynamic"),
	shape = love.physics.newPolygonShape(4.2*2,2.8*2, 42.3*2,.6*2, 41.4*2,44.3*2, 45.3*2,50.8*2, 46.8*2,63.3*2, 9.4*2,64.2*2, .5*2,61.1*2, 7.9*2,27.5*2),
	draw = function() end,
	click = function() end,
}
objects.scientist_rightleg = {
	body = love.physics.newBody(world, 355, settings.window.height-445, "dynamic"),
	shape = love.physics.newPolygonShape(.9*2,3.8*2, 28.4*2,.7*2, 38.5*2,21.6*2, 44.3*2,43.3*2, 47.8*2,48.3*2, 52.6*2,66.2*2, 11.4*2,67.9*2, 10.7*2,31.3*2),
	draw = function() end,
	click = function() end,
}
--joinScientist()