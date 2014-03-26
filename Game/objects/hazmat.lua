heightOffset = 560
function joinHazmat()
	local joints = {}
	joints.head = love.physics.newWeldJoint(    hazmat.torso.body, hazmat.head.body,     223, 152+heightOffset, false)
	joints.head2 = love.physics.newWeldJoint(   hazmat.torso.body, hazmat.head.body,     317, 163+heightOffset, false)
	joints.leftarm = love.physics.newRevoluteJoint( hazmat.torso.body, hazmat.leftarm.body,  213, 185+heightOffset, false)
	joints.rightarm = love.physics.newRevoluteJoint(hazmat.torso.body, hazmat.rightarm.body, 341, 192+heightOffset, false)
	joints.leftleg = love.physics.newRevoluteJoint( hazmat.torso.body, hazmat.leftleg.body,  250, 311+heightOffset, false)
	joints.rightleg = love.physics.newRevoluteJoint(hazmat.torso.body, hazmat.rightleg.body, 330, 306+heightOffset, false)
	hazmat.joints = joints
end

function drawHazmat(uid)
	--error("hazmat Object: \n"..to_string(objects["hazmat"][uid]))
	love.graphics.draw(hazmatSprites.leftleg,  objects["hazmat"][uid].leftleg.body:getX(),  objects["hazmat"][uid].leftleg.body:getY(),  objects["hazmat"][uid].leftleg.body:getAngle(),  1*0.6, 1*0.6)
	love.graphics.draw(hazmatSprites.rightleg, objects["hazmat"][uid].rightleg.body:getX(), objects["hazmat"][uid].rightleg.body:getY(), objects["hazmat"][uid].rightleg.body:getAngle(), 1*0.6, 1*0.6)
	love.graphics.draw(hazmatSprites.leftarm,  objects["hazmat"][uid].leftarm.body:getX(),  objects["hazmat"][uid].leftarm.body:getY(),  objects["hazmat"][uid].leftarm.body:getAngle(),  1*0.6, 1*0.6)
	love.graphics.draw(hazmatSprites.rightarm, objects["hazmat"][uid].rightarm.body:getX(), objects["hazmat"][uid].rightarm.body:getY(), objects["hazmat"][uid].rightarm.body:getAngle(), 1*0.6, 1*0.6)
	love.graphics.draw(hazmatSprites.torso,    objects["hazmat"][uid].torso.body:getX(),    objects["hazmat"][uid].torso.body:getY(),    objects["hazmat"][uid].torso.body:getAngle(),    1*0.6, 1*0.6)
	if not hazmatHelmetBroken[uid] then
		love.graphics.draw(hazmatSprites.head,     objects["hazmat"][uid].head.body:getX(),     objects["hazmat"][uid].head.body:getY(),     objects["hazmat"][uid].head.body:getAngle(),     1*0.6, 1*0.6)
	else
		love.graphics.draw(hazmatSprites.brokenHelm,     objects["hazmat"][uid].head.body:getX(),     objects["hazmat"][uid].head.body:getY(),     objects["hazmat"][uid].head.body:getAngle(),     1*0.6, 1*0.6)
	end
	-- love.graphics.setColor(0,0,0)
	-- love.graphics.polygon("line", hazmat.leftleg.body:getWorldPoints(hazmat.leftleg.shape:getPoints()))
	-- love.graphics.polygon("line", hazmat.rightleg.body:getWorldPoints(hazmat.rightleg.shape:getPoints()))
	-- love.graphics.polygon("line", hazmat.leftarm.body:getWorldPoints(hazmat.leftarm.shape:getPoints()))
	-- love.graphics.polygon("line", hazmat.rightarm.body:getWorldPoints(hazmat.rightarm.shape:getPoints()))
	-- love.graphics.polygon("line", hazmat.torso.body:getWorldPoints(hazmat.torso.shape:getPoints()))
	-- love.graphics.polygon("line", hazmat.head.body:getWorldPoints(hazmat.head.shape:getPoints()))
end

