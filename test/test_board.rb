require "./lib/settings"
require "minitest/autorun"
require "./lib/board"
include BoardModule

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
    @fred = Board.new("enemy")
  end

  def test_generate_blank_board
    # This autoruns generate_blank_board in the initialize method
    assert_equal(@tester_board, @fred.board)
  end
end
