# Strictly limited to the appearance of the Battleship board, both for the
# computer and the player. Subclasses include PlayerBoard and ComputerBoard,
# which show the appearance of the player's board to himself and the
# player's board to the computer-player (for algorithmic fiddling).
module BoardModule

class Board
  attr_accessor :board

  def initialize
    @board = generate_blank_board
  end

  # Returns blank #board, a 10x10 grid of dots, nothing more.
  # #board is later edited by the program to hits, misses,
  # and sunken ships to the player or computer.
  def generate_blank_board
    board = []
    row = %w(. . . . . . . . . .)
    10.times {board << row}
    board
  end

end

end # of BoardModule
