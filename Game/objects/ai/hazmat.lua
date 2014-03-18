function AI(dt)
	if objectList["hazmat"] == nil then return false end
	for uid = 1, objectList["hazmat"] do
		if removedObjects["hazmat"] ~= nil and removedObjects["hazmat"][uid] ~= nil then else
			HazmatAI(uid, dt)
		end
	end
end

function hazmatApproachBunny(uid)
	hazmat = objects["hazmat"][uid]
	hazmat.torso.body:setLinearVelocity(160, -210)
	hazmat.rightleg.body:applyAngularImpulse(-10000)
	hazmat.leftleg.body:applyAngularImpulse(-2000)
	hazmat.torso.body:applyAngularImpulse(-10000)
end

function getAngle(uid)
	hazmat = objects["hazmat"][uid]
	angle = hazmat.torso.body:getAngle()
	local pos = 1
	if angle < 0 then
		while angle < -(2*math.pi) do angle = angle + (2*math.pi) end
		pos = 1
	elseif angle > 0 then
		while angle > (2*math.pi) do angle = angle - (2*math.pi) end
		pos = -1
	end
	return angle
end

function spinUpright(uid)
	hazmat = objects["hazmat"][uid]
	angle = getAngle(uid)
	if math.abs(angle) > 1 then
		hazmat.torso.body:applyAngularImpulse(angle*-35000)
	else
		hazmat.torso.body:applyAngularImpulse(angle*-30000)
	end
	
	if math.abs(angle) < 0.5 then 
		hazmat.torso.body:applyAngularImpulse((angle-0.1)*-200000) 
	end

	if angle < 0.2 then
		hazmat.rightleg.body:applyAngularImpulse(-750)
	end
end

function isRotating(uid)
	if math.abs(getAngle(uid)) < 0.4 then
		return false
	else 
		return true
	end
end

function kick(uid)
	if dazed[uid] == -1 then
		hazmat = objects["hazmat"][uid]
		kickReset[uid] = 1
		hazmat.rightleg.body:applyAngularImpulse(-1000000)
		hazmat.torso.body:applyLinearImpulse(10000, 0)
		dazedImmune[uid] = 2
	end
end

function hazmatFlailFunction()
	if not objects["hazmat"] then return end
	hazmat = objects["hazmat"][1]
	if not hazmat then return end
	hazmatFlail = true
	hazmat.leftarm.body:applyAngularImpulse(300000)
	hazmat.rightarm.body:applyAngularImpulse(-300000)
	hazmat.rightleg.body:applyAngularImpulse(-200000)
	hazmat.torso.body:applyLinearImpulse(3000, -10000)
	if levelTime < 8 then levelTime = 8 end
end

function HazmatAI(uid, dt)
	dt = dt * 1.5
	hazmat = objects["hazmat"][uid]
	if not hazmat then return end
	
	if levelTime == nil then levelTime = 0 end
	if hazmatFlail == nil then hazmatFlail = false end
	if levelTime > 8 and not hazmatFlail and uid == 1 then
		hazmatFlailFunction()
	end

	if hazmat.torso ~= nil and hazmat.leftleg ~= nil then
		x,head_y = hazmat.head.body:getPosition()
		xvel, yvel = hazmat.head.body:getLinearVelocity()
		
		maxvel = math.max(math.abs(xvel), math.abs(yvel))

		if foot_touching_ground[uid] == nil then foot_touching_ground[uid] = 0 end

		spinUpright(uid)
			
		if isRotating(uid) == false and foot_touching_ground[uid] == 2 then hazmatApproachBunny(uid) end
			-- addInfo("Feet On Ground ("..uid.."): "..foot_touching_ground[uid])
			-- addInfo("Touching Ground ("..uid.."): "..touching_ground[uid])
			-- addInfo("Dazed ("..uid.."): "..dazed[uid])
	end
end

function hazmatBeginContact(a, b, coll)
	if isHazmatPart(a) or isHazmatPart(b) then
		if isHazmatPart(a) then
			if touching_ground[isHazmatPart(a)] == nil then touching_ground[isHazmatPart(a)] = 0 end
			if foot_touching_ground[isHazmatPart(a)] == nil then foot_touching_ground[isHazmatPart(a)] = 0 end
		elseif isHazmatPart(b) then
			if touching_ground[isHazmatPart(b)] == nil then touching_ground[isHazmatPart(b)] = 0 end
			if foot_touching_ground[isHazmatPart(b)] == nil then foot_touching_ground[isHazmatPart(b)] = 0 end
		end
	end

	if isHazmatPart(a) then
		if isHazmatFoot(a) then
			if b == ground.fixture then
				foot_touching_ground[isHazmatPart(a)] = foot_touching_ground[isHazmatPart(a)] + 1
			end
		else
			if b == ground.fixture then
				touching_ground[isHazmatPart(a)] = touching_ground[isHazmatPart(a)] + 1
			end
		end
	elseif isHazmatPart(b) then
		if isHazmatFoot(b) then
			if a == ground.fixture then
				foot_touching_ground[isHazmatPart(b)] = foot_touching_ground[isHazmatPart(b)] + 1
			end
		else
			if a == ground.fixture then
				touching_ground[isHazmatPart(b)] = touching_ground[isHazmatPart(b)] + 1
			end
		end
	end
end

function hazmatEndContact(a, b, coll)
	if isHazmatPart(a) then
		if isHazmatFoot(a) then
			if b == ground.fixture then
				foot_touching_ground[isHazmatPart(a)] = foot_touching_ground[isHazmatPart(a)] - 1
			end
		else
			if b == ground.fixture then
				touching_ground[isHazmatPart(a)] = touching_ground[isHazmatPart(a)] - 1
			end
		end
	elseif isHazmatPart(b) then
		if isHazmatFoot(b) then
			if a == ground.fixture then
				foot_touching_ground[isHazmatPart(b)] = foot_touching_ground[isHazmatPart(b)] - 1
			end
		else
			if a == ground.fixture then
				touching_ground[isHazmatPart(b)] = touching_ground[isHazmatPart(b)] - 1
			end
		end
	end
end

return AI