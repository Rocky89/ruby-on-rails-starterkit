class ForgotPasswordService
  def initialize(params)
    ValidateParameterService.new(params, [:email]).valid?
    @email = params[:email]
  end

  def forgot_password
    user = User.find_by_email @email
    raise Errors::NotFound, "#{@email} not found" unless user.present?
    user.send_reset_password_instructions
    {}
  end
end
