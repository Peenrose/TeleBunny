function AI(dt)
	if objectList["swat"] == nil then return false end
	for uid = 1, objectList["swat"] do
		if removedObjects["swat"] ~= nil and removedObjects["swat"][uid] ~= nil then else
			SwatAI(uid, dt)
		end
	end
end

function approachBunny(uid)
	swat = objects["swat"][uid]
	swat.torso.body:setLinearVelocity(160, -210)
	swat.rightleg.body:applyAngularImpulse(-2500)
end

function getAngle(uid)
	if objects["swat"] ~= nil and objects["swat"][uid] ~= nil then
		swat = objects["swat"][uid]
		angle = swat.torso.body:getAngle()
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
end

function spinUpright(uid)
	if objects["swat"] ~= nil and objects["swat"][uid] ~= nil then
		swat = objects["swat"][uid]
		angle = getAngle(uid)
		if math.abs(angle) > 1 then
			swat.torso.body:applyAngularImpulse(angle*-35000)
		else
			swat.torso.body:applyAngularImpulse(angle*-30000)
		end
		
		if math.abs(angle) < 0.5 then 
			swat.torso.body:applyAngularImpulse((angle-0.1)*-200000) 
		end

		if angle < 0.2 then
			swat.rightleg.body:applyAngularImpulse(-750)
		end
	end
end

function isRotating(uid)
	if objects["swat"] ~= nil and objects["swat"][uid] ~= nil then
		if math.abs(getAngle(uid)) < 0.4 then
			return false
		else 
			return true
		end
	end
end

function kick(uid)
	if objects["swat"] ~= nil and objects["swat"][uid] ~= nil then
		swat = objects["swat"][uid]
		kickReset[uid] = 1
		swat.rightleg.body:applyAngularImpulse(-1000000)
		swat.torso.body:applyLinearImpulse(10000, 0)
	end
end

function SwatAI(uid, dt)
	if objects["swat"] ~= nil and objects["swat"][uid] ~= nil then
		dt = dt * 1.5
		swat = objects["swat"][uid]

		if kickReset[uid] == nil then kickReset[uid] = 0 end
		
		if swat.torso ~= nil and swat.leftleg ~= nil then
			x,head_y = swat.head.body:getPosition()
			xvel, yvel = swat.head.body:getLinearVelocity()
			
			maxvel = math.max(math.abs(xvel), math.abs(yvel))

			if kickReset[uid] > 0 then 
				kickReset[uid] = kickReset[uid] - dt 
				if kickReset[uid] < 0 then
					swat.rightleg.body:applyAngularImpulse(200000)
					kickReset[uid] = 0
				end
			end
			if secondCounter[uid] == nil then secondCounter[uid] = 0 end
			if dazed[uid] == -1 then secondCounter[uid] = secondCounter[uid] + dt*0.75 end
			if secondCounter[uid] >= 5 then
				secondCounter[uid] = 0
				local X = swat.torso.body:getX()
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
			
			if touching_ground[uid] == nil then touching_ground[uid] = 0 end
			if foot_touching_ground[uid] == nil then foot_touching_ground[uid] = 0 end

			spinUpright(uid)
			if isRotating(uid) == false and foot_touching_ground[uid] == 2 then approachBunny(uid) end
				-- addInfo("Feet On Ground ("..uid.."): "..foot_touching_ground[uid])
				-- addInfo("Touching Ground ("..uid.."): "..touching_ground[uid])
				-- addInfo("Dazed ("..uid.."): "..dazed[uid])
		end
	end
end

function swatBeginContact(a, b, coll)
	if isSwatPart(a) or isSwatPart(b) then
		if isSwatPart(a) then
			if touching_ground[isSwatPart(a)] == nil then touching_ground[isSwatPart(a)] = 0 end
			if foot_touching_ground[isSwatPart(a)] == nil then foot_touching_ground[isSwatPart(a)] = 0 end
		elseif isSwatPart(b) then
			if touching_ground[isSwatPart(b)] == nil then touching_ground[isSwatPart(b)] = 0 end
			if foot_touching_ground[isSwatPart(b)] == nil then foot_touching_ground[isSwatPart(b)] = 0 end
		end
	end

	if isSwatPart(a) then
		if isSwatFoot(a) then
			if b == ground.fixture then
				foot_touching_ground[isSwatPart(a)] = foot_touching_ground[isSwatPart(a)] + 1
			end
		else
			if b == ground.fixture then
				touching_ground[isSwatPart(a)] = touching_ground[isSwatPart(a)] + 1
			end
		end
	elseif isSwatPart(b) then
		if isSwatFoot(b) then
			if a == ground.fixture then
				foot_touching_ground[isSwatPart(b)] = foot_touching_ground[isSwatPart(b)] + 1
			end
		else
			if a == ground.fixture then
				touching_ground[isSwatPart(b)] = touching_ground[isSwatPart(b)] + 1
			end
		end
	end


	if isSwatPart(a) then
		if maxvel > 800 then
			uid = isSwatPart(a)
			if dazed[uid] == nil then dazed[uid] = 0 end
			dazed[uid] = math.abs(math.min(dazed[uid] + ((maxvel-1000)/1000), 3))
		end
	end
	if isSwatPart(b) then
		if maxvel > 800 then
			uid = isSwatPart(b)
			if dazed[uid] == nil then dazed[uid] = 0 end
			dazed[uid] = math.abs(math.min(dazed[uid] + ((maxvel-1000)/1000), 3))
		end
	end

end

function swatEndContact(a, b, coll)
if isSwatPart(a) then
		if isSwatFoot(a) then
			if b == ground.fixture then
				foot_touching_ground[isSwatPart(a)] = foot_touching_ground[isSwatPart(a)] - 1
			end
		else
			if b == ground.fixture then
				touching_ground[isSwatPart(a)] = touching_ground[isSwatPart(a)] - 1
			end
		end
	elseif isSwatPart(b) then
		if isSwatFoot(b) then
			if a == ground.fixture then
				foot_touching_ground[isSwatPart(b)] = foot_touching_ground[isSwatPart(b)] - 1
			end
		else
			if a == ground.fixture then
				touching_ground[isSwatPart(b)] = touching_ground[isSwatPart(b)] - 1
			end
		end
	end
end

return AI