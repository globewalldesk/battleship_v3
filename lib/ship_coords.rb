require './lib/misc.rb'
include MiscModule

module ShipCoordsModule

###############################################################################
###############################################################################

# ShipCoords are the coordinates of a given ship.
class ShipCoords
  attr_accessor :ship, :fleet, :valid_coords, :coords

  # identify ship type and input fleet info
  def initialize(options)
    @coords = [] # we'll fill this up with an array of coord objects
    @ship = options[:ship]
    @fleet = options[:fleet]
    @valid_coords = false # we aim to turn this true
  end

  ###############################################################################

  # Logic common to both enemy and player ship placement.
  # Basically, this takes an orientation and base coordinates and,
  # combined with ship & fleet info, generates a placement and
  # confirms whether it's OK. If not, @valid_coords remains false
  # and this will be called again by EnemyShipCoords or PlayerShipCoords.
  def finalize_ship_coords(orientation, base_coords)
    calculate_rest_of_ship_coords(orientation, base_coords) # fiddles with @coords
    unless show_ship_coords_are_all_on_board
      return false
    end
    unless show_ship_coords_are_consistent_with_fleet
      return false
    end
    true # if it gets this far, tests are passed & ship coords are finalized!
  end

  ###############################################################################

  # Given orientation and base coords, with coord_count a set @ship method,
  # calculate the rest of the ship_coords (proposed, not validated).
  def calculate_rest_of_ship_coords(orientation, base_coords)
    row, col = base_coords
    @ship.coords = []
    @coords = []
    # iterate coord_count times
    @ship.coord_count.times do |coord|
      # @coords is now an array of two-element arrays; maybe prep hash later.
      @coords << [row, col] # begin by adding base_coords
      # if horiz., then while row stays same, col increases!
      orientation == "horiz" ? col += 1 : row += 1
    end
    @ship.coords = @coords # Won't be permanently saved here necessarily.
  end

  ###############################################################################

  # looks at a set of coords, e.g., [[0,0], [0,1], [0,2], [0,3]], and
  # opines on whether they are all within 0 and 9, i.e., on the board.
  def show_ship_coords_are_all_on_board
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

  ###############################################################################

  # This method turns @valid_coords true only because it has gone through
  # show_ship_coords_are_all_on_board first.
  def show_ship_coords_are_consistent_with_fleet
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
    @valid_coords = true if all_consistent == true
    return all_consistent # for testing
  end

end # of ShipCoords

###############################################################################
###############################################################################

# ShipCoords of enemy ships; each instance is an enemy ship's coordinates.
class EnemyShipCoords < ShipCoords
  def initialize(options)
    super # first initialize variables common to both Enemy and Player ShipCoords
    loop_until_valid_coords_obtained
  end

  ###############################################################################

  def get_random_orientation
    rand(2) == 0 ? "vert" : "horiz"
  end

  ###############################################################################

  def loop_until_valid_coords_obtained
    confirmed_valid = false # this should mirror ShipCoord's @valid_coords
    until confirmed_valid == true
      orientation = get_random_orientation
      base_coords = get_random_coords # from MiscModule
      confirmed_valid = finalize_ship_coords(orientation, base_coords)
    end
  end

end # of EnemyShipCoords

###############################################################################
###############################################################################

# ShipCoords of player ships; each instance is a player ship's coordinates.
class PlayerShipCoords < ShipCoords
  def initialize(options)
    super
  end
end # of PlayerShipCoords

end # of ShipCoordsModule
