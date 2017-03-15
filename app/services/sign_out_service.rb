class SignOutService
  def initialize(params, user)
    ValidateParameterService.new(params, [:device_token, :os]).valid?
    @user = user
    @device_token = params[:device_token]
    @operating_system = params[:os]
  end

  def sign_out
    DeviceToken.where(user_id: @user.id, device_token: @device_token).destroy_all
    {}
  end
end
