function love.conf(game)
  game.identity = "TeleBunny"
  game.author = "Simon Hoke | Andrew Visser | Tyler Lastname"
  game.version = "0.9.0"

  game.modules.joystick = false
  game.modules.audio = true
  game.modules.keyboard = true
  game.modules.event = true
  game.modules.image = true
  game.modules.graphics = true
  game.modules.timer = true
  game.modules.mouse = true
  game.modules.sound = true
  game.modules.physics = true

  game.window.width = 1920
  game.window.height = 1080
  game.window.fullscreen = true
end