class MockObserver

  def initialize
    @notifications = []
  end

  def notify(*args)
    @notifications.concat(args)
    b = 1
  end

  def lastNotification
    a = notifications[-1]
    b = a[0]
    return @notifications[-1]
  end

  def notifications
    return @notifications
  end
end