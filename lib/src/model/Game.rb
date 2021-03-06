require_relative 'Board'

# overall state of the game
class Game

  def Game.CHANGE_TURN_FLAG
    'CHANGE_TURN'
  end
  def Game.WIN_FLAG
    'WIN'
  end
  def Game.STALEMATE_FLAG
    'STALEMATE'
  end
  def Game.COLUMN_FULL_FLAG
    'COLUMN_FULL'
  end
  def Game.UNKNOWN_EXCEPTION
    'UNKNOWN_EXCEPTION'
  end

  def initialize(players, winCondition, dimensions)
    @players = players
    @playerIndex = 0
    @winCondition = winCondition
    @board = Board.new(dimensions)
    @observers = []
    @aiObservers = [] # these need to be separate from the observers, as they are unique, and shouldn't
                      # know about the board state before the board does
  end

  def board
    return @board
  end

  # add an observer for when the state of the game changes
  def addObserver(observer)
    @observers << observer
  end

  # add an observer for when the state of the game changes
  def addAIObserver(observer)
    @aiObservers << observer
  end

  # get the player whose turn it currently is
  def turn
    return @players[@playerIndex]
  end

  # place a piece in the given column
  def placePiece(column)
    begin
      newPieceRow = @board.put(turn,column)
      if newPieceRow
        win = @winCondition.win(@board,newPieceRow,column)
        if win
          _notifyObservers(Game.WIN_FLAG,@board,win)
        elsif @board.full
          _notifyObservers(Game.STALEMATE_FLAG,@board)
        else
          _changeTurn
          _notifyObservers(Game.CHANGE_TURN_FLAG,@board,turn)
        end
      else
        _notifyObservers(Game.COLUMN_FULL_FLAG)
      end
    rescue Exception => e
      _notifyObservers(Game.UNKNOWN_EXCEPTION, e)
    end

  end

  # return the name of the game being played
  def gameName
    return @winCondition.class.name
  end

  # get the win condition of the game
  def winCondition
    return @winCondition
  end

  # send an initial notification (same as the turn notifications)
  def sendInitialNotification
    _notifyObservers(Game.CHANGE_TURN_FLAG,@board,turn)
  end


  def _changeTurn
    @playerIndex += 1
    if @playerIndex >= @players.length
      @playerIndex = 0
    end
  end

  def _notifyObservers(*args)
    @observers.each {|o| o.notify(*args)}
    @aiObservers.each {|o| o.notify(*args)}
  end

  def marshal_dump
    [@players,@playerIndex,@winCondition,@board,@aiObservers]
  end

  def marshal_load(array)
    @players, @playerIndex, @winCondition, @board, @aiObservers = array
    @observers = []
  end

end