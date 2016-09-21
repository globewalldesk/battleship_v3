require "minitest/autorun"
require "./lib/settings"
require "./lib/game_wrapping.rb" # this handily includes all game files
include GameWrappingModule

class TestGameDaemon < Minitest::Test
  def setup
    skip("Trying to avoid the cls from appearing")
    @mygame = GameDaemon.new
  end

# Commenting out test of game ID
  # tests accessor method that game is created with ID
  def test_game_id
    assert_equal(10000, @mygame.game_id)
  end
end
