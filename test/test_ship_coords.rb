require "minitest/autorun"
require "./lib/settings"
require "./lib/ship_coords"
include ShipCoordsModule
require "./lib/fleet"
include FleetModule
require "./lib/board"
include BoardModule

##############################################################################
##############################################################################

class TestShipCoords < Minitest::Test
  def setup
    # Note the .fleet method: these are arrays of fleet ostructs.
    @board = Board.new("player")
    @enemy_fleet = FleetConstructor.new(player_or_enemy:"enemy").fleet
    @player_fleet = FleetConstructor.new(player_or_enemy:"player",
      board:@board).fleet
    # The following selects the first element of the fleet array, itself a
    # struct.
    @mycoords = EnemyShipCoords.new(ship:@enemy_fleet[0], fleet:@enemy_fleet)
    @ship = @enemy_fleet[0]
    # locate the carrier struct for purposes of test_calculate_rest_of_ship_coords
  end

  ##############################################################################

  # tests that randomly-generated orientation is "horiz" or "vert"
  def test_get_random_orientation
    assert_includes(%w|horiz vert|, @mycoords.get_random_orientation)
  end

  ##############################################################################

  # tests that when horizontal, base-coords == 0,0, and the ship is a
  # carrier (5 long), the coords are 0,0, 0,1, 0,2, 0,3, and 0,4. And more...
  def test_calculate_rest_of_ship_coords
    assert_equal(@ship.coords.length, @ship.coord_count)
    @mycoords.calculate_rest_of_ship_coords("horiz", [0,0])
    @ship.coords.each do |coord|
      row, col = coord
      assert(row >= 0 && col >= 0)
    end
    # the slice is needed because the direct .calculate... call above doubled
    # the number of elements in that instance of .coords. It's all good!
    assert_equal([[0,0], [0,1], [0,2], [0,3], [0,4]], @ship.coords)
  end

  ##############################################################################

  # test that [[0,0], [0,1], [0,2], [0,3], [0,4]] returns true
  # that [[0,8], [0,9], [0,10], [0,11], [0,12]] returns false
  def test_show_ship_coords_are_all_on_board
    @enemy_fleet[0].coords = [[0,0], [0,1], [0,2], [0,3], [0,4]]
    assert(@mycoords.show_ship_coords_are_all_on_board)
    @enemy_fleet[0].coords = [[0,8], [0,9], [0,10], [0,11], [0,12]]
    refute(@mycoords.show_ship_coords_are_all_on_board)
    @enemy_fleet[0].coords = [[8,0], [9,0], [10,0], [11,0], [12,0]]
    refute(@mycoords.show_ship_coords_are_all_on_board)
  end

  # test that @valid_coords remains false if the coords list for this one ship
  # contains coords that are in some other ship
  def test_show_ship_coords_are_consistent_with_fleet
    @enemy_fleet[0].coords = [[0,0], [0,1], [0,2], [0,3], [0,4]]
    @enemy_fleet[1].coords = [[1,1], [1,2], [1,3], [1,4]]
    @enemy_fleet[2].coords = [[2,1], [2,2], [2,3]]
    @enemy_fleet[3].coords = [[3,1], [3,2], [3,3]]
    @enemy_fleet[4].coords = [[4,1], [4,2]]
    # no overlapping coords in the above!
    assert(@mycoords.show_ship_coords_are_consistent_with_fleet)
    # swapping in new ship coords: these have the overlapping coord 0,0
    @enemy_fleet[1].coords = [[0,0], [1,0], [2,0], [3,0]]
    refute(@mycoords.show_ship_coords_are_consistent_with_fleet)
  end

end

class TestEnemyShipCoords < Minitest::Test
end

class TestPlayerShipCoords < Minitest::Test
end
