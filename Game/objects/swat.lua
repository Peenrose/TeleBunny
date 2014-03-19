function joinSwat()
	local joints = {}
	joints.head = love.physics.newWeldJoint(        swat.torso.body, swat.head.body,     178, 605, false)
	joints.head2 = love.physics.newWeldJoint(       swat.torso.body, swat.head.body,     288, 610, false)
	joints.leftarm = love.physics.newRevoluteJoint( swat.torso.body, swat.leftarm.body,  163, 627, false)
	joints.rightarm = love.physics.newRevoluteJoint(swat.torso.body, swat.rightarm.body, 295, 622, false)
	joints.leftleg = love.physics.newRevoluteJoint( swat.torso.body, swat.leftleg.body,  200, 717, false)
	joints.rightleg = love.physics.newRevoluteJoint(swat.torso.body, swat.rightleg.body, 287, 713, false)
	swat.joints = joints
end

function drawSwatOutline()
	love.graphics.setColor(0,0,0)
	love.graphics.polygon("line", swat.leftleg.body:getWorldPoints(swat.leftleg.shape:getPoints()))
	love.graphics.polygon("line", swat.rightleg.body:getWorldPoints(swat.rightleg.shape:getPoints()))
	love.graphics.polygon("line", swat.leftarm.body:getWorldPoints(swat.leftarm.shape:getPoints()))
	love.graphics.polygon("line", swat.rightarm.body:getWorldPoints(swat.rightarm.shape:getPoints()))
	love.graphics.polygon("line", swat.torso.body:getWorldPoints(swat.torso.shape:getPoints()))
	love.graphics.polygon("line", swat.head.body:getWorldPoints(swat.head.shape:getPoints()))
end

function drawSwat(uid)
	--error("Swat Object: \n"..to_string(objects["swat"][uid]))
	love.graphics.draw(swatSprites.leftleg,  objects["swat"][uid].leftleg.body:getX(),  objects["swat"][uid].leftleg.body:getY(),  objects["swat"][uid].leftleg.body:getAngle(), 0.6, 0.6)
	love.graphics.draw(swatSprites.rightleg, objects["swat"][uid].rightleg.body:getX(), objects["swat"][uid].rightleg.body:getY(), objects["swat"][uid].rightleg.body:getAngle(), 0.6, 0.6)
	love.graphics.draw(swatSprites.leftarm,  objects["swat"][uid].leftarm.body:getX(),  objects["swat"][uid].leftarm.body:getY(),  objects["swat"][uid].leftarm.body:getAngle(), 0.6, 0.6)
	love.graphics.draw(swatSprites.rightarm, objects["swat"][uid].rightarm.body:getX(), objects["swat"][uid].rightarm.body:getY(), objects["swat"][uid].rightarm.body:getAngle(), 0.6, 0.6)
	love.graphics.draw(swatSprites.torso,    objects["swat"][uid].torso.body:getX(),    objects["swat"][uid].torso.body:getY(),    objects["swat"][uid].torso.body:getAngle(), 0.6, 0.6)
	love.graphics.draw(swatSprites.head,     objects["swat"][uid].head.body:getX(),     objects["swat"][uid].head.body:getY(),     objects["swat"][uid].head.body:getAngle(), 0.6, 0.6)
end

swatWidth = 277*2
swatHeight = 329*2

