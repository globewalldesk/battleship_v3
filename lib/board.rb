require './lib/settings'

# Strictly limited to the appearance of the Battleship board, both for the
# computer and the player. Subclasses include PlayerBoard and ComputerBoard,
# which show the appearance of the player's board to himself and the
# player's board to the computer-player (for algorithmic fiddling).

class Board
  attr_accessor :board

  def initialize(board_header)
    @board = Array.new(10) {Array.new(10) {"."} }
    @board_header = board_header # generated in misc to keep this class clean
  end

  ############################################################################

  # Simply displays the board to the user. Note, takes the whole 10x10
  # array, *not* just a few coordinates
  def display_board
    puts @board_header
    puts "      a   b   c   d   e   f   g   h   i   j", "\n"
    n = 0
    @board.each do |row|
      printable = "#{n+1} " if n < 9
      printable = "#{n+1}" if n == 9
      row.each {|col| printable << ("   " + col) }
      print " #{printable}\n\n" if n < 9
      print " #{printable}\n" if n == 9
      n += 1
    end
    print "\n"
  end

  ############################################################################

  # inputs a board; displays it, then displays a message and clears $message,
  # and finally gets input
  def show_board_and_get_input
    display_board
    print_message_and_clear
    answer = gets.chomp
  end

  ##############################################################################

  def show_initial_player_board
    $message << "Here is how your ships are placed. [Enter] to continue. " unless
      $testing == true # see comment in settings.rb
    show_board_and_get_input unless $testing == true
  end

  ############################################################################

  # saves an individual ship to the board array
  # this flips the '.' at the coords for a particular ship to the '.unhit' char
  def save_ship_to_board(ship)
    # add '.unhit' chars for this ship to the fleet's new board
    # I'm trying to take the coordinates given and flip just the right '.' in @board
    ship.coords.each do |coord|
      row, col = coord
      self.board[row][col] = ship.unhit
    end
  end

  ############################################################################

  # ask player for one ship's orientation
  def get_player_orientation(ship)
    orientation_ok = false
    answer = ""
    $message << "Will your #{ship.type} be [h]orizontal or [v]ertical? "
    answer = show_board_and_get_input
    until orientation_ok == true
      if answer == 'h' || answer == 'v'
        orientation_ok = true
      else
        $message << "Please, either 'v' or 'h': "
        answer = print_message_and_clear_and_get_input
      end
    end
    puts "answer = #{answer}"
    return answer
  end

  def get_player_coords(ship)
    coords_ok_format = false
    answer = ""
    $message << "Place the top/left edge of your #{ship.type} (e.g., 1a): "
    answer = show_board_and_get_input
    until coords_ok_format == true
      if true # NEED TO FILL THIS IN
        coords_ok_format = true
      else
        $message << "Please follow the format \"1a\": "
        answer = print_message_and_clear_and_get_input
      end
    end
    puts "answer = #{answer}"
    return answer
  end


  # Given Shotlist, writes shots to board.

  # Given BoardContents and FleetStatus, generates a board array.

end
