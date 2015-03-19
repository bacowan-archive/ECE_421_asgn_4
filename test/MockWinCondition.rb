class MockWinCondition
  def initialize
    @win = false
  end
  def setWin(win)
    @win = win
  end
  def win(board,piece,col)
    return @win
  end
end