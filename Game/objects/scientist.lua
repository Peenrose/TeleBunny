function joinScientist()
	local joints = {}
	joints.head = love.physics.newRevoluteJoint(    scientist.torso.body, scientist.head.body,     392-150, 590, false)
	joints.head2 = love.physics.newRevoluteJoint(   scientist.torso.body, scientist.head.body,     321-150, 583, false)
	joints.leftarm = love.physics.newRevoluteJoint( scientist.torso.body, scientist.leftarm.body,  308-150, 624, false)
	joints.rightarm = love.physics.newRevoluteJoint(scientist.torso.body, scientist.rightarm.body, 460-150, 639, false)
	joints.leftleg = love.physics.newRevoluteJoint( scientist.torso.body, scientist.leftleg.body,  344-150, 729, false)
	joints.rightleg = love.physics.newRevoluteJoint(scientist.torso.body, scientist.rightleg.body, 447-150, 720, false)
	scientist.joints = joints
end

function drawScientistOutline()
	love.graphics.setColor(0,0,0)
	love.graphics.polygon("line", scientist.leftleg.body:getWorldPoints(scientist.leftleg.shape:getPoints()))
	love.graphics.polygon("line", scientist.rightleg.body:getWorldPoints(scientist.rightleg.shape:getPoints()))
	love.graphics.polygon("line", scientist.leftarm.body:getWorldPoints(scientist.leftarm.shape:getPoints()))
	love.graphics.polygon("line", scientist.rightarm.body:getWorldPoints(scientist.rightarm.shape:getPoints()))
	love.graphics.polygon("line", scientist.torso.body:getWorldPoints(scientist.torso.shape:getPoints()))
	love.graphics.polygon("line", scientist.head.body:getWorldPoints(scientist.head.shape:getPoints()))
end

function drawScientist(uid)
	--error("Scientist Object: \n"..to_string(objects["scientist"][uid]))
	love.graphics.draw(scientistSprites.leftleg,  objects["scientist"][uid].leftleg.body:getX(),  objects["scientist"][uid].leftleg.body:getY(),  objects["scientist"][uid].leftleg.body:getAngle(),  0.078*2, 0.078*2)
	love.graphics.draw(scientistSprites.rightleg, objects["scientist"][uid].rightleg.body:getX(), objects["scientist"][uid].rightleg.body:getY(), objects["scientist"][uid].rightleg.body:getAngle(), 0.078*2, 0.078*2)
	love.graphics.draw(scientistSprites.leftarm,  objects["scientist"][uid].leftarm.body:getX(),  objects["scientist"][uid].leftarm.body:getY(),  objects["scientist"][uid].leftarm.body:getAngle(),  0.078*2, 0.078*2)
	love.graphics.draw(scientistSprites.rightarm, objects["scientist"][uid].rightarm.body:getX(), objects["scientist"][uid].rightarm.body:getY(), objects["scientist"][uid].rightarm.body:getAngle(), 0.078*2, 0.078*2)
	love.graphics.draw(scientistSprites.torso,    objects["scientist"][uid].torso.body:getX(),    objects["scientist"][uid].torso.body:getY(),    objects["scientist"][uid].torso.body:getAngle(),    0.078*2, 0.078*2)
	love.graphics.draw(objects["scientist"][uid].headSprite,objects["scientist"][uid].head.body:getX(),objects["scientist"][uid].head.body:getY(),objects["scientist"][uid].head.body:getAngle(),     0.078*2*4.16, 0.078*2*3.91)
end

scientistWidth = 277*2
scientistHeight = 329*2

