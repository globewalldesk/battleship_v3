require 'minitest/autorun'
require './lib/fleet.rb'
include FleetModule

##############################################################################
##############################################################################

class TestFleetConstructor < Minitest::Test
  def setup
    @enemy_fleet = FleetConstructor.new("enemy")
    @player_fleet = FleetConstructor.new("player")
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
  def test_construct_ship_details
    @enemy_fleet.fleet.each do |ship|
      # sample one type from fleet array
      if ship.type == 'battleship'
        assert_equal(ship.coord_count, 4)
        assert_equal(ship.hit, 'b')
        assert_equal(ship.unhit, 'B')
      end
    end
    @player_fleet.fleet.each do |ship|
      # sample one type from fleet array
      if ship.type == 'battleship'
        assert_equal(ship.coord_count, 4)
        assert_equal(ship.hit, 'b')
        assert_equal(ship.unhit, 'B')
      end
    end
  end

end
