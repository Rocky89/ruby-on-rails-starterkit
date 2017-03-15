class UserNotificationsService
  def initialize(user)
    @user = user
  end

  def run
    @user.notifications.order('created_at desc')
  end
end
