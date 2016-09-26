require './lib/settings' # this should ensure settings is in all components
require './lib/game_wrapping' # only direct dependency is game_wrapping.rb

this_game = GameDaemon.new
