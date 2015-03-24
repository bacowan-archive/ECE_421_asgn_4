require_relative '../src/model/OttoTootWinCondition'
require_relative '../src/model/Board'
require_relative '../src/model/WinCondition'
require 'test/unit'

class TestOttoTootWinCondition < Test::Unit::TestCase

  def setup
    @X = 't'
    @o = 'o' # the players' pieces. picked X and o so that it is easier to see when there are many in a small space
    winLogic = OttoTootWinCondition.new
    @winCondition = WinCondition.new(@X,@o,winLogic)
    @xSize = 7
    @ySize = 6
    @board = Board.new([@ySize,@xSize])
  end

  def teardown

  end

  # the first played piece cannot be a win
  def testBlank
    putPieces(@X)
    assert(!@winCondition.win(@board,@ySize-1,0))
  end

  # a full board with no rows of four is not a win
  def testFull
    putPieces(@X,@o,@X,@o,@X,@o,@X)
    putPieces(@o,@X,@o,@X,@o,@X,@o)
    putPieces(@X,@o,@X,@o,@X,@o,@X)
    putPieces(@o,@X,@o,@X,@o,@X,@o)
    putPieces(@X,@o,@X,@o,@X,@o,@X)
    putPieces(@o,@X,@o,@X,@o,@X,@o)
    assert(!@winCondition.win(@board,@ySize-1,0))
  end

  # a full board when the last piece placed is a win
  def testFullWin
    putPieces(@X,@o,@X,@o,@X,@o,@X)
    putPieces(@o,@X,@o,@X,@o,@X,@o)
    putPieces(@X,@o,@X,@o,@X,@o,@X)
    putPieces(@o,@X,@o,@X,@o,@X,@o)
    putPieces(@X,@o,@X,@o,@X,@o,@o)
    putPieces(@o,@X,@o,@X,@o,@X,@X)
    assert_equal(@winCondition.win(@board,0,@xSize-1),@X)
  end

  # four vertical of player 1 is a win for player 1
  def testP1WinVertical
    putPieces(@X)
    putPieces(@o)
    putPieces(@o)
    putPieces(@X)
    assert_equal(@winCondition.win(@board,@ySize-4,0),@X)
  end

  # four vertical of player 2 is a win for player 2
  def testP2WinVertical
    putPieces(@o)
    putPieces(@X)
    putPieces(@X)
    putPieces(@o)
    assert_equal(@winCondition.win(@board,@ySize-4,0),@o)
  end

  # four horizontal of player 1 is a win for player 1
  def testP1WinHorizontal
    putPieces(@X,@o,@o,@X)
    assert_equal(@winCondition.win(@board,@ySize-1,3),@X)
  end

  # four vertical of player 2 is a win for player 2
  def testP2WinHorizontal
    putPieces(@o,@X,@X,@o)
    assert_equal(@winCondition.win(@board,@ySize-1,3),@o)
  end

  # four diagonal of player 1 is a win for player 1
  def testP1WinDiagonal
    putPieces(@o,@o,@o,@X)
    putPieces(@o,@o,@o,@o)
    putPieces(@o,@o,@o,@o)
    putPieces(@X,@o,@o,@o)
    assert_equal(@winCondition.win(@board,@ySize-4,0),@X)
  end

  # four diagonal of player 2 is a win for player 2
  def testP2WinDiagonal
    putPieces(@o,@o,@o,@o)
    putPieces(@o,@o,@X,@o)
    putPieces(@o,@X,@o,@o)
    putPieces(@o,@o,@o,@o)
    assert_equal(@winCondition.win(@board,@ySize-4,0),@o)
  end

  # convenience method for filling the board
  def putPieces(*args)
    (0..@xSize-1).each {|x|
      @board.put(args[x],x)
    }
  end

end