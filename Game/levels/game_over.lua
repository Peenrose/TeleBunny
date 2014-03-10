function load()
	love.window.setTitle("Telekinetic Bunny")
	setFontSize(14)

	world = love.physics.newWorld(0, 9.81*64, true)
	objects = {}
	--background = love.graphics.newImage("images/game_over.png")
end

function updateGameOver(dt) end
function beginContact(a, b, coll) end
function endContact(a, b, coll) end
function preSolve(a, b, coll) end
function postSolve(a, b, coll) end

return load