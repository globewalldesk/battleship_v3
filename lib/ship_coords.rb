require "./lib/misc.rb"

###############################################################################

# ShipCoords are the coordinates of a given ship (NOT of the whole fleet).
# The coords themselves are an attribute of @ship.
class ShipCoords
  attr_accessor :ship, :fleet, :valid, :coords, :player_orientation,
    :player_base_coords
  def initialize(options)
    @ship = options[:ship]
    @fleet = options[:fleet]
    @player_orientation = options[:player_orientation]
    @player_base_coords = options[:player_base_coords]
    # If ShipCoords was called by board.rb when the player input orientation
    # and coords, test the player's input and spit back result; otherwise,
    # generate coords automatically
    @player_orientation ? test_player_coord_input :
      loop_until_valid_automatically_obtained
  end

  #############################################################################

  # Given orientation and base coords, with coord_count a set @ship method,
  # calculate the rest of the ship_coords (proposed, not validated).
  def calculate_rest_of_ship_coords(orientation, base_coords)
    row, col = base_coords
    @ship.coords = [] # clear! don't want to keep adding onto bad coord sets
    # iterate coord_count times
    @ship.coord_count.times do |coord|
      @ship.coords << [row, col] # begin by adding base_coords
      orientation == "h" ? col += 1 : row += 1
    end
  end

  #############################################################################

  # looks at a set of coords, e.g., [[0,0], [0,1], [0,2], [0,3]], and
  # opines on whether they are all within 0 and 9, i.e., on the board.
  def ship_coords_are_all_on_board
    all_aboard = true
    @ship.coords.each do |coord|
      row, col = coord
      # if row & col are NOT between 0 and 9...
      unless row.between?(0,9) && col.between?(0,9)
        # ...then not all the coords are ok.
        all_aboard = false
      end
      break unless all_aboard == true
    end
    return all_aboard
  end

  #############################################################################

  # This method tests that the proposed coords are consistent with existing
  # ship positions. If not, we loop again.
  def ship_coords_are_consistent_with_fleet
    all_consistent = true
    # for each coord of this ship
    @ship.coords.each do |thiscoord|
      # ...show that every coord in every other ship in the fleet != this coord
      # IF it has coords!
      @fleet.each do |othership|
        next unless othership.coords
        next if othership == @ship # you'll always overlap yourself...
        othership.coords.each do |othercoord|
          all_consistent = false if thiscoord == othercoord
        end
      end
      break unless all_consistent == true
    end
    return all_consistent # for testing
  end

  #############################################################################

  # Basically, this takes an orientation and base coordinates and,
  # combined with ship & fleet info, generates a placement and
  # confirms whether it's OK. If not, we loop again.
  def finalize_ship_coords(orientation, base_coords)
    # makes set of coords to test
    calculate_rest_of_ship_coords(orientation, base_coords)
    # short-circuit evaluation makes this work
    return false unless ship_coords_are_all_on_board &&
      ship_coords_are_consistent_with_fleet
    true # if it gets this far, tests are passed & ship coords are finalized!
  end

  #############################################################################

  def loop_until_valid_automatically_obtained
    confirmed_valid = false # invalid until proven valid!
    until confirmed_valid == true
      orientation = (rand(2) == 0 ? "v" : "h") # get random orientation
      base_coords = get_random_coords # from Misc
      confirmed_valid = finalize_ship_coords(orientation, base_coords)
    end
  end

  #############################################################################

  # Test that coords input by player are groovy
  def test_player_coord_input
    # true if finalize_ship_coords == true
    @ship.valid_coords = finalize_ship_coords(@player_orientation,
      @player_base_coords)
  end

end # of ShipCoords
