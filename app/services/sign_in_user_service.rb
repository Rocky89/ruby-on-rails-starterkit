class SignInUserService
  def initialize(params)
    ValidateParameterService.new(params, [:email, :password]).valid?
    @email = params[:email]
    @password = params[:password]
  end

  def sign_in
    user = User.find_by(email: @email)
    raise Errors::NotFound, "#{@email} not found" unless user.present?
    raise Errors::UnprocessableEntity, 'Invalid credentials' unless user.valid_password? @password
    user.auth_token = TokenService.encode(email: user.email)
    user
  end
end
