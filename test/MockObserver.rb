class MockObserver

  def initialize
    @notifications = []
  end

  def notify(*args)
    if args[0] == Game.UNKNOWN_EXCEPTION
      raise args[1]
    end
    @notifications.concat([args])
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