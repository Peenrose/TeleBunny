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

function approachBunny(dt)
	objects.scientist_torso.body:setLinearVelocity(125, -100)
	--objects.scientist_torso.body:applyLinearImpulse(125, -200)
end
angle = 0
function spinUpright(dt)
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
		objects.scientist_torso.body:applyAngularImpulse(angle*-20000)
	else
		objects.scientist_torso.body:applyAngularImpulse(angle*-30000)
	end
	
	if math.abs(angle) < 0.5 then 
		objects.scientist_torso.body:applyAngularImpulse((angle-0.1)*-200000) 
	end

	if angle < 0.2 then
		objects.scientist_rightleg.body:applyAngularImpulse(-1000)
	end

	if (math.abs(angle) < 0.4) then
		scientistRotating = false
	else scientistRotating = true end
end

function AI(dt)
	x,head_y = objects.scientist_head.body:getPosition()
	xvel, yvel = objects.scientist_head.body:getLinearVelocity()
	
	maxvel = math.max(math.abs(xvel), math.abs(yvel))
	
	--addInfo("Head Y Level: "..head_y) --standing is about 490
	--addInfo("Velocity: "..maxvel)

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
		--objects.scientist_torso.body:setFixedRotation(true)
		spinUpright(dt)
		if scientistRotating == false and foot_touching_ground > 1 then approachBunny(dt) end
	else
		--objects.scientist_torso.body:setFixedRotation(false)
	end
	addInfo("Feet: "..foot_touching_ground)
end
return AI