class SignUpUserService
  def initialize(params)
    @params = params
    ValidateParameterService.new(params, [:email, :password]).valid?
    @user = create_user
  end

  def sign_up
    raise Errors::UnprocessableEntity, @user.errors.full_messages.to_sentence unless @user.valid?
    @user.auth_token = TokenService.encode(email: @user.email)
    @user
  end

  private

  def create_user
    User.create(email: @params[:email], password: @params[:password])
  end
end
