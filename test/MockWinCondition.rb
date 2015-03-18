class MockWinCondition
  def initialize
    @win = false
  end
  def setWin(win)
    @win = win
  end
  def win
    return @win
  end
end