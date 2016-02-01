require 'screens.menu'
require 'screens.help'
require 'screens.game'
require 'screens.credits'
require 'screens.selection'
require 'screens.settingsScreen'

screens = {currentScreen = "menu"}

function screens:load()
  -- currentScreen = "menu"

  help:load()
  -- if current screen == game
  -- load game directly
  -- game:load()
  --
  menu:load()
  credits:load()
  settingsScreen:load()
end

function screens:set(screen)
  screens.currentScreen = screen
end

function screens:on(screen)
  return screens.currentScreen == screen
end

function screens:update(dt)
  if screens.currentScreen == 'menu' then
    menu.update(dt)
  elseif screens.currentScreen == 'game' then
    game.update(dt)
  elseif screens.currentScreen == 'selection' then
    selection.update(dt)
  elseif screens.currentScreen == 'credits' then
    credits.update(dt)
  elseif screens.currentScreen == 'help' then
    help.update(dt)
  elseif screens.currentScreen == 'settings'then
    settingsScreen.update(dt)
  end
end

function screens:draw()
  if screens.currentScreen == 'menu' then
		menu.draw()
  elseif screens.currentScreen == 'game' then
		game.draw()
  elseif screens.currentScreen == 'credits' then
		credits.draw()
  elseif screens.currentScreen == 'selection' then
    selection.draw()
  elseif screens.currentScreen == 'help' then
		help.draw()
  elseif screens.currentScreen == 'settings' then
    settingsScreen.draw()
  end
end

function UPDATE_SCREENS(dt)
  screens:update(dt)
end

function DRAW_SCREENS()
  screens:draw()
end
