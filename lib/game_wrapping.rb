require 'Colorize'
require './lib/navy'
require './lib/misc'

# All the classes associated with setting up and managing the game context.

###############################################################################
###############################################################################

# Starts and stops the game.
class GameDaemon
  attr_accessor :game_id, :game_setup
  def initialize
    welcome_message
    @game_id = get_game_ID # assigns an ID to this game
    @enemy = Navy.new("enemy", true) # sets up enemy's ships, fleet, board
    autogenerated = does_player_want_to_automate_ship_creation # true or false
    @player = Navy.new("player", autogenerated) # sets up player stuff
    @player.board.show_initial_player_board
  end

  ##############################################################################

  # Assigns a game ID to the current game.
  # A future version of this method could assign this based on stored data.
  def get_game_ID
    10000
  end

  ##############################################################################

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

  ##############################################################################

  # Here's the main game wrapper
  def play_game
    # Starts and plays game: uses GameReferee.
    # Save game's current state: uses GameList.
    # Responds to requests to quit.
    # Invites player to play another game.
  end
end

###############################################################################
###############################################################################


# Determines whose turn it is.
class GameReferee
  # Flips coin.
  # Determines who goes first.
  # Toggles turns.
  # Determines if there is a winner yet.
end

###############################################################################
###############################################################################

# Stores information about all games played.
class GameList
  # Saves information about games after they're over.
  # Reports statistics.
end
