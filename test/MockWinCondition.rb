class MockWinCondition
  def initialize
    @win = false
  end
  def setWin(win)
    @win = win
  end
  def isWin
    return @win
  end
end