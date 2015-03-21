# this AI looks ahead 3 turns to see if it can win
class MediumAI

  def initialize(id,otherId,winCondition)
    @playerId = id
    @otherId = otherId
    @winCondition = winCondition
  end

  def nextMove(board)
     _lookAhead(board,3)[1]
  end

  def _lookAhead(board,nMoreTimes)
    options = AI.getValidMoves(board).collect {|col|
      _lookAheadOneMove(col,board,nMoreTimes,false)
    }
    print options
    return _selectBestColumn(options)
  end


  # look ahead in the game nMoreTimes turns. If the game can be won this turn, return the [true,winingColumn].
  # Otherwise, return [false,columnWithBestChances,NumberOfWinningMovesForThatColumn,NumberOfLosingMovesForThatColumn]
  def _lookAheadOneMove(col,board,nMoreTimes,opponent)

    # stopping condition
    if nMoreTimes < 1
      return [false,col,0,0]
    end
    # don't mess with the actual board
    newBoard = board.deep_copy
    row = newBoard.put(opponent ? @otherId : @playerId,col)
    if row == false
      return [false,col,0,0]
    end

    # if we will win or this turn
    winConditionMet = @winCondition.win(newBoard,row,col)
    if winConditionMet == @playerId
      return [true,col]
    elsif winConditionMet == @otherId
      return [false,col,opponent ? 0 : 1, opponent ? 1 : 0]
    end

    # otherwise, analyze the next turn's options
    options = AI.getValidMoves(newBoard).collect {|col|
      _lookAheadOneMove(col,newBoard,nMoreTimes-1,!opponent)
    }

    return _selectBestColumn(options)

  end

  def _selectBestColumn(options)
    best = nil
    options.each {|o|
      if o[0] == true
        return [true,o[1]]
      end
      if best == nil or o[2]-o[3] > best[1]
        best = o
      end
    }

    # if there are multiple equally as good options, randomly select one
    options.select {|o| o[2]-o[3] == best[2]-best[3]}
    if options.length > 1
      best = options.sample
    end

    totalWinningMoves = options.transpose[2].inject(:+)
    totalLosingMoves = options.transpose[3].inject(:+)

    return [false,best[1],totalWinningMoves,totalLosingMoves]
  end












end