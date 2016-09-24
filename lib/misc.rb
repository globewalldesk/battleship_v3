require "./lib/settings"
require "./lib/board"
include BoardModule

# Classless methods
module MiscModule

  ###############################################################################

  # obtains a random, single pair of coordinates
  def get_random_coords
    row = rand(10)
    col = rand(10)
    return [row, col]
  end

  def print_message_and_clear
    print $message
    $message = ""
  end

  # inputs a board; displays it, then displays a message and clears $message,
  # and finally gets input
  def show_board_and_get_input(board)
    board.display_board
    print_message_and_clear
    answer = gets.chomp
  end

  def header_generator(enemy_or_player)
    header = "\n==========\n"
    header += (enemy_or_player == "enemy" ? "ENEMY ZONE" : "YOUR ZONE")
  end

end # of MiscModule
