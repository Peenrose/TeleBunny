function joinhazmat()
	local joints = {}
	joints.head = love.physics.newRevoluteJoint(    hazmat.torso.body, hazmat.head.body,     392-150, 590, false)
	joints.head2 = love.physics.newRevoluteJoint(   hazmat.torso.body, hazmat.head.body,     321-150, 583, false)
	joints.leftarm = love.physics.newRevoluteJoint( hazmat.torso.body, hazmat.leftarm.body,  308-150, 624, false)
	joints.rightarm = love.physics.newRevoluteJoint(hazmat.torso.body, hazmat.rightarm.body, 460-150, 639, false)
	joints.leftleg = love.physics.newRevoluteJoint( hazmat.torso.body, hazmat.leftleg.body,  344-150, 729, false)
	joints.rightleg = love.physics.newRevoluteJoint(hazmat.torso.body, hazmat.rightleg.body, 447-150, 720, false)
	hazmat.joints = joints
end

function drawhazmatOutline()
	love.graphics.setColor(0,0,0)
	love.graphics.polygon("line", hazmat.leftleg.body:getWorldPoints(hazmat.leftleg.shape:getPoints()))
	love.graphics.polygon("line", hazmat.rightleg.body:getWorldPoints(hazmat.rightleg.shape:getPoints()))
	love.graphics.polygon("line", hazmat.leftarm.body:getWorldPoints(hazmat.leftarm.shape:getPoints()))
	love.graphics.polygon("line", hazmat.rightarm.body:getWorldPoints(hazmat.rightarm.shape:getPoints()))
	love.graphics.polygon("line", hazmat.torso.body:getWorldPoints(hazmat.torso.shape:getPoints()))
	love.graphics.polygon("line", hazmat.head.body:getWorldPoints(hazmat.head.shape:getPoints()))
end

function drawhazmat(uid)
	--error("hazmat Object: \n"..to_string(objects["hazmat"][uid]))
	love.graphics.draw(hazmatSprites.leftleg,  objects["hazmat"][uid].leftleg.body:getX(),  objects["hazmat"][uid].leftleg.body:getY(),  objects["hazmat"][uid].leftleg.body:getAngle(),  0.078*2, 0.078*2)
	love.graphics.draw(hazmatSprites.rightleg, objects["hazmat"][uid].rightleg.body:getX(), objects["hazmat"][uid].rightleg.body:getY(), objects["hazmat"][uid].rightleg.body:getAngle(), 0.078*2, 0.078*2)
	love.graphics.draw(hazmatSprites.leftarm,  objects["hazmat"][uid].leftarm.body:getX(),  objects["hazmat"][uid].leftarm.body:getY(),  objects["hazmat"][uid].leftarm.body:getAngle(),  0.078*2, 0.078*2)
	love.graphics.draw(hazmatSprites.rightarm, objects["hazmat"][uid].rightarm.body:getX(), objects["hazmat"][uid].rightarm.body:getY(), objects["hazmat"][uid].rightarm.body:getAngle(), 0.078*2, 0.078*2)
	love.graphics.draw(hazmatSprites.torso,    objects["hazmat"][uid].torso.body:getX(),    objects["hazmat"][uid].torso.body:getY(),    objects["hazmat"][uid].torso.body:getAngle(),    0.078*2, 0.078*2)
	love.graphics.draw(hazmatSprites.head,     objects["hazmat"][uid].head.body:getX(),objects["hazmat"][uid].head.body:getY(),objects["hazmat"][uid].head.body:getAngle(),     0.078*2*4.16, 0.078*2*3.91)
end

hazmatWidth = 277*2
hazmatHeight = 329*2

