class UserSerializer < BaseSerializer
  attributes :id, :email
  attribute :auth_token, if: :full_detail?
  attribute :has_notifications, if: :full_detail?

  def full_detail?
    object.serializer_detail == :full_detail
  end

  def full_detail
    object.serializer_detail == :full_detail
  end
end
