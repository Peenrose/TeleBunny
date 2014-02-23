parts = {
	objects.scientist_head.body:getAngle(), 
	objects.scientist_torso.body:getAngle(), 
	objects.scientist_leftarm.body:getAngle(), 
	objects.scientist_rightarm.body:getAngle(), 
	objects.scientist_leftleg.body:getAngle(), 
	objects.scientist_rightleg.body:getAngle(),
}
--mouse joint to pull scientist
scientistDazed = -1
scientistRotating = false
angle = 0
secondCounter = 0
lastKicked = 0
lastX = 0

function approachBunny()
	objects.scientist_torso.body:setLinearVelocity(125, -100)
end

function spinUpright()
	angle = objects.scientist_torso.body:getAngle()
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
		objects.scientist_torso.body:applyAngularImpulse(angle*-35000)
	else
		objects.scientist_torso.body:applyAngularImpulse(angle*-30000)
	end
	
	if math.abs(angle) < 0.5 then 
		objects.scientist_torso.body:applyAngularImpulse((angle-0.1)*-200000) 
	end

	if angle < 0.2 then
		objects.scientist_rightleg.body:applyAngularImpulse(-750)
	end

	if (math.abs(angle) < 0.4) then
		scientistRotating = false
	else scientistRotating = true end
end

function kick()
	objects.scientist_rightleg.body:applyAngularImpulse(-1000000)
	objects.scientist_torso.body:applyLinearImpulse(10000, 0)
end

function AI(dt)
	if objects.scientist_torso ~= nil and objects.scientist_leftleg ~= nil then
		x,head_y = objects.scientist_head.body:getPosition()
		xvel, yvel = objects.scientist_head.body:getLinearVelocity()
		
		maxvel = math.max(math.abs(xvel), math.abs(yvel))

		secondCounter = secondCounter + dt
		if secondCounter >= 5 then
			secondCounter = 0
			local X = objects.scientist_torso.body:getX()
			if X > lastX then
				moved = X - lastX
			elseif X <= lastX then
				moved = lastX - X
			end
			addInfo("Moved: "..moved, 5)
			if moved < 75 then kick() end
			lastX = X
			traveledLastSecond = 0
		end

		if scientistDazed > -0.95 then
			scientistDazed = scientistDazed - dt
			scientistSprites.head = headSprites.dazed
		end

		if scientistDazed <= 0 then
			if isScientistPart(grabbed.fixture) then
				scientistSprites.head = headSprites.worried
				return
			elseif touching_ground ~= 0 then
				scientistSprites.head = headSprites.normal
			end
		end
		if scientistDazed <= -0.95 then scientistDazed = -1 end

		if scientistDazed == -1 and scientistSprites.head == headSprites.normal then
			spinUpright()
			if scientistRotating == false and foot_touching_ground > 1 then approachBunny() end
		end
	end
end
return AI