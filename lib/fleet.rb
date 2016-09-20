require 'ostruct'
require './lib/ship_coords'
include ShipCoordsModule

# The classes for making, tracking, and destroying a fleet.
module FleetModule

###############################################################################
###############################################################################

# Creates and places ships of the fleet (setup only).
class FleetConstructor
  attr_accessor :fleet, :player_or_enemy
  def initialize(player_or_enemy)
    @fleet = construct_ship_types # an array of ship structs
    @player_or_enemy = player_or_enemy
    construct_ship_details # Creates ship details.
    save_ships # Saves ship ostructs.
    get_ship_coords # Get ship coords for ships.
    # Initializes FleetStatus.
  end

  ##############################################################################

  # Creates the ships of the fleet (ship types only).
  # To add ship types, edit construct_ship_types and construct_ship_details.
  def construct_ship_types
    fleet_starter = []
    %w[carrier battleship submarine warship destroyer].each do |this_type|
      ship = OpenStruct.new # creates an extensible Struct for ships
      ship.type = this_type
      fleet_starter << ship
    end
    fleet_starter # array of Structs armed only with 'type' method
  end

  ##############################################################################

  # Populates the ship Ostructs with their basic information features.
  # This and construct_ship_types should be the only place where ships types
  # are listed.
  def construct_ship_details
    @fleet.each do |ship|
      case ship.type
      when "carrier"
        then ship.coord_count = 5 # a measure of ship length
      when "battleship"
        then ship.coord_count = 4
      when "submarine"
        then ship.coord_count = 3
      when "warship"
        then ship.coord_count = 3
      when "destroyer"
        then ship.coord_count = 2
      end
      ship.unhit = ship.type[0].upcase # e.g., 'B'
      ship.hit = ship.type[0].downcase # e.g., 'b'
    end
  # :col, :row, :orient, :coords; :col and :row needn't be saved
  end

  ##############################################################################

  # Calls EnemyShipCoords or PlayerShipCoords to assign coords to each ship.
  # Not 100% that this is what Sandi Metz/OOD would recommend.
  def get_ship_coords
    @fleet.each do |ship|
      EnemyShipCoords.new(ship:ship, fleet:@fleet) if
        @player_or_enemy == "enemy"
      # PlayerShipCoords.new(ship:ship, fleet:@fleet) if
      #   @player_or_enemy == "player"
    end
  end

  ##############################################################################

  # Save ship Ostructs in Ship class objects
  def save_ships
  end

end

end # of module Fleet
