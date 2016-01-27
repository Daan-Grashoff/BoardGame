function love.conf(t)

	t.title             = "Frequency"
	t.author            = "Damien, Daan, Rick, Stefan en Bob"
	t.version           = "0.10.0"
	t.identity          = "boardgame-settings"

	t.console           = true
  t.modules.audio     = true
  t.modules.keyboard  = true
  t.modules.event     = true
  t.modules.image     = true
  t.modules.graphics  = true
  t.modules.timer     = true
  t.modules.mouse     = true
  t.modules.sound     = true
  t.modules.physics   = false
	t.window.vsync      = true
	t.window.resizable  = false

end