hazmatSprites = {
	torso = love.graphics.newImage("images/Scientist/Hazmat/torso.png"),
	head = love.graphics.newImage("images/Scientist/Hazmat/head.png"),
	leftarm = love.graphics.newImage("images/Scientist/Hazmat/left_arm.png"),
	rightarm = love.graphics.newImage("images/Scientist/Hazmat/right_arm.png"),
	leftleg = love.graphics.newImage("images/Scientist/Hazmat/left_leg.png"),
	rightleg = 	love.graphics.newImage("images/Scientist/Hazmat/right_leg.png"),
	brokenHelm = love.graphics.newImage("images/Scientist/Hazmat/headsmash.png")
}
hazmat = {}
hazmat.draw = drawHazmat
hazmat.torso = {
	body = love.physics.newBody(world, 200,140+heightOffset, "dynamic"),
	shape = love.physics.newPolygonShape(2*0.6,2*0.6, 235*0.6,32*0.6, 270*0.6,267*0.6, 168*0.6,292*0.6, 6*0.6,282*0.6),
	draw = function()
		drawhazmat()
	end,
}
hazmat.head = {
	body = love.physics.newBody(world, 200,0+heightOffset, "dynamic"),
	shape = love.physics.newPolygonShape(2*0.6,22*0.6, 236*0.6,18*0.6, 235*0.6,280*0.6, 3*0.6,251*0.6),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
hazmat.leftarm = {
	body = love.physics.newBody(world, 45,160+heightOffset, "dynamic"),
	shape = love.physics.newPolygonShape(274*0.6,2*0.6, 296*0.6,109*0.6, 132*0.6,179*0.6, 84*0.6,225*0.6, 14*0.6,196*0.6, 3*0.6,156*0.6, 28*0.6,88*0.6),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
hazmat.rightarm = {
	body = love.physics.newBody(world, 310,170+heightOffset, "dynamic"),
	shape = love.physics.newPolygonShape(38*0.6,3*0.6, 245*0.6,116*0.6, 273*0.6,170*0.6, 260*0.6,207*0.6, 199*0.6,232*0.6, 153*0.6,192*0.6, 3*0.6,116*0.6),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
hazmat.leftleg = {
	body = love.physics.newBody(world, 200,300+heightOffset, "dynamic"),
	shape = love.physics.newPolygonShape(4*0.6,11*0.6, 144*0.6,3*0.6, 151*0.6,94*0.6, 144*0.6,182*0.6, 161*0.6,251*0.6, 12*0.6,257*0.6, 16*0.6,110*0.6),
	draw = function() end,
	click = function() end,
	touching_ground = false,
}
hazmat.rightleg = {
	body = love.physics.newBody(world, 290,280+heightOffset, "dynamic"),
	shape = love.physics.newPolygonShape(105*0.6,3*0.6, 149*0.6,93*0.6, 171*0.6,188*0.6, 189*0.6,211*0.6, 198*0.6,268*0.6, 51*0.6,276*0.6, 37*0.6,117*0.6, 1*0.6,15*0.6),
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
joinHazmat()
function loadObject(uid)
	-- hazmat.torso.body:setX((hazmat.torso.body:getX()-(objectList["hazmat"]*700))-80)
	-- hazmat.leftarm.body:setX((hazmat.leftarm.body:getX()-(objectList["hazmat"]*700))-80)
	-- hazmat.rightarm.body:setX((hazmat.rightarm.body:getX()-(objectList["hazmat"]*700))-80)
	-- hazmat.head.body:setX((hazmat.head.body:getX()-(objectList["hazmat"]*700))-80)
	-- hazmat.leftleg.body:setX((hazmat.leftleg.body:getX()-(objectList["hazmat"]*700))-80)
	-- hazmat.rightleg.body:setX((hazmat.rightleg.body:getX()-(objectList["hazmat"]*700))-80)

	if uid ~= 1 then
		hazmat.torso.body:setX((hazmat.torso.body:getX()-(objectList["hazmat"]*700))-80)
		hazmat.leftarm.body:setX((hazmat.leftarm.body:getX()-(objectList["hazmat"]*700))-80)
		hazmat.rightarm.body:setX((hazmat.rightarm.body:getX()-(objectList["hazmat"]*700))-80)
		hazmat.head.body:setX((hazmat.head.body:getX()-(objectList["hazmat"]*700))-80)
		hazmat.leftleg.body:setX((hazmat.leftleg.body:getX()-(objectList["hazmat"]*700))-80)
		hazmat.rightleg.body:setX((hazmat.rightleg.body:getX()-(objectList["hazmat"]*700))-80)
	end
	
	return hazmat
end