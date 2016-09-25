require './lib/settings'

class Ship
  attr_accessor :type, :coords, :coord_count, :unhit, :sunk
  # :board probably won't be needed
  def initialize(type)
    @type = type
    @coords = [] # placeholder for later construction
    construct_ship_details
    
  end

  def construct_ship_details
    case @type
    when "carrier"
      then @coord_count = 5 # a measure of ship length
    when "battleship"
      then @coord_count = 4
    when "submarine"
      then @coord_count = 3
    when "warship"
      then @coord_count = 3
    when "destroyer"
      then @coord_count = 2
    end
    @unhit = @type[0].upcase # e.g., 'B'
    @sunk = @type[0].downcase # e.g., 'b'
    # the following probably won't be needed
    # ship.board = @board # remember, the dots are at this.board
  end

end # of class Ship
