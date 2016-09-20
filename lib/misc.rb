# Classless methods
module MiscModule

###############################################################################

# obtains a random, single pair of coordinates
def get_random_coords
  row = rand(10)
  col = rand(10)
  return [row, col]
end

end # of MiscModule
