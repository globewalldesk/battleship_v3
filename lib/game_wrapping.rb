require 'Colorize'
require './lib/fleet'
include FleetModule

# All the classes associated with setting up and managing the game context.
module GameWrappingModule

###############################################################################
###############################################################################

# Starts and stops the game.
class GameDaemon
  attr_accessor :game_id, :game_setup
  def initialize
    welcome_message
    @game_id = get_game_ID # assigns an ID to this game
    @game_setup = GameSetup.new # sets up boards
  end

  # Assigns a game ID to the current game.
  # A future version of this method could assign this based on stored data.
  def get_game_ID
    10000
  end

  # Simply displays the welcome message that is shown when the game loads.
  def welcome_message
    system ("cls")
    puts "######################"
    puts "Welcome to Battleship!".black.on_white
    puts "To play, first you'll place your battleships on a 10x10 grid."
    puts "Then you'll take shots (also on the grid) at the enemy's area"
    puts "to eliminate their ships. They will be shooting at you, too!"
    puts "Sink all the enemy's ships before yours are sunk!"
    puts "######################\n\n"
  end

  # Here's the main game wrapper
  def play_game
    # Starts and plays game: uses GameReferee.
    # Save game's current state: uses GameList.
    # Responds to requests to quit.
    # Invites player to play another game.
  end
end

###############################################################################

# Creates startup information about the current game.
class GameSetup
  attr_accessor :enemy_fleet, :player_fleet
  def initialize
    # Generate enemy fleet
    @enemy_fleet = FleetConstructor.new("enemy")
    # Generate player fleet
    @player_fleet = FleetConstructor.new("player")
  end
end

###############################################################################


# Determines whose turn it is.
class GameReferee
  # Flips coin.
  # Determines who goes first.
  # Toggles turns.
  # Determines if there is a winner yet.
end

###############################################################################

# Stores information about all games played.
class GameList
  # Saves information about games after they're over.
  # Reports statistics.
end

end # of module GameWrappingModule
