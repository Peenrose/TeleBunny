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

function getAngle(uid)
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
	return angle
end

function spinUpright(uid)
	scientist = objects["scientist"][uid]
	angle = getAngle(uid)
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
end

function isRotating(uid)
	if math.abs(getAngle(uid)) < 0.4 then
		return false
	else 
		return true
	end
end

function kick(uid)
	scientist = objects["scientist"][uid]
	kickReset[uid] = 1
	scientist.rightleg.body:applyAngularImpulse(-1000000)
	scientist.torso.body:applyLinearImpulse(10000, 0)
end

function ScientistAI(uid, dt)
	scientist = objects["scientist"][uid]
	if kickReset[uid] == nil then kickReset[uid] = 0 end

	if not scientist then return end
	if scientist.torso ~= nil and scientist.leftleg ~= nil then
		x,head_y = scientist.head.body:getPosition()
		xvel, yvel = scientist.head.body:getLinearVelocity()
		
		maxvel = math.max(math.abs(xvel), math.abs(yvel))

		if kickReset[uid] > 0 then 
			kickReset[uid] = kickReset[uid] - dt 
			if kickReset[uid] < 0 then
				scientist.rightleg.body:applyAngularImpulse(200000)
				kickReset[uid] = 0
			end
		end
		if secondCounter[uid] == nil then secondCounter[uid] = 0 end
		secondCounter[uid] = secondCounter[uid] + dt
		if secondCounter[uid] >= 5 then
			secondCounter[uid] = 0
			local X = scientist.torso.body:getX()
			if lastx[uid] == nil then lastx[uid] = 0 end
			if X > lastx[uid] then
				moved = X - lastx[uid]
			elseif X <= lastx[uid] then
				moved = lastx[uid] - X
			end
			if moved < 75 then kick(uid) end
			lastx[uid] = X
			traveledLastSecond[uid] = 0
		end
		

		--[[
		if dazed[uid] == nil then dazed[uid] = 0 end
		if touchingGround[uid] == nil then touchingGround[uid] = 0 end

		if dazed[uid] > -0.95 then
			dazed[uid] = dazed[uid] - dt
			objects["scientist"][uid].headSprite = headSprites.dazed
		end

		if dazed[uid] <= 0 then
			if isScientistPart(grabbed.fixture) then
				objects["scientist"][uid].headSprite = headSprites.worried
				return
			elseif touchingGround[uid] ~= 0 then
				objects["scientist"][uid].headSprite = headSprites.normal
			end
		end

		if dazed[uid] <= -0.95 then dazed[uid] = -1 end

		if dazed[uid] == -1 then objects["scientist"][uid].headSprite = headSprites.normal
		if dazed[uid] == -1 and objects["scientist"][uid].headSprite == headSprites.normal then
			spinUpright(uid)
			if isRotating(uid) == false  then approachBunny(uid) end --and touchingGround[uid] > 1
		end
		]]--
	end
end

return AI