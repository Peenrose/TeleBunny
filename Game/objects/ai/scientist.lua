scientistRotating = false
angle = 0
secondCounter = 0
lastKicked = 0
lastX = 0
kickReset = 0
dazed = {}

function AI(dt)
	for uid = 1, objectList["scientist"] do
		if removedObjects["scientist"] ~= nil and removedObjects["scientist"][uid] ~= nil then else
			ScientistAI(uid, dt)
		end
	end
end

function approachBunny(uid)
	scientist = objects["scientist"][uid]
	scientist.torso.body:setLinearVelocity(125, -125)
end

function spinUpright(uid)
	scientist = objects["scientist"][uid]
	angle = scientist.torso.body:getAngle()
	local pos = 1
	if angle < 0 then
		while angle < -(2*math.pi) do angle = angle + (2*math.pi) end
		pos = 1
	elseif angle > 0 then
		while angle > (2*math.pi) do angle = angle - (2*math.pi) end
		pos = -1
	end
	-- local newAngle = angle+(0.4*dt)
	if math.abs(angle) > 1 then
		scientist.torso.body:applyAngularImpulse(angle*-35000)
	else
		scientist.torso.body:applyAngularImpulse(angle*-30000)
	end
	
	if math.abs(angle) < 0.5 then 
		scientist.torso.body:applyAngularImpulse((angle-0.1)*-200000) 
	end

	if angle < 0.2 then
		scientist.rightleg.body:applyAngularImpulse(-750)
	end

	if (math.abs(angle) < 0.4) then
		scientistRotating = false
	else scientistRotating = true end
end

function kick(uid)
	scientist = objects["scientist"][uid]
	kickReset = 1
	scientist.rightleg.body:applyAngularImpulse(-1000000)
	scientist.torso.body:applyLinearImpulse(10000, 0)
end

function ScientistAI(uid, dt)
	scientist = objects["scientist"][uid]
	if not scientist then return end
	if objects["scientist"][uid].scientistDazed == nil then objects["scientist"][uid].scientistDazed = 0 end
	if scientist.torso ~= nil and scientist.leftleg ~= nil then
		x,head_y = scientist.head.body:getPosition()
		xvel, yvel = scientist.head.body:getLinearVelocity()
		
		maxvel = math.max(math.abs(xvel), math.abs(yvel))

		if kickReset > 0 then 
			kickReset = kickReset - dt 
			if kickReset < 0 then
				scientist.rightleg.body:applyAngularImpulse(200000)
				kickReset = 0
			end
		end
		secondCounter = secondCounter + dt
		if secondCounter >= 5 then
			secondCounter = 0
			local X = scientist.torso.body:getX()
			if X > lastX then
				moved = X - lastX
			elseif X <= lastX then
				moved = lastX - X
			end
			if moved < 75 then kick(uid) end
			lastX = X
			traveledLastSecond = 0
		end
		--if objects["scientist"][uid].scientistDazed == nil then return end
		if objects["scientist"][uid].scientistDazed > -0.95 then
			objects["scientist"][uid].scientistDazed = objects["scientist"][uid].scientistDazed - dt
			objects["scientist"][uid].headSprite = headSprites.dazed
		end

		if objects["scientist"][uid].scientistDazed <= 0 then
			if isScientistPart(grabbed.fixture) then
				objects["scientist"][uid].headSprite = headSprites.worried
				return
			elseif touching_ground ~= 0 then
				objects["scientist"][uid].headSprite = headSprites.normal
			end
		end
		if objects["scientist"][uid].scientistDazed <= -0.95 then objects["scientist"][uid].scientistDazed = -1 end

		if objects["scientist"][uid].scientistDazed == -1 and objects["scientist"][uid].headSprite == headSprites.normal then
			spinUpright(uid)
			if scientistRotating == false and foot_touching_ground > 1 then approachBunny(uid) end
		end
	end
end

return AI