require './lib/game_wrapping' # only direct dependency is game_wrapping.rb
require './lib/settings'
include GameWrappingModule

this_game = GameDaemon.new