hazmatSprites = {
	torso = love.graphics.newImage("images/Scientist/Hazmat/torso.png"),
	head = love.graphics.newImage("images/Scientist/Hazmat/head.png"),
	leftarm = love.graphics.newImage("images/Scientist/Hazmat/left_arm.png"),
	rightarm = love.graphics.newImage("images/Scientist/Hazmat/right_arm.png"),
	leftleg = love.graphics.newImage("images/Scientist/Hazmat/left_leg.png"),
	rightleg = 	love.graphics.newImage("images/Scientist/Hazmat/right_leg.png"),
}
hazmat = {}
hazmat.draw = drawhazmat
hazmat.headSprite = headSprites.normal
hazmat.torso = {
	body = love.physics.newBody(world, 300-150, settings.window.height-500, "dynamic"),
	shape = love.physics.newPolygonShape(4.99*2,0, 50.23*2,71.76*2, 77.69*2,7.18*2, 92.04*2,66.14*2, 54.9*2,74.5*2, 0,71.76*2),
	draw = function()
		drawhazmat()
	end,
	click = function() end,
	touching_ground = false,
}
hazmat.head = {
	body = love.physics.newBody(world, 250-150, settings.window.height-725, "dynamic"),
	shape = love.physics.newPolygonShape(43.0*2,4.7*2, 95.0*2,6.3*2, 124.5*2,37.1*2, 117.0*2,117.9*2, 81.6*2,120.5*2, 30.8*2,111.3*2, 19.6*2,100.3*2, 19.4*2,27.7*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
hazmat.leftarm = {
	body = love.physics.newBody(world, 159-150, 605, "dynamic"),
	shape = love.physics.newPolygonShape(20.4*2,7.2*2, 78.6*2,0, 79.4*2,28.3*2, 35.0*2,39.5*2, 17.6*2,45.3*2, 2.0*2,33.9*2, .8*2,24.0*2, 12.5*2,9.8*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
hazmat.rightarm = {
	body = love.physics.newBody(world, 430-150, 600, "dynamic"),
	shape = love.physics.newPolygonShape(10.3*2,.9*2, 61.2*2,27.6*2, 70.1*2,46.2*2, 66.0*2,55.8*2, 51.7*2,60.8*2, 0,29.0*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
hazmat.leftleg = {
	body = love.physics.newBody(world, 294-150, 707, "dynamic"),
	shape = love.physics.newPolygonShape(4.2*2,2.8*2, 42.3*2,.6*2, 41.4*2,44.3*2, 45.3*2,50.8*2, 46.8*2,63.3*2, 9.4*2,64.2*2, .5*2,61.1*2, 7.9*2,27.5*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
hazmat.rightleg = {
	body = love.physics.newBody(world, 408-150, 697, "dynamic"),
	shape = love.physics.newPolygonShape(.9*2,3.8*2, 28.4*2,.7*2, 38.5*2,21.6*2, 44.3*2,43.3*2, 47.8*2,48.3*2, 52.6*2,66.2*2, 11.4*2,67.9*2, 10.7*2,31.3*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}

hazmat.leftleg.body:setBullet(true)
hazmat.rightleg.body:setBullet(true)
hazmat.torso.body:setBullet(true)
hazmat.head.body:setBullet(true)
hazmat.leftarm.body:setBullet(true)
hazmat.rightarm.body:setBullet(true)
joinhazmat()
function loadObject(uid)
	-- hazmat.torso.body:setX((hazmat.torso.body:getX()-(objectList["hazmat"]*400))-80)
	-- hazmat.leftarm.body:setX((hazmat.leftarm.body:getX()-(objectList["hazmat"]*400))-80)
	-- hazmat.rightarm.body:setX((hazmat.rightarm.body:getX()-(objectList["hazmat"]*350))-80)
	-- hazmat.head.body:setX((hazmat.head.body:getX()-(objectList["hazmat"]*400))-80)
	-- hazmat.leftleg.body:setX((hazmat.leftleg.body:getX()-(objectList["hazmat"]*400))-80)
	-- hazmat.rightleg.body:setX((hazmat.rightleg.body:getX()-(objectList["hazmat"]*400))-80)

	return hazmat
end