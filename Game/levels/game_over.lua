function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	objects = {}
	deathBackground = love.graphics.newImage("images/gameover.png")
end

function updateGameOver(dt)

end
function drawGameOver()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill", 0, 0, 1920, 1080)
	love.graphics.draw(deathBackground, 0, 0)
end
function beginContact(a, b, coll) end
function endContact(a, b, coll) end
function preSolve(a, b, coll) end
function postSolve(a, b, coll) end

return load