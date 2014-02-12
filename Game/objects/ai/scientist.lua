sAngles = {0,0,-47,20,0,0}
parts = {
	objects.scientist_head.body:getAngle(), 
	objects.scientist_torso.body:getAngle(), 
	objects.scientist_leftarm.body:getAngle(), 
	objects.scientist_rightarm.body:getAngle(), 
	objects.scientist_leftleg.body:getAngle(), 
	objects.scientist_rightleg.body:getAngle(),
}

function compareAngles(a1, a2)
	a1 = a1 + 360
	a2 = a2 + 360
	res = 0
	if a1 > a2 then
		res = (a1-a2)-360
	elseif a2 > a1 then
		res = (a2-a1)-360
	end
	if res-180 > 180 then 
		res = 360-res
	end
	return res+360
end

function rotatePart(part, amount, time)
	--take x amount of time to rotate y part z degrees
end

function calcTorso()
	comp = compareAngles(angles[2], 0)
	addInfo("difference from standing angle: "..math.abs(comp))
end

function calculateAngles()
	angles = {
		round(objects.scientist_head.body:getAngle()*57.3, 1),
		round(objects.scientist_torso.body:getAngle()*57.3, 1),
		round(objects.scientist_leftarm.body:getAngle()*57.3, 1),
		round(objects.scientist_rightarm.body:getAngle()*57.3, 1),
		round(objects.scientist_leftleg.body:getAngle()*57.3, 1),
		round(objects.scientist_rightleg.body:getAngle()*57.3, 1),
	}
end

function printAngles()
	addInfo("Head:  "..angles[1])
	addInfo("Torso: "..angles[2])
	addInfo("LArm:  "..angles[3])
	addInfo("RArm:  "..angles[4])
	addInfo("LLeg:  "..angles[5])
	addInfo("RLeg:  "..angles[6])
end

function AI(dt)
	--calculateAngles()
	--printAngles()
	addInfo(objects.scientist_torso.body:getLinearVelocity(), 0)
	addInfo(objects.scientist_head.body:getY(), 0)
	
	avel, bvel = objects.scientist_torso.body:getLinearVelocity()
	vel = math.max(avel, bvel)
	y = objects.scientist_head.body:getY()
	if y > 475 and y < 600 then
		--objects.scientist_head.body:applyLinearImpulse(1000,-1000)
	end 
end
return AI