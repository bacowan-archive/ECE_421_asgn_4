require_relative 'OttoTootWinCondition'
require_relative 'ConnectFourWinCondition'


class GameFactory

  # create and return a game object.
  # game type is the name of the game (either "CONNECT_FOUR" (ConnectFour.name) or "OTTO_TOOT" (OttoToot.name))
  # playerNAI is false if the player is not an AI, or 1 2 or 3 for the difficulty levels
  # playerNPiece is the piece object for the given player
  # dimensions is an array of the number of rows and columns in the game board
  def createGame(gameType,  player1, player2, dimensions)
    pieces = [player1,player2]

    if gameType == OttoTootWinCondition.name
      winCondition = OttoTootWinCondition.new(player1,player2)
    elsif gameType == ConnectFourWinCondition.name
      winCondition = ConnectFourWinCondition.new#(player1,player2)
    end

    game = Game.new(pieces,winCondition,dimensions)



    return game

  end
end