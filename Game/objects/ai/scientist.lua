sAngles = {0,0,-47,20,0,0}
parts = {
	objects.scientist_head.body:getAngle(), 
	objects.scientist_torso.body:getAngle(), 
	objects.scientist_leftarm.body:getAngle(), 
	objects.scientist_rightarm.body:getAngle(), 
	objects.scientist_leftleg.body:getAngle(), 
	objects.scientist_rightleg.body:getAngle(),
}

function rotatePart(part, amount, time)
	--take x amount of time to rotate y part z degrees
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
	for k, v in pairs(angles) do
		if v > 365 then
			while v >= 365 do
				v = v - 365
			end
			angles[k] = v
		elseif v < -365 then
			while v <= -365 do
				v = v + 365
			end
			angles[k] = v
		end
	end
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
	calculateAngles()
	printAngles()
	-- calc relative angles to torso
	--remove limbs stuck in torso

	--[[	find difference between standing angle and current angle
	for k, v in pairs(angles) do
		if v > 0 then
				
		elseif v < 0 then

		end
	end
	]]--
end
return AI