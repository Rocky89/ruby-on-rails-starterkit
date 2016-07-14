class CurrentUserService
  def initialize(token)
    raise Errors::Unauthorized, 'Token is missing from header' if token.nil?
    @token = token
  end

  def authenticate
    hash = TokenService.decode(@token)
    user = User.find_by_email hash['email']
    raise Errors::Unauthorized, 'Invalid token' if user.nil?
    user
  end
end
