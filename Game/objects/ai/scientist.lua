parts = {
	objects.scientist_head.body:getAngle(), 
	objects.scientist_torso.body:getAngle(), 
	objects.scientist_leftarm.body:getAngle(), 
	objects.scientist_rightarm.body:getAngle(), 
	objects.scientist_leftleg.body:getAngle(), 
	objects.scientist_rightleg.body:getAngle(),
}
--mouse joint to pull scientist
scientistDazed = 0

function AI(dt)
	x,head_y = objects.scientist_head.body:getPosition()
	xvel, yvel = objects.scientist_head.body:getLinearVelocity()
	
	maxvel = math.max(math.abs(xvel), math.abs(yvel))
	
	addInfo("Head Y Level: "..head_y)
	addInfo("Velocity: "..maxvel)

	if scientistDazed > 0 then
		scientistDazed = scientistDazed - dt
		scientistSprites.head = headSprites.dazed
	else
		if isScientistPart(grabbed.fixture) then
			scientistSprites.head = headSprites.worried
			return
		elseif touching_ground ~= 0 then
			scientistSprites.head = headSprites.normal
		end
	end
	addInfo("Dazed Amount: "..scientistDazed)
end
return AI