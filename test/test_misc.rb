require "minitest/autorun"
require "./lib/settings"
require "./lib/misc"
include MiscModule
require "./lib/board"
include BoardModule

##############################################################################
##############################################################################

class TestMisc < Minitest::Test
  def setup
  end

  # tests that randomly-generated orientation is "horiz" or "vert"
  def test_get_random_coords
    coords = get_random_coords
    assert(coords[0].between?(0,9))
    assert(coords[1].between?(0,9))
  end

end # of TestMisc
