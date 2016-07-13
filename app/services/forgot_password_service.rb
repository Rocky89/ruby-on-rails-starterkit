class ForgotPasswordService
  def initialize(params)
    ValidateParameterService.new(params, [:email]).validate!
    @email = params[:email]
  end

  def forgot_password
    user = User.find_by_email @email
    raise Errors::NotFound.new("#{@email} not found") if user.nil?
    user.send_reset_password_instructions
    return {}
  end

end
