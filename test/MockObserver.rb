class MockObserver

  def initialize
    @notifications = []
  end

  def notify(*args)
    @notifications.concat([args])
  end

  def lastNotification
    return @notifications[-1]
  end
end