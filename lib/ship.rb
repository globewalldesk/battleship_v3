class Ship
  attr_accessor :type, :coords, :coord_count, :unhit, :sunk, :valid_coords
  # :board probably won't be needed
  def initialize(type)
    @type = type
    @coords = [] # placeholder for later construction
    @valid_coords = false # until proven true
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
  end

end # of class Ship
