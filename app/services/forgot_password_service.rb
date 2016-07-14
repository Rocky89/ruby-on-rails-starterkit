class ForgotPasswordService
  def initialize(params)
    ValidateParameterService.new(params, [:email]).validate!
    @email = params[:email]
  end

  def forgot_password
    user = User.find_by_email @email
    raise Errors::NotFound, "#{@email} not found" if user.nil?
    user.send_reset_password_instructions
    {}
  end
end
