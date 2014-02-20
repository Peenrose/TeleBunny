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

function approachBunny(dt)
	--addInfo("Ima get you bunny!")
	objects.scientist_torso.body:setLinearVelocity(125, 0)
end

function spinUpright(dt)
	angle = objects.scientist_torso.body:getAngle()
	if angle < 0 then
		while angle < -360 do angle = angle + 360 end
	elseif angle > 0 then
		while angle > 360 do angle = angle - 360 end
	end
	objects.scientist_torso.body:setAngle(angle+(dt*90))
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
		objects.scientist_torso.body:setFixedRotation(true)
		spinUpright(dt)
		approachBunny(dt)
	else
		objects.scientist_torso.body:setFixedRotation(false)
	end

	if scientistDazed == -1 and scientistSprites.head == headSprites.normal then approachBunny() end
end
return AI