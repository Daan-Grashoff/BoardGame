require 'screens.menu'
require 'screens.help'
require 'screens.game'
require 'screens.credits'
require 'screens.selection'
require 'screens.settings'

screens = {}

function screens:load()
  -- currentScreen = "menu" 
  currentScreen = "game"

  help:load()
  -- if current screen == game
  -- load game directly 
  game:load()
  -- 
  menu:load()
  credits:load()
  settingsScreen:load()
end

function screens:set(screen)
  currentScreen = screen
end

function screens:on(screen)
  return currentScreen == screen
end

function screens:update(dt)
  if currentScreen == 'menu' then
    menu.update(dt)
  elseif currentScreen == 'game' then
    game.update(dt)
  elseif currentScreen == 'selection' then
    selection.update(dt)
  elseif currentScreen == 'credits' then
    credits.update(dt)
  elseif currentScreen == 'help' then
    help.update(dt)
  elseif currentScreen == 'settings'then
    settingsScreen.update(dt)
  end
end

function screens:draw()
  if currentScreen == 'menu' then
		menu.draw()
  elseif currentScreen == 'game' then
		game.draw()
  elseif currentScreen == 'credits' then
		credits.draw()
  elseif currentScreen == 'selection' then
    selection.draw()
  elseif currentScreen == 'help' then
		help.draw()
  elseif currentScreen == 'settings' then
    settingsScreen.draw()
  end
end

function UPDATE_SCREENS(dt)
  screens:update(dt)
end

function DRAW_SCREENS()
  screens:draw()
end
