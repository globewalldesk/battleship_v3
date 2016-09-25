require "./lib/settings"
require "minitest/autorun"
require "./lib/board"
require "./lib/misc"

class TestBoard < Minitest::Test
  def setup
    @tester_board =
      [%w(. . . . . . . . . .),
      %w(. . . . . . . . . .),
      %w(. . . . . . . . . .),
      %w(. . . . . . . . . .),
      %w(. . . . . . . . . .),
      %w(. . . . . . . . . .),
      %w(. . . . . . . . . .),
      %w(. . . . . . . . . .),
      %w(. . . . . . . . . .),
      %w(. . . . . . . . . .)]
    enemy_header = header_generator("enemy") # from misc
    @fred = Board.new(enemy_header)
    @tester_board_with_ships =
      [[".", ".", ".", ".", "W", "W", "W", ".", ".", "."],
      [".", ".", ".", ".", ".", "S", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", "S", ".", ".", ".", "."],
      [".", ".", "B", ".", ".", "S", ".", ".", "D", "."],
      [".", ".", "B", ".", ".", ".", ".", ".", "D", "."],
      [".", ".", "B", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", "B", ".", ".", "C", "C", "C", "C", "C"],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
      [".", ".", ".", ".", ".", ".", ".", ".", ".", "."]]
      @wilma = Board.new(enemy_header) # reusing header from above
      @wilma.board = @tester_board_with_ships
  end

  def test_generate_blank_board
    # This autoruns generate_blank_board in the initialize method
    assert_equal(@tester_board, @fred.board)
  end

  # tests that the output of display_board is as it should be, given a
  # certain unattacked ship input (see @tester_board_with_ships above)
  def test_display_board
    assert_output (
    "\n==========
ENEMY ZONE
      a   b   c   d   e   f   g   h   i   j

 1    .   .   .   .   W   W   W   .   .   .

 2    .   .   .   .   .   S   .   .   .   .

 3    .   .   .   .   .   S   .   .   .   .

 4    .   .   B   .   .   S   .   .   D   .

 5    .   .   B   .   .   .   .   .   D   .

 6    .   .   B   .   .   .   .   .   .   .

 7    .   .   B   .   .   C   C   C   C   C

 8    .   .   .   .   .   .   .   .   .   .

 9    .   .   .   .   .   .   .   .   .   .

 10   .   .   .   .   .   .   .   .   .   .\n\n") {@wilma.display_board}
  end

end
