require "minitest/autorun"
require "./lib/settings"
require "./lib/fleet.rb"
include FleetModule
require "./lib/board.rb"
include BoardModule

##############################################################################
##############################################################################

class TestFleetConstructor < Minitest::Test
  def setup
    @board = Board.new("player")
    @enemy_fleet = FleetConstructor.new(player_or_enemy:"enemy")
    @player_fleet = FleetConstructor.new(player_or_enemy:"player", board:@board)
  end

  ##############################################################################

  # ensure an array of ship types includes the type listed for each ship in fleet
  def test_construct_ship_types
    @enemy_fleet.fleet.each do |ship|
      assert_includes(%w[carrier battleship submarine warship destroyer],
        ship.type)
    end
    @player_fleet.fleet.each do |ship|
      assert_includes(%w[carrier battleship submarine warship destroyer],
        ship.type)
    end
  end

  ##############################################################################

  # ensure a random ship type is populated with its expected values
  # (.coord_count, .sunk, and .unhit, all stable values for each ship type)
  def test_construct_ship_details
    @enemy_fleet.fleet.each do |ship|
      # sample one type from fleet array
      if ship.type == 'battleship'
        assert_equal(ship.coord_count, 4)
        assert_equal(ship.sunk, 'b')
        assert_equal(ship.unhit, 'B')
      end
    end
    @player_fleet.fleet.each do |ship|
      # sample one type from fleet array
      if ship.type == 'battleship'
        assert_equal(ship.coord_count, 4)
        assert_equal(ship.sunk, 'b')
        assert_equal(ship.unhit, 'B')
      end
    end
  end

    ##############################################################################

  # ensure that (1) five ships were created, (2) five ships have coords, and
  # (3) the five types have the right number of coords
  def test_get_ship_coords
    assert_equal(5, @enemy_fleet.fleet.length)
    @enemy_fleet.fleet.each do |ship|
      assert_respond_to(ship,:coords)
      case ship.sunk
      when "c" then assert(ship.coords.length == 5)
      when "b" then assert(ship.coords.length == 4)
      when "w" then assert(ship.coords.length == 3)
      when "s" then assert(ship.coords.length == 3)
      when "d" then assert(ship.coords.length == 2)
      end
    end
  end

end