swatSprites = {
	torso = love.graphics.newImage("images/Scientist/Swat/torso.png"),
	head = love.graphics.newImage("images/Scientist/Swat/head.png"),
	leftarm = love.graphics.newImage("images/Scientist/Swat/left_arm.png"),
	rightarm = love.graphics.newImage("images/Scientist/Swat/right_arm.png"),
	leftleg = love.graphics.newImage("images/Scientist/Swat/left_leg.png"),
	rightleg = 	love.graphics.newImage("images/Scientist/Swat/right_leg.png"),
}
swat = {}
swat.draw = drawSwat
swat.torso = {
	body = love.physics.newBody(world, 300-150, settings.window.height-500, "dynamic"),
	shape = love.physics.newPolygonShape(4*0.6,4*0.6, 146*0.6,22*0.6, 242*0.6,9*0.6, 267*0.6,217*0.6, 157*0.6,234*0.6, 27*0.6,229*0.6),
	draw = function()
		drawSwat()
	end,
	click = function() end,
	touching_ground = false,
}
swat.head = {
	body = love.physics.newBody(world, 270-150, 400, "dynamic"),
	shape = love.physics.newPolygonShape(3*0.6,214*0.6, 54*0.6,47*0.6, 177*0.6,363*0.6, 296*0.6,52*0.6, 331*0.6,152*0.6, 309*0.6,353*0.6, 60*0.6,338*0.6),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
swat.leftarm = {
	body = love.physics.newBody(world, 159-150, 605, "dynamic"),
	shape = love.physics.newPolygonShape(20.4*2,7.2*2, 78.6*2,0, 79.4*2,28.3*2, 35.0*2,39.5*2, 17.6*2,45.3*2, 2.0*2,33.9*2, .8*2,24.0*2, 12.5*2,9.8*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
swat.rightarm = {
	body = love.physics.newBody(world, 430-150, 620, "dynamic"),
	shape = love.physics.newPolygonShape(10.3*2,.9*2, 61.2*2,27.6*2, 70.1*2,46.2*2, 66.0*2,55.8*2, 51.7*2,60.8*2, 0,29.0*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
swat.leftleg = {
	body = love.physics.newBody(world, 305-150, 707, "dynamic"),
	shape = love.physics.newPolygonShape(4.2*2,2.8*2, 42.3*2,.6*2, 41.4*2,44.3*2, 45.3*2,50.8*2, 46.8*2,63.3*2, 9.4*2,64.2*2, .5*2,61.1*2, 7.9*2,27.5*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
swat.rightleg = {
	body = love.physics.newBody(world, 400-150, 697, "dynamic"),
	shape = love.physics.newPolygonShape(.9*2,3.8*2, 28.4*2,.7*2, 38.5*2,21.6*2, 44.3*2,43.3*2, 47.8*2,48.3*2, 52.6*2,66.2*2, 11.4*2,67.9*2, 10.7*2,31.3*2),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}

swat.leftleg.body:setBullet(true)
swat.rightleg.body:setBullet(true)
swat.torso.body:setBullet(true)
swat.head.body:setBullet(true)
swat.leftarm.body:setBullet(true)
swat.rightarm.body:setBullet(true)
joinSwat()

swat.head.fixture = love.physics.newFixture(swat.head.body, swat.head.shape)
swat.torso.fixture = love.physics.newFixture(swat.torso.body, swat.torso.shape)
swat.leftleg.fixture = love.physics.newFixture(swat.leftleg.body, swat.leftleg.shape)
swat.leftarm.fixture = love.physics.newFixture(swat.leftarm.body, swat.leftarm.shape)
swat.rightarm.fixture = love.physics.newFixture(swat.rightarm.body, swat.rightarm.shape)
swat.rightleg.fixture = love.physics.newFixture(swat.rightleg.body, swat.rightleg.shape)

swat.head.fixture:setDensity(swat.head.fixture:getDensity()*3)
swat.torso.fixture:setDensity(swat.torso.fixture:getDensity()*3)
swat.leftarm.fixture:setDensity(swat.leftarm.fixture:getDensity()*3)
swat.leftleg.fixture:setDensity(swat.leftleg.fixture:getDensity()*3)
swat.rightarm.fixture:setDensity(swat.rightarm.fixture:getDensity()*3)
swat.rightleg.fixture:setDensity(swat.rightleg.fixture:getDensity()*3)

-- swat.torso.body:setX((swat.torso.body:getX()-(objectList["swat"]*700))-80)
-- swat.leftarm.body:setX((swat.leftarm.body:getX()-(objectList["swat"]*700))-80)
-- swat.rightarm.body:setX((swat.rightarm.body:getX()-(objectList["swat"]*700))-80)
-- swat.head.body:setX((swat.head.body:getX()-(objectList["swat"]*700))-80)
-- swat.leftleg.body:setX((swat.leftleg.body:getX()-(objectList["swat"]*700))-80)
-- swat.rightleg.body:setX((swat.rightleg.body:getX()-(objectList["swat"]*700))-80)

function loadObject(uid)
	return swat
end