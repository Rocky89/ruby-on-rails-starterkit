class NotificationSerializer < BaseSerializer
  attributes :id, :notification_id, :notification_message, :action, :created_at

  has_one :notified_user, serializer: UserSerializer

  def created_at
    object.created_at.to_i
  end

  def full_detail?
    object.serializer_detail == :full_detail
  end

  def full_detail
    object.serializer_detail == :full_detail
  end
end
