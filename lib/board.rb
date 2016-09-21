require './lib/settings'

# Strictly limited to the appearance of the Battleship board, both for the
# computer and the player. Subclasses include PlayerBoard and ComputerBoard,
# which show the appearance of the player's board to himself and the
# player's board to the computer-player (for algorithmic fiddling).
module BoardModule

  class Board
    attr_accessor :board

    def initialize(enemy_or_player)
      @board = generate_blank_board
      @enemy_or_player = enemy_or_player
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

    # Simply displays the board to the user. Note, takes a whole 10x10
    # array, *not* just a few coordinates
    def display_board
      puts "=========="
      puts (@enemy_or_player == "enemy" ? "ENEMY ZONE" : "YOUR ZONE")
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

    # Given a Fleet, writes ships to board.
    # Given Shotlist, writes shots to board.

    # Given BoardContents and FleetStatus, generates a board array.

  end

end # of BoardModule
