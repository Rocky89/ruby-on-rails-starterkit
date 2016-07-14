class SignUpUserService
  def initialize(params)
    ValidateParameterService.new(params, [:email, :password]).validate!
    @email = params[:email]
    @password = params[:password]
  end

  def sign_up
    user = User.create(email: @email, password: @password)
    raise Errors::UnprocessableEntity, user.errors.full_messages.to_sentence unless user.valid?
    user.auth_token = TokenService.encode(email: user.email)
    user
  end
end
