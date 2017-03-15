class PushNotificationService
  def initialize(user, data)
    @user = user
    @data = data
  end

  def push
    return unless @user.reaction_push_state
    @user.device_tokens.each do |device_token|
      token = device_token.token
      device_token.operating_system.zero? ? apple_push(token) : android_push(token)
    end
  end

  private

  def apple_push(token)
    APNS.send_notification(token, alert: @data[:message], badge: 1, sound: 'default', other: @data[:other])
  end

  def android_push(token)
    options = { collapse_key: 'placar_score_global', time_to_live: 3600, delay_while_idle: false }
    notification = GCM::Notification.new(token, { message: @data[:message], other: @data[:other] }, options)
    GCM.send_notifications([notification])
    # response = GCM.send_notifications([notification])
    # Rollbar.error(response) unless response.first[:body]['success'] == 1
  end
end