headSprites = {
	normal = love.graphics.newImage("images/Scientist/scientist_head.png"),
	dazed = love.graphics.newImage("images/Scientist/scientist_head_dazed.png"),
	worried = love.graphics.newImage("images/Scientist/scientist_head_worried.png"),
}
scientistSprites = {
	torso = love.graphics.newImage("images/Scientist/torso.png"),
	head = headSprites.worried,
	leftarm = love.graphics.newImage("images/Scientist/left_arm.png"),
	rightarm = love.graphics.newImage("images/Scientist/right_arm.png"),
	leftleg = love.graphics.newImage("images/Scientist/left_leg.png"),
	rightleg = 	love.graphics.newImage("images/Scientist/right_leg.png"),
}
scientist = {}
scientist.draw = drawScientist
scientist.headSprite = headSprites.normal
scientist.torso = {
	body = love.physics.newBody(world, 300-150, settings.window.height-500, "dynamic"),
	shape = love.physics.newPolygonShape(4.99*2,0, 50.23*2,71.76*2, 77.69*2,7.18*2, 92.04*2,66.14*2, 54.9*2,74.5*2, 0,71.76*2),
	draw = function()
		drawScientist()
	end,
	click = function() end,
	touching_ground = false,
}
scientist.head = {
	body = love.physics.newBody(world, 250-150, settings.window.height-725, "dynamic"),
	shape = love.physics.newPolygonShape(43.0*2,4.7*2, 95.0*2,6.3*2, 124.5*2,37.1*2, 117.0*2,117.9*2, 81.6*2,120.5*2, 30.8*2,111.3*2, 19.6*2,100.3*2, 19.4*2,27.7*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
scientist.leftarm = {
	body = love.physics.newBody(world, 159-150, 605, "dynamic"),
	shape = love.physics.newPolygonShape(20.4*2,7.2*2, 78.6*2,0, 79.4*2,28.3*2, 35.0*2,39.5*2, 17.6*2,45.3*2, 2.0*2,33.9*2, .8*2,24.0*2, 12.5*2,9.8*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
scientist.rightarm = {
	body = love.physics.newBody(world, 430-150, 600, "dynamic"),
	shape = love.physics.newPolygonShape(10.3*2,.9*2, 61.2*2,27.6*2, 70.1*2,46.2*2, 66.0*2,55.8*2, 51.7*2,60.8*2, 0,29.0*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
scientist.leftleg = {
	body = love.physics.newBody(world, 294-150, 707, "dynamic"),
	shape = love.physics.newPolygonShape(4.2*2,2.8*2, 42.3*2,.6*2, 41.4*2,44.3*2, 45.3*2,50.8*2, 46.8*2,63.3*2, 9.4*2,64.2*2, .5*2,61.1*2, 7.9*2,27.5*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
scientist.rightleg = {
	body = love.physics.newBody(world, 408-150, 697, "dynamic"),
	shape = love.physics.newPolygonShape(.9*2,3.8*2, 28.4*2,.7*2, 38.5*2,21.6*2, 44.3*2,43.3*2, 47.8*2,48.3*2, 52.6*2,66.2*2, 11.4*2,67.9*2, 10.7*2,31.3*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}

scientist.leftleg.body:setBullet(true)
scientist.rightleg.body:setBullet(true)
scientist.torso.body:setBullet(true)
scientist.head.body:setBullet(true)
scientist.leftarm.body:setBullet(true)
scientist.rightarm.body:setBullet(true)
joinScientist()
function loadObject(uid)
	scientist.torso.body:setX((scientist.torso.body:getX()-(objectList["scientist"]*700))-80)
	scientist.leftarm.body:setX((scientist.leftarm.body:getX()-(objectList["scientist"]*700))-80)
	scientist.rightarm.body:setX((scientist.rightarm.body:getX()-(objectList["scientist"]*700))-80)
	scientist.head.body:setX((scientist.head.body:getX()-(objectList["scientist"]*700))-80)
	scientist.leftleg.body:setX((scientist.leftleg.body:getX()-(objectList["scientist"]*700))-80)
	scientist.rightleg.body:setX((scientist.rightleg.body:getX()-(objectList["scientist"]*700))-80)

	return scientist
end