require_relative '../src/model/Game'
require 'test/unit'

class TestGame < Test::Unit::TestCase

  def setup
    @player1 = 0
    @player2 = 1
    @game = Game.new()
    @observer = MockObserver.new
    @game.addObserver(@observer)
  end

  def teardown

  end

  # test the base "Place" functionality: on a blank board
  def testPlaceNew
    assert_equal(@game.board.pieces.length,0,"game does not start with zero pieces.")
    @game.placePiece(0)
    assert_equal(@game.board.pieces.length,1,"new game piece not added")
    assert_equal(@game.board[-1,0], @player1Piece, "correct piece not added in the correct spot")
    @game.placePiece(2)
    assert_equal(@game.board.pieces.length,2,"new game piece not added")
    assert_equal(@game.board[-1,2], @player2Piece, "correct piece not added in the correct spot")
  end

  # test that the "Place" function stacks tiles when more than one are added in the same column
  def testPlaceStack
    @game.placePiece(0)
    assert_equal(@game.board.pieces.length,1,"new game piece not added")
    assert_equal(@game.board[-1,0], @player1Piece, "correct piece not added in the correct spot")
    @game.placePiece(0)
    assert_equal(@game.board.pieces.length,2,"new game piece not added")
    assert_equal(@game.board[-2,0], @player2Piece, "correct piece not added in the correct spot")
    @game.placePiece(0)
    assert_equal(@game.board.pieces.length,3,"new game piece not added")
    assert_equal(@game.board[-3,0], @player1Piece, "correct piece not added in the correct spot")
  end

  # ensure that observers all called when a piece is played
  def testPlaceObserver
    @game.placePiece(0)
    assert_equal(@observer.lastNotification, @game.board, 'correct board not sent in notification')
  end

  # ensure that when the win condition is met, the correct notification is sent (including both the last piece that was
  # placed, as well as the win condition)
  def testWin
    @winCondition.setWin(@player1)
    @game.placePiece(0)
    assert_equal(@observer.notifications[-2], @game.board, 'correct board not sent in notification')
    assert_equal(@observer.notifications[-1][0], 'win', 'win condition not sent in notification')
    assert_equal(@observer.notifications[-1][1], @player1, 'correct player not sent in win notification')
  end
end